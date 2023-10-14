ALTER TABLE
    IF EXISTS "accounts" DROP CONSTRAINT IF EXISTS "owner_currency_key";

ALTER TABLE
    IF EXISTS "accounts" DROP CONSTRAINT IF EXISTS "accounts_owner_fkey";

ALTER TABLE
    IF EXISTS "user_details" DROP CONSTRAINT IF EXISTS "user_details_user_id_fkey";

DROP TABLE IF EXISTS "sessions";

DROP TABLE IF EXISTS "users";