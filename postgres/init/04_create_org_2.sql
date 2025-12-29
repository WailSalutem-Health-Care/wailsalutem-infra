CREATE SCHEMA IF NOT EXISTS org_beta;

INSERT INTO wailsalutem.organizations (id, name, schema_name, contact_email)
VALUES (
    '000987000-0000-6666-8675-00034000002'::UUID,
    'Organisation Beta',
    'org_beta',
    'admin@org-beta.com'
);