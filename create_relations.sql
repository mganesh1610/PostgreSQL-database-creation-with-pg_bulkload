/*ALTER TABLE submissions DROP CONSTRAINT IF EXISTS fk_author;
ALTER TABLE submissions DROP CONSTRAINT IF EXISTS fk_subreddit_id;
ALTER TABLE comments DROP CONSTRAINT IF EXISTS fk_author;
ALTER TABLE comments DROP CONSTRAINT IF EXISTS fk_subreddit_id;
ALTER TABLE comments DROP CONSTRAINT IF EXISTS fk_subreddit;
ALTER TABLE authors DROP CONSTRAINT authors_pkey;
ALTER TABLE subreddits DROP CONSTRAINT subreddits_pkey;
ALTER TABLE submissions DROP CONSTRAINT submissions_pkey;
ALTER TABLE comments DROP CONSTRAINT comments_pkey;
ALTER TABLE authors DROP CONSTRAINT authors_name_unique;
ALTER TABLE subreddits DROP CONSTRAINT subreddits_display_name_unique;
ALTER TABLE subreddits DROP CONSTRAINT subreddits_name_unique; */



-- Adding Primary Keys
ALTER TABLE authors ADD CONSTRAINT authors_pkey PRIMARY KEY (id);
ALTER TABLE subreddits ADD CONSTRAINT subreddits_pkey PRIMARY KEY (id);
ALTER TABLE submissions ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);
ALTER TABLE comments ADD CONSTRAINT comments_pkey PRIMARY KEY (id);

-- Adding Unique Constraints
ALTER TABLE authors ADD CONSTRAINT authors_name_unique UNIQUE (name);
ALTER TABLE subreddits ADD CONSTRAINT subreddits_display_name_unique UNIQUE (display_name);
ALTER TABLE subreddits ADD CONSTRAINT subreddits_name_unique UNIQUE (name);


-- Adding Foreign Key Constraints
ALTER TABLE submissions ADD CONSTRAINT fk_author FOREIGN KEY (author) REFERENCES authors (name);
ALTER TABLE submissions ADD CONSTRAINT fk_subreddit_id FOREIGN KEY (subreddit_id) REFERENCES subreddits (name);
ALTER TABLE comments ADD CONSTRAINT fk_author FOREIGN KEY (author) REFERENCES authors (name);
ALTER TABLE comments ADD CONSTRAINT fk_subreddit_id FOREIGN KEY (subreddit_id) REFERENCES subreddits (name);
ALTER TABLE comments ADD CONSTRAINT fk_subreddit FOREIGN KEY (subreddit) REFERENCES subreddits (display_name);

