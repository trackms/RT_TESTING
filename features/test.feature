#language: ru
@Tree

Функционал: Первоначальная настройка и заполнение БД

Сценарий: Проверка создания номенклатуры в ERP
	Когда я подключаю TestClient "ERP_MSS" логин "UserTesting" пароль "testtest"
	И В командном интерфейсе я выбираю 'НСИ и администрирование' 'Номенклатура'
	Тогда открылось окно 'Номенклатура'
	И я нажимаю на кнопку с именем 'СписокРасширенныйПоискНоменклатураСоздать'
	Тогда открылось окно 'Номенклатура (создание)'
	И в поле 'Рабочее наименование' я ввожу текст 'Тестовая номенклатура'
	И в поле 'Единица хранения' я ввожу текст 'кг'
	И я нажимаю на кнопку 'Записать и закрыть'
	И я жду закрытия окна 'Номенклатура (создание) *' в течение 20 секунд
