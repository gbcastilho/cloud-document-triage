GRANT ALL PRIVILEGES ON DATABASE n8n TO n8n;

ALTER USER n8n WITH SUPERUSER;

-- Required to create extensions
CREATE SCHEMA IF NOT EXISTS triage_app;

GRANT ALL PRIVILEGES ON SCHEMA triage_app TO n8n;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE triage_app.document_status AS ENUM (
  'PENDING',
  'PROCESSING',
  'COMPLETED',
  'NEEDS_REVIEW',
  'FAILED_FETCH',
  'FAILED_EXTRACTION',
  'FAILED_CLASSIFICATION',
  'FAILED_UNKNOWN'
);

CREATE TABLE triage_app.documents_log (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  file_id VARCHAR(255) NOT NULL,
  status triage_app.document_status DEFAULT 'PENDING' NOT NULL,
  ai_result JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TYPE triage_app.document_status OWNER TO n8n;

ALTER TABLE
  triage_app.documents_log OWNER TO n8n;