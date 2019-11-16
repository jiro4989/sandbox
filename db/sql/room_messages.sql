SELECT r.name, u.name, m.text, m.send_at
  FROM messages m
  JOIN rooms r
    ON m.room_id = r.id
  JOIN users u
    ON m.user_id = u.id
 WHERE r.id = 1
 ORDER BY send_at;
