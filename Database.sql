CREATE DATABASE IF NOT EXISTS electronic_voting_system;
USE electronic_voting_system;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS candidates;
DROP TABLE IF EXISTS elections;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
  user_id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin','voter') DEFAULT 'voter',
  status ENUM('active','inactive') DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id),
  UNIQUE KEY email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE elections (
  election_id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(150) NOT NULL,
  description TEXT DEFAULT NULL,
  start_date DATETIME NOT NULL,
  end_date DATETIME NOT NULL,
  status ENUM('active','closed','published') DEFAULT 'active',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (election_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE candidates (
  candidate_id INT(11) NOT NULL AUTO_INCREMENT,
  election_id INT(11) NOT NULL,
  candidate_name VARCHAR(150) NOT NULL,
  description TEXT DEFAULT NULL,
  PRIMARY KEY (candidate_id),
  KEY election_id (election_id),
  CONSTRAINT candidates_ibfk_1 FOREIGN KEY (election_id) REFERENCES elections (election_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE votes (
  vote_id INT(11) NOT NULL AUTO_INCREMENT,
  election_id INT(11) NOT NULL,
  candidate_id INT(11) NOT NULL,
  voter_id INT(11) NOT NULL,
  vote_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (vote_id),
  UNIQUE KEY unique_vote (election_id, voter_id),
  KEY candidate_id (candidate_id),
  KEY voter_id (voter_id),
  CONSTRAINT votes_ibfk_1 FOREIGN KEY (election_id) REFERENCES elections (election_id) ON DELETE CASCADE,
  CONSTRAINT votes_ibfk_2 FOREIGN KEY (candidate_id) REFERENCES candidates (candidate_id) ON DELETE CASCADE,
  CONSTRAINT votes_ibfk_3 FOREIGN KEY (voter_id) REFERENCES users (user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO users (user_id, name, email, password, role, status) VALUES
(1, 'Adriana', 'admin@test.com', '$2y$10$799Ld8i5b8JdQ1UEl7/r3uNc7a2L5jWM/gC6W3fpbuRiBmz7dnpDm', 'admin', 'active'),
(2, 'Test Voter', 'voter@test.com', '$2y$10$iazpSZVNq4e6X52BSaBl1eZZsg26F60PjnidD6EWNUJ2ljbUrHjiW', 'voter', 'active');

INSERT INTO elections (election_id, title, description, start_date, end_date, status) VALUES
(1, 'Student Council Election', 'Election for choosing the student council representative.', '2026-07-03 06:02:00', '2026-07-31 23:59:00', 'active');

INSERT INTO candidates (candidate_id, election_id, candidate_name, description) VALUES
(1, 1, 'Alice Brown', 'Candidate for student council representative.'),
(2, 1, 'Daniel Smith', 'Candidate for student council representative.'),
(3, 1, 'Maria Green', 'Candidate for student council representative.');
