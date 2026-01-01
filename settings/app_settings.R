appCSS <- "
#loading-content {
  position: absolute;
  background: #000000;
  opacity: 0.9;
  z-index: 100;
  left: 0;
  right: 0;
  height: 100%;
  text-align: center;
  color: #FFFFFF;
}
"


yes_symb <- "&#x2705;"
no_symb <- "&#x274C;"

remove_empty_def = FALSE

all_sects <- c("Surfaces", "Animaux", "Aide-mémoire")


spbAtt_subtit <- list("att0"=c("FR" = "Fr./ha ou Fr./arbre",
                             "DE" = "<i>Fr./ha ou Fr./Baum</i>"))
                    

  spbAtt_type <- list("att0"=c("FR" ="Code de culture",
                               "DE" = "Kulturcode"),
                      "att1" = c("FR" ="Bande culturale extensive",
                                 "DE" = "Ackerschonstreifen"),
                      "att2" = c("FR"="Céréales en lignes de semis espacées",
                                 "DE" = "Getreide in weiter Reihe"))
  


K_progsWithCat <- c(
  "ns2:RK_PS_psmHerbicide" = "K_PS_PSM_HERBICIDE_",
  "ns2:RK_PS_soilCoverage"= "K_PS_SOIL_COVERAGE_",
  "ns2:RK_PS_psmArableFarming" = "K_PS_PSM_ARABLE_",
  "ns2:RK_PS_fbdInsectStrips" = "K_PS_FBD_STRIPS_",
  "ns2:RK_PS_soilMildTreatment" = "K_PS_SOIL_TREATMENT",
  "ns2:RK_PS_psmVegetablesBerries" = "K_PS_PSM_VEGBER",
  "ns2:RK_PS_psmPerennialCulture" = "K_PS_PSM_PERENNIAL",
  "ns2:RK_PS_psmBioAids" = "K_PS_PSM_BIOAID",
  "ns1:RK_PS_BIO_OA" = "K_PS_BIO_OA",
  "ns1:RK_PS_BIO_SPK" = "K_PS_BIO_SPK",
  "ns1:RK_PS_BIO_UEF" = "K_PS_BIO_ULN",
  "ns1:RK_EK_EIWEISS" = "K_EK_EIWEISS",
  "ns1:RK_EK_OEL" ="K_EK_OEL",
  "ns1:RK_EK_SAATGUT1"= "K_EK_SAAT1",
  "ns1:RK_EK_SAATGUT2"= "K_EK_SAAT2",
  "ns1:RK_EK_SOJA" = "K_EK_SOJA",
  "ns1:RK_EK_ZUCKERRUEBEN" = "K_EK_ZUCKER",
  "ns1:RK_IN_INSITU" = "K_IN_INSITU"
)

cc_col <- "ns1:Code"
cctxt_col <- c("FR" = "ns1:FR", "DE" = "ns1:DE")

esptxt_col <- c("FR" = "tiercatFR", "DE" = "tiercatDE")

# truefalse_cols <- c( "ns1:RK_BFF","ns2:RK_BFF_Q1","ns2:RK_BFF_Q2","ns2:RK_BFF_V" )
truefalse_cols <- c( "ns1:RK_BFF", "ns1:RK_KUNSTWIESEN" , 
				"ns2:RK_OFFENE_ACKERFLAECHE",
"ns2:RK_ACKERFLAECHE",
"ns2:RK_GRUENFLAECHE",
"ns2:RK_DAUERGRUENFLAECHE",
"ns2:RK_DAUERKULTUREN",
"ns2:RK_KULTUREN_GESCHUETZT",
"ns2:RK_WEITERE_IN_LN",
"ns2:RK_AUSSERHALB_LN",
"ns2:RK_SOEMMERUNG",
"ns2:RK_ANDERE_ELEMENTE","ns2:RK_PS_climatEfficientNUse", "ns1:RK_VS_BAS_DG",
					"ns1:VS_OAD", "ns1:RK_VS_OA", "ns1:RK_VS_BAS_UEB", "ns1:RK_VS_DK",
### biodiv à mettre en true fals car pas diff R / Q
"ns2:RK_cerealsWideRange",
"ns2:RK_extensiveArableStrips",

"ns2:RK_LQ",

# Ansatz Getreidezulage. a mettre en true false car  Wird jährlich Ende Oktober festgelegt
 "ns1:RK_GZ_GETREIDEZULAGE"
)

biodiv_cols <- c("ns2:RK_BFF_Q1","ns2:RK_BFF_Q2","ns2:RK_BFF_V" )

truefalse_animcols <- c("ns1:SOEM","ns1:BTS" ,"ns1:RAUS","ns1:WEIDE")

selected_cols <- c(names(K_progsWithCat), biodiv_cols, "K_VS_ZON", "K_KL_OB","K_KL_HAN", "K_KL_REB", truefalse_cols)

selected_cheptel_cols <- c( "ns1:ETHOKat", "ns1:GVEFaktor","ns1:BTS","ns1:RAUS","ns1:WEIDE", "ns1:SOEM")

selected_bea_cols <- c( "ns1:ETHOKat", "BTS","RAUS","WEIDE")


bd_sel_cols <- list("Q" = c("Q1 (31/41/51/52/53/54)",  "Q2 (31/41/51/52/53/54)"),
                    "R" = c("99_q1"))


bdAtt12_colnames <- c("99_q1" = "Fr./ha")
bdAtt0_colnames <- c("99_q1" = " ")




ps_contribs <- list(
  list(
    tit="Agriculture biologique",
    patt = "_PS_BIO"
  ),
  list(
    tit = "Non-recours PPh",
    patt ="_PS_psm"
  ),
  list(
    tit = "Fertilité du sol",
    patt = "_PS_soil"),
  list(tit="Autres",
       patt = "_PS_climateEfficientNUse|_PS_fbdInsectStrips")
  
)
# [1] "ns1:RK_PS_BIO_OA"               "ns1:RK_PS_BIO_SPK"             
# [3] "ns1:RK_PS_BIO_UEF"              "ns1:RK_PS_GMF"                 
# [5] "ns2:RK_PS_fbdInsectStrips"      "ns2:RK_PS_psmArableFarming"    
# [7] "ns2:RK_PS_psmVegetablesBerries" "ns2:RK_PS_psmPerennialCulture" 
# [9] "ns2:RK_PS_psmBioAids"           "ns2:RK_PS_psmHerbicide"        
# [11] "ns2:RK_PS_soilCoverage"         "ns2:RK_PS_soilMildTreatment"   
# [13] "ns2:RK_PS_climatEfficientNUse" 
# 
# les contributions au système de production :
#   1. contribution pour l’agriculture biologique,
# 2. contributions pour le non-recours aux produits phytosanitaires 
# 4. contributions pour l’amélioration de la fertilité du sol,
# 5. contribution pour une utilisation efficiente de l’azote dans les grandes cultures,
# 63. contribution pour la production de lait et de viande basée sur les herbages,
# 74. contributions au bien-être des animaux,




  all_tits <- c(
                "tit_gloss" = "Glossaire",
                "tit_apercuF" = "Vue d'ensemble",
                "tit_apercuA" = "Vue d'ensemble",
                "tit_secapp" = "Sécurité approvi.",
                "tit_PC" = "Paysage cultivé",
                "tit_SP" = "Syst. de production",
                tit_app = "Aperçu paiements directs",
                tit_contrib = "Contributions",
                tit_BEA = "Bien-être animal",
                tit_biodiv = "Biodiversité"
                
                )
  
  all_subtits <- c(
    tit_secapp2 = "Contributions pour la sécurité de l'approvisionnement",
                tit_SP2 = "Contributions au système de production",
                tit_PC2 = "Contributions pour le paysage cultivé",
    tit_BEA2 = "Contributions pour le bien-être animal",
    tit_biodiv2 ="Contributions à la biodiversité",
    tit_apercuF2 = "Aperçu global"
    
  )






css_settings <-     "




                .tooltip > .tooltip-inner {
                width: 400px;
                color: white;
                background-color: #A92E12;
                }




        #buttons {
         // background-color:yellow; 
         position:fixed; margin-bottom:50px; opacity:1; height:50px; z-index:5;
         display: flex;
         align-items: center;
         justify-content: center;
         }

         #fluidrow1 {
        height:50px;
         }

.navbar-brand  {
text-decoration-line: underline;

}
 .nav-pills {
              color: white;

        }
    .nav-pills>li>a {
            color: white !important;

        }

.nav>li>a:hover {
    color: black !important;
}


.nav-pills>li>a:hover {
 color:black !important;
}

    .nav.nav-pills.nav-stacked > .active > a, .nav.nav-pills.nav-stacked > .active > a:hover {
    background-color: #d52b1e;
	color:black;
  }

 .nav.nav-pills.nav-stacked > a:hover{
	color: black !important;
  }

.well {
    //min-height: 20px;
    //max-width: 200px;
    //padding: 19px;
    margin-bottom: 20px;
    background-color: maroon;
    //border: 1px solid #e3e3e3;
    //border-radius: 4px;
    //-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
    //box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
    //font-family: 'Rock Salt', cursive;
    font-color: white;
}
"
my_header <-   fluidRow(id="fluidrow1",
                        column(4, HTML("")),
                        column(8, align="left", id="buttons",
                               radioGroupButtons(
                                 inputId = "year",
                                 label = "",
#                                 choices = c("2023", 
 #                                            "2024"),
                                 choices = c("2026"),

                                 selected="2026",
                                 individual = TRUE,
                                 checkIcon = list(
                                   yes = tags$i(class = "fa fa-circle", 
                                                style = "color: darkgreen"),
                                   no = tags$i(class = "fa fa-circle-o", 
                                               style = "color: darkgreen"))),
                               HTML("<h4>&nbsp; </h4>"),
                               awesomeRadio(
                                 inputId = "lang",
                                 label = "", 
                                 choices = c("FR", "DE"),
                                 selected = "FR",
                                 inline = TRUE, 
                                 status = "success"
                               ))
                        
                        )


my_footer <- HTML('<br><br><div>
    <i>SCA - OPDir - En cas de problèmes/bugs ou pour des suggestions/corrections :
                <a href="mailto:marie.zufferey@admin.vs.ch">marie.zufferey@admin.vs.ch</a></i>')
