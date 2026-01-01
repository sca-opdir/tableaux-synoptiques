## encodé iso

myactionBttn <- function(id, style){
  return(HTML(paste0('<button class="action-button bttn bttn-material-circle bttn-xs bttn-danger bttn-no-outline" 
  id="', id, '" type="button" style=', style,'></button>')))
}

my_mat_dt <- function(dt){
  datatable(dt,
            escape=FALSE,
            rownames=FALSE,
            class = 'cell-border stripe',
            selection=list(mode = "single"),
            filter="top",
            options = list(
              scrollY = "400px",
              scrollX = "10px",
              searching=FALSE,
              paging=FALSE,
              autowidth=FALSE,
              "pageLength" = nrow(dt),
              columnDefs = list(
                list(width = '5px', targets = "_all"),
                # list(width = '20px', targets = 2),
                # list(width = '10px', targets = c(1,3,5:(ncol(df)-1))),
                # list(searchable = FALSE, targets = 1)
                list(className = "dt-center", targets = "_all")
              ))
  ) %>%
    formatStyle(
      colnames(dt),
      backgroundColor = styleEqual(c("-"), c('lightgray'))) 
  
}



my_mat_dt_aw <- function(dt, targettocenter){

## warning should be 0-based
if(any(targettocenter >= ncol(dt))) warning("targettocenter should be 0-based !!!")
stopifnot(targettocenter < ncol(dt))
  datatable(dt,
            escape=FALSE,
            rownames=FALSE,
            class = 'cell-border stripe',
            selection=list(mode = "single"),
            filter="top",
            options = list(
              scrollY = "400px",
              scrollX = "10px",
              searching=FALSE,
              paging=FALSE,
              autowidth=TRUE,
              "pageLength" = nrow(dt),
              columnDefs = list(
                list(className = "dt-center", targets = targettocenter)
              ))
  ) %>%
    formatStyle(
      colnames(dt),
      backgroundColor = styleEqual(c("-"), c('lightgray'))) 
  
}


my_mat_dt_1cc <- function(subdf){
  
datatable(subdf,
          escape=FALSE,
          rownames=TRUE,
          # colnames=NULL,
          class = 'cell-border stripe',
          selection=list(mode = "single"),
          
          options = list(
            autoWidth = TRUE,
            scrollY = "400px",
            # scrollX = "10px",
            paging=FALSE,
            searching=FALSE,
            autowidth=TRUE,
            "pageLength" = nrow(subdf),
            columnDefs = list(
              # list(width = '5px', targets = "_all"),
              # list(width = '20px', targets = 2),
              # list(width = '10px', targets = c(1,3,5:(ncol(subdf)-1))),
              list(className = "dt-center", targets = "_all")
            ),# remove column name:
            headerCallback = JS(
              "function(thead, data, start, end, display){",
              "  $(thead).remove();",
              "}"))
)  %>% 
  ## put rownames in bold
  formatStyle(
    0,
    target = "cell",
    fontWeight = styleEqual(rownames(subdf), "bold")
  )  %>% 
  ## put rownames in bold
  formatStyle(
    0,
    target = "cell",
    `text-align` = styleEqual(rownames(subdf), "right")
  )

}


