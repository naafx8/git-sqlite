-- migration query
-- sqlite> insert into charlie ( name, time_added) select name, time_added from baz;

-- We are making a baseless assumption
-- that this pseudo, ad-hoc uuid
-- won't produce a collision
-- so we won't need a primary key
CREATE TABLE charlie (
    "id" char(36) default (
        lower(hex(randomblob(4)))
            || '-'
            || lower(hex(randomblob(2)))
            || '-4'
            || substr(lower(hex(randomblob(2))),2)
            || '-'
            || substr('89ab',abs(random()) % 4 + 1, 1)
            || substr(lower(hex(randomblob(2))),2)
            || '-'
            || lower(hex(randomblob(6)))
    ),
    name text,
    time_added timestamp default current_timestamp,
    primary key(id)
) WITHOUT ROWID;

CREATE TABLE entity (
    "id" char(36) default (
        lower(hex(randomblob(4)))
            || '-'
            || lower(hex(randomblob(2)))
            || '-4'
            || substr(lower(hex(randomblob(2))),2)
            || '-'
            || substr('89ab',abs(random()) % 4 + 1, 1)
            || substr(lower(hex(randomblob(2))),2)
            || '-'
            || lower(hex(randomblob(6)))
    ),
    name text,
    txt text,
    time_added timestamp default current_timestamp,
    primary key(id)
) WITHOUT ROWID;

CREATE TABLE tag2entity (
    "id" char(36) default (
        lower(hex(randomblob(4)))
            || '-'
            || lower(hex(randomblob(2)))
            || '-4'
            || substr(lower(hex(randomblob(2))),2)
            || '-'
            || substr('89ab',abs(random()) % 4 + 1, 1)
            || substr(lower(hex(randomblob(2))),2)
            || '-'
            || lower(hex(randomblob(6)))
    ),
    entity_id char(36), -- id
    tag_id char(36), -- id
    time_added timestamp default current_timestamp,
    primary key(id)
) WITHOUT ROWID;
CREATE INDEX tag2entity__entity_id ON tag2entity(entity_id);
CREATE INDEX tag2entity__tag_id ON tag2entity(tag_id);

CREATE TABLE tag (
    "id" char(36) default (
        lower(hex(randomblob(4)))
            || '-'
            || lower(hex(randomblob(2)))
            || '-4'
            || substr(lower(hex(randomblob(2))),2)
            || '-'
            || substr('89ab',abs(random()) % 4 + 1, 1)
            || substr(lower(hex(randomblob(2))),2)
            || '-'
            || lower(hex(randomblob(6)))
    ),
    name text,
    txt text,
    time_added timestamp default current_timestamp,
    primary key(id)
) WITHOUT ROWID;

/* some useful tag queries:


get all the entities that do have (some) tag

select *
from entity e,
    tag2entity t2e
where
    t2e.entity_id = e.id
    and <where_clause about entities or tags>;



get all the entities that DON'T have any tags:

select * from entity e
where not exists (
    select * from tag2entity t2e
    where t2e.entity_id = e.id
)

*/
