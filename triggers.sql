USE dbms_project ;

CREATE TRIGGER delete_profile_photo  
AFTER INSERT  
ON  
user_data  
FOR EACH ROW  
SET new.Profile_Picture = null;  


CREATE TRIGGER block  
AFTER INSERT  
ON  
user_data  
FOR EACH ROW  
SET new.hide_details = 70;  