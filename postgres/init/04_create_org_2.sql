CREATE SCHEMA IF NOT EXISTS org_beta;

INSERT INTO wailsalutem.organizations (id, name, schema_name, contact_email)
VALUES (
    '00000000-0000-0000-0000-000000000002'::UUID,
    'Organisation Beta',
    'org_beta',
    'admin@org-beta.com'
);