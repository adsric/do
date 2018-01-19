# SQL Queries


## WordPress

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
