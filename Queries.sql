--Query 1 – User Name, Status, Profile Picture  & Phone Number


SELECT u.First_Name, u.Status, u.Profile_Picture, u.Visible_Contact_List_Phone_Number                                      
FROM User_Data as u


--Query 2 –  Message retrieval of a DM Conversation 


SELECT u.First_name as `first person` , s.First_Name as `second person`, Message.message
FROM Message, DM, Conversation, User_Data as u, User_Data as s
WHERE Conversation.Conversation_Type = "message" and Message.Conversation_C_ID = Conversation.C_ID and Conversation.DM_DM_ID = DM.DM_ID and 
       DM.User_Data_User_ID = u.User_ID and DM.Second_person_User_ID = s.User_ID



--Query 3 –  Message retrieval of a Group chat Conversation

SELECT u.First_name as `first person`, Message.message, group_chat.Group_ID
FROM Message, group_chat, Conversation, User_Data as u
WHERE Conversation.Conversation_Type = "message" and Message.Conversation_C_ID = Conversation.C_ID and Conversation.Group_Chat_Group_Id = Group_Chat.Group_ID and 
       Group_Chat.Group_Id = "8" and group_chat.member = u.user_Id
       


--Query 4 – Time Sent, Time delivered and Time read of a Message

SELECT conversation.C_ID, message.message, conversation.Time_Sent,   conversation.Time_delivered, conversation.Time_read
FROM Message, Conversation
WHERE Message.Conversation_C_ID = Conversation.C_ID


--Query 5 – Participants in a group chat 
select u.First_Name, g.Group_Name
from group_chat_has_user_data as gu, user_data as u, group_chat as g
where gu.Group_Chat_Group_ID = g.Group_ID and gu.User_Data_User_ID = u.User_ID;

--Query 6 – Common Groups Between 2 users

SELECT u1.User ID, u2.User ID, g.Group_Name
FROM User_data as u1, User_Data as u2, Group_Chat as g
WHERE Group_Chat.User ID = u1.User ID and Group_Chat.User ID = u2.User ID

--Query 7 - Update Status/Phone no./Profile Picture/Name

UPDATE User_Data
SET Status = Online, Phone no. = 9810320617,Name = ‘AK’

--Query 8 - To place the most recent conversation on top.
SELECT Time_delivered as td , CURTIME as ct ,C_ID
FROM conversation
WHERE td = ct
LIMIT 01;


--Query 9 - To display whether online/offline.
SELECT User_Data
FROM online status as os
WHERE os = ‘Online’








--Query 10 - To display last seen

SELECT recent_messages.g, recent_messages.d, MIN(recent_messages.diff)
FROM recent_messages
WHERE
(
CREATE VIEW [recent_messages] AS
SELECT Group_Chat.Group_Name as g, DM.DM_ID as d, TIMESTAMPDIFF(SECOND, NOW(), Conversation.Time_Delievered) AS diff
FROM Message, Conversation, Group_Chat, DM
WHERE Message.Conversation_C_ID = Conversation.C_ID and (Conversation.Group_Chat_Group_ID = Group_Chat.Group_ID or Conversation.DM_DM_ID = DM.DM_ID.)
)

