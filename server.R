library(openxlsx)
library(readxl)
library(shinyBS)
library(shiny.i18n)
library(shinyjs)   # pour shinyjs::runjs explicit
library(shinyTree)

translator <- Translator$new(translation_json_path = "translation.json")

source("settings/app_fcts.R")

colmap_dt <- get(load("data//colmap_dt.Rdata"))
stopifnot(!duplicated(colmap_dt$FR))
stopifnot(!duplicated(colmap_dt$DE))

selectable_cols <- list(
  FR =  colmap_dt$FR[!is.na(colmap_dt$cat_FR)],
  DE =  colmap_dt$DE[!is.na(colmap_dt$cat_DE)]
)

mapcolnames <- list(
  FR = setNames(colmap_dt$id, colmap_dt$FR),
  DE = setNames(colmap_dt$id, colmap_dt$DE)
)

all_cultmatrix_data <- get(load("data//all_cultmatrix_data.Rdata"))
all_biodiv_data     <- get(load("data//all_biodiv_data.Rdata"))
all_anim_data       <- get(load("data//all_anim_data.Rdata"))

shinyServer(function(input, output, session) {
  
  # ---------------------------
  # i18n : réactif propre
  # ---------------------------
  i18n <- reactive({
    selected <- input$lang
    if (length(selected) > 0 && selected %in% translator$get_languages()) {
      translator$set_translation_language(selected)
    }
    translator
  })
  
  # ---------------------------
  # Affichage rapide : on montre l'UI dès le 1er flush
  # (au lieu de hide/show en fin de server, trop tardif)
  # ---------------------------
  session$onFlushed(function() {
    shinyjs::hide(id = "loading-content", anim = TRUE, animType = "fade")
    shinyjs::show("app-content")
  }, once = TRUE)
  
  # ---------------------------
  # Renommer les sections "Surfaces / Animaux / Aide-mémoire" (JS)
  # sans redéfinir d'outputs à chaque fois
  # ---------------------------
  observeEvent(input$lang, {
    # all_sects doit exister (depuis app_settings.R, via tes sources)
    lapply(seq_along(all_sects), function(i){
      shinyjs::runjs(paste0(
        'document.querySelectorAll("#mynavlist li.navbar-brand[role=\'presentation\']")[', i-1,
        '].innerHTML = "', i18n()$t(all_sects[i]), '";'
      ))
    })
  }, ignoreInit = FALSE)
  
  # ---------------------------
  # Outputs UI dépendants de la langue : définis UNE FOIS
  # ---------------------------
  output$info_select <- renderUI({
    HTML(paste0('<br><font color=\"#A92E12\"><b><i>',
                i18n()$t("cliquer sur une ligne pour extraire les informations sur une culture"),
                "</b></i></font>"))
  })
  
  lapply(seq_along(all_tits), function(x){
    id <- paste0(names(all_tits)[x])
    output[[id]] <- renderUI({ HTML(i18n()$t(all_tits[x])) })
  })
  
  lapply(seq_along(all_subtits), function(x){
    id <- paste0(names(all_subtits)[x])
    output[[id]] <- renderUI({ h3(i18n()$t(all_subtits[x])) })
  })
  
  output$bea_subtit <- renderUI({
    HTML(paste0("<i>", i18n()$t("Fr./UGB"), "</i>"))
  })
  
  output$codesToKeep <- renderUI({
    div(
      materialSwitch(
        inputId = "remove_empty",
        label   = i18n()$t("Garder seulement les codes éligibles"),
        value   = remove_empty_def,
        status  = "primary"
      )
    )
  })
  
  # Tooltip (ne pas le recréer en boucle)
  output$my_modal <- renderUI({
    bsTooltip(
      "codesToKeep",
      i18n()$t("Retirer du tableau les cultures avec ligne sans aucune valeur"),
      "left"
    )
  })
  
  # contrib / glossaire selon langue (défini une fois)
  output$tit_contrib2 <- renderUI({
    if (input$lang == "FR") h3(i18n()$t("Les différentes contributions")) else NULL
  })
  output$tit_oterm <- renderUI({
    if (input$lang == "FR") h3(i18n()$t("Ordonnance sur la terminologie agricole (OTerm) 2023")) else NULL
  })
  
  output$contrib <- renderUI({
    if (input$lang == "FR") {
      shinyTree(
        "contrib_tree",
        types = "{ 'red-node': {'a_attr' : { 'style' : 'color:red' }},
                  'blue-node': {'a_attr' : { 'style' : 'color:blue' }} }"
      )
    } else if (input$lang == "DE") {
      HTML("<br><font color=\"#A92E12\"><b><i>nur auf Französisch verfügbar</b></i></font>")
    } else {
      NULL
    }
  })
  
  output$glossaire <- renderUI({
    if (input$lang == "FR") {
      lapply(seq_along(glossaire), function(i){
        accordion(
          id = paste0("def", i),
          accordionItem(
            title = glossaire[[i]][["terme"]],
            status = "info",
            collapsed = TRUE,
            HTML(glossaire[[i]][["déf"]])
          )
        )
      })
    } else if (input$lang == "DE") {
      HTML("<br><font color=\"#A92E12\"><b><i>nur auf Französisch verfügbar</b></i></font>")
    } else {
      NULL
    }
  })
  
  # ---------------------------
  # Données / helpers réactifs
  # ---------------------------
  get_cctxt_col <- reactive({ cctxt_col[input$lang] })
  get_esptxt_col <- reactive({ esptxt_col[input$lang] })
  
  get_raw_mat <- reactive({
    all_cultmatrix_data[[paste0(input$year)]]
  })
  
  get_mat_dt <- reactive({
    mat_dt <- all_cultmatrix_data[[paste0(input$year)]]
    # save(mat_dt, file="mat_dt0.Rdata")
    mat_dt <- mat_dt[, c(cc_col, get_cctxt_col(), selected_cols)]
    # save(mat_dt, file="mat_dt1.Rdata")
    mapcolname <- mapcolnames[[paste0(input$lang)]]
    newcoln <- as.character(sapply(colnames(mat_dt), function(x) names(mapcolname)[mapcolname == x]))
    colnames(mat_dt) <- newcoln
    # save(mat_dt, file="mat_dt2.Rdata")
    mat_dt
  })
  
  get_contrib_mat <- function(x){
    mat_dt <- get_raw_mat()
    pscols <- colmap_dt$id[grepl(paste0("_", x, "_"), colmap_dt$id)]
    
    pscols1 <- pscols[!pscols %in% truefalse_cols]
    pscols2 <- pscols[pscols %in% truefalse_cols]
    pscols  <- sort(c(pscols1, pscols2))
    
    mat_dt <- mat_dt[, c(cc_col, get_cctxt_col(), pscols)]
    mapcolname <- mapcolnames[[paste0(input$lang)]]
    newcoln <- as.character(sapply(colnames(mat_dt), function(x) names(mapcolname)[mapcolname == x]))
    colnames(mat_dt) <- newcoln
    mat_dt
  }
  
  get_BD_dt <- reactive({
    all_biodiv_data[[paste0(input$year)]]
  })
  
  get_cheptel_dt <- reactive({
    mat_dt <- all_anim_data[[paste0(input$year)]][["cheptel"]]
    mat_dt <- mat_dt[, c(cc_col, get_cctxt_col(), get_esptxt_col(), selected_cheptel_cols)]
    mapcolname <- mapcolnames[[paste0(input$lang)]]
    newcoln <- as.character(sapply(colnames(mat_dt), function(x) names(mapcolname)[mapcolname == x]))
    colnames(mat_dt) <- newcoln
    colnames(mat_dt)[colnames(mat_dt) == "Kultur"]  <- "Unterkategorie"
    colnames(mat_dt)[colnames(mat_dt) == "Culture"] <- "Sous-catégorie"
    mat_dt <- mat_dt[order(mat_dt$Code),]
    mat_dt
  })
  
  get_bea_dt <- reactive({
    mat_dt <- all_anim_data[[paste0(input$year)]][["bea"]]
    mat_dt <- mat_dt[, c(cc_col, get_cctxt_col(), get_esptxt_col(),
                         selected_cheptel_cols[selected_cheptel_cols %in% colnames(mat_dt)])]
    mapcolname <- mapcolnames[[paste0(input$lang)]]
    newcoln <- as.character(sapply(colnames(mat_dt), function(x) names(mapcolname)[mapcolname == x]))
    colnames(mat_dt) <- newcoln
    colnames(mat_dt)[colnames(mat_dt) == "Kultur"]  <- "Unterkategorie"
    colnames(mat_dt)[colnames(mat_dt) == "Culture"] <- "Sous-catégorie"
    mat_dt <- mat_dt[order(mat_dt$Code),]
    mat_dt
  })
  
  get_apercu_tit <- reactive({ i18n()$t("Aperçu pour") })
  
  # ---------------------------
  # Sélecteur de colonnes surf_mat : renderUI UNE FOIS
  # ---------------------------
  output$surfmat_colselect <- renderUI({
    catcol <- paste0("cat_", input$lang)
    
    lapply(unique(na.omit(colmap_dt[, catcol])), function(x){
    
      # cat(paste0(x,":\n"))
        
      xlab <- gsub(" ", "", x)
      xlab <- gsub(".", "", xlab, fixed = TRUE)
      
      colstoselect <- colmap_dt[, paste0(input$lang)][!is.na(colmap_dt[, catcol]) & colmap_dt[, catcol] == x]
      
      # cat(paste0(paste0(colstoselect, collapse=","),"\n"))
      
      if(x=="Paysage cult."){
        colna <- colnames(get_mat_dt())
        # save(colstoselect, file="colstoselect.Rdata")
        # save(colna, file="colna.Rdata")
      }
      
      dt=get_mat_dt()
      # save(dt, file="get_mat_dt.Rdata")
      colstoselect <- colstoselect[colstoselect %in% colnames(get_mat_dt())]
      # cat(paste0(paste0(colnames(get_mat_dt()), collapse=","),"\n"))
      
      # cat(paste0(paste0(colstoselect, collapse=","),"\n"))
      
      if (length(colstoselect) == 0) return(NULL)
      
      div(
        HTML(paste0("<b>", x, "</b>")),
        actionLink(paste0("selectall_", xlab), i18n()$t("Tout (dé)sélectionner")),
        checkboxGroupInput(
          paste0("selcols_", xlab),
          label = NULL,
          choices = colstoselect,
          selected = colstoselect,
          inline = TRUE
        )
      )
    })
  })
  
  # ---------------------------
  # IMPORTANT : “Tout (dé)sélectionner” sans empiler des observers
  # -> Un seul observe qui détecte les changements de click count
  # ---------------------------
  click_state <- reactiveValues(last = list())
  
  observe({
    catcol <- paste0("cat_", input$lang)
    cats <- unique(na.omit(colmap_dt[, catcol]))
    
    lapply(cats, function(x){
      xlab <- gsub(" ", "", x)
      xlab <- gsub(".", "", xlab, fixed = TRUE)
      
      btn_id <- paste0("selectall_", xlab)
      sel_id <- paste0("selcols_", xlab)
      
      # l'input n'existe qu'après renderUI → donc on teste
      if (!btn_id %in% names(input)) return(NULL)
      
      val <- input[[btn_id]]
      if (is.null(val) || val == 0) return(NULL)
      
      prev <- click_state$last[[btn_id]]
      if (is.null(prev)) prev <- 0L
      
      if (!identical(val, prev)) {
        click_state$last[[btn_id]] <- val
        
        colstoselect <- colmap_dt[, paste0(input$lang)][colmap_dt[, catcol] == x]
        colstoselect <- colstoselect[colstoselect %in% colnames(get_mat_dt())]
        if (length(colstoselect) == 0) return(NULL)
        
        if (val %% 2 == 0) {
          updateCheckboxGroupInput(session, sel_id, label = NULL,
                                   choices = colstoselect, selected = colstoselect, inline = TRUE)
        } else {
          updateCheckboxGroupInput(session, sel_id, label = NULL,
                                   choices = colstoselect, selected = character(0), inline = TRUE)
        }
      }
      NULL
    })
  })
  
  get_selected_columns_mat <- reactive({
    catcol <- paste0("cat_", input$lang)
    cats <- unique(na.omit(colmap_dt[, catcol]))
    
    unlist(lapply(cats, function(x){
      xlab <- gsub(" ", "", x)
      xlab <- gsub(".", "", xlab, fixed = TRUE)
      id <- paste0("selcols_", xlab)
      input[[id]]
    }))
  })
  
  output$selected_columns <- renderUI({
    paste0(get_selected_columns_mat(), collapse = ",")
  })
  
  # ---------------------------
  # Tables / outputs (logique identique)
  # ---------------------------
  output$cc_select <- renderUI({ NULL })
  
  output$surf_mat_selected_dt <- DT::renderDataTable({
    subdf <- get_mat_dt()
    sel_row <- input$surf_mat_dt_rows_selected
    if (is.null(sel_row) || length(sel_row) < 1) {
      output$cc_select <- NULL
      return(NULL)
    }
    
    cc_idx <- which(colnames(subdf) == names(mapcolnames[["FR"]])[mapcolnames[["FR"]] == cc_col] |
                      colnames(subdf) == names(mapcolnames[["DE"]])[mapcolnames[["DE"]] == cc_col])
    cctxt_idx <- which(colnames(subdf) == names(mapcolnames[["FR"]])[mapcolnames[["FR"]] == get_cctxt_col()] |
                         colnames(subdf) == names(mapcolnames[["DE"]])[mapcolnames[["DE"]] == get_cctxt_col()])
    
    stopifnot(length(cc_idx) == 1)
    stopifnot(length(cctxt_idx) == 1)
    
    selectedcc <- as.character(subdf[sel_row, cc_idx])
    selectedcctxt <- as.character(subdf[sel_row, cctxt_idx])
    
    output$cc_select <- renderUI({
      HTML(paste0("<h3><u>", get_apercu_tit(), " </u>: ", selectedcc, " - ", selectedcctxt, "</h3>"))
    })
    
    subdf <- subdf[sel_row, -c(cc_idx, cctxt_idx), drop = FALSE]
    stopifnot(nrow(subdf) == 1)
    subdf <- t(subdf)
    subdf <- subdf[subdf[,1] != "-", , drop = FALSE]
    my_mat_dt_1cc(subdf)
  })
  
  output$bea_dt <- DT::renderDataTable({
    df <- get_bea_dt()
    tocentercols <- which(!colnames(df) %in% c("Unterkategorie", "Sous-catégorie"))
    my_mat_dt_aw(df, tocentercols - 1)
  })
  
  output$cheptel_dt <- DT::renderDataTable({
    df <- get_cheptel_dt()
    tocentercols <- which(!colnames(df) %in% c("Unterkategorie", "Sous-catégorie"))
    my_mat_dt_aw(df, tocentercols - 1)
  })
  
  lapply(c("PS", "VS", "KL"), function(x){
    output[[paste0(x, "_mat_dt")]] <- DT::renderDataTable({
      df <- get_contrib_mat(x)
      my_mat_dt(df)
    })
  })
  
  output$surf_mat_dt <- DT::renderDataTable({
    
    remove_empty <- if (is.null(input$remove_empty)) remove_empty_def else input$remove_empty
    
    df <- get_mat_dt()
    sel_cols <- get_selected_columns_mat()
    
    stopifnot(sel_cols %in% colnames(df))
    df <- df[, c(1:2, which(colnames(df) %in% sel_cols))]
    
    if (remove_empty) {
      if (ncol(df) > 2) {
        df <- df[which(unlist(apply(df, 1, function(x)
          !all(x[3:length(x)] == "-" | x[3:length(x)] == no_symb)
        ))),]
      }
    }
    
    my_mat_dt(df)
  })
  
  lapply(c("Q","R"), function(bt){
    lapply(0:2, function(i){
      
      output[[paste0("att", i, "_BD_", bt, "_dt")]] <- DT::renderDataTable({
        
        bdData <- get_BD_dt()
        dt <- bdData[[paste0("att", i, "_BD_", bt)]]
        
        if (paste0(i) == "0") {
          dt <- dt[, c(cc_col, paste0("Code_", input$lang), bd_sel_cols[[paste0(bt)]])]
          colnames(dt)[3:length(colnames(dt))] <- sapply(colnames(dt)[3:length(colnames(dt))], function(x){
            if (x %in% names(bdAtt0_colnames)) bdAtt0_colnames[x] else x
          })
        } else {
          if (input$lang == "FR") dt[, paste0("Code_", "DE")] <- NULL
          if (input$lang == "DE") dt[, paste0("Code_", "FR")] <- NULL
          
          othercols <- colnames(dt)[!colnames(dt) %in% c(cc_col, paste0("Code_", input$lang))]
          dt <- dt[, c(cc_col, paste0("Code_", input$lang), othercols)]
          colnames(dt)[3:length(colnames(dt))] <- sapply(colnames(dt)[3:length(colnames(dt))],
                                                         function(x) bdAtt12_colnames[x])
        }
        
        colnames(dt)[1] <- "Code"
        colnames(dt)[2] <- ifelse(input$lang == "FR", "Culture", "Kultur")
        dt[is.na(dt)] <- "-"
        
        if (paste0(i) == "0") my_mat_dt(dt) else my_mat_dt_aw(dt, 2)
      })
      
      output[[paste0("att", i, "_BD_", bt, "_tit")]] <- renderUI({
        fluidRow(
          column(
            12,
            h3(paste0(spbAtt_type[[paste0("att", i)]][input$lang])),
            HTML(paste0("<i>", spbAtt_subtit[[paste0("att", i)]][input$lang], "</i>"))
          )
        )
      })
    })
  })
  
  output$plot   <- renderUI({ HTML("qualité") })
  output$pph_dt <- renderUI({ HTML("PPH") })
  
  observeEvent(input$year, {
    output$contrib_tree <- renderTree({
      contrib_tree_FR[[paste0(input$year)]]
    })
  }, ignoreInit = FALSE)
  
})
