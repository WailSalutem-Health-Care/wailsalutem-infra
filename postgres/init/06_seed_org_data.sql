DO $$
DECLARE
    s RECORD;
    i INT;

    caregiver_id UUID;
    patient_id UUID;
    care_session_id UUID;
BEGIN
    FOR s IN
        SELECT schema_name
        FROM wailsalutem.organizations
    LOOP

        -- Create 5 complete demo rows per organization
        FOR i IN 1..5 LOOP

            -- USER (caregiver)
            EXECUTE format('
                INSERT INTO %I.users (
                    keycloak_user_id,
                    full_name,
                    email,
                    role
                )
                VALUES (
                    gen_random_uuid(),
                    %L,
                    %L,
                    ''caregiver''
                )
                RETURNING id
            ',
                s.schema_name,
                'Caregiver ' || i,
                'caregiver' || i || '@' || s.schema_name || '.com'
            )
            INTO caregiver_id;

            -- PATIENT
            EXECUTE format('
                INSERT INTO %I.patients (
                    full_name,
                    email,
                    phone_number
                )
                VALUES (
                    %L,
                    %L,
                    %L
                )
                RETURNING id
            ',
                s.schema_name,
                'Patient ' || i,
                'patient' || i || '@' || s.schema_name || '.com',
                '+3160000000' || i
            )
            INTO patient_id;

            -- NFC TAG
            EXECUTE format('
                INSERT INTO %I.nfc_tags (
                    tag_id,
                    patient_id,
                    status
                )
                VALUES (
                    %L,
                    %L,
                    ''active''
                )
            ',
                s.schema_name,
                s.schema_name || '-TAG-00' || i,
                patient_id
            );

            -- CARE SESSION
            EXECUTE format('
                INSERT INTO %I.care_sessions (
                    patient_id,
                    caregiver_id,
                    check_in_time,
                    check_out_time,
                    status,
                    caregiver_notes
                )
                VALUES (
                    %L,
                    %L,
                    now() - interval ''%s hours'',
                    now() - interval ''%s hours'',
                    ''completed'',
                    %L
                )
                RETURNING id
            ',
                s.schema_name,
                patient_id,
                caregiver_id,
                6 - i,
                5 - i,
                'Routine visit #' || i
            )
            INTO care_session_id;

            -- FEEDBACK
            EXECUTE format('
                INSERT INTO %I.feedback (
                    care_session_id,
                    patient_id,
                    rating
                )
                VALUES (
                    %L,
                    %L,
                    %s
                )
            ',
                s.schema_name,
                care_session_id,
                patient_id,
                (i % 5) + 1
            );

        END LOOP;
    END LOOP;
END $$;
