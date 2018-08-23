-- run using following command
-- mysql -u <YOUR_USER_NAME> -p < sql/dev_dash.sql

set sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

create database developer_dashboard;

create table if not exists developer_dashboard.tickets (
    id int not null auto_increment,
    ticket_id varchar(20) not null unique,
    status varchar(50) not null,
    priority varchar(10) null,
    summary longtext null,
    project varchar(100) null,
    issue_key varchar (50) null,
    issue_id    varchar (50) null,
    parent_id   varchar (50) null,
    issue_type  varchar (50) null,
    resolution  varchar (50) null,
    assignee    varchar (50) null,
    reporter    varchar (50) null,
    creator     varchar (50) null,
    eta         timestamp null default null ,
    updated     timestamp null default null ,
    last_viewed timestamp null default null , 
    resolved    timestamp null default null ,
    labels      varchar (50) null,
    metadata    json,
    created     timestamp null default null,
    row_created timestamp default now() not null,
    last_modfied timestamp null default null on update current_timestamp,
    primary key (id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
create unique index tickets_id_idx using btree on developer_dashboard.tickets (id,ticket_id,status);

create table if not exists developer_dashboard.daily_reports (
    id int not null auto_increment,
    team varchar (100) not null,
    email_sent date,
    for_date date not null, 
    metadata json,
    table_html longtext null,
    created  timestamp default now() not null,
    last_modfied timestamp null default null on update current_timestamp,
    primary key (id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
create unique index daily_reports_id_idx using btree on developer_dashboard.daily_reports (id,for_date,team) ;

create table if not exists developer_dashboard.dashboard_admin (
    id int not null auto_increment,
    user_id varchar(50) not null unique,
    name varchar(100) not null,
    pass varchar(250) not null,
    created timestamp default now() not null,
    last_modfied timestamp null default null on update current_timestamp,
    primary key (id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
create unique index users_id_idx using btree on developer_dashboard.dashboard_admin(id,user_id,pass) ;


create table if not exists developer_dashboard.users (
    id int not null auto_increment,
    user_id varchar(50) not null unique,
    name varchar(100) not null,
    team varchar(10),
    created timestamp default now() not null,
    last_modfied timestamp null default null on update current_timestamp,
    primary key (id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
create unique index users_id_idx using btree on developer_dashboard.users (id,user_id,name) ;

create table if not exists developer_dashboard.user_tickets (
    id int not null auto_increment,
    ticket_id varchar(20) not null unique,
    user_id varchar(50) not null,
    type varchar (20) not null,
    created timestamp default now() not null,
    last_modfied timestamp null default null on update current_timestamp,
    primary key (id),
    foreign key (ticket_id) 
        references tickets(ticket_id),
    foreign key (user_id) 
        references users(user_id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
create unique index user_tickets_id_idx using btree on developer_dashboard.user_tickets (id,ticket_id,user_id) ;

create table if not exists developer_dashboard.report_processor (
    id int not null auto_increment,
    report_name mediumtext not null,
    path mediumtext not null,
    status varchar(100) not null ,
    created timestamp default now() not null,
    deleted tinyint(1),
    result json,
    last_modfied timestamp null default null on update current_timestamp,
    primary key (id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
create unique index report_processor_id_idx using btree on developer_dashboard.report_processor (id);

create table if not exists developer_dashboard.hidden_tickets (
    id int not null auto_increment,
    ticket_id varchar(20) not null unique,
    hidden tinyint(1) not null,
    created timestamp default now() not null,
    last_modfied timestamp null default null on update current_timestamp,
    primary key (id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
create unique index hidden_tickets_id_idx using btree on developer_dashboard.hidden_tickets (id,ticket_id) ;

create table if not exists developer_dashboard.counter (
    id int not null auto_increment,
    count int not null,
    created timestamp default now() not null,
    last_modfied timestamp null default null on update current_timestamp,
    primary key (id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
create unique index counter_id_idx using btree on developer_dashboard.counter (id,count) ;

insert into developer_dashboard.counter (count) values (0);
insert into developer_dashboard.users (user_id,name) values ('unknown-dev','Unknown');
insert into developer_dashboard.dashboard_admin (user_id, name, pass) values('admin', 'Dashboard Admin', '{SSHA256}SKTsMmFzdssNMhV/r6eeEgrRQYAkdTW324Hka/8tNWNUAipf');
