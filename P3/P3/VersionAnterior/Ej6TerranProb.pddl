﻿(define (problem Terran)
    (:domain Terran)
    (:objects
        VCE1 VCE2 VCE3 - unidad
        Marine1 Marine2 Segador - unidad
        centroMando1 bahiaIng - edificio
        barracones1 barracones2 - edificio
        depos1 depos2 depos3 depos4 - edificio
        min1 min2 min3 - recurso
        gas1 gas2 - recurso
        extr1 extr2 - edificio
        impulsorSegador1 - investigacion

        loc1_1 loc1_2 loc1_3 loc1_4 loc1_5 loc2_1 loc2_2 loc2_3 loc2_4 loc2_5 loc3_1 loc3_2 loc3_3 loc3_4 loc3_5 loc4_1 loc4_2 loc4_3 loc4_4 loc4_5 loc5_1 loc5_2 loc5_3 loc5_4 loc5_5 - localizacion


    )
    (:init
        (conectado loc1_1 loc2_1)
        (conectado loc2_1 loc1_1)
        (conectado loc1_1 loc1_2)
        (conectado loc1_2 loc1_1)
        (conectado loc1_2 loc2_2)
        (conectado loc2_2 loc1_2)
        (conectado loc1_2 loc1_3)
        (conectado loc1_3 loc1_2)
        (conectado loc1_2 loc1_1)
        (conectado loc1_1 loc1_2)
        (conectado loc1_3 loc2_3)
        (conectado loc2_3 loc1_3)
        (conectado loc1_3 loc1_4)
        (conectado loc1_4 loc1_3)
        (conectado loc1_3 loc1_2)
        (conectado loc1_2 loc1_3)
        (conectado loc1_4 loc2_4)
        (conectado loc2_4 loc1_4)
        (conectado loc1_4 loc1_5)
        (conectado loc1_5 loc1_4)
        (conectado loc1_4 loc1_3)
        (conectado loc1_3 loc1_4)
        (conectado loc1_5 loc2_5)
        (conectado loc2_5 loc1_5)
        (conectado loc1_5 loc1_4)
        (conectado loc1_4 loc1_5)
        (conectado loc2_1 loc1_1)
        (conectado loc1_1 loc2_1)
        (conectado loc2_1 loc3_1)
        (conectado loc3_1 loc2_1)
        (conectado loc2_1 loc2_2)
        (conectado loc2_2 loc2_1)
        (conectado loc2_2 loc1_2)
        (conectado loc1_2 loc2_2)
        (conectado loc2_2 loc3_2)
        (conectado loc3_2 loc2_2)
        (conectado loc2_2 loc2_3)
        (conectado loc2_3 loc2_2)
        (conectado loc2_2 loc2_1)
        (conectado loc2_1 loc2_2)
        (conectado loc2_3 loc1_3)
        (conectado loc1_3 loc2_3)
        (conectado loc2_3 loc3_3)
        (conectado loc3_3 loc2_3)
        (conectado loc2_3 loc2_4)
        (conectado loc2_4 loc2_3)
        (conectado loc2_3 loc2_2)
        (conectado loc2_2 loc2_3)
        (conectado loc2_4 loc1_4)
        (conectado loc1_4 loc2_4)
        (conectado loc2_4 loc3_4)
        (conectado loc3_4 loc2_4)
        (conectado loc2_4 loc2_5)
        (conectado loc2_5 loc2_4)
        (conectado loc2_4 loc2_3)
        (conectado loc2_3 loc2_4)
        (conectado loc2_5 loc1_5)
        (conectado loc1_5 loc2_5)
        (conectado loc2_5 loc3_5)
        (conectado loc3_5 loc2_5)
        (conectado loc2_5 loc2_4)
        (conectado loc2_4 loc2_5)
        (conectado loc3_1 loc2_1)
        (conectado loc2_1 loc3_1)
        (conectado loc3_1 loc4_1)
        (conectado loc4_1 loc3_1)
        (conectado loc3_1 loc3_2)
        (conectado loc3_2 loc3_1)
        (conectado loc3_2 loc2_2)
        (conectado loc2_2 loc3_2)
        (conectado loc3_2 loc4_2)
        (conectado loc4_2 loc3_2)
        (conectado loc3_2 loc3_3)
        (conectado loc3_3 loc3_2)
        (conectado loc3_2 loc3_1)
        (conectado loc3_1 loc3_2)
        (conectado loc3_3 loc2_3)
        (conectado loc2_3 loc3_3)
        (conectado loc3_3 loc4_3)
        (conectado loc4_3 loc3_3)
        (conectado loc3_3 loc3_4)
        (conectado loc3_4 loc3_3)
        (conectado loc3_3 loc3_2)
        (conectado loc3_2 loc3_3)
        (conectado loc3_4 loc2_4)
        (conectado loc2_4 loc3_4)
        (conectado loc3_4 loc4_4)
        (conectado loc4_4 loc3_4)
        (conectado loc3_4 loc3_5)
        (conectado loc3_5 loc3_4)
        (conectado loc3_4 loc3_3)
        (conectado loc3_3 loc3_4)
        (conectado loc3_5 loc2_5)
        (conectado loc2_5 loc3_5)
        (conectado loc3_5 loc4_5)
        (conectado loc4_5 loc3_5)
        (conectado loc3_5 loc3_4)
        (conectado loc3_4 loc3_5)
        (conectado loc4_1 loc3_1)
        (conectado loc3_1 loc4_1)
        (conectado loc4_1 loc5_1)
        (conectado loc5_1 loc4_1)
        (conectado loc4_1 loc4_2)
        (conectado loc4_2 loc4_1)
        (conectado loc4_2 loc3_2)
        (conectado loc3_2 loc4_2)
        (conectado loc4_2 loc5_2)
        (conectado loc5_2 loc4_2)
        (conectado loc4_2 loc4_3)
        (conectado loc4_3 loc4_2)
        (conectado loc4_2 loc4_1)
        (conectado loc4_1 loc4_2)
        (conectado loc4_3 loc3_3)
        (conectado loc3_3 loc4_3)
        (conectado loc4_3 loc5_3)
        (conectado loc5_3 loc4_3)
        (conectado loc4_3 loc4_4)
        (conectado loc4_4 loc4_3)
        (conectado loc4_3 loc4_2)
        (conectado loc4_2 loc4_3)
        (conectado loc4_4 loc3_4)
        (conectado loc3_4 loc4_4)
        (conectado loc4_4 loc5_4)
        (conectado loc5_4 loc4_4)
        (conectado loc4_4 loc4_5)
        (conectado loc4_5 loc4_4)
        (conectado loc4_4 loc4_3)
        (conectado loc4_3 loc4_4)
        (conectado loc4_5 loc3_5)
        (conectado loc3_5 loc4_5)
        (conectado loc4_5 loc5_5)
        (conectado loc5_5 loc4_5)
        (conectado loc4_5 loc4_4)
        (conectado loc4_4 loc4_5)
        (conectado loc5_1 loc4_1)
        (conectado loc4_1 loc5_1)
        (conectado loc5_1 loc5_2)
        (conectado loc5_2 loc5_1)
        (conectado loc5_2 loc4_2)
        (conectado loc4_2 loc5_2)
        (conectado loc5_2 loc5_3)
        (conectado loc5_3 loc5_2)
        (conectado loc5_2 loc5_1)
        (conectado loc5_1 loc5_2)
        (conectado loc5_3 loc4_3)
        (conectado loc4_3 loc5_3)
        (conectado loc5_3 loc5_4)
        (conectado loc5_4 loc5_3)
        (conectado loc5_3 loc5_2)
        (conectado loc5_2 loc5_3)
        (conectado loc5_4 loc4_4)
        (conectado loc4_4 loc5_4)
        (conectado loc5_4 loc5_5)
        (conectado loc5_5 loc5_4)
        (conectado loc5_4 loc5_3)
        (conectado loc5_3 loc5_4)
        (conectado loc5_5 loc4_5)
        (conectado loc4_5 loc5_5)
        (conectado loc5_5 loc5_4)
        (conectado loc5_4 loc5_5)

        (esRecurso gas1 gas)
        (esRecurso gas2 gas)
        (esRecurso min1 mineral)
        (esRecurso min2 mineral)
        (esRecurso min3 mineral)
        (esUnidad Marine1 marines)
        (esUnidad Marine2 marines)
        (unidadLibre Marine2)
        (unidadLibre Marine1)
        (esUnidad Segador segadores)
        (unidadLibre Segador)
        

        (en centroMando1 loc2_4)
        (esEdificio centroMando1 centroDeMando)
        (esEdificio barracones1 barracones)
        (esEdificio barracones2 barracones)
        (esEdificio extr1 extractor)
        (esEdificio extr2 extractor)
        (esEdificio bahiaIng bahiaDeIngenieria)
        (esEdificio depos1 deposito)
        (esEdificio depos2 deposito)
        (esEdificio depos3 deposito)
        (esEdificio depos4 deposito)
        (esInvestigacion impulsorSegador1 impulsorSegador)

        (en gas1 loc1_3)
        (en gas2 loc4_1)
        (en min1 loc4_4)
        (en min2 loc2_2)
        (en min3 loc3_5)

        (creadoEn marines barracones)
        (creadoEn segadores barracones)
        (creadoEn VCE centroDeMando)

        (esUnidad VCE1 VCE)
        (unidadCreada VCE1)
        (en VCE1 loc2_4)
        (unidadLibre VCE1)
        (esUnidad VCE2 VCE)
        (esUnidad VCE3 VCE)

        (= (disponible gas) 0)
        (= (disponible mineral) 0)
        (= (numAsignados gas1) 0)
        (= (numAsignados gas2) 0)
        (= (numAsignados min1) 0)
        (= (numAsignados min2) 0)
        (= (numAsignados min3) 0)

        (= (necesario centroDeMando mineral) 150)
        (= (necesario centroDeMando gas) 50)
        (= (necesario barracones mineral) 150)
        (= (necesario barracones gas) 0)
        (= (necesario extractor mineral) 75)
        (= (necesario extractor gas) 0)
        (= (necesario bahiaDeIngenieria mineral) 125)
        (= (necesario bahiaDeIngenieria gas) 0)
        (= (necesario deposito mineral) 75)
        (= (necesario deposito gas) 25)
        (= (necesario VCE mineral) 50)
        (= (necesario VCE gas) 0)
        (= (necesario marines mineral) 50)
        (= (necesario marines gas) 0)
        (= (necesario segador mineral) 50)
        (= (necesario segador gas) 50)
        (= (capacidad gas) 100)
        (= (capacidad mineral) 100)
        (= (necesario impulsorSegador gas) 200)
        (= (necesario impulsorSegador mineral) 50)



        (locLibre loc1_1)
        (locLibre loc1_2)
        (locLibre loc1_3)
        (locLibre loc1_4)
        (locLibre loc1_5)
        (locLibre loc4_1)
        (locLibre loc4_2)
        (locLibre loc4_3)
        (locLibre loc4_4)
        (locLibre loc4_5)
        (locLibre loc2_1)
        (locLibre loc2_2)
        (locLibre loc2_3)
        (locLibre loc2_5)
        (locLibre loc3_1)
        (locLibre loc3_2)
        (locLibre loc3_3)
        (locLibre loc3_4)
        (locLibre loc3_5)
        (locLibre loc5_1)
        (locLibre loc5_2)
        (locLibre loc5_3)
        (locLibre loc5_4)
        (locLibre loc5_5)




    )
    (:goal
        (and
            ;;(extractorEn loc2_3)
            ;;(edificioCreado barracones)
            ;;(en depos2 loc5_5)
            ;;(en Marine1 loc5_5)
            ;;(en Marine2 loc2_5)
            ;;(en Segador loc5_5)
            ;;(en VCE2 loc2_3)
            ;;(> (disponible mineral) 100)
            ;;(en bahiaIng loc5_5)
            ;;(unidadCreada VCE3)
            (investigacionCompletada impulsorSegador)

        )
    )
)