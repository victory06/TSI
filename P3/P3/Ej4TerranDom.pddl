(define (domain Terran)
    (:requirements :strips :typing)
    (:types
        unidad movible localizacion edificio recurso - object
        
    )
    (:constants
        tipoEdificio - edificio
        tipoRecurso - recurso
        tipoUnidad - unidad
        centroDeMando barracones extractor - tipoEdificio
        mineral gas - tipoRecurso
        VCE marines segadores - tipoUnidad
        
    )
    (:predicates
        (en ?obj - object ?x - localizacion)
        (asignadoLoc ?r - recurso ?x - localizacion)
        (extrayendo ?u - unidad ?r - recurso)
        (necesita ?r - tipoRecurso ?b - tipoEdificio)
        (necesita2 ?r - tipoRecurso ?s - tipoRecurso ?b - tipoEdificio)
        (recursoObtenido ?r - tipoRecurso)
        (unidadLibre ?u - unidad)
        (locLibre ?x - localizacion) ;;Para construir edificio
        (conectado ?x - localizacion ?y - localizacion)
        (esRecurso ?r - recurso ?y - tipoRecurso)
        (esEdificio ?b - edificio ?y - tipoEdificio)
        (esUnidad ?v - unidad ?y - tipoUnidad)
        (extractorEn ?x - localizacion)
    )
    
    
    (:action Navegar
        :parameters(?u - unidad ?x - localizacion ?y - localizacion)
        :precondition
            (and
                (en ?u ?x)
                (conectado ?x ?y)
                (unidadLibre ?u)
            )
        :effect
            (and
                (en ?u ?y)
                (not (en ?u ?x))
            )
    )

    (:action Asignar
        :parameters (?u - unidad ?r - recurso ?y - localizacion)
        :precondition(or
            (and (esRecurso ?r mineral) (unidadLibre ?u) (asignadoLoc ?r ?y) (en ?u ?y) (esUnidad ?u VCE))
            (and (esRecurso ?r gas) (unidadLibre ?u) (asignadoLoc ?r ?y) (en ?u ?y) (extractorEn ?y) (esUnidad ?u VCE))
            )
        :effect
            (and
                (extrayendo ?u ?r)
                (not (unidadLibre ?u))
                (when (and (esRecurso ?r gas))
                    (recursoObtenido gas)
                )
                (when (and (esRecurso ?r mineral))
                    (recursoObtenido mineral)
                )
                
            )
    )


    (:action Construir
        :parameters (?u - unidad ?e - edificio ?t - tipoEdificio ?y - localizacion)
        :precondition (and
                (esEdificio ?e ?t)
                (locLibre ?y)
                (unidadLibre ?u)
                (en ?u ?y)
                (esUnidad ?u VCE)
                (imply (necesita2 mineral gas ?t) (and (recursoObtenido mineral)
            (recursoObtenido gas)))
                (imply (necesita2 gas mineral ?t) (and (recursoObtenido mineral)
            (recursoObtenido gas)))
                (imply (necesita mineral ?t) (and (recursoObtenido mineral)))
                (imply (necesita gas ?t) (and (recursoObtenido gas)))
        )
        :effect
            (and
                (en ?e ?y)
                (not (locLibre ?y))
                (when (and (esEdificio ?e extractor))
                    (extractorEn ?y)
                )
            )
    )

    (:action Reclutar
        :parameters (?u - unidad ?e - edificio ?y - localizacion)
        :precondition (or
            (and (esUnidad ?u VCE) (recursoObtenido mineral) (esEdificio ?e centroDeMando) 
            (en ?e ?y) (unidadLibre ?u))
            (and (esUnidad ?u marines) (recursoObtenido mineral) (esEdificio ?e barracones) 
            (en ?e ?y))
            (and (esUnidad ?u segadores) (recursoObtenido mineral) (recursoObtenido gas) 
                (esEdificio ?e barracones) (en ?e ?y))
        )
        :effect
            (and
                (en ?u ?y)
                (unidadLibre ?u)
            )
    )
    
)