(define (domain Terran)
    (:requirements :strips :typing)
    (:types
        unidad localizacion edificio recurso investigacion - object
        
    )
    (:constants
        tipoEdificio - edificio
        tipoRecurso - recurso
        tipoUnidad - unidad
        tipoInvestigacion - investigacion
        centroDeMando barracones extractor bahiaDeIngenieria deposito - tipoEdificio
        mineral gas - tipoRecurso
        VCE marines segadores - TipoUnidad
        impulsorSegador - tipoInvestigacion
        
    )
    (:predicates
        (en ?obj - object ?x - localizacion)
        (extrayendo ?u - unidad ?r - recurso)
        (unidadLibre ?u - unidad)
        (locLibre ?x - localizacion) ;;Para construir edificio
        (conectado ?x - localizacion ?y - localizacion)
        (esRecurso ?r - recurso ?y - tipoRecurso)
        (esEdificio ?b - edificio ?y - tipoEdificio)
        (esUnidad ?v - unidad ?y - tipoUnidad)
        (extractorEn ?x - localizacion)
        (edificioCreado ?b - tipoEdificio)
        (esInvestigacion ?i - investigacion ?y - tipoInvestigacion)
        (investigacionCompletada ?t - tipoInvestigacion)
        (creadoEn ?t - tipoUnidad ?s - tipoEdificio)
        (unidadCreada ?u - unidad)
    )

    (:functions 
        (capacidad ?r - tipoRecurso) - number
        (numAsignados ?r - recurso) - number
        (disponible ?t - tipoRecurso) - number
        (necesario ?x - object ?t - tipoRecurso) - number
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
        :precondition(and  (unidadLibre ?u) (en ?r ?y) (en ?u ?y) (esUnidad ?u VCE)
            (or (esRecurso ?r mineral) (extractorEn ?y))
            )
        :effect
            (and
                (extrayendo ?u ?r)
                (not (unidadLibre ?u))
                (increase (numAsignados ?r) 1)                
            )
    )

    (:action Desasignar
        :parameters (?u - unidad ?r - recurso ?y - localizacion)
        :precondition(and
            (extrayendo ?u ?r) (en ?u ?y) (en ?r ?y)
            )
        :effect
            (and
                (not (extrayendo ?u ?r))
                (unidadLibre ?u)
                (decrease (numAsignados ?r) 1)
                
            )
    )


    (:action Recolectar
        :parameters (?r - recurso ?t - tipoRecurso)
        :precondition(and
            (esRecurso ?r ?t) (> (numAsignados ?r) 0)
            (<= (+ (disponible ?t) (* (numAsignados ?r) 25)) (capacidad ?t))
        )
        :effect(and
            (increase (disponible ?t)  (* (numAsignados ?r) 25))
        )

    )

    (:action Construir
        :parameters (?u - unidad ?e - edificio ?t - tipoEdificio ?y - localizacion)
        :precondition (and
                (esEdificio ?e ?t)
                (locLibre ?y)
                (unidadLibre ?u)
                (esUnidad ?u VCE)
                (en ?u ?y)
                (>= (disponible mineral) (necesario ?t mineral))
                (>= (disponible gas) (necesario ?t gas))
        )
        :effect
            (and
                (en ?e ?y)
                (not (locLibre ?y))
                (edificioCreado ?t)
                (when (esEdificio ?e extractor)
                    (extractorEn ?y)
                )
                (when (esEdificio ?e deposito)
                    (and (increase (capacidad gas) 100)
                    (increase (capacidad mineral) 100))
                )
                (decrease (disponible gas) (necesario ?t gas))
                (decrease (disponible mineral) (necesario ?t mineral))
            )
    )

    (:action Reclutar
        :parameters (?u - unidad ?t - tipoUnidad ?e - edificio ?s - tipoEdificio ?y - localizacion)
        :precondition (and (not (unidadCreada ?u))
        (esUnidad ?u ?t) (esEdificio ?e ?s) (creadoEn ?t ?s) (en ?e ?y) 
        (or (not (esUnidad ?u segadores)) (investigacionCompletada impulsorSegador))
        (>= (disponible mineral) (necesario ?t mineral) )
        (>= (disponible gas) (necesario ?t gas) )
        )
        :effect
            (and
                (en ?u ?y)
                (unidadLibre ?u)
                (unidadCreada ?u)
                (decrease (disponible gas) (necesario ?t gas))
                (decrease (disponible mineral) (necesario ?t mineral))
            )
    )
 
    (:action Investigar
        :parameters (?i - investigacion ?t - tipoInvestigacion)
        :precondition(and
            (esInvestigacion ?i ?t)
            (edificioCreado bahiaDeIngenieria)
            (>= (disponible mineral) (necesario ?t mineral))
            (>= (disponible gas) (necesario ?t gas))
            )
        :effect
            (and
                (investigacionCompletada ?t)
                (decrease (disponible mineral) (necesario ?t mineral))
                (decrease (disponible gas) (necesario ?t gas))
            )
    )


)