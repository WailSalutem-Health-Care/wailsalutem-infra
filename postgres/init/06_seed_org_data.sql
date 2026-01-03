DO $$
DECLARE
    s RECORD;
BEGIN
    FOR s IN
        SELECT schema_name
        FROM wailsalutem.organizations
    LOOP

        -- CAREGIVER 1
        EXECUTE format('
            INSERT INTO %I.users (id, keycloak_user_id, first_name, last_name, email, role)
            VALUES (
                ''11111111-1111-1111-1111-111111111111''::UUID,
                ''10101010-1010-1010-1010-101010101010''::UUID,
                ''John'',
                ''Smith'',
                ''john.smith@demo.com'',
                ''caregiver''
            )
        ', s.schema_name);

        -- PATIENT 1 (first_name, last_name, keycloak_user_id, careplan_type, careplan_frequency)
        EXECUTE format('
            INSERT INTO %I.patients (id, keycloak_user_id, first_name, last_name, email, phone_number, careplan_type, careplan_frequency)
            VALUES (
                ''aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa''::UUID,
                ''12121212-1212-1212-1212-121212121212''::UUID,
                ''Mary'',
                ''Anderson'',
                ''mary.anderson@demo.com'',
                ''+31600000011'',
                ''standard'',
                ''weekly''
            )
        ', s.schema_name);

        -- NFC TAG 1
        EXECUTE format('
            INSERT INTO %I.nfc_tags (tag_id, patient_id, status)
            VALUES (
                ''NFC-00001'',
                ''aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa''::UUID,
                ''active''
            )
        ', s.schema_name);

        -- CARE SESSION 1
        EXECUTE format('
            INSERT INTO %I.care_sessions (id, patient_id, caregiver_id, check_in_time, check_out_time, status, caregiver_notes)
            VALUES (
                ''99999999-0001-0001-0001-000000000001''::UUID,
                ''aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa''::UUID,
                ''11111111-1111-1111-1111-111111111111''::UUID,
                TIMESTAMP ''2025-12-29 08:00:00'',
                TIMESTAMP ''2025-12-29 09:00:00'',
                ''completed'',
                ''Patient doing well, vitals normal''
            )
        ', s.schema_name);

        -- FEEDBACK 1 (added patient_feedback and deleted_at)
        EXECUTE format('
            INSERT INTO %I.feedback (care_session_id, patient_id, rating, patient_feedback, deleted_at)
            VALUES (
                ''99999999-0001-0001-0001-000000000001''::UUID,
                ''aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa''::UUID,
                5,
                ''Caregiver was punctual and attentive'',
                NULL
            )
        ', s.schema_name);

        -- CAREGIVER 2
        EXECUTE format('
            INSERT INTO %I.users (id, keycloak_user_id, first_name, last_name, email, role)
            VALUES (
                ''22222222-2222-2222-2222-222222222222''::UUID,
                ''20202020-2020-2020-2020-202020202020''::UUID,
                ''Sarah'',
                ''Johnson'',
                ''sarah.johnson@demo.com'',
                ''caregiver''
            )
        ', s.schema_name);

        -- PATIENT 2 (first_name, last_name, keycloak_user_id, careplan_type, careplan_frequency)
        EXECUTE format('
            INSERT INTO %I.patients (id, keycloak_user_id, first_name, last_name, email, phone_number, careplan_type, careplan_frequency)
            VALUES (
                ''bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb''::UUID,
                ''23232323-2323-2323-2323-232323232323''::UUID,
                ''James'',
                ''Martinez'',
                ''james.martinez@demo.com'',
                ''+31600000012'',
                ''intensive'',
                ''daily''
            )
        ', s.schema_name);

        -- NFC TAG 2
        EXECUTE format('
            INSERT INTO %I.nfc_tags (tag_id, patient_id, status)
            VALUES (
                ''NFC-00002'',
                ''bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb''::UUID,
                ''active''
            )
        ', s.schema_name);

        -- CARE SESSION 2
        EXECUTE format('
            INSERT INTO %I.care_sessions (id, patient_id, caregiver_id, check_in_time, check_out_time, status, caregiver_notes)
            VALUES (
                ''99999999-0002-0002-0002-000000000002''::UUID,
                ''bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb''::UUID,
                ''22222222-2222-2222-2222-222222222222''::UUID,
                TIMESTAMP ''2025-12-29 09:00:00'',
                TIMESTAMP ''2025-12-29 10:00:00'',
                ''completed'',
                ''Administered medication as prescribed''
            )
        ', s.schema_name);

        -- FEEDBACK 2 (added patient_feedback and deleted_at)
        EXECUTE format('
            INSERT INTO %I.feedback (care_session_id, patient_id, rating, patient_feedback, deleted_at)
            VALUES (
                ''99999999-0002-0002-0002-000000000002''::UUID,
                ''bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb''::UUID,
                4,
                ''Good visit; missed one medication'',
                NULL
            )
        ', s.schema_name);

        -- CAREGIVER 3
        EXECUTE format('
            INSERT INTO %I.users (id, keycloak_user_id, first_name, last_name, email, role)
            VALUES (
                ''33333333-3333-3333-3333-333333333333''::UUID,
                ''30303030-3030-3030-3030-303030303030''::UUID,
                ''Michael'',
                ''Brown'',
                ''michael.brown@demo.com'',
                ''caregiver''
            )
        ', s.schema_name);

        -- PATIENT 3 (first_name, last_name, keycloak_user_id, careplan_type, careplan_frequency)
        EXECUTE format('
            INSERT INTO %I.patients (id, keycloak_user_id, first_name, last_name, email, phone_number, careplan_type, careplan_frequency)
            VALUES (
                ''cccccccc-cccc-cccc-cccc-cccccccccccc''::UUID,
                ''34343434-3434-3434-3434-343434343434''::UUID,
                ''Patricia'',
                ''Taylor'',
                ''patricia.taylor@demo.com'',
                ''+31600000013'',
                ''rehab'',
                ''biweekly''
            )
        ', s.schema_name);

        -- NFC TAG 3
        EXECUTE format('
            INSERT INTO %I.nfc_tags (tag_id, patient_id, status)
            VALUES (
                ''NFC-00003'',
                ''cccccccc-cccc-cccc-cccc-cccccccccccc''::UUID,
                ''active''
            )
        ', s.schema_name);

        -- CARE SESSION 3
        EXECUTE format('
            INSERT INTO %I.care_sessions (id, patient_id, caregiver_id, check_in_time, check_out_time, status, caregiver_notes)
            VALUES (
                ''99999999-0003-0003-0003-000000000003''::UUID,
                ''cccccccc-cccc-cccc-cccc-cccccccccccc''::UUID,
                ''33333333-3333-3333-3333-333333333333''::UUID,
                TIMESTAMP ''2025-12-29 10:00:00'',
                TIMESTAMP ''2025-12-29 11:00:00'',
                ''completed'',
                ''Physical therapy exercises completed''
            )
        ', s.schema_name);

        -- FEEDBACK 3 (added patient_feedback and deleted_at)
        EXECUTE format('
            INSERT INTO %I.feedback (care_session_id, patient_id, rating, patient_feedback, deleted_at)
            VALUES (
                ''99999999-0003-0003-0003-000000000003''::UUID,
                ''cccccccc-cccc-cccc-cccc-cccccccccccc''::UUID,
                5,
                ''Therapist was very encouraging'',
                NULL
            )
        ', s.schema_name);

        -- CAREGIVER 4
        EXECUTE format('
            INSERT INTO %I.users (id, keycloak_user_id, first_name, last_name, email, role)
            VALUES (
                ''44444444-4444-4444-4444-444444444444''::UUID,
                ''40404040-4040-4040-4040-404040404040''::UUID,
                ''Emily'',
                ''Davis'',
                ''emily.davis@demo.com'',
                ''caregiver''
            )
        ', s.schema_name);

        -- PATIENT 4 (first_name, last_name, keycloak_user_id, careplan_type, careplan_frequency)
        EXECUTE format('
            INSERT INTO %I.patients (id, keycloak_user_id, first_name, last_name, email, phone_number, careplan_type, careplan_frequency)
            VALUES (
                ''dddddddd-dddd-dddd-dddd-dddddddddddd''::UUID,
                ''45454545-4545-4545-4545-454545454545''::UUID,
                ''Robert'',
                ''Thomas'',
                ''robert.thomas@demo.com'',
                ''+31600000014'',
                ''palliative'',
                ''monthly''
            )
        ', s.schema_name);

        -- NFC TAG 4
        EXECUTE format('
            INSERT INTO %I.nfc_tags (tag_id, patient_id, status)
            VALUES (
                ''NFC-00004'',
                ''dddddddd-dddd-dddd-dddd-dddddddddddd''::UUID,
                ''active''
            )
        ', s.schema_name);

        -- CARE SESSION 4
        EXECUTE format('
            INSERT INTO %I.care_sessions (id, patient_id, caregiver_id, check_in_time, check_out_time, status, caregiver_notes)
            VALUES (
                ''99999999-0004-0004-0004-000000000004''::UUID,
                ''dddddddd-dddd-dddd-dddd-dddddddddddd''::UUID,
                ''44444444-4444-4444-4444-444444444444''::UUID,
                TIMESTAMP ''2025-12-29 11:00:00'',
                TIMESTAMP ''2025-12-29 12:00:00'',
                ''completed'',
                ''Patient reported improved mobility''
            )
        ', s.schema_name);

        -- FEEDBACK 4 (added patient_feedback and deleted_at)
        EXECUTE format('
            INSERT INTO %I.feedback (care_session_id, patient_id, rating, patient_feedback, deleted_at)
            VALUES (
                ''99999999-0004-0004-0004-000000000004''::UUID,
                ''dddddddd-dddd-dddd-dddd-dddddddddddd''::UUID,
                3,
                ''Visit helpful but patient felt tired afterwards'',
                NULL
            )
        ', s.schema_name);

        -- CAREGIVER 5
        EXECUTE format('
            INSERT INTO %I.users (id, keycloak_user_id, first_name, last_name, email, role)
            VALUES (
                ''55555555-5555-5555-5555-555555555555''::UUID,
                ''50505050-5050-5050-5050-505050505050''::UUID,
                ''David'',
                ''Wilson'',
                ''david.wilson@demo.com'',
                ''caregiver''
            )
        ', s.schema_name);

        -- PATIENT 5 (first_name, last_name, keycloak_user_id, careplan_type, careplan_frequency)
        EXECUTE format('
            INSERT INTO %I.patients (id, keycloak_user_id, first_name, last_name, email, phone_number, careplan_type, careplan_frequency)
            VALUES (
                ''eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee''::UUID,
                ''56565656-5656-5656-5656-565656565656''::UUID,
                ''Linda'',
                ''Moore'',
                ''linda.moore@demo.com'',
                ''+31600000015'',
                ''standard'',
                ''weekly''
            )
        ', s.schema_name);

        -- NFC TAG 5
        EXECUTE format('
            INSERT INTO %I.nfc_tags (tag_id, patient_id, status)
            VALUES (
                ''NFC-00005'',
                ''eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee''::UUID,
                ''active''
            )
        ', s.schema_name);

        -- CARE SESSION 5
        EXECUTE format('
            INSERT INTO %I.care_sessions (id, patient_id, caregiver_id, check_in_time, check_out_time, status, caregiver_notes)
            VALUES (
                ''99999999-0005-0005-0005-000000000005''::UUID,
                ''eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee''::UUID,
                ''55555555-5555-5555-5555-555555555555''::UUID,
                TIMESTAMP ''2025-12-29 12:00:00'',
                TIMESTAMP ''2025-12-29 13:00:00'',
                ''completed'',
                ''Regular checkup, all systems normal''
            )
        ', s.schema_name);

        -- FEEDBACK 5 (added patient_feedback and deleted_at)
        EXECUTE format('
            INSERT INTO %I.feedback (care_session_id, patient_id, rating, patient_feedback, deleted_at)
            VALUES (
                ''99999999-0005-0005-0005-000000000005''::UUID,
                ''eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee''::UUID,
                5,
                ''Excellent care and attention'',
                NULL
            )
        ', s.schema_name);

    END LOOP;
END $$;
