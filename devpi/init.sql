create role devpi with login password 'devpi';
create database devpi with owner devpi template template0 encoding UTF8 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';
--create schema if not exists devpi authorization devpi;
