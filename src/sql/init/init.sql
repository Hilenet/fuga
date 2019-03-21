
CREATE DATABASE development
  IF NOT EXISTS development
  DEFAULT CHARSET=utf8mb4;


CREATE TABLE `user` (
  `id`        INT           NOT NULL  AUTO_INCREMENT,
  `slack_id`  VARCHAR(16)   NOT NULL  COMMENT 'user.id',
  `name`      VARCHAR(256)  NOT NULL  COMMENT 'user.name (as: hilenet)',
  `real_name` VARCHAR(256)  NOT NULL  COMMENT 'user.profile.real_name (as: の)',
  `email`     VARCHAR(256)  NOT NULL  COMMENT 'user.profile.email',
  `icon_url`  VARCHAR(256)  NOT NULL  COMMENT 'user.profile.image_original',
  `deleted`   BOOLEAN       NOT NULL DEFAULT (FALSE) COMMENT 'user.deleted',
  PRIMARY KEY (id),
  UNIQUE (id, slack_id)
);

CREATE TABLE `channel` (
  `id`          INT           NOT NULL AUTO_INCREMENT,
  `slack_id`    VARCHAR(16)   NOT NULL                  COMMENT 'channel.id',
  `name`        VARCHAR(256)  NOT NULL                  COMMENT 'channel.name',
  `creator_id`  INT           NOT NULL                  COMMENT 'foreign: user.id',
  `topic`       JSON          DEFAULT NULL              COMMENT 'channel.topic (NOTE: null or json)',
  `purpose`     JSON          DEFAULT NULL              COMMENT 'channel.purpose (NOTE: null or json)',,
  `is_archived` BOOLEAN       NOT NULL DEFAULT (FALSE)  COMMENT 'channel.is_archived',
  PRIMARY KEY (id),
  UNIQUE (id, slack_id),
  FOREIGN KEY (creator_id) REFERENCES user(id)
);

CREATE TABLE `message` (
  `id`          INT             NOT NULL  AUTO_INCREMENT,
  `ts`          DECIMAL(16, 6)  NOT NULL      COMMENT 'slack message should identified by timestamp \d{10}.\d{6}',
  `channel_id`  INT             NOT NULL      COMMENT 'belongs_to',
  `user_id`     INT             NOT NULL      COMMENT 'belongs_to',
  `text`        TEXT            NOT NULL      COMMENT 'entity',
  `attachments` JSON            DEFAULT NULL  COMMENT 'would array of json',
  PRIMARY KEY (id),
  UNIQUE  (id, ts),
  FOREIGN KEY (user_id)     REFERENCES user(id),
  FOREIGN KEY (channel_id)  REFERENCES channel(id)
);

CREATE TABLE `file` (
  `id`        INT         NOT NULL  AUTO_INCREMENT,
  `slack_id`  VARCHAR(16) NOT NULL          COMMENT 'file.id',
  `filetype`  VARCHAR(16) NOT NULL          COMMENT 'file.filetype (as: gif)',
  `user_id`   INT         NOT NULL          COMMENT 'file.user, belongs_to',
  `created`   TIMESTAMP   NOT NULL          COMMENT 'file.created',
  `url`       TEXT       NOT NULL          COMMENT 'file.permalink'
  PRIMARY KEY (id),
  UNIQUE (id),
  FOREIGN KEY (user_id)   REFERENCES user(id)
);

/* TODO: constraint */

