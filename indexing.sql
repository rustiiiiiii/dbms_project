USE dbms_project;

create index times on conversation (Time_Sent);

create index messages on message (message);

create index memb on members (Member_ID);

create index user_d on user_data (Visible_Contact_List_Phone_Number);

