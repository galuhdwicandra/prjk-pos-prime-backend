--
-- PostgreSQL database dump
--

\restrict iVlsNt0YhucFzSamq2yWXpH69R3mh2s07JA10I53DgmIEdjJe7rUVHZOula51Xq

-- Dumped from database version 18.0 (Ubuntu 18.0-1.pgdg24.04+3)
-- Dumped by pg_dump version 18.0 (Ubuntu 18.0-1.pgdg24.04+3)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."accounts" (
    "id" bigint NOT NULL,
    "cabang_id" bigint,
    "code" character varying(32) NOT NULL,
    "name" character varying(160) NOT NULL,
    "type" character varying(20) NOT NULL,
    "normal_balance" character varying(6) NOT NULL,
    "parent_id" bigint,
    "is_active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."accounts_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."accounts_id_seq" OWNED BY "public"."accounts"."id";


--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."audit_logs" (
    "id" bigint NOT NULL,
    "actor_type" character varying(50) NOT NULL,
    "actor_id" bigint,
    "action" character varying(120) NOT NULL,
    "model" character varying(120) NOT NULL,
    "model_id" bigint NOT NULL,
    "diff_json" json NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    "occurred_at" timestamp(0) without time zone
);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."audit_logs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."audit_logs_id_seq" OWNED BY "public"."audit_logs"."id";


--
-- Name: backups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."backups" (
    "id" bigint NOT NULL,
    "storage_path" character varying(512) NOT NULL,
    "kind" character varying(255) NOT NULL,
    "size_bytes" bigint NOT NULL,
    "created_at" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT "backups_kind_check" CHECK ((("kind")::"text" = ANY ((ARRAY['DB'::character varying, 'FILES'::character varying])::"text"[])))
);


--
-- Name: backups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."backups_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: backups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."backups_id_seq" OWNED BY "public"."backups"."id";


--
-- Name: cabangs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."cabangs" (
    "id" bigint NOT NULL,
    "nama" character varying(120) NOT NULL,
    "kota" character varying(120),
    "alamat" character varying(255),
    "telepon" character varying(30),
    "jam_operasional" character varying(120),
    "is_active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: cabangs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."cabangs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cabangs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."cabangs_id_seq" OWNED BY "public"."cabangs"."id";


--
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."cache" (
    "key" character varying(255) NOT NULL,
    "value" "text" NOT NULL,
    "expiration" integer NOT NULL
);


--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."cache_locks" (
    "key" character varying(255) NOT NULL,
    "owner" character varying(255) NOT NULL,
    "expiration" integer NOT NULL
);


--
-- Name: cash_holders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."cash_holders" (
    "id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "name" character varying(120) NOT NULL,
    "balance" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: cash_holders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."cash_holders_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cash_holders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."cash_holders_id_seq" OWNED BY "public"."cash_holders"."id";


--
-- Name: cash_moves; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."cash_moves" (
    "id" bigint NOT NULL,
    "from_holder_id" bigint NOT NULL,
    "to_holder_id" bigint NOT NULL,
    "amount" numeric(18,2) NOT NULL,
    "note" "text",
    "moved_at" timestamp(0) without time zone NOT NULL,
    "status" character varying(255) DEFAULT 'DRAFT'::character varying NOT NULL,
    "submitted_by" bigint,
    "approved_by" bigint,
    "approved_at" timestamp(0) without time zone,
    "rejected_at" timestamp(0) without time zone,
    "reject_reason" "text",
    "idempotency_key" character varying(64),
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    CONSTRAINT "cash_moves_status_check" CHECK ((("status")::"text" = ANY ((ARRAY['DRAFT'::character varying, 'SUBMITTED'::character varying, 'APPROVED'::character varying, 'REJECTED'::character varying])::"text"[])))
);


--
-- Name: cash_moves_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."cash_moves_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cash_moves_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."cash_moves_id_seq" OWNED BY "public"."cash_moves"."id";


--
-- Name: cash_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."cash_sessions" (
    "id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "cashier_id" bigint NOT NULL,
    "opening_amount" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "closing_amount" numeric(18,2),
    "status" character varying(255) DEFAULT 'OPEN'::character varying NOT NULL,
    "opened_at" timestamp(0) without time zone NOT NULL,
    "closed_at" timestamp(0) without time zone,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    CONSTRAINT "cash_sessions_status_check" CHECK ((("status")::"text" = ANY ((ARRAY['OPEN'::character varying, 'CLOSED'::character varying])::"text"[])))
);


--
-- Name: cash_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."cash_sessions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cash_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."cash_sessions_id_seq" OWNED BY "public"."cash_sessions"."id";


--
-- Name: cash_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."cash_transactions" (
    "id" bigint NOT NULL,
    "session_id" bigint NOT NULL,
    "type" character varying(255) NOT NULL,
    "amount" numeric(18,2) NOT NULL,
    "source" character varying(255) NOT NULL,
    "ref_type" character varying(50),
    "ref_id" bigint,
    "note" "text",
    "occurred_at" timestamp(0) without time zone NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    CONSTRAINT "cash_transactions_source_check" CHECK ((("source")::"text" = ANY ((ARRAY['ORDER'::character varying, 'MANUAL'::character varying, 'REFUND'::character varying])::"text"[]))),
    CONSTRAINT "cash_transactions_type_check" CHECK ((("type")::"text" = ANY ((ARRAY['IN'::character varying, 'OUT'::character varying])::"text"[])))
);


--
-- Name: cash_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."cash_transactions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cash_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."cash_transactions_id_seq" OWNED BY "public"."cash_transactions"."id";


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."categories" (
    "id" bigint NOT NULL,
    "nama" character varying(120) NOT NULL,
    "slug" character varying(140) NOT NULL,
    "deskripsi" "text",
    "is_active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."categories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."categories_id_seq" OWNED BY "public"."categories"."id";


--
-- Name: customer_timelines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."customer_timelines" (
    "id" bigint NOT NULL,
    "customer_id" bigint NOT NULL,
    "event_type" character varying(40) NOT NULL,
    "title" character varying(190),
    "note" "text",
    "meta" "jsonb",
    "happened_at" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: customer_timelines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."customer_timelines_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_timelines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."customer_timelines_id_seq" OWNED BY "public"."customer_timelines"."id";


--
-- Name: customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."customers" (
    "id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "nama" character varying(120) NOT NULL,
    "phone" character varying(30) NOT NULL,
    "email" character varying(190),
    "alamat" character varying(255),
    "catatan" character varying(255),
    "stage" character varying(30) DEFAULT 'ACTIVE'::character varying NOT NULL,
    "last_order_at" timestamp(0) without time zone,
    "total_spent" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "total_orders" bigint DEFAULT '0'::bigint NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."customers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."customers_id_seq" OWNED BY "public"."customers"."id";


--
-- Name: deliveries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."deliveries" (
    "id" bigint NOT NULL,
    "order_id" bigint NOT NULL,
    "assigned_to" bigint,
    "type" character varying(255) DEFAULT 'DELIVERY'::character varying NOT NULL,
    "status" character varying(255) DEFAULT 'REQUESTED'::character varying NOT NULL,
    "pickup_address" character varying(255),
    "delivery_address" character varying(255),
    "pickup_lat" numeric(10,7),
    "pickup_lng" numeric(10,7),
    "delivery_lat" numeric(10,7),
    "delivery_lng" numeric(10,7),
    "requested_at" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "completed_at" timestamp(0) without time zone,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    "sj_number" character varying(255),
    "sj_issued_at" timestamp(0) without time zone,
    CONSTRAINT "deliveries_status_check" CHECK ((("status")::"text" = ANY ((ARRAY['REQUESTED'::character varying, 'ASSIGNED'::character varying, 'PICKED_UP'::character varying, 'ON_ROUTE'::character varying, 'DELIVERED'::character varying, 'FAILED'::character varying, 'CANCELLED'::character varying])::"text"[]))),
    CONSTRAINT "deliveries_type_check" CHECK ((("type")::"text" = ANY ((ARRAY['PICKUP'::character varying, 'DELIVERY'::character varying, 'BOTH'::character varying])::"text"[])))
);


--
-- Name: deliveries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."deliveries_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."deliveries_id_seq" OWNED BY "public"."deliveries"."id";


--
-- Name: delivery_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."delivery_events" (
    "id" bigint NOT NULL,
    "delivery_id" bigint NOT NULL,
    "status" character varying(50) NOT NULL,
    "note" "text",
    "photo_url" "text",
    "occurred_at" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: delivery_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."delivery_events_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."delivery_events_id_seq" OWNED BY "public"."delivery_events"."id";


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."failed_jobs" (
    "id" bigint NOT NULL,
    "uuid" character varying(255) NOT NULL,
    "connection" "text" NOT NULL,
    "queue" "text" NOT NULL,
    "payload" "text" NOT NULL,
    "exception" "text" NOT NULL,
    "failed_at" timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."failed_jobs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."failed_jobs_id_seq" OWNED BY "public"."failed_jobs"."id";


--
-- Name: fee_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."fee_entries" (
    "id" bigint NOT NULL,
    "fee_id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "period_date" "date" NOT NULL,
    "ref_type" character varying(255) NOT NULL,
    "ref_id" bigint NOT NULL,
    "owner_user_id" bigint,
    "base_amount" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "fee_amount" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "pay_status" character varying(255) DEFAULT 'UNPAID'::character varying NOT NULL,
    "paid_amount" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "paid_at" timestamp(0) without time zone,
    "notes" character varying(255),
    "created_by" bigint,
    "updated_by" bigint,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    CONSTRAINT "fee_entries_pay_status_check" CHECK ((("pay_status")::"text" = ANY ((ARRAY['UNPAID'::character varying, 'PAID'::character varying, 'PARTIAL'::character varying])::"text"[]))),
    CONSTRAINT "fee_entries_ref_type_check" CHECK ((("ref_type")::"text" = ANY ((ARRAY['ORDER'::character varying, 'DELIVERY'::character varying])::"text"[])))
);


--
-- Name: fee_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."fee_entries_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fee_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."fee_entries_id_seq" OWNED BY "public"."fee_entries"."id";


--
-- Name: fees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."fees" (
    "id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "name" character varying(100) NOT NULL,
    "kind" character varying(255) NOT NULL,
    "calc_type" character varying(255) NOT NULL,
    "rate" numeric(10,2) NOT NULL,
    "base" character varying(255) NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "created_by" bigint,
    "updated_by" bigint,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    CONSTRAINT "fees_base_check" CHECK ((("base")::"text" = ANY ((ARRAY['GRAND_TOTAL'::character varying, 'DELIVERY'::character varying])::"text"[]))),
    CONSTRAINT "fees_calc_type_check" CHECK ((("calc_type")::"text" = ANY ((ARRAY['PERCENT'::character varying, 'FIXED'::character varying])::"text"[]))),
    CONSTRAINT "fees_kind_check" CHECK ((("kind")::"text" = ANY ((ARRAY['SALES'::character varying, 'CASHIER'::character varying, 'COURIER'::character varying])::"text"[])))
);


--
-- Name: fees_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."fees_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."fees_id_seq" OWNED BY "public"."fees"."id";


--
-- Name: fiscal_periods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."fiscal_periods" (
    "id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "year" smallint NOT NULL,
    "month" smallint NOT NULL,
    "status" character varying(6) DEFAULT 'OPEN'::character varying NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: fiscal_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."fiscal_periods_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fiscal_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."fiscal_periods_id_seq" OWNED BY "public"."fiscal_periods"."id";


--
-- Name: gudangs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."gudangs" (
    "id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "nama" character varying(120) NOT NULL,
    "is_default" boolean DEFAULT false NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: gudangs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."gudangs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gudangs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."gudangs_id_seq" OWNED BY "public"."gudangs"."id";


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."job_batches" (
    "id" character varying(255) NOT NULL,
    "name" character varying(255) NOT NULL,
    "total_jobs" integer NOT NULL,
    "pending_jobs" integer NOT NULL,
    "failed_jobs" integer NOT NULL,
    "failed_job_ids" "text" NOT NULL,
    "options" "text",
    "cancelled_at" integer,
    "created_at" integer NOT NULL,
    "finished_at" integer
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."jobs" (
    "id" bigint NOT NULL,
    "queue" character varying(255) NOT NULL,
    "payload" "text" NOT NULL,
    "attempts" smallint NOT NULL,
    "reserved_at" integer,
    "available_at" integer NOT NULL,
    "created_at" integer NOT NULL
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."jobs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."jobs_id_seq" OWNED BY "public"."jobs"."id";


--
-- Name: journal_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."journal_entries" (
    "id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "journal_date" "date" NOT NULL,
    "number" character varying(40) NOT NULL,
    "description" character varying(255),
    "status" character varying(6) DEFAULT 'DRAFT'::character varying NOT NULL,
    "period_year" smallint NOT NULL,
    "period_month" smallint NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: journal_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."journal_entries_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journal_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."journal_entries_id_seq" OWNED BY "public"."journal_entries"."id";


--
-- Name: journal_lines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."journal_lines" (
    "id" bigint NOT NULL,
    "journal_id" bigint NOT NULL,
    "account_id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "debit" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "credit" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "ref_type" character varying(50),
    "ref_id" bigint,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: journal_lines_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."journal_lines_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journal_lines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."journal_lines_id_seq" OWNED BY "public"."journal_lines"."id";


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."migrations" (
    "id" integer NOT NULL,
    "migration" character varying(255) NOT NULL,
    "batch" integer NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."migrations_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."migrations_id_seq" OWNED BY "public"."migrations"."id";


--
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."model_has_permissions" (
    "permission_id" bigint NOT NULL,
    "model_type" character varying(255) NOT NULL,
    "model_id" bigint NOT NULL
);


--
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."model_has_roles" (
    "role_id" bigint NOT NULL,
    "model_type" character varying(255) NOT NULL,
    "model_id" bigint NOT NULL
);


--
-- Name: order_change_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."order_change_logs" (
    "id" bigint NOT NULL,
    "order_id" bigint NOT NULL,
    "actor_id" bigint,
    "action" character varying(50) NOT NULL,
    "diff_json" json,
    "note" "text",
    "occurred_at" timestamp(0) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "created_at" timestamp(0) with time zone,
    "updated_at" timestamp(0) with time zone
);


--
-- Name: order_change_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."order_change_logs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_change_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."order_change_logs_id_seq" OWNED BY "public"."order_change_logs"."id";


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."order_items" (
    "id" bigint NOT NULL,
    "order_id" bigint NOT NULL,
    "variant_id" bigint NOT NULL,
    "name_snapshot" character varying(200) NOT NULL,
    "price" numeric(18,2) NOT NULL,
    "discount" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "qty" numeric(18,2) NOT NULL,
    "line_total" numeric(18,2) NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."order_items_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."order_items_id_seq" OWNED BY "public"."order_items"."id";


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."orders" (
    "id" bigint NOT NULL,
    "kode" character varying(50) NOT NULL,
    "cabang_id" bigint NOT NULL,
    "gudang_id" bigint NOT NULL,
    "cashier_id" bigint NOT NULL,
    "customer_id" bigint,
    "status" character varying(255) DEFAULT 'DRAFT'::character varying NOT NULL,
    "subtotal" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "discount" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "tax" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "service_fee" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "grand_total" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "paid_total" numeric(18,2) DEFAULT '0'::numeric NOT NULL,
    "channel" character varying(255) DEFAULT 'POS'::character varying NOT NULL,
    "note" "text",
    "ordered_at" timestamp(0) without time zone NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    "paid_at" timestamp(0) with time zone,
    "customer_name" character varying(191),
    "customer_phone" character varying(30),
    "customer_address" "text",
    "cash_position" character varying(16),
    CONSTRAINT "orders_cash_position_check" CHECK ((("cash_position" IS NULL) OR (("cash_position")::"text" = ANY ((ARRAY['CUSTOMER'::character varying, 'CASHIER'::character varying, 'SALES'::character varying, 'ADMIN'::character varying])::"text"[])))),
    CONSTRAINT "orders_channel_check" CHECK ((("channel")::"text" = ANY ((ARRAY['POS'::character varying, 'ONLINE'::character varying])::"text"[]))),
    CONSTRAINT "orders_status_check" CHECK ((("status")::"text" = ANY ((ARRAY['DRAFT'::character varying, 'UNPAID'::character varying, 'PAID'::character varying, 'VOID'::character varying, 'REFUND'::character varying])::"text"[])))
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."orders_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."orders_id_seq" OWNED BY "public"."orders"."id";


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."payments" (
    "id" bigint NOT NULL,
    "order_id" bigint NOT NULL,
    "method" character varying(255) NOT NULL,
    "amount" numeric(18,2) NOT NULL,
    "status" character varying(255) DEFAULT 'PENDING'::character varying NOT NULL,
    "ref_no" character varying(191),
    "payload_json" json,
    "paid_at" timestamp(0) without time zone,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    CONSTRAINT "payments_method_check" CHECK ((("method")::"text" = ANY ((ARRAY['CASH'::character varying, 'TRANSFER'::character varying, 'QRIS'::character varying, 'XENDIT'::character varying])::"text"[]))),
    CONSTRAINT "payments_status_check" CHECK ((("status")::"text" = ANY ((ARRAY['PENDING'::character varying, 'SUCCESS'::character varying, 'FAILED'::character varying, 'REFUND'::character varying])::"text"[])))
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."payments_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."payments_id_seq" OWNED BY "public"."payments"."id";


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."permissions" (
    "id" bigint NOT NULL,
    "name" character varying(255) NOT NULL,
    "guard_name" character varying(255) NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."permissions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."permissions_id_seq" OWNED BY "public"."permissions"."id";


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."personal_access_tokens" (
    "id" bigint NOT NULL,
    "tokenable_type" character varying(255) NOT NULL,
    "tokenable_id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "token" character varying(64) NOT NULL,
    "abilities" "text",
    "last_used_at" timestamp(0) without time zone,
    "expires_at" timestamp(0) without time zone,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."personal_access_tokens_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."personal_access_tokens_id_seq" OWNED BY "public"."personal_access_tokens"."id";


--
-- Name: product_media; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."product_media" (
    "id" bigint NOT NULL,
    "product_id" bigint NOT NULL,
    "disk" character varying(40) DEFAULT 'public'::character varying NOT NULL,
    "path" character varying(255) NOT NULL,
    "mime" character varying(100),
    "size_kb" integer,
    "is_primary" boolean DEFAULT false NOT NULL,
    "sort_order" smallint DEFAULT '0'::smallint NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: product_media_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."product_media_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."product_media_id_seq" OWNED BY "public"."product_media"."id";


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."product_variants" (
    "id" bigint NOT NULL,
    "product_id" bigint NOT NULL,
    "size" character varying(40),
    "type" character varying(60),
    "tester" character varying(40),
    "sku" character varying(80) NOT NULL,
    "harga" numeric(14,2) NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: product_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."product_variants_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."product_variants_id_seq" OWNED BY "public"."product_variants"."id";


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."products" (
    "id" bigint NOT NULL,
    "category_id" bigint NOT NULL,
    "nama" character varying(160) NOT NULL,
    "slug" character varying(180) NOT NULL,
    "deskripsi" "text",
    "is_active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."products_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."products_id_seq" OWNED BY "public"."products"."id";


--
-- Name: receipts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."receipts" (
    "id" bigint NOT NULL,
    "order_id" bigint NOT NULL,
    "print_format" smallint DEFAULT '58'::smallint NOT NULL,
    "html_snapshot" "text" NOT NULL,
    "wa_url" character varying(255),
    "printed_by" bigint,
    "printed_at" timestamp(0) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "reprint_of_id" bigint,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."receipts_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."receipts_id_seq" OWNED BY "public"."receipts"."id";


--
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."role_has_permissions" (
    "permission_id" bigint NOT NULL,
    "role_id" bigint NOT NULL
);


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."roles" (
    "id" bigint NOT NULL,
    "name" character varying(255) NOT NULL,
    "guard_name" character varying(255) NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."roles_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."roles_id_seq" OWNED BY "public"."roles"."id";


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."settings" (
    "id" bigint NOT NULL,
    "scope" character varying(255) NOT NULL,
    "scope_id" bigint,
    "key" character varying(150) NOT NULL,
    "value_json" json NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    CONSTRAINT "settings_scope_check" CHECK ((("scope")::"text" = ANY ((ARRAY['GLOBAL'::character varying, 'BRANCH'::character varying, 'USER'::character varying])::"text"[])))
);


--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."settings_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."settings_id_seq" OWNED BY "public"."settings"."id";


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."users" (
    "id" bigint NOT NULL,
    "name" character varying(120) NOT NULL,
    "email" character varying(190) NOT NULL,
    "phone" character varying(30),
    "password" character varying(255) NOT NULL,
    "cabang_id" bigint,
    "role" character varying(255) NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "remember_token" character varying(100),
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone,
    "email_verified_at" timestamp(0) without time zone,
    CONSTRAINT "users_role_check" CHECK ((("role")::"text" = ANY ((ARRAY['superadmin'::character varying, 'admin_cabang'::character varying, 'gudang'::character varying, 'kasir'::character varying, 'sales'::character varying, 'kurir'::character varying])::"text"[])))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."users_id_seq" OWNED BY "public"."users"."id";


--
-- Name: variant_stocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."variant_stocks" (
    "id" bigint NOT NULL,
    "cabang_id" bigint NOT NULL,
    "gudang_id" bigint NOT NULL,
    "product_variant_id" bigint NOT NULL,
    "qty" integer DEFAULT 0 NOT NULL,
    "min_stok" integer DEFAULT 10 NOT NULL,
    "created_at" timestamp(0) without time zone,
    "updated_at" timestamp(0) without time zone
);


--
-- Name: variant_stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."variant_stocks_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: variant_stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."variant_stocks_id_seq" OWNED BY "public"."variant_stocks"."id";


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."accounts" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."accounts_id_seq"'::"regclass");


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."audit_logs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."audit_logs_id_seq"'::"regclass");


--
-- Name: backups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."backups" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."backups_id_seq"'::"regclass");


--
-- Name: cabangs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cabangs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."cabangs_id_seq"'::"regclass");


--
-- Name: cash_holders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_holders" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."cash_holders_id_seq"'::"regclass");


--
-- Name: cash_moves id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_moves" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."cash_moves_id_seq"'::"regclass");


--
-- Name: cash_sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_sessions" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."cash_sessions_id_seq"'::"regclass");


--
-- Name: cash_transactions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_transactions" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."cash_transactions_id_seq"'::"regclass");


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."categories" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."categories_id_seq"'::"regclass");


--
-- Name: customer_timelines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."customer_timelines" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."customer_timelines_id_seq"'::"regclass");


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."customers" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."customers_id_seq"'::"regclass");


--
-- Name: deliveries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."deliveries" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."deliveries_id_seq"'::"regclass");


--
-- Name: delivery_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."delivery_events" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."delivery_events_id_seq"'::"regclass");


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."failed_jobs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."failed_jobs_id_seq"'::"regclass");


--
-- Name: fee_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."fee_entries" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."fee_entries_id_seq"'::"regclass");


--
-- Name: fees id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."fees" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."fees_id_seq"'::"regclass");


--
-- Name: fiscal_periods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."fiscal_periods" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."fiscal_periods_id_seq"'::"regclass");


--
-- Name: gudangs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."gudangs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."gudangs_id_seq"'::"regclass");


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."jobs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."jobs_id_seq"'::"regclass");


--
-- Name: journal_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."journal_entries" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."journal_entries_id_seq"'::"regclass");


--
-- Name: journal_lines id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."journal_lines" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."journal_lines_id_seq"'::"regclass");


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."migrations" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."migrations_id_seq"'::"regclass");


--
-- Name: order_change_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."order_change_logs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."order_change_logs_id_seq"'::"regclass");


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."order_items" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."order_items_id_seq"'::"regclass");


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."orders" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."orders_id_seq"'::"regclass");


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."payments" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."payments_id_seq"'::"regclass");


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."permissions" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."permissions_id_seq"'::"regclass");


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."personal_access_tokens" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."personal_access_tokens_id_seq"'::"regclass");


--
-- Name: product_media id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."product_media" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."product_media_id_seq"'::"regclass");


--
-- Name: product_variants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."product_variants" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."product_variants_id_seq"'::"regclass");


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."products" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."products_id_seq"'::"regclass");


--
-- Name: receipts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."receipts" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."receipts_id_seq"'::"regclass");


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."roles" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."roles_id_seq"'::"regclass");


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."settings" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."settings_id_seq"'::"regclass");


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."users_id_seq"'::"regclass");


--
-- Name: variant_stocks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."variant_stocks" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."variant_stocks_id_seq"'::"regclass");


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."accounts" ("id", "cabang_id", "code", "name", "type", "normal_balance", "parent_id", "is_active", "created_at", "updated_at") FROM stdin;
1	1	1101	Kas	Asset	DEBIT	\N	t	2025-10-24 15:29:17	2025-10-24 15:29:17
2	1	3101	Modal	Equity	CREDIT	\N	t	2025-10-24 15:33:00	2025-10-24 15:33:00
4	\N	1102	Bank	Asset	DEBIT	\N	t	2025-10-24 20:14:39	2025-10-24 20:14:39
6	\N	1000	ASET	ASSET	DEBIT	\N	t	2025-10-24 21:41:22	2025-10-24 21:41:22
7	\N	1100	Kas & Bank	ASSET	DEBIT	6	t	2025-10-24 21:41:22	2025-10-24 21:41:22
8	\N	1110	Kas (Cash on Hand)	ASSET	DEBIT	7	t	2025-10-24 21:41:22	2025-10-24 21:41:22
9	\N	1120	Bank	ASSET	DEBIT	7	t	2025-10-24 21:41:22	2025-10-24 21:41:22
10	\N	1200	Piutang Usaha	ASSET	DEBIT	6	t	2025-10-24 21:41:22	2025-10-24 21:41:22
11	\N	1400	Persediaan Barang	ASSET	DEBIT	6	t	2025-10-24 21:41:22	2025-10-24 21:41:22
12	\N	2000	KEWAJIBAN	LIABILITY	CREDIT	\N	t	2025-10-24 21:41:22	2025-10-24 21:41:22
13	\N	2100	Hutang Usaha	LIABILITY	CREDIT	12	t	2025-10-24 21:41:22	2025-10-24 21:41:22
14	\N	3000	EKUITAS	EQUITY	CREDIT	\N	t	2025-10-24 21:41:22	2025-10-24 21:41:22
15	\N	3100	Modal Pemilik	EQUITY	CREDIT	14	t	2025-10-24 21:41:22	2025-10-24 21:41:22
16	\N	3200	Laba Ditahan	EQUITY	CREDIT	14	t	2025-10-24 21:41:22	2025-10-24 21:41:22
17	\N	4000	PENDAPATAN	REVENUE	CREDIT	\N	t	2025-10-24 21:41:22	2025-10-24 21:41:22
18	\N	4100	Penjualan	REVENUE	CREDIT	17	t	2025-10-24 21:41:22	2025-10-24 21:41:22
19	\N	4200	Diskon Penjualan (-)	REVENUE	CREDIT	17	t	2025-10-24 21:41:22	2025-10-24 21:41:22
20	\N	5000	HARGA POKOK PENJUALAN	EXPENSE	DEBIT	\N	t	2025-10-24 21:41:22	2025-10-24 21:41:22
21	\N	5100	HPP	EXPENSE	DEBIT	20	t	2025-10-24 21:41:22	2025-10-24 21:41:22
22	\N	6000	BEBAN OPERASIONAL	EXPENSE	DEBIT	\N	t	2025-10-24 21:41:22	2025-10-24 21:41:22
23	\N	6100	Beban Listrik & Air	EXPENSE	DEBIT	22	t	2025-10-24 21:41:22	2025-10-24 21:41:22
24	\N	6200	Beban Sewa	EXPENSE	DEBIT	22	t	2025-10-24 21:41:22	2025-10-24 21:41:22
25	\N	6300	Beban Gaji	EXPENSE	DEBIT	22	t	2025-10-24 21:41:22	2025-10-24 21:41:22
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."audit_logs" ("id", "actor_type", "actor_id", "action", "model", "model_id", "diff_json", "created_at", "updated_at", "occurred_at") FROM stdin;
1	USER	1	ORDER_ITEMS_UPDATED	Order	3	{"before":{"order":{"id":3,"kode":"PRM-1760497266-C1","status":"UNPAID","subtotal":"300000.00","discount":"0.00","tax":"0.00","service_fee":"0.00","grand_total":"300000.00","paid_total":"50000.00"},"items":[{"id":3,"variant_id":2,"name_snapshot":"Kue ulang tahun - ","price":"300000.00","discount":"0.00","qty":"1.00","line_total":"300000.00"}]},"after":{"order":{"id":3,"kode":"PRM-1760497266-C1","status":"UNPAID","subtotal":"480000.00","discount":"0.00","tax":"0.00","service_fee":"0.00","grand_total":"480000.00","paid_total":"50000.00"},"items":[{"id":3,"variant_id":2,"name_snapshot":"Kue ulang tahun - ","price":"300000.00","discount":"0.00","qty":"1.00","line_total":"300000.00"}]},"note":"Koreksi harga promo"}	2025-10-16 11:44:28	2025-10-16 11:44:28	\N
2	USER	1	ORDER_RECEIPT_REPRINTED	Order	3	{"format":"58","printed_at":"2025-10-16 13:15:21"}	2025-10-16 13:15:21	2025-10-16 13:15:21	\N
3	USER	1	ORDER_RECEIPT_REPRINTED	Order	3	{"format":"58","printed_at":"2025-10-16 13:22:01"}	2025-10-16 13:22:01	2025-10-16 13:22:01	\N
4	USER	1	ORDER_WA_RESEND	Order	3	{"phone":"6281214695222","message":"Terima kasih. Kode: PRM-1760..."}	2025-10-16 13:23:20	2025-10-16 13:23:20	\N
5	USER	5	ORDER_ITEMS_UPDATED	Order	4	{"before":{"order":{"id":4,"kode":"PRM-1760497768-C1","status":"UNPAID","subtotal":300000,"discount":0,"tax":0,"service_fee":0,"grand_total":300000,"paid_total":100000},"items":[{"id":4,"variant_id":2,"name_snapshot":"Kue ulang tahun - ","price":300000,"discount":0,"qty":1,"line_total":300000}]},"after":{"order":{"id":4,"kode":"PRM-1760497768-C1","status":"UNPAID","subtotal":300000,"discount":0,"tax":0,"service_fee":0,"grand_total":300000,"paid_total":100000},"items":[{"id":4,"variant_id":2,"name_snapshot":"Kue ulang tahun - ","price":300000,"discount":0,"qty":1,"line_total":300000}]},"note":null}	2025-10-16 14:24:26	2025-10-16 14:24:26	\N
6	USER	1	SUBMIT	cash_moves	3	{"after":{"from_holder_id":1,"to_holder_id":2,"amount":"50000.00","note":"Setor kas","moved_at":"2025-10-17T05:00:00.000000Z","status":"SUBMITTED","submitted_by":1,"idempotency_key":"shift-20251017-1200-u5","updated_at":"2025-10-17T07:01:20.000000Z","created_at":"2025-10-17T07:01:20.000000Z","id":3}}	2025-10-17 14:01:20	2025-10-17 14:01:20	\N
7	USER	1	APPROVE	cash_moves	3	{"before":{"from.balance":"250000.00","to.balance":"0.00","status":"SUBMITTED"},"after":{"from.balance":"200000","to.balance":"50000","status":"APPROVED"}}	2025-10-17 14:29:02	2025-10-17 14:29:02	\N
8	USER	5	SUBMIT	cash_moves	4	{"after":{"from_holder_id":2,"to_holder_id":1,"amount":"150000.00","note":null,"moved_at":"2025-10-16T17:00:00.000000Z","status":"SUBMITTED","submitted_by":5,"idempotency_key":"vhad474d6r.mgun2mcy","updated_at":"2025-10-17T09:21:24.000000Z","created_at":"2025-10-17T09:21:24.000000Z","id":4}}	2025-10-17 16:21:24	2025-10-17 16:21:24	\N
9	USER	6	REJECT	cash_moves	4	{"after":{"status":"REJECTED","reject_reason":"nyoba"}}	2025-10-17 16:46:53	2025-10-17 16:46:53	\N
10	USER	5	SUBMIT	cash_moves	5	{"after":{"from_holder_id":3,"to_holder_id":1,"amount":"60000.00","note":null,"moved_at":"2025-10-16T17:00:00.000000Z","status":"SUBMITTED","submitted_by":5,"idempotency_key":"jzcgun4wkpb.mguo10pa","updated_at":"2025-10-17T09:48:09.000000Z","created_at":"2025-10-17T09:48:09.000000Z","id":5}}	2025-10-17 16:48:09	2025-10-17 16:48:09	\N
11	USER	5	SUBMIT	cash_moves	6	{"after":{"from_holder_id":2,"to_holder_id":3,"amount":"300000.00","note":"[POS] PRM-1760768969-C1 \\u2014 Pelunasan Rp\\u00a0300.000","moved_at":"2025-10-17T23:29:59.000000Z","status":"SUBMITTED","submitted_by":5,"idempotency_key":"order:9\\/cash:1760768999538","updated_at":"2025-10-18T06:29:59.000000Z","created_at":"2025-10-18T06:29:59.000000Z","id":6}}	2025-10-18 13:29:59	2025-10-18 13:29:59	\N
12	USER	5	SUBMIT	cash_moves	7	{"after":{"from_holder_id":3,"to_holder_id":2,"amount":"600000.00","note":"[POS] PRM-1760770412-C1 \\u2014 Pelunasan Rp\\u00a0600.000","moved_at":"2025-10-18T00:18:40.000000Z","status":"SUBMITTED","submitted_by":5,"idempotency_key":"order:12\\/pay:14","updated_at":"2025-10-18T07:18:47.000000Z","created_at":"2025-10-18T07:18:47.000000Z","id":7}}	2025-10-18 14:18:47	2025-10-18 14:18:47	\N
13	USER	5	SUBMIT	cash_moves	8	{"after":{"from_holder_id":3,"to_holder_id":2,"amount":"1500000.00","note":"[POS] PRM-1760774615-C1 \\u2014 Pelunasan Rp\\u00a01.500.000","moved_at":"2025-10-18T01:03:58.000000Z","status":"SUBMITTED","submitted_by":5,"idempotency_key":"order:20\\/cash:1760774638517","updated_at":"2025-10-18T08:03:58.000000Z","created_at":"2025-10-18T08:03:58.000000Z","id":8}}	2025-10-18 15:03:58	2025-10-18 15:03:58	\N
14	USER	5	SUBMIT	cash_moves	9	{"after":{"from_holder_id":3,"to_holder_id":2,"amount":"200000.00","note":"[POS] PRM-1760770758-C1 \\u2014 Pelunasan Rp\\u00a0200.000","moved_at":"2025-10-18T01:28:38.000000Z","status":"SUBMITTED","submitted_by":5,"idempotency_key":"order:13\\/cash:1760776118180","updated_at":"2025-10-18T08:28:39.000000Z","created_at":"2025-10-18T08:28:39.000000Z","id":9}}	2025-10-18 15:28:39	2025-10-18 15:28:39	\N
15	USER	5	CASH_MIRROR	payments	22	{"holder_id":3,"amount":300000,"note":"ORDER#PRM-1760782139-C1","before":"0.00","after":"300000.00"}	2025-10-18 17:18:36	2025-10-18 17:18:36	\N
16	USER	5	CASH_MIRROR	payments	23	{"holder_id":3,"amount":1600000,"note":"ORDER#PRM-1760782766-C1","before":"300000.00","after":"1900000.00"}	2025-10-18 17:19:51	2025-10-18 17:19:51	\N
17	USER	6	APPROVE	cash_moves	9	{"before":{"from.balance":"1900000.00","to.balance":"50000.00","status":"SUBMITTED"},"after":{"from.balance":"1700000","to.balance":"250000","status":"APPROVED"}}	2025-10-18 17:21:08	2025-10-18 17:21:08	\N
18	USER	6	APPROVE	cash_moves	8	{"before":{"from.balance":"1700000.00","to.balance":"250000.00","status":"SUBMITTED"},"after":{"from.balance":"200000","to.balance":"1750000","status":"APPROVED"}}	2025-10-18 17:21:13	2025-10-18 17:21:13	\N
19	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T17:00:00.000000Z","to":"2025-10-23T16:59:59.999999Z"}	2025-10-23 11:11:27	2025-10-23 11:11:27	\N
20	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 11:12:09	2025-10-23 11:12:09	\N
21	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 11:12:30	2025-10-23 11:12:30	\N
22	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 11:16:25	2025-10-23 11:16:25	\N
23	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 13:24:44	2025-10-23 13:24:44	\N
24	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 13:24:45	2025-10-23 13:24:45	\N
25	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 13:24:47	2025-10-23 13:24:47	\N
26	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 13:24:47	2025-10-23 13:24:47	\N
27	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 13:24:49	2025-10-23 13:24:49	\N
28	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 13:24:50	2025-10-23 13:24:50	\N
29	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 13:24:51	2025-10-23 13:24:51	\N
30	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 13:24:53	2025-10-23 13:24:53	\N
31	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 13:24:54	2025-10-23 13:24:54	\N
32	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 13:24:55	2025-10-23 13:24:55	\N
33	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 13:55:47	2025-10-23 13:55:47	\N
34	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 13:55:48	2025-10-23 13:55:48	\N
35	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 13:55:50	2025-10-23 13:55:50	\N
36	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 13:55:51	2025-10-23 13:55:51	\N
37	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 13:55:53	2025-10-23 13:55:53	\N
38	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 13:55:53	2025-10-23 13:55:53	\N
39	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 13:55:56	2025-10-23 13:55:56	\N
40	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 13:55:57	2025-10-23 13:55:57	\N
41	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 13:55:58	2025-10-23 13:55:58	\N
42	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 13:55:58	2025-10-23 13:55:58	\N
43	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 13:55:59	2025-10-23 13:55:59	\N
44	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 13:55:59	2025-10-23 13:55:59	\N
45	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 13:56:00	2025-10-23 13:56:00	\N
46	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 13:56:03	2025-10-23 13:56:03	\N
47	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 13:56:05	2025-10-23 13:56:05	\N
48	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 13:56:06	2025-10-23 13:56:06	\N
49	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 13:56:07	2025-10-23 13:56:07	\N
50	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 13:56:08	2025-10-23 13:56:08	\N
51	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 13:56:08	2025-10-23 13:56:08	\N
52	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 13:56:08	2025-10-23 13:56:08	\N
53	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 13:56:32	2025-10-23 13:56:32	\N
54	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 13:56:33	2025-10-23 13:56:33	\N
55	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 13:56:33	2025-10-23 13:56:33	\N
56	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 13:56:33	2025-10-23 13:56:33	\N
57	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 13:56:34	2025-10-23 13:56:34	\N
58	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 13:56:35	2025-10-23 13:56:35	\N
59	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 13:56:36	2025-10-23 13:56:36	\N
60	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 13:56:36	2025-10-23 13:56:36	\N
61	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 13:56:38	2025-10-23 13:56:38	\N
62	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 13:56:38	2025-10-23 13:56:38	\N
63	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 14:08:14	2025-10-23 14:08:14	\N
64	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 14:08:14	2025-10-23 14:08:14	\N
65	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 14:08:15	2025-10-23 14:08:15	\N
66	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 14:08:16	2025-10-23 14:08:16	\N
67	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 14:08:17	2025-10-23 14:08:17	\N
68	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 14:08:17	2025-10-23 14:08:17	\N
69	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 14:08:20	2025-10-23 14:08:20	\N
70	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 14:08:21	2025-10-23 14:08:21	\N
71	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 14:08:22	2025-10-23 14:08:22	\N
72	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 14:08:22	2025-10-23 14:08:22	\N
73	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 14:17:13	2025-10-23 14:17:13	\N
74	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 14:17:15	2025-10-23 14:17:15	\N
75	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 14:17:15	2025-10-23 14:17:15	\N
76	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 14:17:17	2025-10-23 14:17:17	\N
77	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 14:17:17	2025-10-23 14:17:17	\N
78	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 14:17:17	2025-10-23 14:17:17	\N
79	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 14:17:18	2025-10-23 14:17:18	\N
80	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 14:17:19	2025-10-23 14:17:19	\N
81	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 14:17:20	2025-10-23 14:17:20	\N
82	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 14:17:20	2025-10-23 14:17:20	\N
83	USER	1	UPSERT	Setting	2	{"before":null,"after":{"prefix":"INV-","pad":6,"reset":"daily"}}	2025-10-23 16:53:44	2025-10-23 16:53:44	2025-10-23 16:53:44
84	USER	1	UPSERT	Setting	3	{"before":null,"after":{"rate":0.11,"rounding":"HALF_UP"}}	2025-10-23 17:02:35	2025-10-23 17:02:35	2025-10-23 17:02:35
85	USER	1	UPSERT	Setting	4	{"before":null,"after":{"line1":"Terima kasih"}}	2025-10-23 17:03:03	2025-10-23 17:03:03	2025-10-23 17:03:03
86	USER	1	UPSERT	Setting	5	{"before":null,"after":{"width":"58"}}	2025-10-23 17:03:03	2025-10-23 17:03:03	2025-10-23 17:03:03
87	USER	1	UPSERT	Setting	2	{"before":{"prefix":"INV-","pad":6,"reset":"daily"},"after":{"prefix":"SALE-","pad":6,"reset":"daily"}}	2025-10-23 17:04:12	2025-10-23 17:04:12	2025-10-23 17:04:12
88	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 17:45:59	2025-10-23 17:45:59	\N
89	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 17:45:59	2025-10-23 17:45:59	\N
90	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 17:46:02	2025-10-23 17:46:02	\N
91	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 17:46:02	2025-10-23 17:46:02	\N
92	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 17:46:02	2025-10-23 17:46:02	\N
93	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-23 17:46:03	2025-10-23 17:46:03	\N
94	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-23 17:46:05	2025-10-23 17:46:05	\N
95	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-23 17:46:07	2025-10-23 17:46:07	\N
96	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 17:46:07	2025-10-23 17:46:07	\N
97	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-23 17:46:07	2025-10-23 17:46:07	\N
98	USER	1	UPSERT	Setting	6	{"before":null,"after":{"darkMode":true}}	2025-10-23 17:46:17	2025-10-23 17:46:17	2025-10-23 17:46:17
99	USER	1	UPSERT	Setting	6	{"before":{"darkMode":true},"after":{"darkMode":false}}	2025-10-23 17:46:21	2025-10-23 17:46:21	2025-10-23 17:46:21
100	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 18:22:56	2025-10-23 18:22:56	\N
101	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 18:22:57	2025-10-23 18:22:57	\N
102	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 18:22:58	2025-10-23 18:22:58	\N
103	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 18:22:59	2025-10-23 18:22:59	\N
104	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 18:22:59	2025-10-23 18:22:59	\N
105	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 18:22:59	2025-10-23 18:22:59	\N
106	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 18:23:01	2025-10-23 18:23:01	\N
107	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 18:23:02	2025-10-23 18:23:02	\N
108	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 18:23:02	2025-10-23 18:23:02	\N
109	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 18:23:02	2025-10-23 18:23:02	\N
110	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 18:33:51	2025-10-23 18:33:51	\N
111	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 18:33:52	2025-10-23 18:33:52	\N
112	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 18:33:52	2025-10-23 18:33:52	\N
113	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 18:33:53	2025-10-23 18:33:53	\N
114	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 18:33:53	2025-10-23 18:33:53	\N
115	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 18:33:54	2025-10-23 18:33:54	\N
116	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 18:33:56	2025-10-23 18:33:56	\N
117	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 18:33:56	2025-10-23 18:33:56	\N
118	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 18:33:57	2025-10-23 18:33:57	\N
119	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 18:33:58	2025-10-23 18:33:58	\N
120	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 20:31:25	2025-10-23 20:31:25	\N
121	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 20:31:27	2025-10-23 20:31:27	\N
122	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 20:31:28	2025-10-23 20:31:28	\N
123	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 20:31:30	2025-10-23 20:31:30	\N
124	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 20:31:30	2025-10-23 20:31:30	\N
125	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 20:31:30	2025-10-23 20:31:30	\N
126	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 20:31:33	2025-10-23 20:31:33	\N
127	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 20:31:33	2025-10-23 20:31:33	\N
128	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 20:31:33	2025-10-23 20:31:33	\N
129	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 20:31:33	2025-10-23 20:31:33	\N
130	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 20:41:29	2025-10-23 20:41:29	\N
131	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 20:41:31	2025-10-23 20:41:31	\N
132	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 20:41:31	2025-10-23 20:41:31	\N
133	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 20:41:32	2025-10-23 20:41:32	\N
134	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 20:41:33	2025-10-23 20:41:33	\N
135	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 20:41:33	2025-10-23 20:41:33	\N
136	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 20:41:35	2025-10-23 20:41:35	\N
137	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 20:41:36	2025-10-23 20:41:36	\N
138	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 20:41:36	2025-10-23 20:41:36	\N
139	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 20:41:36	2025-10-23 20:41:36	\N
140	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 20:47:12	2025-10-23 20:47:12	\N
141	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 20:47:14	2025-10-23 20:47:14	\N
142	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-16T00:00:00.000000Z","to":"2025-10-23T23:59:59.999999Z"}	2025-10-23 20:47:15	2025-10-23 20:47:15	\N
143	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 20:47:16	2025-10-23 20:47:16	\N
144	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 20:47:18	2025-10-23 20:47:18	\N
145	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 20:47:18	2025-10-23 20:47:18	\N
146	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-23 20:47:21	2025-10-23 20:47:21	\N
147	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-23 20:47:21	2025-10-23 20:47:21	\N
148	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-23 20:47:22	2025-10-23 20:47:22	\N
149	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-23 20:47:23	2025-10-23 20:47:23	\N
150	USER	6	UPSERT	Setting	7	{"before":null,"after":{"prefix":"INV-","pad":6,"reset":"daily"}}	2025-10-23 20:47:38	2025-10-23 20:47:38	2025-10-23 20:47:38
151	USER	1	JOURNAL_POSTED	JournalEntry	1	{"number":"JV-20251024-001","posted_at":"2025-10-24 15:34:20"}	2025-10-24 15:34:20	2025-10-24 15:34:20	2025-10-24 15:34:20
152	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 19:31:26	2025-10-24 19:31:26	\N
153	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 19:31:28	2025-10-24 19:31:28	\N
154	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 19:31:29	2025-10-24 19:31:29	\N
155	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 19:31:31	2025-10-24 19:31:31	\N
156	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 19:31:32	2025-10-24 19:31:32	\N
157	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 19:31:33	2025-10-24 19:31:33	\N
158	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 19:34:24	2025-10-24 19:34:24	\N
159	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 19:34:24	2025-10-24 19:34:24	\N
160	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 19:34:25	2025-10-24 19:34:25	\N
161	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 19:34:26	2025-10-24 19:34:26	\N
162	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 19:34:26	2025-10-24 19:34:26	\N
163	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 19:34:27	2025-10-24 19:34:27	\N
164	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 19:34:28	2025-10-24 19:34:28	\N
165	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 19:34:30	2025-10-24 19:34:30	\N
166	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 19:34:30	2025-10-24 19:34:30	\N
167	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 19:34:30	2025-10-24 19:34:30	\N
168	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 20:04:47	2025-10-24 20:04:47	\N
169	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 20:04:47	2025-10-24 20:04:47	\N
170	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 20:04:50	2025-10-24 20:04:50	\N
171	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 20:04:50	2025-10-24 20:04:50	\N
172	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 20:04:51	2025-10-24 20:04:51	\N
173	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 20:04:52	2025-10-24 20:04:52	\N
174	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 20:04:54	2025-10-24 20:04:54	\N
175	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 20:04:56	2025-10-24 20:04:56	\N
176	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 20:04:56	2025-10-24 20:04:56	\N
177	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 20:04:57	2025-10-24 20:04:57	\N
178	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 20:56:54	2025-10-24 20:56:54	\N
179	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 20:56:55	2025-10-24 20:56:55	\N
180	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 20:56:57	2025-10-24 20:56:57	\N
181	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 20:56:57	2025-10-24 20:56:57	\N
182	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 20:56:57	2025-10-24 20:56:57	\N
183	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 20:56:57	2025-10-24 20:56:57	\N
184	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 20:57:00	2025-10-24 20:57:00	\N
185	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 20:57:00	2025-10-24 20:57:00	\N
186	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 20:57:01	2025-10-24 20:57:01	\N
187	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 20:57:02	2025-10-24 20:57:02	\N
188	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 21:28:34	2025-10-24 21:28:34	\N
189	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 21:28:34	2025-10-24 21:28:34	\N
190	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 21:28:36	2025-10-24 21:28:36	\N
191	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 21:28:37	2025-10-24 21:28:37	\N
192	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 21:28:37	2025-10-24 21:28:37	\N
193	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 21:28:37	2025-10-24 21:28:37	\N
194	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 21:28:40	2025-10-24 21:28:40	\N
195	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 21:28:41	2025-10-24 21:28:41	\N
196	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 21:28:42	2025-10-24 21:28:42	\N
197	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 21:28:42	2025-10-24 21:28:42	\N
198	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 21:29:03	2025-10-24 21:29:03	\N
199	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-24 21:29:03	2025-10-24 21:29:03	\N
200	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 21:29:05	2025-10-24 21:29:05	\N
201	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-24 21:29:06	2025-10-24 21:29:06	\N
202	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-24 21:29:06	2025-10-24 21:29:06	\N
203	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-24 21:29:06	2025-10-24 21:29:06	\N
204	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-24 21:29:09	2025-10-24 21:29:09	\N
205	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-24 21:29:11	2025-10-24 21:29:11	\N
206	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-24 21:29:13	2025-10-24 21:29:13	\N
207	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-24 21:29:15	2025-10-24 21:29:15	\N
208	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 22:03:40	2025-10-24 22:03:40	\N
209	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 22:03:40	2025-10-24 22:03:40	\N
210	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 22:03:41	2025-10-24 22:03:41	\N
211	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 22:03:42	2025-10-24 22:03:42	\N
212	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 22:03:42	2025-10-24 22:03:42	\N
213	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 22:03:43	2025-10-24 22:03:43	\N
214	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-24 22:03:43	2025-10-24 22:03:43	\N
215	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-24 22:03:44	2025-10-24 22:03:44	\N
216	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-24 22:03:45	2025-10-24 22:03:45	\N
217	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-24 22:03:45	2025-10-24 22:03:45	\N
218	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 23:39:39	2025-10-24 23:39:39	\N
219	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-24 23:39:41	2025-10-24 23:39:41	\N
220	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-17T00:00:00.000000Z","to":"2025-10-24T23:59:59.999999Z"}	2025-10-24 23:39:41	2025-10-24 23:39:41	\N
221	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-24 23:39:42	2025-10-24 23:39:42	\N
222	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-24 23:39:43	2025-10-24 23:39:43	\N
223	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-24 23:39:43	2025-10-24 23:39:43	\N
224	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-24 23:39:45	2025-10-24 23:39:45	\N
225	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-24 23:39:46	2025-10-24 23:39:46	\N
226	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-24 23:39:46	2025-10-24 23:39:46	\N
227	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-24 23:39:46	2025-10-24 23:39:46	\N
228	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 01:21:05	2025-10-25 01:21:05	\N
229	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 01:21:06	2025-10-25 01:21:06	\N
230	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 01:21:08	2025-10-25 01:21:08	\N
231	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 01:21:08	2025-10-25 01:21:08	\N
232	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 01:21:08	2025-10-25 01:21:08	\N
233	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 01:21:09	2025-10-25 01:21:09	\N
234	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 01:21:11	2025-10-25 01:21:11	\N
235	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 01:21:13	2025-10-25 01:21:13	\N
236	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 01:21:13	2025-10-25 01:21:13	\N
237	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 01:21:14	2025-10-25 01:21:14	\N
238	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 01:21:45	2025-10-25 01:21:45	\N
239	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 01:21:47	2025-10-25 01:21:47	\N
240	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 01:21:48	2025-10-25 01:21:48	\N
241	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 01:21:50	2025-10-25 01:21:50	\N
242	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 01:21:51	2025-10-25 01:21:51	\N
243	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 01:21:53	2025-10-25 01:21:53	\N
244	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 01:21:53	2025-10-25 01:21:53	\N
245	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 01:21:54	2025-10-25 01:21:54	\N
246	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 01:21:56	2025-10-25 01:21:56	\N
247	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 01:21:56	2025-10-25 01:21:56	\N
248	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 01:50:20	2025-10-25 01:50:20	\N
249	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 01:50:20	2025-10-25 01:50:20	\N
250	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 01:50:20	2025-10-25 01:50:20	\N
251	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 01:50:21	2025-10-25 01:50:21	\N
252	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 01:50:22	2025-10-25 01:50:22	\N
253	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 01:50:22	2025-10-25 01:50:22	\N
254	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 01:50:23	2025-10-25 01:50:23	\N
255	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 01:50:24	2025-10-25 01:50:24	\N
256	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 01:50:25	2025-10-25 01:50:25	\N
257	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 01:50:25	2025-10-25 01:50:25	\N
258	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 01:53:12	2025-10-25 01:53:12	\N
259	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 01:53:13	2025-10-25 01:53:13	\N
260	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 01:53:14	2025-10-25 01:53:14	\N
261	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 01:53:15	2025-10-25 01:53:15	\N
262	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 01:53:15	2025-10-25 01:53:15	\N
263	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 01:53:15	2025-10-25 01:53:15	\N
264	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 01:53:16	2025-10-25 01:53:16	\N
265	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 01:53:17	2025-10-25 01:53:17	\N
266	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 01:53:17	2025-10-25 01:53:17	\N
267	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 01:53:18	2025-10-25 01:53:18	\N
268	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
269	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
270	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
271	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
272	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
273	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
274	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
275	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
276	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
277	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:09:47	2025-10-25 03:09:47	\N
278	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:10:40	2025-10-25 03:10:40	\N
279	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:10:40	2025-10-25 03:10:40	\N
280	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:10:41	2025-10-25 03:10:41	\N
281	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:10:41	2025-10-25 03:10:41	\N
282	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:10:41	2025-10-25 03:10:41	\N
283	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:10:41	2025-10-25 03:10:41	\N
284	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:10:41	2025-10-25 03:10:41	\N
285	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:10:41	2025-10-25 03:10:41	\N
286	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:10:41	2025-10-25 03:10:41	\N
287	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:10:41	2025-10-25 03:10:41	\N
288	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
289	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
290	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
291	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
292	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
293	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
294	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
295	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
296	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
297	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:19:45	2025-10-25 03:19:45	\N
298	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
299	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
300	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
301	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
302	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
303	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
304	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
305	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
306	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
307	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:20:10	2025-10-25 03:20:10	\N
308	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:21:18	2025-10-25 03:21:18	\N
309	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:21:18	2025-10-25 03:21:18	\N
310	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:21:19	2025-10-25 03:21:19	\N
311	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:21:19	2025-10-25 03:21:19	\N
312	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:21:19	2025-10-25 03:21:19	\N
313	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:21:19	2025-10-25 03:21:19	\N
314	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:21:19	2025-10-25 03:21:19	\N
315	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:21:19	2025-10-25 03:21:19	\N
316	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:21:19	2025-10-25 03:21:19	\N
317	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:21:19	2025-10-25 03:21:19	\N
318	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:24:37	2025-10-25 03:24:37	\N
319	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:24:37	2025-10-25 03:24:37	\N
320	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:24:37	2025-10-25 03:24:37	\N
321	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:24:37	2025-10-25 03:24:37	\N
322	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:24:37	2025-10-25 03:24:37	\N
323	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:24:38	2025-10-25 03:24:38	\N
324	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:24:38	2025-10-25 03:24:38	\N
325	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:24:38	2025-10-25 03:24:38	\N
326	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:24:38	2025-10-25 03:24:38	\N
327	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:24:38	2025-10-25 03:24:38	\N
328	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:25:14	2025-10-25 03:25:14	\N
329	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 03:25:14	2025-10-25 03:25:14	\N
330	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 03:25:14	2025-10-25 03:25:14	\N
331	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:25:14	2025-10-25 03:25:14	\N
332	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 03:25:14	2025-10-25 03:25:14	\N
333	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 03:25:14	2025-10-25 03:25:14	\N
334	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 03:25:14	2025-10-25 03:25:14	\N
335	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 03:25:14	2025-10-25 03:25:14	\N
336	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 03:25:14	2025-10-25 03:25:14	\N
337	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 03:25:15	2025-10-25 03:25:15	\N
338	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:28:40	2025-10-25 03:28:40	\N
339	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:28:40	2025-10-25 03:28:40	\N
340	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 03:28:40	2025-10-25 03:28:40	\N
341	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 03:28:40	2025-10-25 03:28:40	\N
342	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 03:28:40	2025-10-25 03:28:40	\N
343	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 03:28:40	2025-10-25 03:28:40	\N
344	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 03:28:40	2025-10-25 03:28:40	\N
345	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 03:28:40	2025-10-25 03:28:40	\N
346	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 03:28:41	2025-10-25 03:28:41	\N
347	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 03:28:41	2025-10-25 03:28:41	\N
348	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:30:47	2025-10-25 03:30:47	\N
349	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 03:30:47	2025-10-25 03:30:47	\N
350	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 03:30:47	2025-10-25 03:30:47	\N
351	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:30:47	2025-10-25 03:30:47	\N
352	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 03:30:47	2025-10-25 03:30:47	\N
353	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 03:30:47	2025-10-25 03:30:47	\N
354	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 03:30:47	2025-10-25 03:30:47	\N
355	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 03:30:47	2025-10-25 03:30:47	\N
356	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 03:30:47	2025-10-25 03:30:47	\N
357	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 03:30:48	2025-10-25 03:30:48	\N
358	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
359	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
360	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
361	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
362	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
363	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
364	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
365	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
366	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
367	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:30:57	2025-10-25 03:30:57	\N
368	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
369	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
370	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
371	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
372	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
373	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
374	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
375	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
376	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
377	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:28	2025-10-25 03:32:28	\N
378	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
379	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
380	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
381	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
382	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
383	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
384	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
385	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
386	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
387	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:37	2025-10-25 03:32:37	\N
388	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
389	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
390	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
391	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
392	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
393	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
394	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
395	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
396	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
397	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:32:44	2025-10-25 03:32:44	\N
398	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:35:22	2025-10-25 03:35:22	\N
399	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:35:22	2025-10-25 03:35:22	\N
400	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:35:22	2025-10-25 03:35:22	\N
401	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:35:22	2025-10-25 03:35:22	\N
402	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:35:22	2025-10-25 03:35:22	\N
403	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:35:22	2025-10-25 03:35:22	\N
404	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:35:23	2025-10-25 03:35:23	\N
405	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:35:23	2025-10-25 03:35:23	\N
406	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:35:23	2025-10-25 03:35:23	\N
407	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:35:23	2025-10-25 03:35:23	\N
408	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:35:38	2025-10-25 03:35:38	\N
409	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:35:38	2025-10-25 03:35:38	\N
410	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:35:38	2025-10-25 03:35:38	\N
411	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:35:38	2025-10-25 03:35:38	\N
412	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:35:38	2025-10-25 03:35:38	\N
413	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:35:38	2025-10-25 03:35:38	\N
414	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:35:38	2025-10-25 03:35:38	\N
415	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:35:39	2025-10-25 03:35:39	\N
416	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:35:39	2025-10-25 03:35:39	\N
417	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:35:39	2025-10-25 03:35:39	\N
418	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:51:55	2025-10-25 03:51:55	\N
419	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:51:55	2025-10-25 03:51:55	\N
420	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:51:55	2025-10-25 03:51:55	\N
421	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:51:55	2025-10-25 03:51:55	\N
422	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 03:51:55	2025-10-25 03:51:55	\N
423	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 03:51:55	2025-10-25 03:51:55	\N
424	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:51:55	2025-10-25 03:51:55	\N
425	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 03:51:55	2025-10-25 03:51:55	\N
426	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 03:51:56	2025-10-25 03:51:56	\N
427	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 03:51:56	2025-10-25 03:51:56	\N
428	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
429	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
430	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
431	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
432	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
433	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
434	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
435	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
436	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
437	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 21:32:26	2025-10-25 21:32:26	\N
438	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
439	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
440	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
441	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
442	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
443	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
444	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
445	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
446	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
447	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-25 21:34:51	2025-10-25 21:34:51	\N
448	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
449	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
450	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
451	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
452	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
453	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
454	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
455	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
456	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
457	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 23:53:23	2025-10-25 23:53:23	\N
458	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
459	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
460	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
461	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
462	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
463	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-18T00:00:00.000000Z","to":"2025-10-25T23:59:59.999999Z"}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
464	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
465	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
466	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
467	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-25 23:57:27	2025-10-25 23:57:27	\N
468	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
469	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
470	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
471	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
472	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
473	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
474	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
475	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
476	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
477	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:02:36	2025-10-26 00:02:36	\N
478	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
479	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
480	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
481	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
482	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
483	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
484	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
485	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
486	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
487	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:06:03	2025-10-26 00:06:03	\N
488	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
489	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
490	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
491	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
492	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
493	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
494	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
495	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
496	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
497	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:08:56	2025-10-26 00:08:56	\N
498	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:11:43	2025-10-26 00:11:43	\N
499	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:43	2025-10-26 00:11:43	\N
500	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:11:43	2025-10-26 00:11:43	\N
501	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:11:43	2025-10-26 00:11:43	\N
502	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:44	2025-10-26 00:11:44	\N
503	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:11:44	2025-10-26 00:11:44	\N
504	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:44	2025-10-26 00:11:44	\N
505	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:11:44	2025-10-26 00:11:44	\N
506	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:11:44	2025-10-26 00:11:44	\N
507	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:44	2025-10-26 00:11:44	\N
508	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
509	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
510	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
511	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
512	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
513	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
514	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
515	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
516	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
517	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:46	2025-10-26 00:11:46	\N
518	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
519	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
520	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
521	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
522	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
523	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
524	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
525	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
526	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
527	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:11:53	2025-10-26 00:11:53	\N
528	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:14:42	2025-10-26 00:14:42	\N
529	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:14:42	2025-10-26 00:14:42	\N
530	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:14:43	2025-10-26 00:14:43	\N
531	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:14:43	2025-10-26 00:14:43	\N
532	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:14:43	2025-10-26 00:14:43	\N
533	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:14:43	2025-10-26 00:14:43	\N
534	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:14:43	2025-10-26 00:14:43	\N
535	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:14:43	2025-10-26 00:14:43	\N
536	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:14:43	2025-10-26 00:14:43	\N
537	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:14:43	2025-10-26 00:14:43	\N
538	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:16:25	2025-10-26 00:16:25	\N
539	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:16:25	2025-10-26 00:16:25	\N
540	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:16:25	2025-10-26 00:16:25	\N
541	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:16:25	2025-10-26 00:16:25	\N
542	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:16:26	2025-10-26 00:16:26	\N
543	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:16:26	2025-10-26 00:16:26	\N
544	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:16:26	2025-10-26 00:16:26	\N
545	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:16:26	2025-10-26 00:16:26	\N
546	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:16:26	2025-10-26 00:16:26	\N
547	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:16:26	2025-10-26 00:16:26	\N
548	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:18:08	2025-10-26 00:18:08	\N
549	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:18:08	2025-10-26 00:18:08	\N
550	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:18:08	2025-10-26 00:18:08	\N
551	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:18:09	2025-10-26 00:18:09	\N
552	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:18:09	2025-10-26 00:18:09	\N
553	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:18:09	2025-10-26 00:18:09	\N
554	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:18:09	2025-10-26 00:18:09	\N
555	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:18:09	2025-10-26 00:18:09	\N
556	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:18:09	2025-10-26 00:18:09	\N
557	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:18:09	2025-10-26 00:18:09	\N
558	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
559	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
560	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
561	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
562	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
563	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
564	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
565	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
566	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
567	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:19:31	2025-10-26 00:19:31	\N
568	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
569	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
570	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
571	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
572	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
573	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
574	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
575	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
576	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
577	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:21:49	2025-10-26 00:21:49	\N
578	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:27:34	2025-10-26 00:27:34	\N
579	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:27:34	2025-10-26 00:27:34	\N
580	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:27:35	2025-10-26 00:27:35	\N
581	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:27:35	2025-10-26 00:27:35	\N
582	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:27:35	2025-10-26 00:27:35	\N
583	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:27:35	2025-10-26 00:27:35	\N
584	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:27:35	2025-10-26 00:27:35	\N
585	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:27:35	2025-10-26 00:27:35	\N
586	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:27:35	2025-10-26 00:27:35	\N
587	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:27:35	2025-10-26 00:27:35	\N
588	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:32:23	2025-10-26 00:32:23	\N
589	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:32:23	2025-10-26 00:32:23	\N
590	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:32:23	2025-10-26 00:32:23	\N
591	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:32:23	2025-10-26 00:32:23	\N
592	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:32:23	2025-10-26 00:32:23	\N
593	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:32:23	2025-10-26 00:32:23	\N
594	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:32:23	2025-10-26 00:32:23	\N
595	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:32:24	2025-10-26 00:32:24	\N
596	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:32:24	2025-10-26 00:32:24	\N
597	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:32:24	2025-10-26 00:32:24	\N
598	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
599	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
600	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
601	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
602	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
603	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
604	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
605	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
606	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
607	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:43:12	2025-10-26 00:43:12	\N
608	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
609	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
610	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
611	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
612	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
613	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
614	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
615	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
616	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
617	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:47:21	2025-10-26 00:47:21	\N
618	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:47:34	2025-10-26 00:47:34	\N
619	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:47:34	2025-10-26 00:47:34	\N
620	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:47:34	2025-10-26 00:47:34	\N
621	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:47:34	2025-10-26 00:47:34	\N
622	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:47:34	2025-10-26 00:47:34	\N
623	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 00:47:35	2025-10-26 00:47:35	\N
624	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 00:47:35	2025-10-26 00:47:35	\N
625	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 00:47:35	2025-10-26 00:47:35	\N
626	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 00:47:35	2025-10-26 00:47:35	\N
627	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 00:47:35	2025-10-26 00:47:35	\N
628	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
629	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
630	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
631	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
632	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
633	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
634	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
635	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
636	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
637	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:33	2025-10-26 01:38:33	\N
638	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
639	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
640	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
641	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
642	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
643	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
644	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
645	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
646	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
647	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:34	2025-10-26 01:38:34	\N
648	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
649	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
650	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
651	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
652	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
653	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
654	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
655	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
656	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
657	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 01:38:48	2025-10-26 01:38:48	\N
658	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
659	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
660	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
661	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
662	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
663	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
664	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
665	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
666	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
667	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 01:55:21	2025-10-26 01:55:21	\N
668	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
669	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
670	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
671	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
672	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
673	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
674	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
675	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
676	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
677	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:01:22	2025-10-26 02:01:22	\N
678	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
679	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
680	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
681	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
682	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
683	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
684	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
685	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
686	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
687	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:02:35	2025-10-26 02:02:35	\N
688	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:33:45	2025-10-26 02:33:45	\N
689	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:33:45	2025-10-26 02:33:45	\N
690	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:33:45	2025-10-26 02:33:45	\N
691	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:33:45	2025-10-26 02:33:45	\N
692	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:33:45	2025-10-26 02:33:45	\N
693	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:33:45	2025-10-26 02:33:45	\N
694	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:33:45	2025-10-26 02:33:45	\N
695	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:33:45	2025-10-26 02:33:45	\N
696	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:33:46	2025-10-26 02:33:46	\N
697	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:33:46	2025-10-26 02:33:46	\N
698	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:33:46	2025-10-26 02:33:46	\N
699	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:33:46	2025-10-26 02:33:46	\N
700	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:33:46	2025-10-26 02:33:46	\N
701	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:33:47	2025-10-26 02:33:47	\N
702	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:33:47	2025-10-26 02:33:47	\N
703	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:33:47	2025-10-26 02:33:47	\N
704	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:33:47	2025-10-26 02:33:47	\N
705	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:33:47	2025-10-26 02:33:47	\N
706	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:33:47	2025-10-26 02:33:47	\N
707	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:33:47	2025-10-26 02:33:47	\N
708	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:34:33	2025-10-26 02:34:33	\N
709	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:34:33	2025-10-26 02:34:33	\N
710	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:34:33	2025-10-26 02:34:33	\N
711	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:34:33	2025-10-26 02:34:33	\N
712	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:34:33	2025-10-26 02:34:33	\N
713	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
714	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
715	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
716	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
717	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
718	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
719	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
720	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
721	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
722	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:34:36	2025-10-26 02:34:36	\N
723	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
724	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
725	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
726	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
727	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
728	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
729	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
730	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
731	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
732	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:37:35	2025-10-26 02:37:35	\N
733	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:38:23	2025-10-26 02:38:23	\N
734	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:38:23	2025-10-26 02:38:23	\N
735	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:38:24	2025-10-26 02:38:24	\N
736	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:38:24	2025-10-26 02:38:24	\N
737	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:38:24	2025-10-26 02:38:24	\N
738	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:38:24	2025-10-26 02:38:24	\N
739	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:38:24	2025-10-26 02:38:24	\N
740	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:38:24	2025-10-26 02:38:24	\N
741	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:38:24	2025-10-26 02:38:24	\N
742	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:38:24	2025-10-26 02:38:24	\N
743	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
744	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
745	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
746	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
747	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
748	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
749	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
750	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
751	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
752	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:40:14	2025-10-26 02:40:14	\N
753	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
754	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
755	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
756	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
757	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
758	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
759	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
760	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
761	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
762	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:41:21	2025-10-26 02:41:21	\N
763	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
764	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
765	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
766	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
767	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
768	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
769	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
770	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
771	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
772	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:42:09	2025-10-26 02:42:09	\N
773	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:42:52	2025-10-26 02:42:52	\N
774	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:42:52	2025-10-26 02:42:52	\N
775	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:42:53	2025-10-26 02:42:53	\N
776	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:42:53	2025-10-26 02:42:53	\N
777	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:42:53	2025-10-26 02:42:53	\N
778	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:42:53	2025-10-26 02:42:53	\N
779	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:42:53	2025-10-26 02:42:53	\N
780	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:42:53	2025-10-26 02:42:53	\N
781	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:42:53	2025-10-26 02:42:53	\N
782	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:42:53	2025-10-26 02:42:53	\N
783	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
784	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
785	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
786	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
787	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
788	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
789	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
790	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
791	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
792	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:46:32	2025-10-26 02:46:32	\N
793	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:50:52	2025-10-26 02:50:52	\N
794	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:50:52	2025-10-26 02:50:52	\N
795	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:50:53	2025-10-26 02:50:53	\N
796	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:50:53	2025-10-26 02:50:53	\N
797	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:50:53	2025-10-26 02:50:53	\N
798	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 02:50:53	2025-10-26 02:50:53	\N
799	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 02:50:53	2025-10-26 02:50:53	\N
800	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 02:50:53	2025-10-26 02:50:53	\N
801	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 02:50:53	2025-10-26 02:50:53	\N
802	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 02:50:53	2025-10-26 02:50:53	\N
803	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:14:51	2025-10-26 03:14:51	\N
804	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:14:51	2025-10-26 03:14:51	\N
805	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:14:51	2025-10-26 03:14:51	\N
806	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:14:51	2025-10-26 03:14:51	\N
807	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:14:51	2025-10-26 03:14:51	\N
808	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:14:51	2025-10-26 03:14:51	\N
809	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:14:51	2025-10-26 03:14:51	\N
810	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:14:51	2025-10-26 03:14:51	\N
811	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:14:52	2025-10-26 03:14:52	\N
812	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:14:52	2025-10-26 03:14:52	\N
813	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
814	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
815	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
816	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
817	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
818	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
819	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
820	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
821	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
822	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:15:07	2025-10-26 03:15:07	\N
823	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
824	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
825	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
826	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
827	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
828	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
829	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
830	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
831	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
832	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:43:45	2025-10-26 03:43:45	\N
833	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
834	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
835	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
836	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
837	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
838	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
839	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
840	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
841	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
842	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:44:55	2025-10-26 03:44:55	\N
843	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
844	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
845	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
846	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
847	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
848	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
849	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
850	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
851	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
852	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:53:03	2025-10-26 03:53:03	\N
853	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:55:12	2025-10-26 03:55:12	\N
854	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:55:12	2025-10-26 03:55:12	\N
855	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:55:12	2025-10-26 03:55:12	\N
856	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:55:12	2025-10-26 03:55:12	\N
857	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:55:12	2025-10-26 03:55:12	\N
858	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 03:55:12	2025-10-26 03:55:12	\N
859	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 03:55:12	2025-10-26 03:55:12	\N
860	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 03:55:12	2025-10-26 03:55:12	\N
861	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 03:55:12	2025-10-26 03:55:12	\N
862	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 03:55:13	2025-10-26 03:55:13	\N
863	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 04:03:35	2025-10-26 04:03:35	\N
864	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 04:03:35	2025-10-26 04:03:35	\N
865	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 04:03:35	2025-10-26 04:03:35	\N
866	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 04:03:35	2025-10-26 04:03:35	\N
867	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 04:03:35	2025-10-26 04:03:35	\N
868	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 04:03:36	2025-10-26 04:03:36	\N
869	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 04:03:36	2025-10-26 04:03:36	\N
870	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 04:03:36	2025-10-26 04:03:36	\N
871	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 04:03:36	2025-10-26 04:03:36	\N
872	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 04:03:36	2025-10-26 04:03:36	\N
873	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 04:05:59	2025-10-26 04:05:59	\N
874	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 04:05:59	2025-10-26 04:05:59	\N
875	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 04:06:00	2025-10-26 04:06:00	\N
876	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 04:06:00	2025-10-26 04:06:00	\N
877	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 04:06:00	2025-10-26 04:06:00	\N
878	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 04:06:00	2025-10-26 04:06:00	\N
879	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 04:06:00	2025-10-26 04:06:00	\N
880	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 04:06:00	2025-10-26 04:06:00	\N
881	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 04:06:00	2025-10-26 04:06:00	\N
882	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 04:06:00	2025-10-26 04:06:00	\N
883	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
884	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
885	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
886	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
887	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
888	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
889	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
890	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
891	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
892	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 04:09:44	2025-10-26 04:09:44	\N
893	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
894	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
895	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
896	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
897	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
898	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
899	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
900	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
901	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
902	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:43:08	2025-10-26 16:43:08	\N
903	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:44:49	2025-10-26 16:44:49	\N
904	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:44:49	2025-10-26 16:44:49	\N
905	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:44:50	2025-10-26 16:44:50	\N
906	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:44:50	2025-10-26 16:44:50	\N
907	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:44:50	2025-10-26 16:44:50	\N
908	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:44:52	2025-10-26 16:44:52	\N
909	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:44:52	2025-10-26 16:44:52	\N
910	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:44:52	2025-10-26 16:44:52	\N
911	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:44:52	2025-10-26 16:44:52	\N
912	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:44:52	2025-10-26 16:44:52	\N
913	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:44:52	2025-10-26 16:44:52	\N
914	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:44:52	2025-10-26 16:44:52	\N
915	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:44:53	2025-10-26 16:44:53	\N
916	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:44:53	2025-10-26 16:44:53	\N
917	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:44:53	2025-10-26 16:44:53	\N
918	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:45:21	2025-10-26 16:45:21	\N
919	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:45:21	2025-10-26 16:45:21	\N
920	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:45:22	2025-10-26 16:45:22	\N
921	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:45:22	2025-10-26 16:45:22	\N
922	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:45:22	2025-10-26 16:45:22	\N
923	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:45:24	2025-10-26 16:45:24	\N
924	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:45:24	2025-10-26 16:45:24	\N
925	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:45:24	2025-10-26 16:45:24	\N
926	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:45:24	2025-10-26 16:45:24	\N
927	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:45:24	2025-10-26 16:45:24	\N
928	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:45:24	2025-10-26 16:45:24	\N
929	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:45:24	2025-10-26 16:45:24	\N
930	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:45:24	2025-10-26 16:45:24	\N
931	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:45:25	2025-10-26 16:45:25	\N
932	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:45:25	2025-10-26 16:45:25	\N
933	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:47:07	2025-10-26 16:47:07	\N
934	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:47:07	2025-10-26 16:47:07	\N
935	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:47:07	2025-10-26 16:47:07	\N
936	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:47:07	2025-10-26 16:47:07	\N
937	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:47:07	2025-10-26 16:47:07	\N
938	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:47:29	2025-10-26 16:47:29	\N
939	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:47:29	2025-10-26 16:47:29	\N
940	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:47:29	2025-10-26 16:47:29	\N
941	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:47:29	2025-10-26 16:47:29	\N
942	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:47:29	2025-10-26 16:47:29	\N
943	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:47:29	2025-10-26 16:47:29	\N
944	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:47:29	2025-10-26 16:47:29	\N
945	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:47:30	2025-10-26 16:47:30	\N
946	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:47:30	2025-10-26 16:47:30	\N
947	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:47:30	2025-10-26 16:47:30	\N
948	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
949	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
950	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
951	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
952	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
953	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
954	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
955	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
956	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
957	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:50:37	2025-10-26 16:50:37	\N
958	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
959	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
960	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
961	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
962	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
963	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
964	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
965	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
966	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
967	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 16:53:47	2025-10-26 16:53:47	\N
968	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 17:00:07	2025-10-26 17:00:07	\N
969	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 17:00:08	2025-10-26 17:00:08	\N
970	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 17:00:08	2025-10-26 17:00:08	\N
971	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 17:00:08	2025-10-26 17:00:08	\N
972	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 17:00:08	2025-10-26 17:00:08	\N
973	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 17:01:41	2025-10-26 17:01:41	\N
974	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 17:01:42	2025-10-26 17:01:42	\N
975	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 17:01:42	2025-10-26 17:01:42	\N
976	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 17:01:42	2025-10-26 17:01:42	\N
977	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 17:01:42	2025-10-26 17:01:42	\N
978	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 17:22:08	2025-10-26 17:22:08	\N
979	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 17:22:08	2025-10-26 17:22:08	\N
980	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 17:22:08	2025-10-26 17:22:08	\N
981	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 17:22:09	2025-10-26 17:22:09	\N
982	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 17:22:09	2025-10-26 17:22:09	\N
983	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 17:22:09	2025-10-26 17:22:09	\N
984	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 17:22:09	2025-10-26 17:22:09	\N
985	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 17:22:09	2025-10-26 17:22:09	\N
986	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 17:22:09	2025-10-26 17:22:09	\N
987	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 17:22:09	2025-10-26 17:22:09	\N
988	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 18:09:43	2025-10-26 18:09:43	\N
989	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 18:09:43	2025-10-26 18:09:43	\N
990	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 18:09:43	2025-10-26 18:09:43	\N
991	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 18:09:43	2025-10-26 18:09:43	\N
992	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 18:09:43	2025-10-26 18:09:43	\N
993	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 18:09:43	2025-10-26 18:09:43	\N
994	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 18:09:43	2025-10-26 18:09:43	\N
995	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 18:09:44	2025-10-26 18:09:44	\N
996	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 18:09:44	2025-10-26 18:09:44	\N
997	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 18:09:44	2025-10-26 18:09:44	\N
998	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 18:34:57	2025-10-26 18:34:57	\N
999	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-26 18:34:58	2025-10-26 18:34:58	\N
1000	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-26 18:34:58	2025-10-26 18:34:58	\N
1001	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-26 18:34:58	2025-10-26 18:34:58	\N
1002	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-26 18:34:58	2025-10-26 18:34:58	\N
1003	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 18:34:58	2025-10-26 18:34:58	\N
1004	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-26 18:34:58	2025-10-26 18:34:58	\N
1005	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-26 18:34:58	2025-10-26 18:34:58	\N
1006	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-26 18:34:58	2025-10-26 18:34:58	\N
1007	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-26 18:34:58	2025-10-26 18:34:58	\N
1008	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 18:35:10	2025-10-26 18:35:10	\N
1009	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 18:35:11	2025-10-26 18:35:11	\N
1010	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 18:35:11	2025-10-26 18:35:11	\N
1011	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 18:35:11	2025-10-26 18:35:11	\N
1012	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 18:35:11	2025-10-26 18:35:11	\N
1013	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-19T00:00:00.000000Z","to":"2025-10-26T23:59:59.999999Z"}	2025-10-26 18:35:11	2025-10-26 18:35:11	\N
1014	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-26 18:35:11	2025-10-26 18:35:11	\N
1015	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-26 18:35:11	2025-10-26 18:35:11	\N
1016	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-26 18:35:11	2025-10-26 18:35:11	\N
1017	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-26 18:35:11	2025-10-26 18:35:11	\N
1018	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1019	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1020	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1021	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1022	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1023	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1024	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1025	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1026	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1027	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-27 11:39:59	2025-10-27 11:39:59	\N
1028	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 11:41:05	2025-10-27 11:41:05	\N
1029	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-27 11:41:06	2025-10-27 11:41:06	\N
1030	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-27 11:41:06	2025-10-27 11:41:06	\N
1031	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-27 11:41:06	2025-10-27 11:41:06	\N
1032	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-27 11:41:06	2025-10-27 11:41:06	\N
1033	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 11:41:06	2025-10-27 11:41:06	\N
1034	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-27 11:41:06	2025-10-27 11:41:06	\N
1035	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-27 11:41:06	2025-10-27 11:41:06	\N
1036	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-27 11:41:06	2025-10-27 11:41:06	\N
1037	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-27 11:41:06	2025-10-27 11:41:06	\N
1038	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1039	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1040	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1041	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1042	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1043	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1044	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1045	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1046	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1047	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-27 12:54:28	2025-10-27 12:54:28	\N
1048	USER	1	REJECT	cash_moves	7	{"after":{"status":"REJECTED","reject_reason":"Tidak sama"}}	2025-10-27 13:55:46	2025-10-27 13:55:46	\N
1049	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1050	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1051	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1052	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1053	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1054	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1055	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1056	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1057	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1058	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 14:46:50	2025-10-27 14:46:50	\N
1059	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1060	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1061	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1062	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1063	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1064	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1065	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1066	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1067	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1068	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 15:38:32	2025-10-27 15:38:32	\N
1069	USER	6	UPSERT	Setting	13	{"before":null,"after":{"darkMode":true}}	2025-10-27 15:55:32	2025-10-27 15:55:32	2025-10-27 15:55:32
1070	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:00:20	2025-10-27 16:00:20	\N
1071	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-27 16:00:20	2025-10-27 16:00:20	\N
1072	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-27 16:00:20	2025-10-27 16:00:20	\N
1073	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-27 16:00:20	2025-10-27 16:00:20	\N
1074	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-27 16:00:20	2025-10-27 16:00:20	\N
1075	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:00:20	2025-10-27 16:00:20	\N
1076	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-27 16:00:20	2025-10-27 16:00:20	\N
1077	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-27 16:00:20	2025-10-27 16:00:20	\N
1078	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-27 16:00:20	2025-10-27 16:00:20	\N
1079	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-27 16:00:21	2025-10-27 16:00:21	\N
1080	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1081	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1082	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1083	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1084	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1085	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1086	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1087	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1088	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1089	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 16:00:54	2025-10-27 16:00:54	\N
1090	USER	6	JOURNAL_POSTED	JournalEntry	2	{"number":"PAY-PRM-1761337297-C1-64","posted_at":"2025-10-27 16:01:20"}	2025-10-27 16:01:20	2025-10-27 16:01:20	2025-10-27 16:01:20
1091	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:02:39	2025-10-27 16:02:39	\N
1092	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 16:02:39	2025-10-27 16:02:39	\N
1093	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 16:02:39	2025-10-27 16:02:39	\N
1094	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 16:02:39	2025-10-27 16:02:39	\N
1095	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 16:02:39	2025-10-27 16:02:39	\N
1096	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:02:39	2025-10-27 16:02:39	\N
1097	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 16:02:39	2025-10-27 16:02:39	\N
1098	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 16:02:39	2025-10-27 16:02:39	\N
1099	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 16:02:39	2025-10-27 16:02:39	\N
1100	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 16:02:40	2025-10-27 16:02:40	\N
1101	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1102	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1103	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1104	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1105	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1106	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1107	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1108	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1109	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1110	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 16:03:41	2025-10-27 16:03:41	\N
1111	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:14:45	2025-10-27 16:14:45	\N
1112	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 16:14:45	2025-10-27 16:14:45	\N
1113	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 16:14:45	2025-10-27 16:14:45	\N
1114	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 16:14:46	2025-10-27 16:14:46	\N
1115	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 16:14:46	2025-10-27 16:14:46	\N
1116	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-20T00:00:00.000000Z","to":"2025-10-27T23:59:59.999999Z"}	2025-10-27 16:14:46	2025-10-27 16:14:46	\N
1117	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-27 16:14:46	2025-10-27 16:14:46	\N
1118	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-27 16:14:46	2025-10-27 16:14:46	\N
1119	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-27 16:14:46	2025-10-27 16:14:46	\N
1120	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-27 16:14:46	2025-10-27 16:14:46	\N
1121	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1122	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1123	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1124	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1125	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1126	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1127	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1128	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1129	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1130	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:25:27	2025-10-28 10:25:27	\N
1131	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1132	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1133	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1134	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1135	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1136	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1137	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1138	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1139	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1140	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:25:38	2025-10-28 10:25:38	\N
1141	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:31:48	2025-10-28 10:31:48	\N
1142	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:31:48	2025-10-28 10:31:48	\N
1143	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:31:48	2025-10-28 10:31:48	\N
1144	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:31:48	2025-10-28 10:31:48	\N
1145	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:31:48	2025-10-28 10:31:48	\N
1146	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:31:48	2025-10-28 10:31:48	\N
1147	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:31:48	2025-10-28 10:31:48	\N
1148	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:31:48	2025-10-28 10:31:48	\N
1149	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:31:49	2025-10-28 10:31:49	\N
1150	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:31:49	2025-10-28 10:31:49	\N
1151	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:34:40	2025-10-28 10:34:40	\N
1152	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:34:40	2025-10-28 10:34:40	\N
1153	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:34:40	2025-10-28 10:34:40	\N
1154	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:34:40	2025-10-28 10:34:40	\N
1155	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:34:40	2025-10-28 10:34:40	\N
1156	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:34:40	2025-10-28 10:34:40	\N
1157	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:34:41	2025-10-28 10:34:41	\N
1158	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:34:41	2025-10-28 10:34:41	\N
1159	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:34:41	2025-10-28 10:34:41	\N
1160	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:34:41	2025-10-28 10:34:41	\N
1161	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:43:19	2025-10-28 10:43:19	\N
1162	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:43:20	2025-10-28 10:43:20	\N
1163	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:43:20	2025-10-28 10:43:20	\N
1164	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:43:20	2025-10-28 10:43:20	\N
1165	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:43:20	2025-10-28 10:43:20	\N
1166	USER	5	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 10:43:20	2025-10-28 10:43:20	\N
1167	USER	5	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 10:43:20	2025-10-28 10:43:20	\N
1168	USER	5	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 10:43:20	2025-10-28 10:43:20	\N
1169	USER	5	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 10:43:20	2025-10-28 10:43:20	\N
1170	USER	5	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 10:43:20	2025-10-28 10:43:20	\N
1171	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1172	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1173	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1174	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1175	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1176	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1177	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1178	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1179	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1180	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:08:37	2025-10-28 13:08:37	\N
1181	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1182	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1183	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1184	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1185	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1186	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1187	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1188	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1189	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1190	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:43:37	2025-10-28 13:43:37	\N
1191	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1192	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1193	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1194	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1195	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1196	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1197	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1198	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1199	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1200	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:45:02	2025-10-28 13:45:02	\N
1201	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:49:01	2025-10-28 13:49:01	\N
1202	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:49:01	2025-10-28 13:49:01	\N
1203	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:49:02	2025-10-28 13:49:02	\N
1204	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:49:02	2025-10-28 13:49:02	\N
1205	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:49:02	2025-10-28 13:49:02	\N
1206	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:49:02	2025-10-28 13:49:02	\N
1207	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:49:02	2025-10-28 13:49:02	\N
1208	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:49:02	2025-10-28 13:49:02	\N
1209	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:49:02	2025-10-28 13:49:02	\N
1210	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:49:02	2025-10-28 13:49:02	\N
1211	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1212	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1213	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1214	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1215	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1216	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1217	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1218	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1219	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1220	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 13:52:41	2025-10-28 13:52:41	\N
1221	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:59:54	2025-10-28 13:59:54	\N
1222	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 13:59:54	2025-10-28 13:59:54	\N
1223	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 13:59:54	2025-10-28 13:59:54	\N
1224	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 13:59:55	2025-10-28 13:59:55	\N
1225	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 13:59:55	2025-10-28 13:59:55	\N
1226	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 13:59:55	2025-10-28 13:59:55	\N
1227	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 13:59:55	2025-10-28 13:59:55	\N
1228	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 13:59:55	2025-10-28 13:59:55	\N
1229	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 13:59:55	2025-10-28 13:59:55	\N
1230	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 13:59:55	2025-10-28 13:59:55	\N
1231	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1232	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1233	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1234	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1235	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1236	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1237	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1238	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1239	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1240	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-28 15:37:11	2025-10-28 15:37:11	\N
1241	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1242	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1243	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1244	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1245	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-21T00:00:00.000000Z","to":"2025-10-28T23:59:59.999999Z"}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1246	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1247	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1248	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1249	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1250	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-28 15:37:38	2025-10-28 15:37:38	\N
1251	USER	6	JOURNAL_POSTED	JournalEntry	5	{"number":"FEE-ACCR-35","posted_at":"2025-10-28 15:39:22"}	2025-10-28 15:39:22	2025-10-28 15:39:22	2025-10-28 15:39:22
1252	USER	6	ORDER_WA_RESEND	Order	65	{"phone":"6281214695222","message":"Terima kasih telah berbelanja.\\nKode: PRM-1761640684-C1\\nTotal: Rp 400.000\\nTanggal: 2025-10-28 15:38:04"}	2025-10-28 16:00:32	2025-10-28 16:00:32	\N
1253	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 11:18:09	2025-10-29 11:18:09	\N
1254	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-29 11:18:10	2025-10-29 11:18:10	\N
1255	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 11:18:10	2025-10-29 11:18:10	\N
1256	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-29 11:18:10	2025-10-29 11:18:10	\N
1257	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-29 11:18:10	2025-10-29 11:18:10	\N
1258	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-29 11:18:10	2025-10-29 11:18:10	\N
1259	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-29 11:18:10	2025-10-29 11:18:10	\N
1260	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-29 11:18:10	2025-10-29 11:18:10	\N
1261	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-29 11:18:10	2025-10-29 11:18:10	\N
1262	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-29 11:18:10	2025-10-29 11:18:10	\N
1263	USER	6	CASH_MIRROR	payments	67	{"holder_id":3,"amount":200000,"note":"ORDER#PRM-1761711519-C1","before":"200000.00","after":"400000.00"}	2025-10-29 11:20:05	2025-10-29 11:20:05	\N
1264	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 14:06:29	2025-10-29 14:06:29	\N
1265	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-29 14:06:29	2025-10-29 14:06:29	\N
1266	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-29 14:06:29	2025-10-29 14:06:29	\N
1267	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-29 14:06:30	2025-10-29 14:06:30	\N
1268	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 14:06:30	2025-10-29 14:06:30	\N
1269	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-29 14:06:30	2025-10-29 14:06:30	\N
1270	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-29 14:06:30	2025-10-29 14:06:30	\N
1271	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-29 14:06:30	2025-10-29 14:06:30	\N
1272	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-29 14:06:30	2025-10-29 14:06:30	\N
1273	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-29 14:06:30	2025-10-29 14:06:30	\N
1274	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 14:06:41	2025-10-29 14:06:41	\N
1275	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-29 14:06:41	2025-10-29 14:06:41	\N
1276	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-29 14:06:41	2025-10-29 14:06:41	\N
1277	USER	6	DASHBOARD.KPIS	dashboard	0	{"cabang_id":1,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 14:06:42	2025-10-29 14:06:42	\N
1278	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-29 14:06:42	2025-10-29 14:06:42	\N
1279	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-29 14:06:42	2025-10-29 14:06:42	\N
1280	USER	6	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":1}	2025-10-29 14:06:42	2025-10-29 14:06:42	\N
1281	USER	6	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":1,"limit":5}	2025-10-29 14:06:42	2025-10-29 14:06:42	\N
1282	USER	6	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":1,"threshold":null}	2025-10-29 14:06:42	2025-10-29 14:06:42	\N
1283	USER	6	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":1}	2025-10-29 14:06:42	2025-10-29 14:06:42	\N
1284	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 14:06:47	2025-10-29 14:06:47	\N
1285	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-29 14:06:47	2025-10-29 14:06:47	\N
1286	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-29 14:06:47	2025-10-29 14:06:47	\N
1287	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-29 14:06:47	2025-10-29 14:06:47	\N
1288	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-29 14:06:48	2025-10-29 14:06:48	\N
1289	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 14:06:48	2025-10-29 14:06:48	\N
1290	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-29 14:06:48	2025-10-29 14:06:48	\N
1291	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-29 14:06:48	2025-10-29 14:06:48	\N
1292	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-29 14:06:48	2025-10-29 14:06:48	\N
1293	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-29 14:06:48	2025-10-29 14:06:48	\N
1294	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 14:19:46	2025-10-29 14:19:46	\N
1295	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-29 14:19:47	2025-10-29 14:19:47	\N
1296	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-29 14:19:47	2025-10-29 14:19:47	\N
1297	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-29 14:19:47	2025-10-29 14:19:47	\N
1298	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-29 14:19:47	2025-10-29 14:19:47	\N
1299	USER	1	DASHBOARD.KPIS	dashboard	0	{"cabang_id":null,"from":"2025-10-22T00:00:00.000000Z","to":"2025-10-29T23:59:59.999999Z"}	2025-10-29 14:19:47	2025-10-29 14:19:47	\N
1300	USER	1	DASHBOARD.CHART7D	dashboard	0	{"cabang_id":null}	2025-10-29 14:19:47	2025-10-29 14:19:47	\N
1301	USER	1	DASHBOARD.TOPPRODUCTS	dashboard	0	{"cabang_id":null,"limit":5}	2025-10-29 14:19:47	2025-10-29 14:19:47	\N
1302	USER	1	DASHBOARD.LOWSTOCK	dashboard	0	{"cabang_id":null,"threshold":null}	2025-10-29 14:19:47	2025-10-29 14:19:47	\N
1303	USER	1	DASHBOARD.QUICKACTIONS	dashboard	0	{"cabang_id":null}	2025-10-29 14:19:47	2025-10-29 14:19:47	\N
\.


--
-- Data for Name: backups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."backups" ("id", "storage_path", "kind", "size_bytes", "created_at") FROM stdin;
\.


--
-- Data for Name: cabangs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."cabangs" ("id", "nama", "kota", "alamat", "telepon", "jam_operasional", "is_active", "created_at", "updated_at") FROM stdin;
1	Cabang Pusat	Bandung	Jl. Contoh No. 1	081234567890	Senin-Minggu 08:00-21:00	t	2025-10-13 13:43:53	2025-10-13 13:43:53
2	Cabang Selatan	Bandung	Permata Biru	081214695222	Senin–Sabtu 08:00-21:00	t	2025-10-13 14:09:39	2025-10-13 14:09:39
3	Cabang Barat	Bandung	Permata Biru	085865809424	Senin–Minggu 08:00-21:00	t	2025-10-13 14:41:23	2025-10-13 14:41:23
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."cache" ("key", "value", "expiration") FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."cache_locks" ("key", "owner", "expiration") FROM stdin;
\.


--
-- Data for Name: cash_holders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."cash_holders" ("id", "cabang_id", "name", "balance", "created_at", "updated_at") FROM stdin;
1	1	Laci Kasir Utama	200000.00	2025-10-17 10:47:48	2025-10-17 14:29:02
2	1	Brankas Toko	1750000.00	2025-10-17 13:42:46	2025-10-18 17:21:13
3	1	Kasir	400000.00	2025-10-17 13:43:12	2025-10-29 11:20:05
\.


--
-- Data for Name: cash_moves; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."cash_moves" ("id", "from_holder_id", "to_holder_id", "amount", "note", "moved_at", "status", "submitted_by", "approved_by", "approved_at", "rejected_at", "reject_reason", "idempotency_key", "created_at", "updated_at") FROM stdin;
3	1	2	50000.00	Setor kas	2025-10-17 12:00:00	APPROVED	1	1	2025-10-17 09:05:00	\N	\N	shift-20251017-1200-u5	2025-10-17 14:01:20	2025-10-17 14:29:02
4	2	1	150000.00	\N	2025-10-17 00:00:00	REJECTED	5	6	\N	2025-10-17 16:46:53	nyoba	vhad474d6r.mgun2mcy	2025-10-17 16:21:24	2025-10-17 16:46:53
5	3	1	60000.00	\N	2025-10-17 00:00:00	SUBMITTED	5	\N	\N	\N	\N	jzcgun4wkpb.mguo10pa	2025-10-17 16:48:09	2025-10-17 16:48:09
6	2	3	300000.00	[POS] PRM-1760768969-C1 — Pelunasan Rp 300.000	2025-10-18 06:29:59	SUBMITTED	5	\N	\N	\N	\N	order:9/cash:1760768999538	2025-10-18 13:29:59	2025-10-18 13:29:59
9	3	2	200000.00	[POS] PRM-1760770758-C1 — Pelunasan Rp 200.000	2025-10-18 08:28:38	APPROVED	5	6	2025-10-18 17:21:08	\N	\N	order:13/cash:1760776118180	2025-10-18 15:28:39	2025-10-18 17:21:08
8	3	2	1500000.00	[POS] PRM-1760774615-C1 — Pelunasan Rp 1.500.000	2025-10-18 08:03:58	APPROVED	5	6	2025-10-18 17:21:13	\N	\N	order:20/cash:1760774638517	2025-10-18 15:03:58	2025-10-18 17:21:13
7	3	2	600000.00	[POS] PRM-1760770412-C1 — Pelunasan Rp 600.000	2025-10-18 07:18:40	REJECTED	5	1	\N	2025-10-27 13:55:46	Tidak sama	order:12/pay:14	2025-10-18 14:18:47	2025-10-27 13:55:46
\.


--
-- Data for Name: cash_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."cash_sessions" ("id", "cabang_id", "cashier_id", "opening_amount", "closing_amount", "status", "opened_at", "closed_at", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: cash_transactions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."cash_transactions" ("id", "session_id", "type", "amount", "source", "ref_type", "ref_id", "note", "occurred_at", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."categories" ("id", "nama", "slug", "deskripsi", "is_active", "created_at", "updated_at") FROM stdin;
1	Cake	cake	\N	t	2025-10-13 13:43:53	2025-10-13 13:43:53
2	Cookies	cookies	\N	t	2025-10-13 13:43:53	2025-10-13 13:43:53
3	Brownies	brownies	\N	t	2025-10-13 13:43:53	2025-10-13 13:43:53
4	Pudding	pudding	\N	t	2025-10-13 13:43:53	2025-10-13 13:43:53
5	Snack Box	snack-box	\N	t	2025-10-13 13:43:53	2025-10-13 13:43:53
6	Contoh	contoh	Nyobain dulu	t	2025-10-26 20:42:18	2025-10-26 20:42:18
\.


--
-- Data for Name: customer_timelines; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."customer_timelines" ("id", "customer_id", "event_type", "title", "note", "meta", "happened_at", "created_at", "updated_at") FROM stdin;
1	1	NOTE	Customer created	\N	{"source": "POS"}	2025-10-21 11:26:12	2025-10-21 11:26:12	2025-10-21 11:26:12
2	2	NOTE	Customer created	\N	{"source": "POS"}	2025-10-22 03:11:31	2025-10-22 03:11:31	2025-10-22 03:11:31
3	3	NOTE	Customer created	\N	{"source": "POS"}	2025-10-22 03:42:28	2025-10-22 03:42:28	2025-10-22 03:42:28
4	4	NOTE	Customer created	\N	{"source": "POS"}	2025-10-28 14:21:47	2025-10-28 14:21:47	2025-10-28 14:21:47
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."customers" ("id", "cabang_id", "nama", "phone", "email", "alamat", "catatan", "stage", "last_order_at", "total_spent", "total_orders", "created_at", "updated_at") FROM stdin;
1	0	Andi	+628123000111	andi@gmail.com	Bandung	VIP	ACTIVE	\N	0.00	0	2025-10-21 11:26:12	2025-10-21 11:26:12
2	0	Galuh	085865809424	\N	\N	\N	ACTIVE	\N	0.00	0	2025-10-22 03:11:30	2025-10-22 03:11:30
3	1	galuh	081214695222	\N	\N	\N	ACTIVE	\N	0.00	0	2025-10-22 03:42:27	2025-10-22 03:42:27
4	1	kaka	085865809424	\N	\N	\N	ACTIVE	\N	0.00	0	2025-10-28 14:21:47	2025-10-28 14:21:47
\.


--
-- Data for Name: deliveries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."deliveries" ("id", "order_id", "assigned_to", "type", "status", "pickup_address", "delivery_address", "pickup_lat", "pickup_lng", "delivery_lat", "delivery_lng", "requested_at", "completed_at", "created_at", "updated_at", "sj_number", "sj_issued_at") FROM stdin;
2	3	\N	DELIVERY	REQUESTED	\N	Jl. Mawar No. 1	\N	\N	-6.9000000	107.6000000	2025-10-16 15:54:41	\N	2025-10-16 15:54:41	2025-10-16 15:54:41	\N	\N
3	3	8	DELIVERY	DELIVERED	\N	Jl. Mawar No. 1	\N	\N	-6.9000000	107.6000000	2025-10-16 16:02:34	2025-10-16 16:47:49	2025-10-16 16:02:34	2025-10-16 16:47:49	\N	\N
6	63	8	DELIVERY	PICKED_UP	\N	\N	\N	\N	\N	\N	2025-10-25 03:52:12	\N	2025-10-25 03:52:12	2025-10-25 03:52:41	\N	\N
5	8	8	DELIVERY	DELIVERED	\N	\N	\N	\N	\N	\N	2025-10-16 19:56:02	2025-10-28 13:22:29	2025-10-16 19:56:02	2025-10-28 13:22:29	\N	\N
1	3	8	DELIVERY	DELIVERED	\N	Jl. Mawar No. 1	\N	\N	-6.9000000	107.6000000	2025-10-16 15:50:57	2025-10-28 13:22:38	2025-10-16 15:50:57	2025-10-28 13:22:38	\N	\N
4	7	8	DELIVERY	PICKED_UP	\N	\N	\N	\N	\N	\N	2025-10-16 18:51:33	\N	2025-10-16 18:51:33	2025-10-28 13:22:41	\N	\N
\.


--
-- Data for Name: delivery_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."delivery_events" ("id", "delivery_id", "status", "note", "photo_url", "occurred_at", "created_at", "updated_at") FROM stdin;
1	1	REQUESTED	Delivery requested	\N	2025-10-16 15:50:57	2025-10-16 15:50:57	2025-10-16 15:50:57
2	2	REQUESTED	Delivery requested	\N	2025-10-16 15:54:41	2025-10-16 15:54:41	2025-10-16 15:54:41
3	3	REQUESTED	Delivery requested	\N	2025-10-16 16:02:34	2025-10-16 16:02:34	2025-10-16 16:02:34
4	3	ASSIGNED	Assigned to user #8	\N	2025-10-16 16:02:35	2025-10-16 16:02:35	2025-10-16 16:02:35
5	1	ASSIGNED	Assigned to user #5	\N	2025-10-16 16:03:27	2025-10-16 16:03:27	2025-10-16 16:03:27
6	3	PICKED_UP	\N	\N	2025-10-16 16:47:40	2025-10-16 16:47:40	2025-10-16 16:47:40
7	3	ON_ROUTE	\N	\N	2025-10-16 16:47:45	2025-10-16 16:47:45	2025-10-16 16:47:45
8	3	DELIVERED	\N	\N	2025-10-16 16:47:49	2025-10-16 16:47:49	2025-10-16 16:47:49
9	4	REQUESTED	Delivery requested	\N	2025-10-16 18:51:33	2025-10-16 18:51:33	2025-10-16 18:51:33
10	5	REQUESTED	Delivery requested	\N	2025-10-16 19:56:02	2025-10-16 19:56:02	2025-10-16 19:56:02
11	5	ASSIGNED	Assigned to user #8	\N	2025-10-16 20:10:58	2025-10-16 20:10:58	2025-10-16 20:10:58
12	4	ASSIGNED	Assigned to user #8	\N	2025-10-16 20:11:08	2025-10-16 20:11:08	2025-10-16 20:11:08
13	1	PICKED_UP	\N	\N	2025-10-16 20:11:17	2025-10-16 20:11:17	2025-10-16 20:11:17
14	1	ON_ROUTE	\N	\N	2025-10-16 20:11:24	2025-10-16 20:11:24	2025-10-16 20:11:24
15	5	PICKED_UP	\N	\N	2025-10-16 20:11:50	2025-10-16 20:11:50	2025-10-16 20:11:50
16	5	ON_ROUTE	\N	\N	2025-10-16 20:11:55	2025-10-16 20:11:55	2025-10-16 20:11:55
17	6	REQUESTED	Delivery requested	\N	2025-10-25 03:52:12	2025-10-25 03:52:12	2025-10-25 03:52:12
18	6	ASSIGNED	Assigned to user #8	\N	2025-10-25 03:52:20	2025-10-25 03:52:20	2025-10-25 03:52:20
19	6	PICKED_UP	\N	\N	2025-10-25 03:52:41	2025-10-25 03:52:41	2025-10-25 03:52:41
20	5	DELIVERED	\N	\N	2025-10-28 13:22:29	2025-10-28 13:22:29	2025-10-28 13:22:29
21	1	DELIVERED	\N	\N	2025-10-28 13:22:37	2025-10-28 13:22:37	2025-10-28 13:22:37
22	4	PICKED_UP	\N	\N	2025-10-28 13:22:41	2025-10-28 13:22:41	2025-10-28 13:22:41
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."failed_jobs" ("id", "uuid", "connection", "queue", "payload", "exception", "failed_at") FROM stdin;
\.


--
-- Data for Name: fee_entries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."fee_entries" ("id", "fee_id", "cabang_id", "period_date", "ref_type", "ref_id", "owner_user_id", "base_amount", "fee_amount", "pay_status", "paid_amount", "paid_at", "notes", "created_by", "updated_by", "created_at", "updated_at") FROM stdin;
1	1	1	2025-10-19	ORDER	26	5	300000.00	5000.00	UNPAID	0.00	\N	\N	5	5	2025-10-19 21:13:15	2025-10-19 21:13:15
34	1	1	2025-10-25	ORDER	63	5	300000.00	5000.00	UNPAID	0.00	\N	\N	5	5	2025-10-25 03:21:37	2025-10-25 03:21:37
35	1	1	2025-10-28	ORDER	64	7	200000.00	5000.00	UNPAID	0.00	\N	\N	7	7	2025-10-28 10:49:16	2025-10-28 10:49:16
36	1	1	2025-10-28	ORDER	65	6	400000.00	5000.00	UNPAID	0.00	\N	\N	6	6	2025-10-28 15:38:04	2025-10-28 15:38:04
37	1	1	2025-10-29	ORDER	66	6	200000.00	5000.00	UNPAID	0.00	\N	\N	6	6	2025-10-29 11:20:05	2025-10-29 11:20:05
38	1	1	2025-10-29	ORDER	68	7	200000.00	5000.00	UNPAID	0.00	\N	\N	7	7	2025-10-29 11:29:01	2025-10-29 11:29:01
39	1	1	2025-10-29	ORDER	69	7	200000.00	5000.00	UNPAID	0.00	\N	\N	7	7	2025-10-29 13:11:05	2025-10-29 13:11:05
40	1	1	2025-10-29	ORDER	70	7	300000.00	5000.00	UNPAID	0.00	\N	\N	7	7	2025-10-29 13:13:27	2025-10-29 13:13:27
41	1	1	2025-10-29	ORDER	71	7	200000.00	5000.00	UNPAID	0.00	\N	\N	7	7	2025-10-29 13:40:45	2025-10-29 13:40:45
\.


--
-- Data for Name: fees; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."fees" ("id", "cabang_id", "name", "kind", "calc_type", "rate", "base", "is_active", "created_by", "updated_by", "created_at", "updated_at") FROM stdin;
1	1	Kasir	CASHIER	FIXED	5000.00	GRAND_TOTAL	t	6	6	2025-10-19 19:27:03	2025-10-19 19:28:14
2	1	Fee Kurir	COURIER	FIXED	5000.00	DELIVERY	t	1	1	2025-10-27 14:24:13	2025-10-27 14:24:13
\.


--
-- Data for Name: fiscal_periods; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."fiscal_periods" ("id", "cabang_id", "year", "month", "status", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: gudangs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."gudangs" ("id", "cabang_id", "nama", "is_default", "is_active", "created_at", "updated_at") FROM stdin;
1	1	Gudang Utama	t	t	2025-10-13 13:43:53	2025-10-13 13:43:53
2	2	Gudang Utama	t	t	2025-10-13 14:09:39	2025-10-13 14:09:39
3	3	Gudang Utama	t	t	2025-10-13 14:41:23	2025-10-13 14:41:23
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."job_batches" ("id", "name", "total_jobs", "pending_jobs", "failed_jobs", "failed_job_ids", "options", "cancelled_at", "created_at", "finished_at") FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."jobs" ("id", "queue", "payload", "attempts", "reserved_at", "available_at", "created_at") FROM stdin;
\.


--
-- Data for Name: journal_entries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."journal_entries" ("id", "cabang_id", "journal_date", "number", "description", "status", "period_year", "period_month", "created_at", "updated_at") FROM stdin;
1	1	2025-10-24	JV-20251024-001	Setoran modal	POSTED	2025	10	2025-10-24 15:33:14	2025-10-24 15:34:20
3	1	2025-10-25	FEE-ACCR-34	Akru Fee order #PRM-1761337297-C1	DRAFT	2025	10	2025-10-25 03:21:37	2025-10-25 03:21:37
2	1	2025-10-25	PAY-PRM-1761337297-C1-64	Pembayaran Order PRM-1761337297-C1 (CASH)	POSTED	2025	10	2025-10-25 03:21:37	2025-10-27 16:01:20
4	1	2025-10-28	PAY-PRM-1761623356-C1-65	Pembayaran Order PRM-1761623356-C1 (CASH)	DRAFT	2025	10	2025-10-28 10:49:16	2025-10-28 10:49:16
6	1	2025-10-28	PAY-PRM-1761640684-C1-66	Pembayaran Order PRM-1761640684-C1 (CASH)	DRAFT	2025	10	2025-10-28 15:38:04	2025-10-28 15:38:04
7	1	2025-10-28	FEE-ACCR-36	Akru Fee order #PRM-1761640684-C1	DRAFT	2025	10	2025-10-28 15:38:04	2025-10-28 15:38:04
5	1	2025-10-28	FEE-ACCR-35	Akru Fee order #PRM-1761623356-C1	POSTED	2025	10	2025-10-28 10:49:16	2025-10-28 15:39:22
8	1	2025-10-29	PAY-PRM-1761711519-C1-67	Pembayaran Order PRM-1761711519-C1 (CASH)	DRAFT	2025	10	2025-10-29 11:20:05	2025-10-29 11:20:05
9	1	2025-10-29	FEE-ACCR-37	Akru Fee order #PRM-1761711519-C1	DRAFT	2025	10	2025-10-29 11:20:05	2025-10-29 11:20:05
10	1	2025-10-29	PAY-PRM-1761712141-C1-68	Pembayaran Order PRM-1761712141-C1 (CASH)	DRAFT	2025	10	2025-10-29 11:29:01	2025-10-29 11:29:01
11	1	2025-10-29	FEE-ACCR-38	Akru Fee order #PRM-1761712141-C1	DRAFT	2025	10	2025-10-29 11:29:01	2025-10-29 11:29:01
12	1	2025-10-29	PAY-PRM-1761718265-C1-69	Pembayaran Order PRM-1761718265-C1 (CASH)	DRAFT	2025	10	2025-10-29 13:11:05	2025-10-29 13:11:05
13	1	2025-10-29	FEE-ACCR-39	Akru Fee order #PRM-1761718265-C1	DRAFT	2025	10	2025-10-29 13:11:05	2025-10-29 13:11:05
14	1	2025-10-29	PAY-PRM-1761718407-C1-70	Pembayaran Order PRM-1761718407-C1 (CASH)	DRAFT	2025	10	2025-10-29 13:13:27	2025-10-29 13:13:27
15	1	2025-10-29	FEE-ACCR-40	Akru Fee order #PRM-1761718407-C1	DRAFT	2025	10	2025-10-29 13:13:27	2025-10-29 13:13:27
16	1	2025-10-29	PAY-PRM-1761720045-C1-71	Pembayaran Order PRM-1761720045-C1 (CASH)	DRAFT	2025	10	2025-10-29 13:40:45	2025-10-29 13:40:45
17	1	2025-10-29	FEE-ACCR-41	Akru Fee order #PRM-1761720045-C1	DRAFT	2025	10	2025-10-29 13:40:45	2025-10-29 13:40:45
\.


--
-- Data for Name: journal_lines; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."journal_lines" ("id", "journal_id", "account_id", "cabang_id", "debit", "credit", "ref_type", "ref_id", "created_at", "updated_at") FROM stdin;
1	1	1	1	1000000.00	0.00	\N	\N	2025-10-24 15:33:14	2025-10-24 15:33:14
2	1	2	1	0.00	1000000.00	\N	\N	2025-10-24 15:33:14	2025-10-24 15:33:14
3	2	8	1	300000.00	0.00	ORDER_PAYMENT	64	2025-10-25 03:21:37	2025-10-25 03:21:37
4	2	18	1	0.00	300000.00	ORDER_PAYMENT	64	2025-10-25 03:21:37	2025-10-25 03:21:37
5	3	22	1	5000.00	0.00	FEE_ENTRY	34	2025-10-25 03:21:37	2025-10-25 03:21:37
6	3	13	1	0.00	5000.00	FEE_ENTRY	34	2025-10-25 03:21:37	2025-10-25 03:21:37
7	4	8	1	200000.00	0.00	ORDER_PAYMENT	65	2025-10-28 10:49:16	2025-10-28 10:49:16
8	4	18	1	0.00	200000.00	ORDER_PAYMENT	65	2025-10-28 10:49:16	2025-10-28 10:49:16
9	5	22	1	5000.00	0.00	FEE_ENTRY	35	2025-10-28 10:49:16	2025-10-28 10:49:16
10	5	13	1	0.00	5000.00	FEE_ENTRY	35	2025-10-28 10:49:16	2025-10-28 10:49:16
11	6	8	1	400000.00	0.00	ORDER_PAYMENT	66	2025-10-28 15:38:04	2025-10-28 15:38:04
12	6	18	1	0.00	400000.00	ORDER_PAYMENT	66	2025-10-28 15:38:04	2025-10-28 15:38:04
13	7	22	1	5000.00	0.00	FEE_ENTRY	36	2025-10-28 15:38:04	2025-10-28 15:38:04
14	7	13	1	0.00	5000.00	FEE_ENTRY	36	2025-10-28 15:38:04	2025-10-28 15:38:04
15	8	8	1	200000.00	0.00	ORDER_PAYMENT	67	2025-10-29 11:20:05	2025-10-29 11:20:05
16	8	18	1	0.00	200000.00	ORDER_PAYMENT	67	2025-10-29 11:20:05	2025-10-29 11:20:05
17	9	22	1	5000.00	0.00	FEE_ENTRY	37	2025-10-29 11:20:05	2025-10-29 11:20:05
18	9	13	1	0.00	5000.00	FEE_ENTRY	37	2025-10-29 11:20:05	2025-10-29 11:20:05
19	10	8	1	200000.00	0.00	ORDER_PAYMENT	68	2025-10-29 11:29:01	2025-10-29 11:29:01
20	10	18	1	0.00	200000.00	ORDER_PAYMENT	68	2025-10-29 11:29:01	2025-10-29 11:29:01
21	11	22	1	5000.00	0.00	FEE_ENTRY	38	2025-10-29 11:29:01	2025-10-29 11:29:01
22	11	13	1	0.00	5000.00	FEE_ENTRY	38	2025-10-29 11:29:01	2025-10-29 11:29:01
23	12	8	1	200000.00	0.00	ORDER_PAYMENT	69	2025-10-29 13:11:05	2025-10-29 13:11:05
24	12	18	1	0.00	200000.00	ORDER_PAYMENT	69	2025-10-29 13:11:05	2025-10-29 13:11:05
25	13	22	1	5000.00	0.00	FEE_ENTRY	39	2025-10-29 13:11:05	2025-10-29 13:11:05
26	13	13	1	0.00	5000.00	FEE_ENTRY	39	2025-10-29 13:11:05	2025-10-29 13:11:05
27	14	8	1	300000.00	0.00	ORDER_PAYMENT	70	2025-10-29 13:13:27	2025-10-29 13:13:27
28	14	18	1	0.00	300000.00	ORDER_PAYMENT	70	2025-10-29 13:13:27	2025-10-29 13:13:27
29	15	22	1	5000.00	0.00	FEE_ENTRY	40	2025-10-29 13:13:27	2025-10-29 13:13:27
30	15	13	1	0.00	5000.00	FEE_ENTRY	40	2025-10-29 13:13:27	2025-10-29 13:13:27
31	16	8	1	200000.00	0.00	ORDER_PAYMENT	71	2025-10-29 13:40:45	2025-10-29 13:40:45
32	16	18	1	0.00	200000.00	ORDER_PAYMENT	71	2025-10-29 13:40:45	2025-10-29 13:40:45
33	17	22	1	5000.00	0.00	FEE_ENTRY	41	2025-10-29 13:40:45	2025-10-29 13:40:45
34	17	13	1	0.00	5000.00	FEE_ENTRY	41	2025-10-29 13:40:45	2025-10-29 13:40:45
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."migrations" ("id", "migration", "batch") FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2025_10_10_163000_create_personal_access_tokens_table	1
5	2025_10_10_163102_create_permission_tables	1
6	2025_10_10_235604_add_email_verified_at_to_users_table	1
7	2025_10_11_034254_create_cabangs_table	1
8	2025_10_11_034314_create_gudangs_table	1
9	2025_10_11_034328_alter_users_add_fk_cabang	1
10	2025_10_11_155442_create_categories_table	1
11	2025_10_11_164844_create_products_table	1
12	2025_10_11_164857_create_product_variants_table	1
13	2025_10_11_164921_create_product_media_table	1
14	2025_10_11_222030_create_variant_stocks_table	1
15	2025_10_13_163035_create_orders_table	2
16	2025_10_13_163117_create_order_items_table	2
17	2025_10_13_163143_create_payments_table	2
18	2025_10_15_141249_add_indexes_to_product_media_table	3
21	2025_10_16_114348_create_audit_logs_table	4
22	2025_10_16_144328_create_deliveries_table	5
23	2025_10_16_144357_create_delivery_events_table	5
24	2025_10_17_094949_create_cash_tables	6
25	2025_10_19_140501_create_fees_table	7
26	2025_10_19_140645_create_fee_entries_table	7
27	2025_10_19_211100_add_paid_at_to_orders_table	8
28	2025_10_21_110720_create_customers_tables	9
29	2025_10_21_111710_create_customer_timelines_table	9
30	2025_10_21_111736_add_fk_orders_customer	9
31	2025_10_23_155723_create_settings_table	10
32	2025_10_23_155810_create_backups_table	10
33	2025_10_23_164213_alter_audit_logs_add_occurred_at	11
34	2025_10_24_141645_create_accounts_table	12
35	2025_10_24_141733_create_fiscal_periods_table	12
36	2025_10_24_141758_create_journal_entries_table	12
37	2025_10_24_141829_create_journal_lines_table	12
38	2025_10_28_150702_add_customer_snapshot_to_orders	13
39	2025_10_29_095742_add_cash_position_to_orders	14
41	2025_10_29_113547_order_change_logs_table	15
42	2025_10_29_131948_create_receipts_table	16
43	2025_10_29_144826_add_sj_columns_to_deliveries_table	17
\.


--
-- Data for Name: model_has_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."model_has_permissions" ("permission_id", "model_type", "model_id") FROM stdin;
\.


--
-- Data for Name: model_has_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."model_has_roles" ("role_id", "model_type", "model_id") FROM stdin;
1	App\\Models\\User	1
2	App\\Models\\User	6
3	App\\Models\\User	5
4	App\\Models\\User	8
\.


--
-- Data for Name: order_change_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."order_change_logs" ("id", "order_id", "actor_id", "action", "diff_json", "note", "occurred_at", "created_at", "updated_at") FROM stdin;
1	70	7	REPRINT	{"format":"58"}	\N	2025-10-29 13:13:27+07	2025-10-29 13:13:27+07	2025-10-29 13:13:27+07
2	70	7	REPRINT	{"format":"58"}	\N	2025-10-29 13:13:28+07	2025-10-29 13:13:28+07	2025-10-29 13:13:28+07
3	71	7	REPRINT	{"format":58}	\N	2025-10-29 13:40:45+07	2025-10-29 13:40:45+07	2025-10-29 13:40:45+07
4	71	7	REPRINT	{"format":58}	\N	2025-10-29 13:40:45+07	2025-10-29 13:40:45+07	2025-10-29 13:40:45+07
5	71	7	SET_CASH_POSITION	{"before":"CUSTOMER","after":"SALES"}	\N	2025-10-29 14:05:28+07	2025-10-29 14:05:28+07	2025-10-29 14:05:28+07
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."order_items" ("id", "order_id", "variant_id", "name_snapshot", "price", "discount", "qty", "line_total", "created_at", "updated_at") FROM stdin;
2	2	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-14 14:38:25	2025-10-14 14:38:25
4	4	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-15 10:09:28	2025-10-15 10:09:28
5	5	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-15 10:16:08	2025-10-15 10:16:08
6	6	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-15 13:50:47	2025-10-15 13:50:47
7	7	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-16 10:34:23	2025-10-16 10:34:23
8	1	2	Kue ulang tahun -	300000.00	0.00	1.00	300000.00	2025-10-16 10:55:46	2025-10-16 10:55:46
9	1	1	Cholate Flavor -	200000.00	0.00	2.00	400000.00	2025-10-16 10:55:46	2025-10-16 10:55:46
3	3	2	Kue ulang tahun - 	280000.00	0.00	1.00	280000.00	2025-10-15 10:01:06	2025-10-16 11:44:28
12	3	1	Cholate Flavor -	200000.00	0.00	1.00	200000.00	2025-10-16 11:44:28	2025-10-16 11:44:28
13	8	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-16 19:55:21	2025-10-16 19:55:21
14	8	1	Cholate Flavor - 	200000.00	0.00	1.00	200000.00	2025-10-16 19:55:21	2025-10-16 19:55:21
15	9	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-18 13:29:29	2025-10-18 13:29:29
16	10	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-18 13:47:44	2025-10-18 13:47:44
17	11	1	Cholate Flavor - 	200000.00	0.00	1.00	200000.00	2025-10-18 13:50:04	2025-10-18 13:50:04
18	12	1	Cholate Flavor - 	200000.00	0.00	3.00	600000.00	2025-10-18 13:53:32	2025-10-18 13:53:32
19	13	1	Cholate Flavor - 	200000.00	0.00	1.00	200000.00	2025-10-18 13:59:18	2025-10-18 13:59:18
20	14	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-18 14:02:33	2025-10-18 14:02:33
21	15	2	Kue ulang tahun - 	300000.00	0.00	3.00	900000.00	2025-10-18 14:14:48	2025-10-18 14:14:48
22	16	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-18 14:38:07	2025-10-18 14:38:07
23	17	1	Cholate Flavor - 	200000.00	0.00	2.00	400000.00	2025-10-18 14:38:36	2025-10-18 14:38:36
24	18	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-18 14:53:39	2025-10-18 14:53:39
25	19	2	Kue ulang tahun - 	300000.00	0.00	4.00	1200000.00	2025-10-18 15:00:12	2025-10-18 15:00:12
26	20	2	Kue ulang tahun - 	300000.00	0.00	5.00	1500000.00	2025-10-18 15:03:35	2025-10-18 15:03:35
27	21	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-18 17:08:59	2025-10-18 17:08:59
28	22	1	Cholate Flavor - 	200000.00	0.00	8.00	1600000.00	2025-10-18 17:19:26	2025-10-18 17:19:26
29	23	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-19 18:17:05	2025-10-19 18:17:05
30	24	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-19 19:29:02	2025-10-19 19:29:02
32	26	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-19 21:13:15	2025-10-19 21:13:15
69	63	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-25 03:21:37	2025-10-25 03:21:37
70	64	1	Cholate Flavor - 	200000.00	0.00	1.00	200000.00	2025-10-28 10:49:16	2025-10-28 10:49:16
71	65	1	Cholate Flavor - 	200000.00	0.00	2.00	400000.00	2025-10-28 15:38:04	2025-10-28 15:38:04
72	66	1	Cholate Flavor - 	200000.00	0.00	1.00	200000.00	2025-10-29 11:18:39	2025-10-29 11:18:39
73	67	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-29 11:20:34	2025-10-29 11:20:34
74	68	1	Cholate Flavor - 	200000.00	0.00	1.00	200000.00	2025-10-29 11:29:01	2025-10-29 11:29:01
75	69	1	Cholate Flavor - 	200000.00	0.00	1.00	200000.00	2025-10-29 13:11:05	2025-10-29 13:11:05
76	70	2	Kue ulang tahun - 	300000.00	0.00	1.00	300000.00	2025-10-29 13:13:27	2025-10-29 13:13:27
77	71	1	Cholate Flavor - 	200000.00	0.00	1.00	200000.00	2025-10-29 13:40:45	2025-10-29 13:40:45
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."orders" ("id", "kode", "cabang_id", "gudang_id", "cashier_id", "customer_id", "status", "subtotal", "discount", "tax", "service_fee", "grand_total", "paid_total", "channel", "note", "ordered_at", "created_at", "updated_at", "paid_at", "customer_name", "customer_phone", "customer_address", "cash_position") FROM stdin;
66	PRM-1761711519-C1	1	1	6	4	PAID	200000.00	0.00	0.00	0.00	200000.00	200000.00	POS	\N	2025-10-29 11:18:39	2025-10-29 11:18:39	2025-10-29 11:20:05	2025-10-29 11:20:05+07	kaka	085865809424	\N	CUSTOMER
16	PRM-1760773087-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-18 14:38:07	2025-10-18 14:38:07	2025-10-18 14:39:01	\N	\N	\N	\N	\N
2	PRM-1760427505-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-14 14:38:25	2025-10-14 14:38:25	2025-10-14 14:38:25	\N	\N	\N	\N	\N
26	PRM-1760883195-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-19 21:13:15	2025-10-19 21:13:15	2025-10-19 21:13:15	2025-10-19 21:13:15+07	\N	\N	\N	\N
18	PRM-1760774019-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-18 14:53:39	2025-10-18 14:53:39	2025-10-18 14:54:05	\N	\N	\N	\N	\N
5	PRM-1760498168-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-15 10:16:08	2025-10-15 10:16:08	2025-10-15 10:16:08	\N	\N	\N	\N	\N
6	PRM-1760511046-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-15 13:50:46	2025-10-15 13:50:46	2025-10-15 13:50:47	\N	\N	\N	\N	\N
7	PRM-1760585663-C1	1	1	6	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-16 10:34:23	2025-10-16 10:34:23	2025-10-16 10:34:23	\N	\N	\N	\N	\N
19	PRM-1760774412-C1	1	1	5	\N	PAID	1200000.00	0.00	0.00	0.00	1200000.00	1200000.00	POS	\N	2025-10-18 15:00:12	2025-10-18 15:00:12	2025-10-18 15:00:27	\N	\N	\N	\N	\N
1	PRM-1760426365-C1	1	1	5	\N	PAID	700000.00	0.00	0.00	0.00	700000.00	700000.00	POS	\N	2025-10-14 14:19:25	2025-10-14 14:19:25	2025-10-16 11:18:45	\N	\N	\N	\N	\N
67	PRM-1761711634-C1	1	1	6	\N	UNPAID	300000.00	0.00	0.00	0.00	300000.00	0.00	POS	\N	2025-10-29 11:20:34	2025-10-29 11:20:34	2025-10-29 11:20:34	\N	\N	\N	\N	CASHIER
20	PRM-1760774615-C1	1	1	5	\N	PAID	1500000.00	0.00	0.00	0.00	1500000.00	1500000.00	POS	\N	2025-10-18 15:03:35	2025-10-18 15:03:35	2025-10-18 15:03:56	\N	\N	\N	\N	\N
3	PRM-1760497266-C1	1	1	5	\N	UNPAID	480000.00	0.00	0.00	0.00	480000.00	50000.00	POS	\N	2025-10-15 10:01:06	2025-10-15 10:01:06	2025-10-16 11:44:28	\N	\N	\N	\N	\N
4	PRM-1760497768-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-15 10:09:28	2025-10-15 10:09:28	2025-10-16 14:35:31	\N	\N	\N	\N	\N
13	PRM-1760770758-C1	1	1	5	\N	PAID	200000.00	0.00	0.00	0.00	200000.00	200000.00	POS	\N	2025-10-18 13:59:18	2025-10-18 13:59:18	2025-10-18 15:28:36	\N	\N	\N	\N	\N
8	PRM-1760619321-C1	1	1	5	\N	PAID	500000.00	0.00	0.00	0.00	500000.00	500000.00	POS	\N	2025-10-16 19:55:21	2025-10-16 19:55:21	2025-10-16 19:55:21	\N	\N	\N	\N	\N
9	PRM-1760768969-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-18 13:29:29	2025-10-18 13:29:29	2025-10-18 13:29:59	\N	\N	\N	\N	\N
10	PRM-1760770064-C1	1	1	5	\N	UNPAID	300000.00	0.00	0.00	0.00	300000.00	0.00	POS	\N	2025-10-18 13:47:44	2025-10-18 13:47:44	2025-10-18 13:47:44	\N	\N	\N	\N	\N
11	PRM-1760770204-C1	1	1	5	\N	UNPAID	200000.00	0.00	0.00	0.00	200000.00	0.00	POS	\N	2025-10-18 13:50:04	2025-10-18 13:50:04	2025-10-18 13:50:04	\N	\N	\N	\N	\N
15	PRM-1760771688-C1	1	1	5	\N	PAID	900000.00	0.00	0.00	0.00	900000.00	900000.00	POS	\N	2025-10-18 14:14:48	2025-10-18 14:14:48	2025-10-18 14:15:36	\N	\N	\N	\N	\N
14	PRM-1760770953-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-18 14:02:33	2025-10-18 14:02:33	2025-10-18 14:16:13	\N	\N	\N	\N	\N
21	PRM-1760782139-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-18 17:08:59	2025-10-18 17:08:59	2025-10-18 17:18:36	\N	\N	\N	\N	\N
12	PRM-1760770412-C1	1	1	5	\N	PAID	600000.00	0.00	0.00	0.00	600000.00	600000.00	POS	\N	2025-10-18 13:53:32	2025-10-18 13:53:32	2025-10-18 14:18:39	\N	\N	\N	\N	\N
17	PRM-1760773116-C1	1	1	5	\N	PAID	400000.00	0.00	0.00	0.00	400000.00	400000.00	POS	\N	2025-10-18 14:38:36	2025-10-18 14:38:36	2025-10-18 14:38:37	\N	\N	\N	\N	\N
22	PRM-1760782766-C1	1	1	5	\N	PAID	1600000.00	0.00	0.00	0.00	1600000.00	1600000.00	POS	\N	2025-10-18 17:19:26	2025-10-18 17:19:26	2025-10-18 17:19:51	\N	\N	\N	\N	\N
68	PRM-1761712141-C1	1	1	7	3	PAID	200000.00	0.00	0.00	0.00	200000.00	200000.00	POS	\N	2025-10-29 11:29:01	2025-10-29 11:29:01	2025-10-29 11:29:01	2025-10-29 11:29:01+07	galuh	081214695222	\N	CUSTOMER
23	PRM-1760872625-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-19 18:17:05	2025-10-19 18:17:05	2025-10-19 18:17:05	\N	\N	\N	\N	\N
24	PRM-1760876942-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-19 19:29:02	2025-10-19 19:29:02	2025-10-19 19:29:02	\N	\N	\N	\N	\N
63	PRM-1761337297-C1	1	1	5	\N	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-25 03:21:37	2025-10-25 03:21:37	2025-10-25 03:21:37	2025-10-25 03:21:37+07	\N	\N	\N	\N
71	PRM-1761720045-C1	1	1	7	4	PAID	200000.00	0.00	0.00	0.00	200000.00	200000.00	POS	\N	2025-10-29 13:40:45	2025-10-29 13:40:45	2025-10-29 14:05:28	2025-10-29 13:40:45+07	kaka	085865809424	\N	SALES
64	PRM-1761623356-C1	1	1	7	\N	PAID	200000.00	0.00	0.00	0.00	200000.00	200000.00	POS	\N	2025-10-28 10:49:16	2025-10-28 10:49:16	2025-10-28 10:49:16	2025-10-28 10:49:16+07	\N	\N	\N	\N
69	PRM-1761718265-C1	1	1	7	4	PAID	200000.00	0.00	0.00	0.00	200000.00	200000.00	POS	\N	2025-10-29 13:11:05	2025-10-29 13:11:05	2025-10-29 13:11:05	2025-10-29 13:11:05+07	kaka	085865809424	\N	CUSTOMER
65	PRM-1761640684-C1	1	1	6	3	PAID	400000.00	0.00	0.00	0.00	400000.00	400000.00	POS	\N	2025-10-28 15:38:04	2025-10-28 15:38:04	2025-10-28 15:38:04	2025-10-28 15:38:04+07	galuh	081214695222	\N	\N
70	PRM-1761718407-C1	1	1	7	3	PAID	300000.00	0.00	0.00	0.00	300000.00	300000.00	POS	\N	2025-10-29 13:13:27	2025-10-29 13:13:27	2025-10-29 13:13:27	2025-10-29 13:13:27+07	galuh	081214695222	\N	CASHIER
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."payments" ("id", "order_id", "method", "amount", "status", "ref_no", "payload_json", "paid_at", "created_at", "updated_at") FROM stdin;
1	1	CASH	10000.00	SUCCESS	\N	\N	2025-10-14 14:19:25	2025-10-14 14:19:25	2025-10-14 14:19:25
2	2	CASH	300000.00	SUCCESS	\N	\N	2025-10-14 14:38:25	2025-10-14 14:38:25	2025-10-14 14:38:25
3	3	CASH	50000.00	SUCCESS	\N	\N	2025-10-15 10:01:06	2025-10-15 10:01:06	2025-10-15 10:01:06
4	4	CASH	100000.00	SUCCESS	\N	\N	2025-10-15 10:09:28	2025-10-15 10:09:28	2025-10-15 10:09:28
5	5	CASH	300000.00	SUCCESS	\N	\N	2025-10-15 10:16:08	2025-10-15 10:16:08	2025-10-15 10:16:08
6	6	CASH	300000.00	SUCCESS	\N	\N	2025-10-15 13:50:47	2025-10-15 13:50:47	2025-10-15 13:50:47
7	7	CASH	300000.00	SUCCESS	\N	\N	2025-10-16 10:34:23	2025-10-16 10:34:23	2025-10-16 10:34:23
8	1	CASH	690000.00	SUCCESS	\N	\N	2025-10-16 11:18:45	2025-10-16 11:18:45	2025-10-16 11:18:45
9	4	CASH	200000.00	SUCCESS	\N	\N	2025-10-16 14:35:31	2025-10-16 14:35:31	2025-10-16 14:35:31
10	8	CASH	500000.00	SUCCESS	\N	\N	2025-10-16 19:55:21	2025-10-16 19:55:21	2025-10-16 19:55:21
11	9	CASH	300000.00	SUCCESS	\N	\N	2025-10-18 13:29:59	2025-10-18 13:29:59	2025-10-18 13:29:59
12	15	CASH	900000.00	SUCCESS	\N	\N	2025-10-18 14:15:36	2025-10-18 14:15:36	2025-10-18 14:15:36
13	14	CASH	300000.00	SUCCESS	\N	\N	2025-10-18 14:16:13	2025-10-18 14:16:13	2025-10-18 14:16:13
14	12	CASH	600000.00	SUCCESS	\N	\N	2025-10-18 14:18:39	2025-10-18 14:18:39	2025-10-18 14:18:39
15	17	CASH	400000.00	SUCCESS	\N	\N	2025-10-18 14:38:37	2025-10-18 14:38:37	2025-10-18 14:38:37
16	16	CASH	300000.00	SUCCESS	\N	\N	2025-10-18 14:39:01	2025-10-18 14:39:01	2025-10-18 14:39:01
17	18	CASH	300000.00	SUCCESS	\N	\N	2025-10-18 14:54:05	2025-10-18 14:54:05	2025-10-18 14:54:05
18	19	CASH	1200000.00	SUCCESS	\N	\N	2025-10-18 15:00:27	2025-10-18 15:00:27	2025-10-18 15:00:27
19	20	CASH	1500000.00	SUCCESS	\N	\N	2025-10-18 15:03:56	2025-10-18 15:03:56	2025-10-18 15:03:56
20	13	CASH	200000.00	SUCCESS	\N	\N	2025-10-18 15:28:36	2025-10-18 15:28:36	2025-10-18 15:28:36
22	21	CASH	300000.00	SUCCESS	\N	{"holder_id":3,"collected_at":"2025-10-18T10:18:34.649Z"}	2025-10-18 17:18:36	2025-10-18 17:18:36	2025-10-18 17:18:36
23	22	CASH	1600000.00	SUCCESS	\N	{"holder_id":3,"collected_at":"2025-10-18T10:19:48.802Z"}	2025-10-18 17:19:51	2025-10-18 17:19:51	2025-10-18 17:19:51
24	23	CASH	300000.00	SUCCESS	\N	\N	2025-10-19 18:17:05	2025-10-19 18:17:05	2025-10-19 18:17:05
25	24	CASH	300000.00	SUCCESS	\N	\N	2025-10-19 19:29:02	2025-10-19 19:29:02	2025-10-19 19:29:02
27	26	CASH	300000.00	SUCCESS	\N	\N	2025-10-19 21:13:15	2025-10-19 21:13:15	2025-10-19 21:13:15
64	63	CASH	300000.00	SUCCESS	\N	\N	2025-10-25 03:21:37	2025-10-25 03:21:37	2025-10-25 03:21:37
65	64	CASH	200000.00	SUCCESS	\N	\N	2025-10-28 10:49:16	2025-10-28 10:49:16	2025-10-28 10:49:16
66	65	CASH	400000.00	SUCCESS	\N	\N	2025-10-28 15:38:04	2025-10-28 15:38:04	2025-10-28 15:38:04
67	66	CASH	200000.00	SUCCESS	\N	{"holder_id":3,"collected_at":"2025-10-29T04:20:05.125Z"}	2025-10-29 11:20:05	2025-10-29 11:20:05	2025-10-29 11:20:05
68	68	CASH	200000.00	SUCCESS	\N	\N	2025-10-29 11:29:01	2025-10-29 11:29:01	2025-10-29 11:29:01
69	69	CASH	200000.00	SUCCESS	\N	\N	2025-10-29 13:11:05	2025-10-29 13:11:05	2025-10-29 13:11:05
70	70	CASH	300000.00	SUCCESS	\N	\N	2025-10-29 13:13:27	2025-10-29 13:13:27	2025-10-29 13:13:27
71	71	CASH	200000.00	SUCCESS	\N	\N	2025-10-29 13:40:45	2025-10-29 13:40:45	2025-10-29 13:40:45
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."permissions" ("id", "name", "guard_name", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."personal_access_tokens" ("id", "tokenable_type", "tokenable_id", "name", "token", "abilities", "last_used_at", "expires_at", "created_at", "updated_at") FROM stdin;
62	App\\Models\\User	6	api	920ffc7c4eeaa15d1daf8112c719582ce262f244e2b88e8f0a5f81305eae4b95	["*"]	2025-10-15 10:16:52	\N	2025-10-15 10:16:49	2025-10-15 10:16:52
1	App\\Models\\User	1	api	5f6ddc4137f960fdb0bf28adbb7878fce605150824a66a342c30f9d312f92868	["*"]	2025-10-13 17:03:44	\N	2025-10-13 14:09:02	2025-10-13 17:03:44
2	App\\Models\\User	1	api	d86980bf5fde42da9e2750d7bb8799d57bd64b9a80cfb7c7a81a70933c1e83de	["*"]	\N	\N	2025-10-13 14:29:14	2025-10-13 14:29:14
98	App\\Models\\User	6	api	d50c62b9a8a63e8c104659c041c802d8d076191c30266db2422b9b3f49ed9670	["*"]	2025-10-17 13:05:12	\N	2025-10-17 10:48:50	2025-10-17 13:05:12
127	App\\Models\\User	6	api	b4824493cfea3a46ff1295afdf34d3d011cee04fa5928fb5edf3bb532493409e	["*"]	2025-10-18 15:17:49	\N	2025-10-18 15:04:26	2025-10-18 15:17:49
60	App\\Models\\User	1	api	d93b3f0486a86c2f318ef2797452efcbcb1b0d47e9c6a7d8f72bf26edafa3d3b	["*"]	2025-10-15 10:09:52	\N	2025-10-15 10:05:03	2025-10-15 10:09:52
51	App\\Models\\User	5	api	c29d6c219f281068b14aa945c2955a61454639f4a95f9cecd9a6767356f560b8	["*"]	2025-10-14 11:42:43	\N	2025-10-14 11:35:31	2025-10-14 11:42:43
101	App\\Models\\User	1	api	be850b9da51a8fbdb97fbd43fd6df909db433ecfd92ab894a8ce84c9d7a4f80d	["*"]	2025-10-19 14:49:45	\N	2025-10-17 13:14:40	2025-10-19 14:49:45
128	App\\Models\\User	6	api	310d2068d0b46d0318d728645ae701bd455b007b97a11b6de18e55d6d30c4a3c	["*"]	2025-10-18 15:18:48	\N	2025-10-18 15:18:22	2025-10-18 15:18:48
94	App\\Models\\User	6	api	1f203fb17df8cb884f968928e6b9a341991e27350ee7a564dcef583be5659a30	["*"]	2025-10-17 10:47:18	\N	2025-10-16 19:49:33	2025-10-17 10:47:18
81	App\\Models\\User	1	api	2de582907de59f3fad17a60e03c0e2f03fe7e6fa627f10f9fcd265f2480b513e	["*"]	2025-10-16 13:23:19	\N	2025-10-16 10:53:14	2025-10-16 13:23:19
46	App\\Models\\User	6	api	4f3afdaa9fb9d87faaeeb04bdb60d62a2f1bd6b864c5875ac90001f0c7e444b1	["*"]	2025-10-14 10:38:09	\N	2025-10-14 10:37:42	2025-10-14 10:38:09
70	App\\Models\\User	6	api	32ee773303f6228802021c49b3afaba0ed1edc67d24cb7decfa4c0c6fd507d19	["*"]	2025-10-15 11:33:41	\N	2025-10-15 11:24:32	2025-10-15 11:33:41
169	App\\Models\\User	1	api	b84bd095cb17ab2e6685bb14c260400f05a8939554857977b1470cca2b46e4a0	["*"]	2025-10-21 11:34:29	\N	2025-10-21 11:22:52	2025-10-21 11:34:29
68	App\\Models\\User	6	api	2a56f401a59b73bbaca972072e1b1925f4f3144cd70383412e85567d0806e39c	["*"]	2025-10-15 11:02:00	\N	2025-10-15 10:56:50	2025-10-15 11:02:00
59	App\\Models\\User	6	api	0a8f8f48859915f9d3e0ba74da25e9f25f25b7ba6dbbc01bde7afeb7c06d67aa	["*"]	2025-10-15 10:04:14	\N	2025-10-15 10:04:12	2025-10-15 10:04:14
88	App\\Models\\User	5	api	5af70eb34a736609cc1a22518a22daa886e2363374abc5adcffc1771f1d966c1	["*"]	2025-10-16 18:51:46	\N	2025-10-16 16:53:29	2025-10-16 18:51:46
56	App\\Models\\User	5	api	b5995fdea4eb31cfc14bf771980a60947aec3579ef6a05ebb34acebb2ed2fd10	["*"]	2025-10-14 14:19:25	\N	2025-10-14 14:18:41	2025-10-14 14:19:25
84	App\\Models\\User	6	api	c9e2f8e5e7c28a95432e93af2b1377b588ac493dbbaf725a6629448d8047394c	["*"]	2025-10-16 16:43:57	\N	2025-10-16 15:34:19	2025-10-16 16:43:57
83	App\\Models\\User	1	api	6035ffc861356cc00683d6f9697e86545489673274bf304aac962e535231f9c0	["*"]	2025-10-16 15:32:31	\N	2025-10-16 15:28:29	2025-10-16 15:32:31
65	App\\Models\\User	6	api	92394e772727b8a8227cb54ac784c75c51416ac4517d4ab44cb6c470236c2fcf	["*"]	2025-10-15 10:24:58	\N	2025-10-15 10:23:34	2025-10-15 10:24:58
207	App\\Models\\User	7	api	d39a7cf37fa37cf9a349ea8426762df0e49a49bfc202fdc2a16fc5013419c37d	["*"]	2025-10-22 14:35:04	\N	2025-10-22 13:33:06	2025-10-22 14:35:04
49	App\\Models\\User	1	api	5a5ac18200db1da3cc8406d7bfb1d638915aca611549ca414a20df0c7ef902d9	["*"]	2025-10-14 13:51:20	\N	2025-10-14 10:59:26	2025-10-14 13:51:20
71	App\\Models\\User	6	api	bc25308eb97c503fa2a4c9e69e6a1f4d2e02936c59bbe6f89739c1d6ac068954	["*"]	2025-10-15 11:41:05	\N	2025-10-15 11:33:50	2025-10-15 11:41:05
72	App\\Models\\User	6	api	ecfce1d485df906c85015675bee0ee18af26a81749a433f75b83f7524199bffb	["*"]	2025-10-15 11:50:26	\N	2025-10-15 11:50:24	2025-10-15 11:50:26
79	App\\Models\\User	6	api	430f2ab40d4a9203e066237974bbc9544e0fd8391c9c608154dcfff776ed01c9	["*"]	2025-10-15 17:01:09	\N	2025-10-15 15:20:12	2025-10-15 17:01:09
66	App\\Models\\User	6	api	551a7fcffd6627fbd4f71ac90d06dc923e93391f658166118bd2a137dd5e9ab3	["*"]	2025-10-15 10:28:57	\N	2025-10-15 10:27:48	2025-10-15 10:28:57
67	App\\Models\\User	6	api	ecc457d921cf81310b95ca99084ae69df3082f79483db6ddbb250b7f40efe028	["*"]	2025-10-15 10:52:49	\N	2025-10-15 10:52:47	2025-10-15 10:52:49
93	App\\Models\\User	5	api	29ebd45fd77eb8d1be24804c8cebc9a4516c33cb49bec919113ac781c2591382	["*"]	2025-10-16 19:31:56	\N	2025-10-16 19:31:42	2025-10-16 19:31:56
75	App\\Models\\User	6	api	1c5976e6911baa1aef47f55f7a7c2d7fca01c834aa6b5e6924ca2121726adcaa	["*"]	2025-10-15 13:51:26	\N	2025-10-15 13:51:15	2025-10-15 13:51:26
210	App\\Models\\User	5	api	2a3f8acbdc3661949cffe24c7fdc618a974f3134349fb4fc3d4abfe024782613	["*"]	2025-10-23 13:00:19	\N	2025-10-23 12:32:58	2025-10-23 13:00:19
211	App\\Models\\User	5	api	09977d798b68301497915e64d5720a94b5e0bb93f79f0d7a8776cff51c5746ad	["*"]	2025-10-23 12:51:32	\N	2025-10-23 12:51:20	2025-10-23 12:51:32
89	App\\Models\\User	5	api	f2006ce43d5868fbde7bc0889be7aaaa79061aa98304e4d00703cc20ff522a8a	["*"]	2025-10-16 18:58:38	\N	2025-10-16 18:58:25	2025-10-16 18:58:38
97	App\\Models\\User	1	api	d4ea80563e5cfade0fca4e4d280e6ede005c18b4bbce81315be560eb0adfaa9f	["*"]	2025-10-17 10:47:47	\N	2025-10-17 10:47:37	2025-10-17 10:47:47
92	App\\Models\\User	5	api	6b735850f93a8a7a9ee34c30e9e9d92d9be57f8b5d183186a1825ee4fd8b0a7e	["*"]	2025-10-16 19:11:43	\N	2025-10-16 19:11:30	2025-10-16 19:11:43
90	App\\Models\\User	5	api	2dd6dabd0cd12c07fdaa7ab14aa7308b61dd2e4fc02e3562b93280dbe0d0b455	["*"]	2025-10-16 19:07:45	\N	2025-10-16 19:07:32	2025-10-16 19:07:45
212	App\\Models\\User	6	api	3cae97d2f1e460cb09a55e5e2d7b070189fead22b38940ea57ee62871b796252	["*"]	2025-10-23 12:51:52	\N	2025-10-23 12:51:43	2025-10-23 12:51:52
214	App\\Models\\User	6	api	b50120980ab7cbcbf2d3e46df4d7c647bb361f971d5916b5e7777cffbebb8477	["*"]	2025-10-23 13:13:57	\N	2025-10-23 13:13:45	2025-10-23 13:13:57
100	App\\Models\\User	5	api	ff8c8a5bb0efd772c9f923b4ff8c50f9f249d8c5f7f7a13f105fd03a2baead9e	["*"]	2025-10-17 13:12:10	\N	2025-10-17 13:05:33	2025-10-17 13:12:10
213	App\\Models\\User	6	api	0be450c5c9af85bf27b6e6dabff3ef47f396dfbf19ea0ab62cfbd1faf78b7993	["*"]	2025-10-23 12:56:36	\N	2025-10-23 12:56:26	2025-10-23 12:56:36
209	App\\Models\\User	1	api	997a7668ac891a3d0e023821b2e4e240c730cb6c9374a1b6c8c08b949e32fb76	["*"]	2025-10-23 17:04:11	\N	2025-10-23 11:03:39	2025-10-23 17:04:11
95	App\\Models\\User	5	api	daba3a72c26819b63ef2ae09dffa87576e55fd2a1cb540092c4227050733b771	["*"]	2025-10-16 19:56:16	\N	2025-10-16 19:55:01	2025-10-16 19:56:16
102	App\\Models\\User	6	api	b52e4b2bf9773476bd7293ef2e26eac8adac986ccbbf2a91dd195b827c8d3b6a	["*"]	2025-10-17 16:01:37	\N	2025-10-17 15:34:51	2025-10-17 16:01:37
114	App\\Models\\User	6	api	5922a77bd28f452463f924dc277d9505f0c00858c6562295be1698ec4cfe0d4b	["*"]	2025-10-18 13:53:10	\N	2025-10-18 13:49:31	2025-10-18 13:53:10
215	App\\Models\\User	6	api	340dddc0caefaf47d4690a2e1b0755bb29ae4fb9ec6739603fec370158a31c64	["*"]	2025-10-23 13:18:53	\N	2025-10-23 13:18:40	2025-10-23 13:18:53
237	App\\Models\\User	5	api	bbf1509948b847bb00fd3b922a89e0ba339b4a6a5b6e34a24e662078547d5e98	["*"]	2025-10-25 03:25:02	\N	2025-10-25 03:21:18	2025-10-25 03:25:02
220	App\\Models\\User	6	api	b5b05b9e86306572b77a68aabe26a0a17bb884c57c1448219e4d4c525b1f7660	["*"]	2025-10-23 17:47:21	\N	2025-10-23 17:47:07	2025-10-23 17:47:21
256	App\\Models\\User	6	api	4f0747860d3818693ce2297da223cf9a26bc2b00ad61c9d838de4c75218a669e	["*"]	2025-10-27 15:55:32	\N	2025-10-27 15:38:31	2025-10-27 15:55:32
218	App\\Models\\User	6	api	034d559ff239a31b06da5b55c2538509c78e2b0e6e5d0602855a6faeae5105fe	["*"]	2025-10-23 14:07:28	\N	2025-10-23 14:07:17	2025-10-23 14:07:28
247	App\\Models\\User	1	api	0964fcd981b5d3ded1046ac784e793f98aafc4c5ce2a8c092bd7312ad88b65a7	["*"]	2025-10-26 16:15:54	\N	2025-10-26 04:05:59	2025-10-26 16:15:54
221	App\\Models\\User	6	api	1b35f682da6f3aecd90e77badb0c54684ae53d021990b23315fa051bbf3efcc8	["*"]	2025-10-23 17:47:52	\N	2025-10-23 17:47:31	2025-10-23 17:47:52
225	App\\Models\\User	6	api	eb96bd6ffeb39f48093475b58eb8694f3db45e2e40826b978d986b2a8ab59ba6	["*"]	2025-10-23 20:47:38	\N	2025-10-23 20:41:25	2025-10-23 20:47:38
226	App\\Models\\User	1	api	23276a7a6e15b7a6b9980b32975ff095b57cad2a3abc5d0f823700993813d0be	["*"]	\N	\N	2025-10-24 14:28:07	2025-10-24 14:28:07
260	App\\Models\\User	7	api	0b2881c7ad234cc88c55885a88c1930810f8db8994a4387ed7f327d9d4aa7522	["*"]	2025-10-27 16:15:03	\N	2025-10-27 16:15:02	2025-10-27 16:15:03
222	App\\Models\\User	6	api	761444eb9ebc54a5d35ac4e0ff9a68dad860e1c2649997d54eb04348e26d4770	["*"]	2025-10-23 17:48:27	\N	2025-10-23 17:48:14	2025-10-23 17:48:27
227	App\\Models\\User	1	api	5f2790e5497f2f21476dddb0de77fa7da147586bf2cd925562673082315e5fbd	["*"]	2025-10-24 15:34:53	\N	2025-10-24 14:33:09	2025-10-24 15:34:53
261	App\\Models\\User	7	api	4bd4b70f68167946e8e63b30a92b6cdce62dc567b0fcce0c0de54fe7c4acb6de	["*"]	2025-10-28 10:18:02	\N	2025-10-28 10:18:01	2025-10-28 10:18:02
224	App\\Models\\User	6	api	4c6cd37b0480de79e41edb9e8219c5f7052d47ac3a98b6f43c412ee6838597b5	["*"]	2025-10-23 20:31:36	\N	2025-10-23 18:22:51	2025-10-23 20:31:36
262	App\\Models\\User	7	api	37960ad12a66b38f6143339a860e0a8fed15b99776d080ae14cf86e06db3f061	["*"]	2025-10-28 10:21:56	\N	2025-10-28 10:21:55	2025-10-28 10:21:56
223	App\\Models\\User	6	api	12f2ba45fa97d50dc252cb762416d96b5ea99ef5ff06025523d6672eade50cb4	["*"]	2025-10-23 17:53:14	\N	2025-10-23 17:53:01	2025-10-23 17:53:14
263	App\\Models\\User	7	api	094ff34068c74728593335ac791e1abff0619c919858bea33b8f1bf19bd069cd	["*"]	2025-10-28 10:24:17	\N	2025-10-28 10:24:16	2025-10-28 10:24:17
241	App\\Models\\User	5	api	7a5aac6be5350fc786bd59053d48efd07508c3358a58c4556a90de8dcb1830fe	["*"]	2025-10-25 03:52:59	\N	2025-10-25 03:35:38	2025-10-25 03:52:59
265	App\\Models\\User	7	api	fbd2fc4a072dd9e5fe689cc1c1c2dccf189dc798c367edb51bd52e9e0dc414bc	["*"]	2025-10-28 10:29:53	\N	2025-10-28 10:28:29	2025-10-28 10:29:53
289	App\\Models\\User	1	api	50ce6ed26e47a8b8bccc907f8eade6efb128fab081d79457e6f845597db48087	["*"]	2025-10-29 14:24:14	\N	2025-10-29 14:06:47	2025-10-29 14:24:14
\.


--
-- Data for Name: product_media; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."product_media" ("id", "product_id", "disk", "path", "mime", "size_kb", "is_primary", "sort_order", "created_at", "updated_at") FROM stdin;
1	1	public	products/1/zbhYDolv9C6VgnteEu9CxOkjYpEBQ1gfs8Cexo5S.png	image/png	382	t	0	2025-10-13 22:10:38	2025-10-13 22:10:38
3	2	public	products/2/IrFEx6MLPesfqSwiY6FzclS9lUPpe2XKPkiHhITe.png	image/png	382	t	0	2025-10-25 03:20:36	2025-10-25 03:20:36
4	2	public	products/2/pDuzbSnPR1GzJReBSg31mxJD3pX8qxgaEn37bNtE.png	image/png	112	f	0	2025-10-26 19:50:54	2025-10-26 19:50:54
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."product_variants" ("id", "product_id", "size", "type", "tester", "sku", "harga", "is_active", "created_at", "updated_at") FROM stdin;
1	1	Small	750gr	\N	CF-1	200000.00	t	2025-10-13 16:56:56	2025-10-13 16:56:56
2	2	Large	\N	\N	CK2	300000.00	t	2025-10-14 10:32:37	2025-10-14 10:32:37
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."products" ("id", "category_id", "nama", "slug", "deskripsi", "is_active", "created_at", "updated_at") FROM stdin;
1	3	Cholate Flavor	cholate-flavor	\N	t	2025-10-13 16:55:55	2025-10-13 16:55:55
2	1	Kue ulang tahun	kue-ulang-tahun	\N	t	2025-10-14 10:32:03	2025-10-14 10:32:03
\.


--
-- Data for Name: receipts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."receipts" ("id", "order_id", "print_format", "html_snapshot", "wa_url", "printed_by", "printed_at", "reprint_of_id", "created_at", "updated_at") FROM stdin;
1	71	58	<!doctype html><html><head><meta charset="utf-8"><style>\n*{box-sizing:border-box}\nbody{font-family:ui-monospace,Menlo,Consolas,monospace;font-size:12px;margin:0;padding:0;color:#111}\n.wrap{width:58mm;max-width:58mm;margin:0 auto;padding:6px}\nh1,h2,h3,p{margin:0;padding:0}\n.center{text-align:center}\n.right{text-align:right}\n.muted{color:#555}\n.row{display:flex;justify-content:space-between;gap:8px}\n.hr{border-top:1px dashed #333;margin:6px 0}\ntable{width:100%;border-collapse:collapse}\ntd{vertical-align:top;padding:2px 0}\n.small{font-size:11px}\n.tot td{padding-top:4px}\n.tot .lbl{width:60%}\n.tot .val{width:40%;text-align:right}\n</style></head>\n<body onload="setTimeout(()=>{window.print&&window.print()},10)">\n  <div class="wrap">\n    <div class="center">\n      <h2>POS PRIME</h2>\n      <div class="small muted">Cabang Pusat • Gudang Utama</div>\n      <div class="small">No: <b>PRM-1761720045-C1</b> • 2025-10-29 13:40</div>\n      <div class="small">Kasir: Sales 1</div>\n      <div class="hr"></div>\n    </div>\n\n    <table><tr><td colspan='2'>Cholate Flavor - </td></tr><tr><td class='small'>1 x 200000.00</td><td class='right'>200000.00</td></tr></table>\n    <div class="hr"></div>\n\n    <table class="tot"><tr><td class="lbl">Subtotal</td><td class="val">200000.00</td></tr><tr><td class="lbl">Discount</td><td class="val">0.00</td></tr><tr><td class="lbl">Service</td><td class="val">0.00</td></tr><tr><td class="lbl">Tax</td><td class="val">0.00</td></tr><tr><td class="lbl"><b>Grand Total</b></td><td class="val"><b>200000.00</b></td></tr><tr><td class="lbl">Paid</td><td class="val">200000.00</td></tr></table>\n    <div class="hr"></div>\n\n    <div class="center small">Status: <b>PAID</b></div>\n    <div class="center small muted">Terima kasih 🙏</div>\n  </div>\n</body></html>	\N	7	2025-10-29 13:40:45+07	\N	2025-10-29 13:40:45	2025-10-29 13:40:45
2	71	58	<!doctype html><html><head><meta charset="utf-8"><style>\n*{box-sizing:border-box}\nbody{font-family:ui-monospace,Menlo,Consolas,monospace;font-size:12px;margin:0;padding:0;color:#111}\n.wrap{width:58mm;max-width:58mm;margin:0 auto;padding:6px}\nh1,h2,h3,p{margin:0;padding:0}\n.center{text-align:center}\n.right{text-align:right}\n.muted{color:#555}\n.row{display:flex;justify-content:space-between;gap:8px}\n.hr{border-top:1px dashed #333;margin:6px 0}\ntable{width:100%;border-collapse:collapse}\ntd{vertical-align:top;padding:2px 0}\n.small{font-size:11px}\n.tot td{padding-top:4px}\n.tot .lbl{width:60%}\n.tot .val{width:40%;text-align:right}\n</style></head>\n<body onload="setTimeout(()=>{window.print&&window.print()},10)">\n  <div class="wrap">\n    <div class="center">\n      <h2>POS PRIME</h2>\n      <div class="small muted">Cabang Pusat • Gudang Utama</div>\n      <div class="small">No: <b>PRM-1761720045-C1</b> • 2025-10-29 13:40</div>\n      <div class="small">Kasir: Sales 1</div>\n      <div class="hr"></div>\n    </div>\n\n    <table><tr><td colspan='2'>Cholate Flavor - </td></tr><tr><td class='small'>1 x 200000.00</td><td class='right'>200000.00</td></tr></table>\n    <div class="hr"></div>\n\n    <table class="tot"><tr><td class="lbl">Subtotal</td><td class="val">200000.00</td></tr><tr><td class="lbl">Discount</td><td class="val">0.00</td></tr><tr><td class="lbl">Service</td><td class="val">0.00</td></tr><tr><td class="lbl">Tax</td><td class="val">0.00</td></tr><tr><td class="lbl"><b>Grand Total</b></td><td class="val"><b>200000.00</b></td></tr><tr><td class="lbl">Paid</td><td class="val">200000.00</td></tr></table>\n    <div class="hr"></div>\n\n    <div class="center small">Status: <b>PAID</b></div>\n    <div class="center small muted">Terima kasih 🙏</div>\n  </div>\n</body></html>	\N	7	2025-10-29 13:40:45+07	\N	2025-10-29 13:40:45	2025-10-29 13:40:45
\.


--
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."role_has_permissions" ("permission_id", "role_id") FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."roles" ("id", "name", "guard_name", "created_at", "updated_at") FROM stdin;
1	superadmin	web	2025-10-16 16:02:16	2025-10-16 16:02:16
2	admin_cabang	web	2025-10-16 16:02:16	2025-10-16 16:02:16
3	kasir	web	2025-10-16 16:02:16	2025-10-16 16:02:16
4	kurir	web	2025-10-16 16:02:16	2025-10-16 16:02:16
5	gudang	web	2025-10-28 11:44:47	2025-10-28 11:44:47
6	sales	web	2025-10-28 11:44:47	2025-10-28 11:44:47
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."settings" ("id", "scope", "scope_id", "key", "value_json", "created_at", "updated_at") FROM stdin;
3	BRANCH	2	tax.vat	{"rate":0.11,"rounding":"HALF_UP"}	2025-10-23 17:02:35	2025-10-23 17:02:35
4	GLOBAL	\N	receipt.footer	{"line1":"Terima kasih"}	2025-10-23 17:03:02	2025-10-23 17:03:02
5	BRANCH	2	pos.printer	{"width":"58"}	2025-10-23 17:03:03	2025-10-23 17:03:03
2	GLOBAL	\N	pos.numbering	{"prefix":"SALE-","pad":6,"reset":"daily"}	2025-10-23 16:53:44	2025-10-23 17:04:12
6	USER	1	ui.preferences	{"darkMode":false}	2025-10-23 17:46:17	2025-10-23 17:46:21
7	BRANCH	\N	numbering.invoice	{"prefix":"INV-","pad":6,"reset":"daily"}	2025-10-23 20:47:38	2025-10-23 20:47:38
8	GLOBAL	\N	acc.cash_id	{"id":8}	2025-10-25 01:49:14	2025-10-25 01:49:14
9	GLOBAL	\N	acc.bank_id	{"id":9}	2025-10-25 01:49:14	2025-10-25 01:49:14
10	GLOBAL	\N	acc.sales_id	{"id":18}	2025-10-25 01:49:14	2025-10-25 01:49:14
11	GLOBAL	\N	acc.fee_expense_id	{"id":22}	2025-10-25 01:49:14	2025-10-25 01:49:14
12	GLOBAL	\N	acc.fee_payable_id	{"id":13}	2025-10-25 01:49:14	2025-10-25 01:49:14
13	USER	6	ui.preferences	{"darkMode":true}	2025-10-27 15:55:32	2025-10-27 15:55:32
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."users" ("id", "name", "email", "phone", "password", "cabang_id", "role", "is_active", "remember_token", "created_at", "updated_at", "email_verified_at") FROM stdin;
2	Ms. Taryn Kessler MD	gkoch@example.net	\N	$2y$12$Rbgp58A2N.s5/tWVxgR4T.90xJiNDvwID8HTmkjaEOjz4aTx7MNxG	\N	gudang	t	RpMlwTN9ga	2025-10-13 13:43:53	2025-10-13 13:43:53	\N
3	Kaylin Daniel	jeanette86@example.org	+13326350021	$2y$12$hu7iUbLw3JLHu8HezOV4GO2jG4nDAU9ZZXodjATMoFp.tgCIEr6f.	\N	admin_cabang	t	ZuFJesSQzt	2025-10-13 13:43:53	2025-10-13 13:43:53	\N
4	Edgardo Casper	bianka13@example.com	\N	$2y$12$TL9SRpQE0DfcRuzDwOMMGeRUUazmBVSQ.zmtjy35gVxZiLamcmjzC	\N	kurir	t	irsXvNN7OS	2025-10-13 13:43:53	2025-10-13 13:43:53	\N
1	Superadmin	superadmin@gmail.com	081234567890	$2y$12$8FAQ4LWCENyf0uaLIGbul.M2YestjcFqFpoPyAkOpda7SFYoDFzGK	\N	superadmin	t	\N	2025-10-13 13:43:52	2025-10-16 16:02:17	\N
6	Admin 1	admin1@gmail.com	081111111111	$2y$12$VdTDoDmx8JDYkbmmxvD9e.j31dcsofosytJfZB15ItiAu5b1ExZe6	1	admin_cabang	t	\N	2025-10-14 10:31:20	2025-10-16 16:02:17	\N
5	Kasir 1	kasir1@gmail.com	082222222222	$2y$12$I.m2/eo.QDoB58OE0hII1eGWEC6oOO80bmHPl6p2193YxvhCu5nlG	1	kasir	t	\N	2025-10-13 23:04:19	2025-10-16 16:02:18	\N
8	Kurir 1	kurir1@gmail.com	083333333334	$2y$12$n.SLhe5RNo3Ta44PuHpNzuUJtf.oYEyeKz.Q6zlllzP1FoPDrkylW	1	kurir	t	\N	2025-10-16 16:02:18	2025-10-23 18:34:14	\N
9	gudang	gudang@gmail.com	081214695222	$2y$12$ss7Z3MJZaQI3.W9KyiDjT..n/RAW25A3w11z/z7abqAti3q3GV.3K	1	gudang	t	\N	2025-10-28 10:35:23	2025-10-28 10:35:23	\N
7	Sales 1	sales1@gmail.com	081214695222	$2y$12$zJtTV0F8afdy6JqIiVuoTOJMBDTMUuuqjAcOBkKEd1MCqE7MPVKSm	1	sales	t	\N	2025-10-15 10:18:57	2025-10-28 13:43:54	\N
\.


--
-- Data for Name: variant_stocks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."variant_stocks" ("id", "cabang_id", "gudang_id", "product_variant_id", "qty", "min_stok", "created_at", "updated_at") FROM stdin;
2	1	1	2	21	10	2025-10-14 10:44:20	2025-10-29 13:13:27
1	1	1	1	13	10	2025-10-13 22:12:49	2025-10-29 13:40:45
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."accounts_id_seq"', 25, true);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."audit_logs_id_seq"', 1303, true);


--
-- Name: backups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."backups_id_seq"', 1, false);


--
-- Name: cabangs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."cabangs_id_seq"', 3, true);


--
-- Name: cash_holders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."cash_holders_id_seq"', 3, true);


--
-- Name: cash_moves_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."cash_moves_id_seq"', 9, true);


--
-- Name: cash_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."cash_sessions_id_seq"', 1, false);


--
-- Name: cash_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."cash_transactions_id_seq"', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."categories_id_seq"', 6, true);


--
-- Name: customer_timelines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."customer_timelines_id_seq"', 4, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."customers_id_seq"', 4, true);


--
-- Name: deliveries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."deliveries_id_seq"', 6, true);


--
-- Name: delivery_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."delivery_events_id_seq"', 22, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."failed_jobs_id_seq"', 1, false);


--
-- Name: fee_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."fee_entries_id_seq"', 41, true);


--
-- Name: fees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."fees_id_seq"', 2, true);


--
-- Name: fiscal_periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."fiscal_periods_id_seq"', 1, false);


--
-- Name: gudangs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."gudangs_id_seq"', 3, true);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."jobs_id_seq"', 1, false);


--
-- Name: journal_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."journal_entries_id_seq"', 17, true);


--
-- Name: journal_lines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."journal_lines_id_seq"', 34, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."migrations_id_seq"', 43, true);


--
-- Name: order_change_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."order_change_logs_id_seq"', 5, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."order_items_id_seq"', 77, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."orders_id_seq"', 71, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."payments_id_seq"', 71, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."permissions_id_seq"', 1, false);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."personal_access_tokens_id_seq"', 289, true);


--
-- Name: product_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."product_media_id_seq"', 4, true);


--
-- Name: product_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."product_variants_id_seq"', 2, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."products_id_seq"', 2, true);


--
-- Name: receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."receipts_id_seq"', 2, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."roles_id_seq"', 6, true);


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."settings_id_seq"', 13, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."users_id_seq"', 9, true);


--
-- Name: variant_stocks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."variant_stocks_id_seq"', 2, true);


--
-- Name: accounts accounts_code_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_code_unique" UNIQUE ("code");


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_pkey" PRIMARY KEY ("id");


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."audit_logs"
    ADD CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id");


--
-- Name: backups backups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."backups"
    ADD CONSTRAINT "backups_pkey" PRIMARY KEY ("id");


--
-- Name: cabangs cabangs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cabangs"
    ADD CONSTRAINT "cabangs_pkey" PRIMARY KEY ("id");


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cache_locks"
    ADD CONSTRAINT "cache_locks_pkey" PRIMARY KEY ("key");


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cache"
    ADD CONSTRAINT "cache_pkey" PRIMARY KEY ("key");


--
-- Name: cash_holders cash_holders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_holders"
    ADD CONSTRAINT "cash_holders_pkey" PRIMARY KEY ("id");


--
-- Name: cash_moves cash_moves_idempotency_key_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_moves"
    ADD CONSTRAINT "cash_moves_idempotency_key_unique" UNIQUE ("idempotency_key");


--
-- Name: cash_moves cash_moves_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_moves"
    ADD CONSTRAINT "cash_moves_pkey" PRIMARY KEY ("id");


--
-- Name: cash_sessions cash_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_sessions"
    ADD CONSTRAINT "cash_sessions_pkey" PRIMARY KEY ("id");


--
-- Name: cash_transactions cash_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_transactions"
    ADD CONSTRAINT "cash_transactions_pkey" PRIMARY KEY ("id");


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."categories"
    ADD CONSTRAINT "categories_pkey" PRIMARY KEY ("id");


--
-- Name: categories categories_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."categories"
    ADD CONSTRAINT "categories_slug_unique" UNIQUE ("slug");


--
-- Name: customer_timelines customer_timelines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."customer_timelines"
    ADD CONSTRAINT "customer_timelines_pkey" PRIMARY KEY ("id");


--
-- Name: customers customers_cabang_id_phone_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."customers"
    ADD CONSTRAINT "customers_cabang_id_phone_unique" UNIQUE ("cabang_id", "phone");


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."customers"
    ADD CONSTRAINT "customers_pkey" PRIMARY KEY ("id");


--
-- Name: deliveries deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."deliveries"
    ADD CONSTRAINT "deliveries_pkey" PRIMARY KEY ("id");


--
-- Name: delivery_events delivery_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."delivery_events"
    ADD CONSTRAINT "delivery_events_pkey" PRIMARY KEY ("id");


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."failed_jobs"
    ADD CONSTRAINT "failed_jobs_pkey" PRIMARY KEY ("id");


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."failed_jobs"
    ADD CONSTRAINT "failed_jobs_uuid_unique" UNIQUE ("uuid");


--
-- Name: fee_entries fee_entries_fee_id_ref_type_ref_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."fee_entries"
    ADD CONSTRAINT "fee_entries_fee_id_ref_type_ref_id_unique" UNIQUE ("fee_id", "ref_type", "ref_id");


--
-- Name: fee_entries fee_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."fee_entries"
    ADD CONSTRAINT "fee_entries_pkey" PRIMARY KEY ("id");


--
-- Name: fees fees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."fees"
    ADD CONSTRAINT "fees_pkey" PRIMARY KEY ("id");


--
-- Name: fiscal_periods fiscal_periods_cabang_id_year_month_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."fiscal_periods"
    ADD CONSTRAINT "fiscal_periods_cabang_id_year_month_unique" UNIQUE ("cabang_id", "year", "month");


--
-- Name: fiscal_periods fiscal_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."fiscal_periods"
    ADD CONSTRAINT "fiscal_periods_pkey" PRIMARY KEY ("id");


--
-- Name: gudangs gudangs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."gudangs"
    ADD CONSTRAINT "gudangs_pkey" PRIMARY KEY ("id");


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."job_batches"
    ADD CONSTRAINT "job_batches_pkey" PRIMARY KEY ("id");


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."jobs"
    ADD CONSTRAINT "jobs_pkey" PRIMARY KEY ("id");


--
-- Name: journal_entries journal_entries_cabang_id_number_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."journal_entries"
    ADD CONSTRAINT "journal_entries_cabang_id_number_unique" UNIQUE ("cabang_id", "number");


--
-- Name: journal_entries journal_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."journal_entries"
    ADD CONSTRAINT "journal_entries_pkey" PRIMARY KEY ("id");


--
-- Name: journal_lines journal_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."journal_lines"
    ADD CONSTRAINT "journal_lines_pkey" PRIMARY KEY ("id");


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."migrations"
    ADD CONSTRAINT "migrations_pkey" PRIMARY KEY ("id");


--
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."model_has_permissions"
    ADD CONSTRAINT "model_has_permissions_pkey" PRIMARY KEY ("permission_id", "model_id", "model_type");


--
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."model_has_roles"
    ADD CONSTRAINT "model_has_roles_pkey" PRIMARY KEY ("role_id", "model_id", "model_type");


--
-- Name: order_change_logs order_change_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."order_change_logs"
    ADD CONSTRAINT "order_change_logs_pkey" PRIMARY KEY ("id");


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_pkey" PRIMARY KEY ("id");


--
-- Name: orders orders_kode_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_kode_unique" UNIQUE ("kode");


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_pkey" PRIMARY KEY ("id");


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."payments"
    ADD CONSTRAINT "payments_pkey" PRIMARY KEY ("id");


--
-- Name: permissions permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."permissions"
    ADD CONSTRAINT "permissions_name_guard_name_unique" UNIQUE ("name", "guard_name");


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."permissions"
    ADD CONSTRAINT "permissions_pkey" PRIMARY KEY ("id");


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."personal_access_tokens"
    ADD CONSTRAINT "personal_access_tokens_pkey" PRIMARY KEY ("id");


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."personal_access_tokens"
    ADD CONSTRAINT "personal_access_tokens_token_unique" UNIQUE ("token");


--
-- Name: product_media product_media_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."product_media"
    ADD CONSTRAINT "product_media_pkey" PRIMARY KEY ("id");


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."product_variants"
    ADD CONSTRAINT "product_variants_pkey" PRIMARY KEY ("id");


--
-- Name: product_variants product_variants_product_id_size_type_tester_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."product_variants"
    ADD CONSTRAINT "product_variants_product_id_size_type_tester_unique" UNIQUE ("product_id", "size", "type", "tester");


--
-- Name: product_variants product_variants_sku_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."product_variants"
    ADD CONSTRAINT "product_variants_sku_unique" UNIQUE ("sku");


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_pkey" PRIMARY KEY ("id");


--
-- Name: products products_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_slug_unique" UNIQUE ("slug");


--
-- Name: receipts receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."receipts"
    ADD CONSTRAINT "receipts_pkey" PRIMARY KEY ("id");


--
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."role_has_permissions"
    ADD CONSTRAINT "role_has_permissions_pkey" PRIMARY KEY ("permission_id", "role_id");


--
-- Name: roles roles_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."roles"
    ADD CONSTRAINT "roles_name_guard_name_unique" UNIQUE ("name", "guard_name");


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."roles"
    ADD CONSTRAINT "roles_pkey" PRIMARY KEY ("id");


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."settings"
    ADD CONSTRAINT "settings_pkey" PRIMARY KEY ("id");


--
-- Name: settings settings_scope_key_uk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."settings"
    ADD CONSTRAINT "settings_scope_key_uk" UNIQUE ("scope", "scope_id", "key");


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_email_unique" UNIQUE ("email");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");


--
-- Name: variant_stocks variant_stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."variant_stocks"
    ADD CONSTRAINT "variant_stocks_pkey" PRIMARY KEY ("id");


--
-- Name: variant_stocks variant_stocks_unique_gudang_variant; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."variant_stocks"
    ADD CONSTRAINT "variant_stocks_unique_gudang_variant" UNIQUE ("gudang_id", "product_variant_id");


--
-- Name: accounts_cabang_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "accounts_cabang_id_index" ON "public"."accounts" USING "btree" ("cabang_id");


--
-- Name: accounts_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "accounts_is_active_index" ON "public"."accounts" USING "btree" ("is_active");


--
-- Name: accounts_parent_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "accounts_parent_id_index" ON "public"."accounts" USING "btree" ("parent_id");


--
-- Name: accounts_type_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "accounts_type_index" ON "public"."accounts" USING "btree" ("type");


--
-- Name: audit_logs_action_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "audit_logs_action_index" ON "public"."audit_logs" USING "btree" ("action");


--
-- Name: audit_logs_actor_type_actor_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "audit_logs_actor_type_actor_id_index" ON "public"."audit_logs" USING "btree" ("actor_type", "actor_id");


--
-- Name: audit_logs_model_model_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "audit_logs_model_model_id_index" ON "public"."audit_logs" USING "btree" ("model", "model_id");


--
-- Name: audit_logs_occurred_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "audit_logs_occurred_at_index" ON "public"."audit_logs" USING "btree" ("occurred_at");


--
-- Name: cabangs_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "cabangs_is_active_index" ON "public"."cabangs" USING "btree" ("is_active");


--
-- Name: cabangs_kota_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "cabangs_kota_is_active_index" ON "public"."cabangs" USING "btree" ("kota", "is_active");


--
-- Name: cash_holders_cabang_id_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "cash_holders_cabang_id_name_index" ON "public"."cash_holders" USING "btree" ("cabang_id", "name");


--
-- Name: cash_moves_moved_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "cash_moves_moved_at_index" ON "public"."cash_moves" USING "btree" ("moved_at");


--
-- Name: cash_sessions_cabang_id_cashier_id_opened_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "cash_sessions_cabang_id_cashier_id_opened_at_index" ON "public"."cash_sessions" USING "btree" ("cabang_id", "cashier_id", "opened_at");


--
-- Name: cash_sessions_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "cash_sessions_status_index" ON "public"."cash_sessions" USING "btree" ("status");


--
-- Name: cash_transactions_ref_type_ref_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "cash_transactions_ref_type_ref_id_index" ON "public"."cash_transactions" USING "btree" ("ref_type", "ref_id");


--
-- Name: cash_transactions_session_id_occurred_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "cash_transactions_session_id_occurred_at_index" ON "public"."cash_transactions" USING "btree" ("session_id", "occurred_at");


--
-- Name: categories_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "categories_is_active_index" ON "public"."categories" USING "btree" ("is_active");


--
-- Name: customer_timelines_customer_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "customer_timelines_customer_id_index" ON "public"."customer_timelines" USING "btree" ("customer_id");


--
-- Name: customers_cabang_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "customers_cabang_id_index" ON "public"."customers" USING "btree" ("cabang_id");


--
-- Name: customers_cabang_id_phone_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "customers_cabang_id_phone_index" ON "public"."customers" USING "btree" ("cabang_id", "phone");


--
-- Name: deliveries_assigned_to_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "deliveries_assigned_to_status_index" ON "public"."deliveries" USING "btree" ("assigned_to", "status");


--
-- Name: deliveries_requested_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "deliveries_requested_at_index" ON "public"."deliveries" USING "btree" ("requested_at");


--
-- Name: deliveries_sj_number_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "deliveries_sj_number_index" ON "public"."deliveries" USING "btree" ("sj_number");


--
-- Name: delivery_events_delivery_id_occurred_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "delivery_events_delivery_id_occurred_at_index" ON "public"."delivery_events" USING "btree" ("delivery_id", "occurred_at");


--
-- Name: fee_entries_cabang_id_period_date_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fee_entries_cabang_id_period_date_index" ON "public"."fee_entries" USING "btree" ("cabang_id", "period_date");


--
-- Name: fee_entries_owner_user_id_pay_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fee_entries_owner_user_id_pay_status_index" ON "public"."fee_entries" USING "btree" ("owner_user_id", "pay_status");


--
-- Name: fees_cabang_id_kind_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fees_cabang_id_kind_is_active_index" ON "public"."fees" USING "btree" ("cabang_id", "kind", "is_active");


--
-- Name: fiscal_periods_cabang_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fiscal_periods_cabang_id_index" ON "public"."fiscal_periods" USING "btree" ("cabang_id");


--
-- Name: fiscal_periods_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "fiscal_periods_status_index" ON "public"."fiscal_periods" USING "btree" ("status");


--
-- Name: gudangs_cabang_id_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "gudangs_cabang_id_is_active_index" ON "public"."gudangs" USING "btree" ("cabang_id", "is_active");


--
-- Name: gudangs_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "gudangs_is_active_index" ON "public"."gudangs" USING "btree" ("is_active");


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "jobs_queue_index" ON "public"."jobs" USING "btree" ("queue");


--
-- Name: journal_entries_cabang_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "journal_entries_cabang_id_index" ON "public"."journal_entries" USING "btree" ("cabang_id");


--
-- Name: journal_entries_journal_date_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "journal_entries_journal_date_index" ON "public"."journal_entries" USING "btree" ("journal_date");


--
-- Name: journal_entries_number_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "journal_entries_number_index" ON "public"."journal_entries" USING "btree" ("number");


--
-- Name: journal_entries_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "journal_entries_status_index" ON "public"."journal_entries" USING "btree" ("status");


--
-- Name: journal_lines_account_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "journal_lines_account_id_index" ON "public"."journal_lines" USING "btree" ("account_id");


--
-- Name: journal_lines_cabang_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "journal_lines_cabang_id_index" ON "public"."journal_lines" USING "btree" ("cabang_id");


--
-- Name: journal_lines_journal_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "journal_lines_journal_id_index" ON "public"."journal_lines" USING "btree" ("journal_id");


--
-- Name: journal_lines_ref_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "journal_lines_ref_id_index" ON "public"."journal_lines" USING "btree" ("ref_id");


--
-- Name: journal_lines_ref_type_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "journal_lines_ref_type_index" ON "public"."journal_lines" USING "btree" ("ref_type");


--
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "model_has_permissions_model_id_model_type_index" ON "public"."model_has_permissions" USING "btree" ("model_id", "model_type");


--
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "model_has_roles_model_id_model_type_index" ON "public"."model_has_roles" USING "btree" ("model_id", "model_type");


--
-- Name: order_change_logs_action_occurred_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "order_change_logs_action_occurred_at_index" ON "public"."order_change_logs" USING "btree" ("action", "occurred_at");


--
-- Name: order_change_logs_order_id_occurred_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "order_change_logs_order_id_occurred_at_index" ON "public"."order_change_logs" USING "btree" ("order_id", "occurred_at");


--
-- Name: order_items_order_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "order_items_order_id_index" ON "public"."order_items" USING "btree" ("order_id");


--
-- Name: order_items_variant_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "order_items_variant_id_index" ON "public"."order_items" USING "btree" ("variant_id");


--
-- Name: orders_cabang_id_ordered_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "orders_cabang_id_ordered_at_index" ON "public"."orders" USING "btree" ("cabang_id", "ordered_at");


--
-- Name: orders_cash_position_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "orders_cash_position_index" ON "public"."orders" USING "btree" ("cash_position");


--
-- Name: orders_cashier_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "orders_cashier_id_index" ON "public"."orders" USING "btree" ("cashier_id");


--
-- Name: orders_gudang_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "orders_gudang_id_index" ON "public"."orders" USING "btree" ("gudang_id");


--
-- Name: orders_paid_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "orders_paid_at_index" ON "public"."orders" USING "btree" ("paid_at");


--
-- Name: orders_status_channel_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "orders_status_channel_index" ON "public"."orders" USING "btree" ("status", "channel");


--
-- Name: payments_order_id_method_status_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "payments_order_id_method_status_index" ON "public"."payments" USING "btree" ("order_id", "method", "status");


--
-- Name: payments_paid_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "payments_paid_at_index" ON "public"."payments" USING "btree" ("paid_at");


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "personal_access_tokens_expires_at_index" ON "public"."personal_access_tokens" USING "btree" ("expires_at");


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "personal_access_tokens_tokenable_type_tokenable_id_index" ON "public"."personal_access_tokens" USING "btree" ("tokenable_type", "tokenable_id");


--
-- Name: product_media_primary_sort_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "product_media_primary_sort_idx" ON "public"."product_media" USING "btree" ("product_id", "is_primary", "sort_order");


--
-- Name: product_media_product_id_is_primary_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "product_media_product_id_is_primary_index" ON "public"."product_media" USING "btree" ("product_id", "is_primary");


--
-- Name: product_variants_product_id_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "product_variants_product_id_is_active_index" ON "public"."product_variants" USING "btree" ("product_id", "is_active");


--
-- Name: products_category_id_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "products_category_id_is_active_index" ON "public"."products" USING "btree" ("category_id", "is_active");


--
-- Name: receipts_order_id_printed_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "receipts_order_id_printed_at_index" ON "public"."receipts" USING "btree" ("order_id", "printed_at");


--
-- Name: settings_scope_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "settings_scope_idx" ON "public"."settings" USING "btree" ("scope", "scope_id");


--
-- Name: users_cabang_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "users_cabang_id_index" ON "public"."users" USING "btree" ("cabang_id");


--
-- Name: users_is_active_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "users_is_active_index" ON "public"."users" USING "btree" ("is_active");


--
-- Name: users_phone_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "users_phone_index" ON "public"."users" USING "btree" ("phone");


--
-- Name: users_role_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "users_role_index" ON "public"."users" USING "btree" ("role");


--
-- Name: variant_stocks_cabang_id_gudang_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "variant_stocks_cabang_id_gudang_id_index" ON "public"."variant_stocks" USING "btree" ("cabang_id", "gudang_id");


--
-- Name: variant_stocks_product_variant_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "variant_stocks_product_variant_id_index" ON "public"."variant_stocks" USING "btree" ("product_variant_id");


--
-- Name: accounts accounts_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id") ON DELETE SET NULL;


--
-- Name: accounts accounts_parent_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."accounts"
    ADD CONSTRAINT "accounts_parent_id_foreign" FOREIGN KEY ("parent_id") REFERENCES "public"."accounts"("id") ON DELETE RESTRICT;


--
-- Name: cash_holders cash_holders_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_holders"
    ADD CONSTRAINT "cash_holders_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id");


--
-- Name: cash_moves cash_moves_approved_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_moves"
    ADD CONSTRAINT "cash_moves_approved_by_foreign" FOREIGN KEY ("approved_by") REFERENCES "public"."users"("id");


--
-- Name: cash_moves cash_moves_from_holder_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_moves"
    ADD CONSTRAINT "cash_moves_from_holder_id_foreign" FOREIGN KEY ("from_holder_id") REFERENCES "public"."cash_holders"("id");


--
-- Name: cash_moves cash_moves_submitted_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_moves"
    ADD CONSTRAINT "cash_moves_submitted_by_foreign" FOREIGN KEY ("submitted_by") REFERENCES "public"."users"("id");


--
-- Name: cash_moves cash_moves_to_holder_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_moves"
    ADD CONSTRAINT "cash_moves_to_holder_id_foreign" FOREIGN KEY ("to_holder_id") REFERENCES "public"."cash_holders"("id");


--
-- Name: cash_sessions cash_sessions_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_sessions"
    ADD CONSTRAINT "cash_sessions_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id");


--
-- Name: cash_sessions cash_sessions_cashier_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_sessions"
    ADD CONSTRAINT "cash_sessions_cashier_id_foreign" FOREIGN KEY ("cashier_id") REFERENCES "public"."users"("id");


--
-- Name: cash_transactions cash_transactions_session_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."cash_transactions"
    ADD CONSTRAINT "cash_transactions_session_id_foreign" FOREIGN KEY ("session_id") REFERENCES "public"."cash_sessions"("id") ON DELETE CASCADE;


--
-- Name: deliveries deliveries_assigned_to_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."deliveries"
    ADD CONSTRAINT "deliveries_assigned_to_foreign" FOREIGN KEY ("assigned_to") REFERENCES "public"."users"("id") ON DELETE SET NULL;


--
-- Name: deliveries deliveries_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."deliveries"
    ADD CONSTRAINT "deliveries_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE RESTRICT;


--
-- Name: delivery_events delivery_events_delivery_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."delivery_events"
    ADD CONSTRAINT "delivery_events_delivery_id_foreign" FOREIGN KEY ("delivery_id") REFERENCES "public"."deliveries"("id") ON DELETE CASCADE;


--
-- Name: fiscal_periods fiscal_periods_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."fiscal_periods"
    ADD CONSTRAINT "fiscal_periods_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id") ON DELETE CASCADE;


--
-- Name: gudangs gudangs_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."gudangs"
    ADD CONSTRAINT "gudangs_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id") ON DELETE CASCADE;


--
-- Name: journal_entries journal_entries_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."journal_entries"
    ADD CONSTRAINT "journal_entries_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id") ON DELETE CASCADE;


--
-- Name: journal_lines journal_lines_account_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."journal_lines"
    ADD CONSTRAINT "journal_lines_account_id_foreign" FOREIGN KEY ("account_id") REFERENCES "public"."accounts"("id") ON DELETE RESTRICT;


--
-- Name: journal_lines journal_lines_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."journal_lines"
    ADD CONSTRAINT "journal_lines_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id") ON DELETE CASCADE;


--
-- Name: journal_lines journal_lines_journal_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."journal_lines"
    ADD CONSTRAINT "journal_lines_journal_id_foreign" FOREIGN KEY ("journal_id") REFERENCES "public"."journal_entries"("id") ON DELETE CASCADE;


--
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."model_has_permissions"
    ADD CONSTRAINT "model_has_permissions_permission_id_foreign" FOREIGN KEY ("permission_id") REFERENCES "public"."permissions"("id") ON DELETE CASCADE;


--
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."model_has_roles"
    ADD CONSTRAINT "model_has_roles_role_id_foreign" FOREIGN KEY ("role_id") REFERENCES "public"."roles"("id") ON DELETE CASCADE;


--
-- Name: order_change_logs order_change_logs_actor_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."order_change_logs"
    ADD CONSTRAINT "order_change_logs_actor_id_foreign" FOREIGN KEY ("actor_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;


--
-- Name: order_change_logs order_change_logs_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."order_change_logs"
    ADD CONSTRAINT "order_change_logs_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE;


--
-- Name: order_items order_items_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."order_items"
    ADD CONSTRAINT "order_items_variant_id_foreign" FOREIGN KEY ("variant_id") REFERENCES "public"."product_variants"("id") ON DELETE RESTRICT;


--
-- Name: orders orders_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id") ON DELETE RESTRICT;


--
-- Name: orders orders_cashier_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_cashier_id_foreign" FOREIGN KEY ("cashier_id") REFERENCES "public"."users"("id") ON DELETE RESTRICT;


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: orders orders_gudang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."orders"
    ADD CONSTRAINT "orders_gudang_id_foreign" FOREIGN KEY ("gudang_id") REFERENCES "public"."gudangs"("id") ON DELETE RESTRICT;


--
-- Name: payments payments_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."payments"
    ADD CONSTRAINT "payments_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON DELETE CASCADE;


--
-- Name: product_media product_media_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."product_media"
    ADD CONSTRAINT "product_media_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE CASCADE;


--
-- Name: product_variants product_variants_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."product_variants"
    ADD CONSTRAINT "product_variants_product_id_foreign" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE CASCADE;


--
-- Name: products products_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."products"
    ADD CONSTRAINT "products_category_id_foreign" FOREIGN KEY ("category_id") REFERENCES "public"."categories"("id") ON DELETE RESTRICT;


--
-- Name: receipts receipts_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."receipts"
    ADD CONSTRAINT "receipts_order_id_foreign" FOREIGN KEY ("order_id") REFERENCES "public"."orders"("id") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: receipts receipts_printed_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."receipts"
    ADD CONSTRAINT "receipts_printed_by_foreign" FOREIGN KEY ("printed_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;


--
-- Name: receipts receipts_reprint_of_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."receipts"
    ADD CONSTRAINT "receipts_reprint_of_id_foreign" FOREIGN KEY ("reprint_of_id") REFERENCES "public"."receipts"("id") ON DELETE SET NULL;


--
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."role_has_permissions"
    ADD CONSTRAINT "role_has_permissions_permission_id_foreign" FOREIGN KEY ("permission_id") REFERENCES "public"."permissions"("id") ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."role_has_permissions"
    ADD CONSTRAINT "role_has_permissions_role_id_foreign" FOREIGN KEY ("role_id") REFERENCES "public"."roles"("id") ON DELETE CASCADE;


--
-- Name: users users_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id") ON DELETE SET NULL;


--
-- Name: variant_stocks variant_stocks_cabang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."variant_stocks"
    ADD CONSTRAINT "variant_stocks_cabang_id_foreign" FOREIGN KEY ("cabang_id") REFERENCES "public"."cabangs"("id") ON DELETE CASCADE;


--
-- Name: variant_stocks variant_stocks_gudang_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."variant_stocks"
    ADD CONSTRAINT "variant_stocks_gudang_id_foreign" FOREIGN KEY ("gudang_id") REFERENCES "public"."gudangs"("id") ON DELETE CASCADE;


--
-- Name: variant_stocks variant_stocks_product_variant_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."variant_stocks"
    ADD CONSTRAINT "variant_stocks_product_variant_id_foreign" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict iVlsNt0YhucFzSamq2yWXpH69R3mh2s07JA10I53DgmIEdjJe7rUVHZOula51Xq

