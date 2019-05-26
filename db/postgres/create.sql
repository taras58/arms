/*пользователи, ссылочные данные, наблюдаемый объект*/
CREATE TABLE public.user_e
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    login character varying(255),
    "password" character varying(255),
    email character varying(255),
    phone character varying(255),
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT user_e_pkey PRIMARY KEY (id),
    CONSTRAINT user_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.role
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT role_pkey PRIMARY KEY (id),
    CONSTRAINT role_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.ref_group
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT ref_group_pkey PRIMARY KEY (id),
    CONSTRAINT ref_group_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.ref_data
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
	"group" integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT ref_data_pkey PRIMARY KEY (id),
    CONSTRAINT ref_data_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ref_data_group_fkey FOREIGN KEY ("group")
        REFERENCES public.ref_group (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.application
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    xml_properties text,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT application_pkey PRIMARY KEY (id),
    CONSTRAINT application_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.component
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    parent integer,
    application integer,
    "type" integer,
    xml_properties text,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT component_pkey PRIMARY KEY (id),
    CONSTRAINT component_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT component_parent_fkey FOREIGN KEY (parent)
        REFERENCES public.component (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT component_application_fkey FOREIGN KEY (application)
        REFERENCES public.application (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT component_type_fkey FOREIGN KEY ("type")
        REFERENCES public.ref_data (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.user_role
(
    id serial NOT NULL ,
    description character varying(1024) COLLATE pg_catalog."default",
    application integer,
    user_e integer,
    "role" integer,
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT user_role_pkey PRIMARY KEY (id),
    CONSTRAINT user_role_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_role_application_fkey FOREIGN KEY (application)
        REFERENCES public.application (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_role_user_fkey FOREIGN KEY (user_e)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_role_role_fkey FOREIGN KEY ("role")
        REFERENCES public.role (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

)
WITH (
    OIDS = FALSE
);

/*сеть петри*/
CREATE TABLE public.marker
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT marker_pkey PRIMARY KEY (id),
    CONSTRAINT marker_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION

)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.field_marker
(
    id serial NOT NULL ,
    description character varying(1024) COLLATE pg_catalog."default",
    "value" text,
    "type" integer,
    marker integer,
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT field_marker_pkey PRIMARY KEY (id),
    CONSTRAINT field_marker_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT field_marker_type_fkey FOREIGN KEY ("type")
        REFERENCES public.ref_data (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT field_marker_marker_fkey FOREIGN KEY (marker)
        REFERENCES public.marker (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);


CREATE TABLE public.direction
(
    id serial NOT NULL ,
    "type" integer,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT direction_pkey PRIMARY KEY (id),
    CONSTRAINT direction_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT direction_type_fkey FOREIGN KEY ("type")
        REFERENCES public.ref_data (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);


CREATE TABLE public.position
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT position_pkey PRIMARY KEY (id),
    CONSTRAINT position_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.transition
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
	"condition" text,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT transition_pkey PRIMARY KEY (id),
    CONSTRAINT transition_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.transition_position
(
    id serial NOT NULL ,
    direction integer,
    marker integer,
    "position" integer,
    transition integer,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT transition_position_pkey PRIMARY KEY (id),
    CONSTRAINT transition_position_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT transition_position_direction_fkey FOREIGN KEY (direction)
        REFERENCES public.direction (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT transition_position_marker_fkey FOREIGN KEY (marker)
        REFERENCES public.marker (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT transition_position_position_fkey FOREIGN KEY ("position")
        REFERENCES public.position (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT transition_position_transition_fkey FOREIGN KEY (transition)
        REFERENCES public.transition (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

/*активные правила*/
CREATE TABLE public.package
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
	parent integer,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT package_pkey PRIMARY KEY (id),
    CONSTRAINT package_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT package_parent_fkey FOREIGN KEY (parent)
        REFERENCES public.package (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.context
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
	xml_properties text,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT context_pkey PRIMARY KEY (id),
    CONSTRAINT context_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.condition_event
(
    id serial NOT NULL ,
	script text,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT condition_event_pkey PRIMARY KEY (id),
    CONSTRAINT condition_event_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);


CREATE TABLE public.complex_event
(
    id serial NOT NULL ,
	initiator integer,
	"expression" text,
	time_limit integer,
    CONSTRAINT complex_event_pkey PRIMARY KEY (id)    
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.event
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
	"type" integer,
	"condition" integer,
	context integer,
	complex_event integer,
	"source" integer,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT event_pkey PRIMARY KEY (id),
    CONSTRAINT event_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT event_type_fkey FOREIGN KEY ("type")
        REFERENCES public.ref_data (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT event_condition_fkey FOREIGN KEY ("condition")
        REFERENCES public.condition_event (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT event_context_fkey FOREIGN KEY (context)
        REFERENCES public.context (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT event_complex_event_fkey FOREIGN KEY (complex_event)
        REFERENCES public.complex_event (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT event_source_fkey FOREIGN KEY ("source")
        REFERENCES public.component (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

alter table complex_event add CONSTRAINT complex_event_initiator_fkey FOREIGN KEY (initiator)
        REFERENCES public.event (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO action;

CREATE TABLE public.rule
(
    id serial NOT NULL ,
    "name" character varying(255) COLLATE pg_catalog."default" NOT NULL,
	package integer,
	linking_mode integer,
	"type" integer,
	"state" integer,
	"event" integer,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT rule_pkey PRIMARY KEY (id),
    CONSTRAINT rule_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT rule_package_fkey FOREIGN KEY (package)
        REFERENCES public.package (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT rule_event_fkey FOREIGN KEY ("event")
        REFERENCES public.event (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT rule_linking_mode_fkey FOREIGN KEY (linking_mode)
        REFERENCES public.ref_data (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT rule_type_fkey FOREIGN KEY ("type")
        REFERENCES public.ref_data (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT rule_state_fkey FOREIGN KEY ("state")
        REFERENCES public.ref_data (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

CREATE TABLE public.condition
(
    id serial NOT NULL ,
	script text,
	context integer,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT condition_pkey PRIMARY KEY (id),
    CONSTRAINT condition_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT condition_context_fkey FOREIGN KEY (context)
        REFERENCES public.context (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);


CREATE TABLE public.action
(
    id serial NOT NULL ,
	script text,
	context integer,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT action_pkey PRIMARY KEY (id),
    CONSTRAINT action_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT action_context_fkey FOREIGN KEY (context)
        REFERENCES public.context (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);


CREATE TABLE public.block_rule
(
    id serial NOT NULL ,
	"condition" integer,
	"action" integer,
	alternative_action integer,
	"rule" integer,
	call_mode integer,
    description character varying(1024) COLLATE pg_catalog."default",
    updu integer,
    updt timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ver integer,
    CONSTRAINT block_rule_pkey PRIMARY KEY (id),
    CONSTRAINT block_rule_updu_fkey FOREIGN KEY (updu)
        REFERENCES public.user_e (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT block_rule_action_fkey FOREIGN KEY ("action")
        REFERENCES public.action (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT block_rule_alternative_action_fkey FOREIGN KEY ("action")
        REFERENCES public.action (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT block_rule_rule_fkey FOREIGN KEY ("rule")
        REFERENCES public.rule (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT block_rule_call_mode_fkey FOREIGN KEY (call_mode)
        REFERENCES public.ref_data (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT block_rule_condition_fkey FOREIGN KEY ("condition")
        REFERENCES public.condition (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);
