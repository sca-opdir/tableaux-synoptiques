# codé u8

stopened_conditions <- FALSE

icon_chapitre <- "signal"
icon_section  <- "bolt"
icon_cond     <- "caret-right"

contrib_tree_FR <- list(
  "2026" = list(

    "Contributions au paysage cultivé (art. 42-49)" = structure(
      list(

        "Contribution au maintien d'un paysage ouvert (art. 42)" = structure(
          list(
            "prévenir la progression de la forêt" =
              structure("", sttype = "file", sticon = icon_cond),

            "non versée pour les surfaces dans la zone de plaine, les haies, les bosquets champêtres et les berges boisées" =
              structure("", sttype = "file", sticon = icon_cond),

            "échelonnée selon la zone" =
              structure("", sttype = "file", sticon = icon_cond),

            "octroyée par hectare" =
              structure("", sttype = "file", sticon = icon_cond)
          ),
          stopened = TRUE,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "Contributions pour surfaces en pente (art. 43)" = structure(
          list(
            "versée par hectare " =
              structure("", sttype = "default", sticon = icon_cond),

            "à partir de 18% de pente" =
              structure("", sttype = "default", sticon = icon_cond),

            "non versée pour les pâturages permanents, les surfaces viticoles, les haies, les bosquets champêtres et les berges boisées" =
              structure("", sttype = "default", sticon = icon_cond),

            "versée si la surface en pente est de 50 ares au moins par exploitation (seules les surfaces d’au moins un are en un seul tenant sont prises en compte)" =
              structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "Contributions pour surfaces en forte pente (art. 44)" = structure(
          list(
            "versée par hectare" =
              structure("", sttype = "default", sticon = icon_cond),

            "à partir de 35% pour les surfaces recevant les contributions pour surface en pente" =
              structure("", sttype = "default", sticon = icon_cond),

            "versée si ces surfaces représente au moins 30 % de la surface agricole utile (SAU) donnant droit à des contributions" =
              structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "Contributions pour surfaces viticoles en pente (art. 45)" = structure(
          list(
            "versée par hectare" =
              structure("", sttype = "default", sticon = icon_cond),

            "si contribution versée pour vignobles en terrasses, ne reçoit aucune contribution pour les vignobles en pente" =
              structure("", sttype = "default", sticon = icon_cond),

            "versées si la surface viticole en pente est de 10 ares au moins (seules les surfaces d’au moins un are en un seul tenant sont prises en compte" =
              structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "Contributions de mise à l’alpage (art. 46)" = structure(
          list(
            "versée par PN" =
              structure("", sttype = "default", sticon = icon_cond),

            "pour l’estivage d’animaux consommant des fourrages grossiers (sauf bisons et cerfs), dans une exploitation d’estivage ou de pâturages communautaires" =
              structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "Contributions d’estivage (art. 47-49)" = structure(
          list(
            "versée par PN selon diverses catégories (selon espèce/type de pacage/surveillance)" =
              structure("", sttype = "default", sticon = icon_cond),

            "pour l’estivage d’animaux consommant des fourrages grossiers (sauf bisons et cerfs), dans une exploitation d’estivage ou de pâturages communautaires" =
              structure("", sttype = "default", sticon = icon_cond),

            "contribution supplémentaire pour vaches/brebis/chèvres laitières" =
              structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        )

      ),
      stopened = TRUE,
      sttype   = "red-node",
      sticon   = icon_chapitre
    ),

    " Contributions à la sécurité de l’approvisionnement (art. 50-54)" = structure(
      list(

        "Contribution de base (art. 50-51)" = structure(
          list(
            "versée par hectare et échelonnée selon la surface" =
              structure("", sttype = "default", sticon = icon_cond),

            "contribution réduite pour les surfaces herbagères permanentes exploitées en tant que SPB (prairies extensives, peu intensives ou riveraines, pâturages extensifs ou boisés" =
              structure("", sttype = "default", sticon = icon_cond),

            "aucune contribution pour les surfaces ne servant pas au maintien de la capacité de production de denrées alimentaires" =
              structure("", sttype = "default", sticon = icon_cond),

            "pour les surfaces herbagères permanentes, contributions versées uniquement si la charge minimale en UGBFG définie à l'art. 51 est atteinte" =
              structure("", sttype = "default", sticon = icon_cond),

            "si charge minimale UGBFG non atteinte contributions pour les surfaces herbagères permanentes fixées proportionnellement" =
              structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "Contribution pour la production dans des conditions difficiles (art. 52)" = structure(
          list(
            "versée par hectare et échelonnée selon la zone" =
              structure("", sttype = "default", sticon = icon_cond),

            "pour des surfaces en région collines ou montagne" =
              structure("", sttype = "default", sticon = icon_cond),

            "aucune contribution pour les surfaces ne servant pas au maintien de la capacité de production de denrées alimentaires" =
              structure("", sttype = "default", sticon = icon_cond),

            "pour les surfaces herbagères permanentes, contribution versée uniquement si la charge minimale en UGBFG définie à l'art. 51 est atteinte" =
              structure("", sttype = "default", sticon = icon_cond),

            "si charge minimale UGBFG non atteinte contributions pour les surfaces herbagères permanentes fixées proportionnellement" =
              structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "Contribution pour les terres ouvertes et les cultures pérennes (art. 53)" = structure(
          list(
            "versée par hectare" =
              structure("", sttype = "default", sticon = icon_cond),

            "aucune contribution pour les surfaces ne servant pas au maintien de la capacité de production de denrées alimentaires" =
              structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        )

      ),
      stopened = TRUE,
      sttype   = "red-node",
      sticon   = icon_chapitre
    ),

    " Contributions à la biodiversité (art. 55-62)" = structure(
      list(
        "contribution pour la qualité (art. 56-60)" = structure(

          list(
            "Q1 et Q2" =
              structure("", sttype = "default", sticon = icon_cond),

            "contributions pour prairies et surfaces à litière échelonnées par zone" =
              structure("", sttype = "default", sticon = icon_cond),
            "contributions pour jachères florales ou tournantes uniquement en zones de plaine et collines" =
              structure("", sttype = "default", sticon = icon_cond),
                          "contributions pour ourlets uniquement en zones de plaine, collines, montagne I et montagne II" =
              structure("", sttype = "default", sticon = icon_cond)
          ),          
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "contribution pour la mise en réseau (art. 61-62)" = structure(
          list(
            "soutien à des projets des cantons visant à la promotion de la mise en réseau et de l’exploitation appropriée de surfaces de promotion de la biodiversité" = structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        )
      ),
      stopened = TRUE,
      sttype   = "red-node",
      sticon   = icon_chapitre
    ),

    " Contribution à la qualité du paysage (art. 63-64)" = structure(
      list(
        "soutien à des projets cantonaux de préservation, promotion et développement de paysages cultivés diversifiés" = structure("", sttype = "default", sticon = icon_cond)
      ),
      stopened = TRUE,
      sttype   = "red-node",
      sticon   = icon_chapitre
    ),

    " Contributions  au système de production (art. 65-76a)" = structure(
      list(
        "contribution pour l’agriculture biologique (art. 66-67)" = structure(
          list(
            "versée par hectare et échelonnée selon les types d'utilisation" =
              structure("", sttype = "default", sticon = icon_cond),

            "cultures spéciales / terres ouvertes / autres surfaces" =
              structure("", sttype = "default", sticon = icon_cond)
          ),  
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "contributions pour le non-recours aux produits phytosanitaires (art. 68-71a)" = structure(
         list(
            "non-recours aux produits phytosanitaires dans les grandes cultures (art. 68)" =
              structure("", sttype = "default", sticon = icon_cond),
            "non-recours aux insecticides et aux acaricides dans les cultures maraîchères et les cultures de petits fruits (art. 69)" =
              structure("", sttype = "default", sticon = icon_cond),
            "non-recours aux insecticides, aux acaricides et aux fongicides dans les cultures pérennes après la floraison (art. 70)" =
              structure("", sttype = "default", sticon = icon_cond),
            "exploitation de surfaces de cultures pérennes à l’aide d’intrants conformes à l’agriculture biologique (art. 71)" =
              structure("", sttype = "default", sticon = icon_cond),
            "non-recours aux herbicides dans les grandes cultures et les cultures spéciales (art. 71a)" =
              structure("", sttype = "default", sticon = icon_cond)
          ),  
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "contribution pour la biodiversité fonctionnelle (art. 71b)" = structure(
          list(
            "contribution pour les bandes semées pour organismes utiles" = structure("", sttype = "default", sticon = icon_cond),
            "en région de plaine et des collines uniquement" = structure("", sttype = "default", sticon = icon_cond),
                        "dans les terres ouvertes ou cultures pérennes" = structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "contributions pour l’amélioration de la fertilité du sol (art. 71c-d)" = structure(
          list(
            "pour la couverture du sol sur terres ouvertes ou en viticulture (art. 71c)" = structure("", sttype = "default", sticon = icon_cond),
                        "pour des techniques culturales préservant le sol dans les cultures principales sur terres assolées (art. 71d)" = structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "contribution pour une utilisation efficiente de l’azote dans les grandes cultures (art. 71e)" = structure(
          list(
            "versée par hectare sous forme d’une contribution pour une utilisation efficiente de l’azote dans les terres assolées" = structure("", sttype = "default", sticon = icon_cond),
            "l'apport en azote dans l’ensemble de l’exploitation ne dépasse pas 90 % des besoins des cultures" = structure("", sttype = "default", sticon = icon_cond)
            
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "contribution pour la production de lait et de viande basée sur les herbages (art. 71f-g)" = structure(
          list(
            "versée par hectare de surface herbagère" = structure("", sttype = "default", sticon = icon_cond),
                        "une charge minimale en bétail doit être atteinte pour que la contribution soit versée" = structure("", sttype = "default", sticon = icon_cond)
            
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),

        "contributions au bien-être des animaux (art. 72-76a)" = structure(
          list(
            "SST" = structure("", sttype = "default", sticon = icon_cond),
                        "SRPA" = structure("", sttype = "default", sticon = icon_cond),
            "Mise au pâturage" = structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        ),
                "contribution pour une durée de vie productive plus longue des vaches (art. 77)" = structure(
          list(
            "échelonnée par catégorie d’animaux en fonction du nombre moyen des vêlages par vache qui a été abattue au cours des 3 années civiles précédentes" = structure("", sttype = "default", sticon = icon_cond),
                        "aucune contribution pour les vaches laitières < 3 vêlages" = structure("", sttype = "default", sticon = icon_cond),
            "aucune contribution pour les autres vaches  < 4 vêlages" = structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        )
      ),
      stopened = TRUE,
      sttype   = "red-node",
      sticon   = icon_chapitre
    ),

    " Contributions à l’utilisation efficiente des ressources (art. 82-82c)" = structure(
      list(


        "contribution pour l’alimentation biphase des porcs appauvrie en matière azotée (art. 82b-c)" = structure(
          list(
            "la ration alimentaire totale de l’ensemble des porcs détenus dans l’exploitation ne doit pas dépasser la valeur limite de protéines brutes en grammes par mégajoule d’énergie digestible porc" = structure("", sttype = "default", sticon = icon_cond)
          ),
          stopened = stopened_conditions,
          sttype   = "blue-node",
          sticon   = icon_section
        )
      ),
      stopened = TRUE,
      sttype   = "red-node",
      sticon   = icon_chapitre
    )

  )
)

