-- name: CreateUserDetail :one

INSERT INTO
    user_details (user_id, photo, address)
VALUES ($1, $2, $3) RETURNING *;