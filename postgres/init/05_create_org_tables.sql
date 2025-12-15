DO $$
DECLARE
    s RECORD;
BEGIN
    FOR s IN SELECT schema_name FROM wailsalutem.organizations LOOP

        EXECUTE format('
        CREATE TABLE IF NOT EXISTS %I.users (
            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
            keycloak_user_id UUID NOT NULL,
            full_name VARCHAR(255),
            email VARCHAR(255),
            phone_number VARCHAR(50),
            role VARCHAR(50),
            is_active BOOLEAN DEFAULT true,
            created_at TIMESTAMP DEFAULT now(),
            updated_at TIMESTAMP,
            deleted_at TIMESTAMP
        );', s.schema_name);

        EXECUTE format('
        CREATE TABLE IF NOT EXISTS %I.patients (
            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
            full_name VARCHAR(255),
            email VARCHAR(255),
            phone_number VARCHAR(50),
            date_of_birth DATE,
            address TEXT,
            emergency_contact_name VARCHAR(255),
            emergency_contact_phone VARCHAR(50),
            medical_notes TEXT,
            is_active BOOLEAN DEFAULT true,
            created_at TIMESTAMP DEFAULT now(),
            updated_at TIMESTAMP,
            deleted_at TIMESTAMP
        );', s.schema_name);

        EXECUTE format('
        CREATE TABLE IF NOT EXISTS %I.care_sessions (
            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
            patient_id UUID REFERENCES %I.patients(id),
            caregiver_id UUID,
            check_in_time TIMESTAMP,
            check_out_time TIMESTAMP,
            status VARCHAR(50),
            caregiver_notes TEXT,
            created_at TIMESTAMP DEFAULT now(),
            updated_at TIMESTAMP,
            deleted_at TIMESTAMP
        );', s.schema_name, s.schema_name);

        EXECUTE format('
        CREATE TABLE IF NOT EXISTS %I.nfc_tags (
            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
            tag_id VARCHAR(100) UNIQUE,
            patient_id UUID REFERENCES %I.patients(id),
            issued_at TIMESTAMP DEFAULT now(),
            status VARCHAR(50),
            deactivated_at TIMESTAMP,
            created_at TIMESTAMP DEFAULT now(),
            updated_at TIMESTAMP
        );', s.schema_name, s.schema_name);

        EXECUTE format('
        CREATE TABLE IF NOT EXISTS %I.feedback (
            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
            care_session_id UUID UNIQUE,
            patient_id UUID,
            rating INTEGER CHECK (rating BETWEEN 1 AND 5),
            created_at TIMESTAMP DEFAULT now()
        );', s.schema_name);

    END LOOP;
END $$;
