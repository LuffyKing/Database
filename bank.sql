drop table if exists UserCategories;
drop table if exists Users;
create table Users(
  username varchar(125) primary key not null,
  preferred_name varchar(125) not null,
  email varchar(125) unique not null,
  password varchar(125) not null,
  last_login_date timestamp not null,
  creation_date timestamp not null default current_timestamp,
  birthday date not null,
  phonenumber varchar(15) not null unique
  );

create table UserCategories(
    category_id bigint auto_increment not null primary key,
    category varchar(125) not null,
    user_username varchar(125) not null,
    constraint `fk_categories_username`
            FOREIGN KEY (user_username) REFERENCES Users(username)
);

create table Transactions(
  id bigint auto_increment not null primary key,
  bank_account_number bigint not null,
  merchant varchar(80) not null,
  description text not null,
  category_id bigint not null,
  transaction_date timestamp not null default current_timestamp,
  clearing_date timestamp not null,
  amount decimal(13, 2) unsigned not null,
  type ENUM('debit', 'credit'),
  constraint `fk_transactions_bank_accounts`
          FOREIGN KEY (bank_account_number) REFERENCES Bank_Accounts(account_number),
  constraint `chk_clearing_date` check (clearing_date >= transaction_date)
);

create table Bank_Accounts(
  account_number bigint primary key not null,
  bank_branch int not null,
  nickname varchar(125) not null,
  last_update_date timestamp not null default current_timestamp,
  type ENUM('current', 'savings', 'loan'),
  is_joint_account tinyint(1) not null default 0,
  username_a varchar(125) not null,
  username_b varchar(125) not null default 'NO_USER',
  constraint `fk_accounts_bank`
          FOREIGN KEY (bank_branch) REFERENCES Bank_Branches(sortcode),
  constraint `account_check` check (
    (is_joint_account = 0 and username_b = 'NO_USER')
    or (is_joint_account = 1)
  )
);

create table Bank_Branches(
  bank mediumint not null,
  sortcode int primary key not null,
  postal_code unique not null varchar(10);
  constraint `fk_branches_banks` FOREIGN KEY (bank)
    REFERENCES Banks(id),
  constraint `fk_postal_code_branches` FOREIGN KEY (postal_code)
    REFERENCES Adresses(postal_code)
);

create table Banks(
    id mediumint auto_increment primary key not null,
    headquarters_postal_code varchar(10) unique not null,
    name varchar(125) not null,
    central_branch int not null,
    constraint `fk_postal_code_banks` FOREIGN KEY (headquarters_postal_code)
      REFERENCES Adresses(postal_code),
    constraint `fk_central_branch` FOREIGN KEY (central_branch)
      REFERENCES Bank_Branches(sortcode)
);

create table Adresses(
  street varchar(255) not null,
  city varchar(255) not null,
  postal_code varchar(10) primary key not null
);

create table Errors(
    id bigint auto_increment primary key not null,
    message text not null,
    bank_account_number bigint not null,
    error_date timestamp not null default current_timestamp,
    constraint 'fk_errors_account_number' FOREIGN KEY (bank_account_number)
      REFERENCES Bank_Accounts(account_number)
);
