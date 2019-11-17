create table Users{
  username varchar(125) primary key not null,
  preferred_name varchar(125) not null,
  email varchar(125) unique not null;
  last_login_date timestamp;
  creation_date timestamp not null current_timestamp;
  birthday date not null;
  phonenumber varchar(15) not null unique;
  };

  create table UserCategories{
    category varchar(125) not null,
    user_username varchar(125) not null,
    bank_account_number bigint not null;
    constraint 'fk_categories_bank_accounts'
            FOREIGN KEY (bank_account_number) REFERENCES Bank_Accounts(account_number);
    constraint 'fk_categories_username'
            FOREIGN KEY (user_username) REFERENCES Users(username);
    }

create table Transactions{
  id bigint auto_increment not null primary key;
  bank_account_number bigint not null;
  merchant varchar(80) not null;
  description text not null;
  category varchar(125) not null;
  transaction_date timestamp not null default current_timestamp;
  clearing_date timestamp;
  amount decimal(13, 2) unsigned not null;
  type enum(debit, credit) not null;
  constraint 'fk_transactions_bank_accounts'
          FOREIGN KEY (bank_account_number) REFERENCES Bank_Accounts(account_number);
  constraint 'CHK_CATEGORY' check (category in ('pets', 'kids', 'bills', 'food') or cat_function()=1);
  };

create table Bank_Accounts{
  account_number bigint primary key not null;
  bank_sortcode int not null;
  nickname varchar(125) not null;
  last_update_date timestamp not null default current_timestamp;
  type enum(current, savings, loan) not null;
  is_joint_account tinyint(1) not null default 0;
  constraint 'fk_accounts_bank'
          FOREIGN KEY (bank_sortcode) REFERENCES Bank_Branches(fk_accounts_bank)
  };

create table Links{
  id auto_increment bigint primary key;
  user_username varchar(125) not null;
  bank_account_number bigint not null;
  creation_date timestamp not null default current_timestamp;
  constraint 'fk_links_bank_account_no' FOREIGN KEY (bank_account_number) REFERENCES Bank_Accounts(account_number);
  constraint 'fk_links_username' FOREIGN KEY (user_username) REFERENCES Users(username);
  constraint 'check_maximum_number_links' check(noOfLinks(bank_account_number) <= 2)
  constraint 'check_acccount_links' check(check_account_links(ban) = 1);

  };

  DELIMITER $$
  CREATE FUNCTION noOfLinks(
      bigint account_number
  )
  RETURNS int DETERMINISTIC
  BEGIN
  DECLARE int answer
  Select count(bank_account_number) from Links where bank_account_number = account_number into answer;
  RETURN answer;
  END $$
  DELIMITER ;

create table Bank_Branches{
  bank mediumint not null;
  sortcode int primary key not null;
  postal_code unique not null varchar(10);
  is_central_bank_branch tinyint(1) not null default 0;
  constraint 'fk_branches_banks' FOREIGN KEY (bank)
    REFERENCES Banks(id);
  constraint 'fk_postal_code_branches' FOREIGN KEY (postal_code)
    REFERENCES Adresses(postal_code);
  constraint 'one_central_branch' check(central_bank)
  };
  -- CREATE TRIGGER one_central_branch
  --   after update, on
  -- create table Adresses{
  --   postal_code varchar(10) not null primary key;
  --   street varchar(255) not null unique;
  --   city varchar(255) not null;
  --   };

  create table Banks{
    id mediumint auto_increment primary key not null;
    postal_code varchar(10) unique not null;
    name varchar(125) not null;
    constraint 'fk_postal_code_banks' FOREIGN KEY (postal_code)
      REFERENCES Adresses(postal_code);
    };

  create table Errors{
    id bigint auto_increment primary key not null;
    message text not null;
    bank_account_number bigint not null;
    error_date timestamp not null default current_timestamp;
    constraint 'fk_errors_account_number' FOREIGN KEY (bank_account_number)
      REFERENCES Bank_Accounts(account_number);
    };
