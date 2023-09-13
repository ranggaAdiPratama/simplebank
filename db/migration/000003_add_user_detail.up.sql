CREATE TABLE
    "user_details" (
        "id" bigserial PRIMARY KEY,
        "user_id" varchar NOT NULL,
        "photo" varchar NULL,
        "address" text NULL,
        "created_at" timestamp NOT NULL DEFAULT (now())
    );

ALTER TABLE "user_details"
ADD
    FOREIGN KEY ("user_id") REFERENCES "users" ("username");