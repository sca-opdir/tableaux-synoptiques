library(shinyWidgets)
library(shiny)
library(DT)
library(shinyTree)
library(shinydashboardPlus)
library(shinyjs)
library(waiter)

source("settings/app_settings.R", encoding="UTF-8")
source("settings/contributions_tree.R", encoding="UTF-8")
source("settings/glossaire.R", encoding="UTF-8")

fluidPage(
  shinyjs::useShinyjs(),
  inlineCSS(appCSS),
  tags$head(tags$style(HTML(css_settings))),
  
  # Loading message
  div(
    id = "loading-content",
    h2("Loading...")
  ),
  
  hidden(
    div(
      id = "app-content",
      
      titlePanel(uiOutput("tit_app")),
      
      navlistPanel(
        id="mynavlist",
        widths = c(2, 10),
        footer = my_footer,
        header = my_header,
        
        "Surfaces",
        tabPanel(
          uiOutput("tit_apercuF"),
          uiOutput("tit_apercuF2"),
          
          uiOutput("surfmat_colselect"),
          HTML("<br>"),
          uiOutput("codesToKeep"),
          uiOutput("my_modal"),
          uiOutput("info_select"),
          
          DTOutput("surf_mat_dt"),
          htmlOutput("cc_select"),
          DTOutput("surf_mat_selected_dt")
        ),
        
        tabPanel(
          uiOutput("tit_biodiv"),
          uiOutput("tit_biodiv2"),
          do.call(
            tabsetPanel,
            lapply(c("Q","R"), function(bt){
              tabPanel(
                ifelse(bt=="Q", "Qualité", "Réseau"),
                lapply(0:2, function(i){
                  list(
                    uiOutput(paste0("att", i, "_BD_", bt, "_tit")),
                    DTOutput(paste0("att", i, "_BD_", bt, "_dt"))
                  )
                })
              )
            })
          )
        ),
        
        tabPanel(
          uiOutput("tit_SP"),
          uiOutput("tit_SP2"),
          DTOutput("PS_mat_dt")
        ),
        
        tabPanel(
          uiOutput("tit_secapp"),
          uiOutput("tit_secapp2"),
          DTOutput("VS_mat_dt")
        ),
        
        tabPanel(
          uiOutput("tit_PC"),
          uiOutput("tit_PC2"),
          DTOutput("KL_mat_dt")
        ),
        
        "Animaux",
        tabPanel(
          uiOutput("tit_apercuA"),
          DTOutput("cheptel_dt")
        ),
        
        tabPanel(
          uiOutput("tit_BEA"),
          uiOutput("tit_BEA2"),
          uiOutput("bea_subtit"),
          DTOutput("bea_dt")
        ),
        
        "Aide-mémoire",
        tabPanel(
          uiOutput("tit_contrib"),
          uiOutput("tit_contrib2"),
          uiOutput("contrib")
        ),
        
        tabPanel(
          uiOutput("tit_gloss"),
          uiOutput("tit_oterm"),
          uiOutput("glossaire")
        )
      )
    )
  )
)
