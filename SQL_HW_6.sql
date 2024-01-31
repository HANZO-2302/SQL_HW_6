
#Удаление информации о пользователе из базы данных VK

-- Функция для удаления информации о пользователе из базы данных VK
CREATE FUNCTION remove_user(user_id INT) RETURNS INT
BEGIN
    -- Удаление сообщений пользователя
    DELETE FROM messages WHERE user_id = user_id;
    
    -- Удаление лайков пользователя
    DELETE FROM likes WHERE user_id = user_id;
    
    -- Удаление медиа-записей пользователя
    DELETE FROM media WHERE user_id = user_id;
    
    -- Удаление профиля пользователя
    DELETE FROM profile WHERE user_id = user_id;
    
    -- Удаление записей из таблицы пользователей
    DELETE FROM users WHERE id = user_id;
    
    -- Возвращение номера удаленного пользователя
    RETURN user_id;
END;


#Удаление информации о пользователе из базы данных VK с использованием процедуры и транзакции

-- Процедура для удаления информации о пользователе из базы данных VK
CREATE PROCEDURE remove_user_procedure(user_id INT)
BEGIN
    -- Начало транзакции
    START TRANSACTION;
    
    -- Удаление сообщений пользователя
    DELETE FROM messages WHERE user_id = user_id;
    
    -- Удаление лайков пользователя
    DELETE FROM likes WHERE user_id = user_id;
    
    -- Удаление медиа-записей пользователя
    DELETE FROM media WHERE user_id = user_id;
    
    -- Удаление профиля пользователя
    DELETE FROM profile WHERE user_id = user_id;
    
    -- Удаление записей из таблицы пользователей
    DELETE FROM users WHERE id = user_id;
    
    -- Коммит транзакции
    COMMIT;
END;

#Триггер для проверки нового появления сообщества

-- Триггер для проверки нового появления сообщества
CREATE TRIGGER check_community_name
BEFORE INSERT ON communities
FOR EACH ROW
BEGIN
    -- Проверка длины названия сообщества
    IF LENGTH(NEW.name) < 5 THEN
        -- Выброс исключения с объяснением
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Название сообщества должно содержать не менее 5 символов.';
    END IF;
END;


