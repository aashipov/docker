create role gitea with login password 'gitea';
create database gitea with owner gitea template template0 encoding UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';
--create schema if not exists gitea authorization gitea;
