create table Users{
  username varchar(125) primary key not null,
  preferred_name varchar(125) not null,
  email varchar(125) unique not null;
  last_login_date timestamp not null default current_timestamp;
  creation_date timestamp not null;
  birthday date not null;
  phonenumber varchar(15) not null unique;
  }

create table Transactions{
  id bigint auto_increment not null primary key;
  bank_account varchar(20) not null;
  merchant varchar(80) not null;
  description text not null;
  category enum(pets, kids, bills, food) not null;
  transaction_date timestamp not null default current_timestamp;
  clearing_date timestamp not null;
  amount decimal(13, 2) unsigned not null;
  type enum(debit, credit) not null;
  }

create table Bank_Accounts{
  bank_branch varchar(255) not null;
  nickname varchar(125) not null;
  account_number bigint primary key not null;
  last_update_date timestamp not null default current_timestamp;
  type enum(current, savings, loan) not null;
  is_joint_account tinyint(1) not null default 0;
  }

create table Account_Link{
  id auto_increment bigint primary key;
  owner_link varchar(125) not null;
  account_link bigint primary key not null;
  creation_date timestamp not null default current_timestamp;
  }

create table Bank_Branches{
  bank mediumint not null;
  sortcode int primary key not null;
  postal_code unique not null varchar(10);
  is_central_bank_branch tinyint(1) not null default 0;
  }

  create table Adresses_Street{
    postal_code varchar(10) not null primary key;
    street varchar(255) not null;
    }

  create table Adresses_City{
    postal_code varchar(10) not null primary key;
    city varchar(255) not null;
    }

  create table Bank{
    id mediumint auto_increment primary key not null;
    postal_code varchar(10) unique not null;
    name varchar(125) not null;
    }

  create table Errors{
    id bigint auto_increment primary key not null;
    message text not null;
    account bigint not null;
    error_date timestamp not null default current_timestamp;
    }
