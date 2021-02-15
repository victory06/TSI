(define (domain Terran)
    (:requirements :strips :typing :adl :fluents)
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
        VCE marines segadores - tipoUnidad
        impulsorsegador - tipoInvestigacion
        
    )
    (:predicates
        (en ?obj - object ?x - localizacion)
        (conectado ?x - localizacion ?y - localizacion)
        (extrayendo ?u - unidad ?r - recurso)
        (unidadLibre ?u - unidad)
        (unidadCreada ?u - unidad)
        (locLibreEdif ?x - localizacion)
        (esRecurso ?r - recurso ?y - tipoRecurso)
        (esEdificio ?b - edificio ?y - tipoEdificio)
        (esUnidad ?v - unidad ?y - tipoUnidad)
        (esInvestigacion ?i - investigacion ?y - tipoInvestigacion)
        (creadoEn ?u - tipoUnidad ?e - tipoEdificio)
        (investigacionCompletada ?t - tipoInvestigacion)
        (edificioCreado ?b - tipoEdificio)
    )
    (:functions
        (disponible ?t - tipoRecurso)
        (numAsignados ?r - recurso)
        (necesario ?x - object ?t - tipoRecurso)
        (capacidad ?t - tipoRecurso)
    )
    
    (:action Navegar
        :parameters(?u - unidad ?x - localizacion ?y - localizacion)
        :precondition
            (and
		(unidadLibre ?u)
                (en ?u ?x)
                (conectado ?x ?y)
            )
        :effect
            (and
                (en ?u ?y)
                (not (en ?u ?x))
            )
    )

    (:action Asignar
        :parameters (?u - unidad ?r - recurso ?y - localizacion)
        :precondition
            (and (unidadLibre ?u) (en ?r ?y) (en ?u ?y) (esUnidad ?u VCE) (or (esRecurso ?r mineral) (en extractor ?y)))
        :effect
            (and
                (extrayendo ?u ?r)
                (not (unidadLibre ?u))
                (increase (numAsignados ?r) 1)
            )
    )
    (:action Construir
        :parameters (?u - unidad ?e - edificio ?t - tipoEdificio ?y - localizacion)
        :precondition
            (and
                (esEdificio ?e ?t)
                (locLibreEdif ?y) (unidadLibre ?u)
                (en ?u ?y) (esUnidad ?u VCE)
                (>= (disponible mineral) (necesario ?t mineral))
                (>= (disponible gas) (necesario ?t gas))
            )
        :effect
            (and
                (en ?e ?y)
                (edificioCreado ?t)
                (not (locLibreEdif ?y))
                (when (esEdificio ?e extractor) 
                    (en extractor ?y) 
                )
                (when (esEdificio ?e deposito) 
                    (and (increase (capacidad gas) 100) 
                        (increase (capacidad mineral) 100))
                )
                (decrease (disponible mineral) (necesario ?t mineral))
                (decrease (disponible gas) (necesario ?t gas))
            )
    )
    (:action Reclutar
        :parameters (?u - unidad ?t - tipoUnidad ?e - edificio ?a - tipoEdificio ?y - localizacion)
        :precondition
            (and
                (not (unidadCreada ?u)) (esUnidad ?u ?t) 
                (esEdificio ?e ?a) (creadoEn ?t ?a) (en ?e ?y)
                (or (not (esUnidad ?u segadores)) (investigacionCompletada impulsorSegador))
                (>= (disponible mineral) (necesario ?t mineral))
                (>= (disponible gas) (necesario ?t gas))
            )
        :effect
            (and
                (en ?u ?y)
                (unidadLibre ?u) (unidadCreada ?u)
                (decrease (disponible mineral) (necesario ?t mineral))
                (decrease (disponible gas) (necesario ?t gas))
            )
    )
    (:action Investigar
        :parameters (?i - investigacion ?t - tipoInvestigacion)
        :precondition
            (and
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
    (:action Desasignar
        :parameters (?u - unidad ?r - recurso ?y - localizacion)
        :precondition
            (and (extrayendo ?u ?r) (en ?r ?y) (en ?u ?y))
        :effect
            (and
                (not (extrayendo ?u ?r))
                (unidadLibre ?u)
                (decrease (numAsignados ?r) 1)
            )
    )
    (:action Recolectar
        :parameters (?r - recurso ?t - tipoRecurso)
        :precondition
            (and (> (numAsignados ?r) 0) (esRecurso ?r ?t)
                (<= (+ (* (numAsignados ?r) 25)(disponible ?t) ) (capacidad ?t) )
	    )
        :effect
            (and
                (increase (disponible ?t) (* (numAsignados ?r) 25))
            )
    )
)
