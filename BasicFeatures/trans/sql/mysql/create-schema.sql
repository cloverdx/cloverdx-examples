drop schema IF EXISTS training;
create schema training;
GRANT ALL PRIVILEGES ON training.* TO 'clover'@'%';
