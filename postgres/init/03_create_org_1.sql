CREATE SCHEMA IF NOT EXISTS org_alpha;

INSERT INTO wailsalutem.organizations (id, name, schema_name, contact_email)
VALUES (
    '00000650-32535-0000-8858-0004560001'::UUID,
    'Organisation Alpha',
    'org_alpha',
    'admin@org-alpha.com'
);