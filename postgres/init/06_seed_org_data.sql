DO $$
DECLARE
    s RECORD;
    
    -- Hard-coded caregiver data
    caregiver_data RECORD[] := ARRAY[
        ROW('11111111-1111-1111-1111-111111111111'::UUID, '10101010-1010-1010-1010-101010101010'::UUID, 'John Smith', 'john.smith@demo.com')::RECORD,
        ROW('22222222-2222-2222-2222-222222222222'::UUID, '20202020-2020-2020-2020-202020202020'::UUID, 'Sarah Johnson', 'sarah.johnson@demo.com')::RECORD,
        ROW('33333333-3333-3333-3333-333333333333'::UUID, '30303030-3030-3030-3030-303030303030'::UUID, 'Michael Brown', 'michael.brown@demo.com')::RECORD,
        ROW('44444444-4444-4444-4444-444444444444'::UUID, '40404040-4040-4040-4040-404040404040'::UUID, 'Emily Davis', 'emily.davis@demo.com')::RECORD,
        ROW('55555555-5555-5555-5555-555555555555'::UUID, '50505050-5050-5050-5050-505050505050'::UUID, 'David Wilson', 'david.wilson@demo.com')::RECORD
    ];
    
    -- Hard-coded patient data
    patient_data RECORD[] := ARRAY[
        ROW('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'::UUID, 'Mary Anderson', 'mary.anderson@demo.com', '+31600000011')::RECORD,
        ROW('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'::UUID, 'James Martinez', 'james.martinez@demo.com', '+31600000012')::RECORD,
        ROW('cccccccc-cccc-cccc-cccc-cccccccccccc'::UUID, 'Patricia Taylor', 'patricia.taylor@demo.com', '+31600000013')::RECORD,
        ROW('dddddddd-dddd-dddd-dddd-dddddddddddd'::UUID, 'Robert Thomas', 'robert.thomas@demo.com', '+31600000014')::RECORD,
        ROW('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee'::UUID, 'Linda Moore', 'linda.moore@demo.com', '+31600000015')::RECORD
    ];
    
    -- Hard-coded session IDs and notes
    session_data TEXT[][] := ARRAY[
        ARRAY['99999999-0001-0001-0001-000000000001', 'Patient doing well, vitals normal'],
        ARRAY['99999999-0002-0002-0002-000000000002', 'Administered medication as prescribed'],
        ARRAY['99999999-0003-0003-0003-000000000003', 'Physical therapy exercises completed'],
        ARRAY['99999999-0004-0004-0004-000000000004', 'Patient reported improved mobility'],
        ARRAY['99999999-0005-0005-0005-000000000005', 'Regular checkup, all systems normal']
    ];
    
    i INT;
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
                    id,
                    keycloak_user_id,
                    full_name,
                    email,
                    role
                )
                VALUES (
                    %L,
                    %L,
                    %L,
                    %L,
                    ''caregiver''
                )
            ',
                s.schema_name,
                caregiver_data[i].f1,
                caregiver_data[i].f2,
                caregiver_data[i].f3,
                caregiver_data[i].f4
            );

            -- PATIENT
            EXECUTE format('
                INSERT INTO %I.patients (
                    id,
                    full_name,
                    email,
                    phone_number
                )
                VALUES (
                    %L,
                    %L,
                    %L,
                    %L
                )
            ',
                s.schema_name,
                patient_data[i].f1,
                patient_data[i].f2,
                patient_data[i].f3,
                patient_data[i].f4
            );

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
                'NFC-' || LPAD(i::TEXT, 5, '0'),
                patient_data[i].f1
            );

            -- CARE SESSION
            EXECUTE format('
                INSERT INTO %I.care_sessions (
                    id,
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
                    %L,
                    TIMESTAMP ''2025-12-29 %s:00:00'',
                    TIMESTAMP ''2025-12-29 %s:00:00'',
                    ''completed'',
                    %L
                )
            ',
                s.schema_name,
                session_data[i][1],
                patient_data[i].f1,
                caregiver_data[i].f1,
                LPAD((8 + i)::TEXT, 2, '0'),
                LPAD((9 + i)::TEXT, 2, '0'),
                session_data[i][2]
            );

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
                session_data[i][1],
                patient_data[i].f1,
                i
            );

        END LOOP;
    END LOOP;
END $$;
