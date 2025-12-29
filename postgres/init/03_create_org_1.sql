CREATE SCHEMA IF NOT EXISTS org_alpha;

INSERT INTO wailsalutem.organizations (id, name, schema_name, contact_email)
VALUES (
    '00000000-0000-0000-0000-000000000001'::UUID,
    'Organisation Alpha',
    'org_alpha',
    'admin@org-alpha.com'
);