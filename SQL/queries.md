# SQL Queries

Learn by examples! This documents supplements all explanations with clarifying examples.

## WordPress Specific

The query string to rename a custom post type:

```
UPDATE `wp_posts` SET `post_type` = '<new post type name>' WHERE `post_type` = '<old post type name>';
```

The query string to rename a custom taxonomy:

```
UPDATE `wp_term_taxonomy` SET `taxonomy` = '<new taxonomy name>' WHERE `taxonomy` = '<old taxonomy name>';
```

The query string to rename a custom meta field:

```
UPDATE `wp_postmeta` SET `meta_key` = '<new name>' WHERE `meta_key` = '<old name>';
```

The query string to remove all post revisions:

```
DELETE FROM wp_posts WHERE post_type = "revision";
```

The query to view the postmeta fields that do not have any post relation

```
SELECT * FROM wp_postmeta pm LEFT JOIN wp_posts wp ON wp.ID = pm.post_id WHERE wp.ID IS NULL;
```

The query to show only the postmeta fields by field name.

```
SELECT * FROM wp_postmeta pm LEFT JOIN wp_posts wp ON wp.ID = pm.post_id WHERE wp.ID IS NULL AND pm.meta_key LIKE '%my-custom-field-name%';
```

The query once correct to delete without problems and errors the postmeta fields.

```
DELETE FROM wp_postmeta pm LEFT JOIN wp_posts wp ON wp.ID = pm.post_id WHERE wp.ID IS NULL AND pm.meta_key LIKE '%my-custom-field-name%';
```
