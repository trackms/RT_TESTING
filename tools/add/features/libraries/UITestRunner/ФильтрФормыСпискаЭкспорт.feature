﻿# language: ru

@IgnoreOnCIMainBuild
@ExportScenarios

@tree

Функционал: Создание фильтра формы списка



@ТипШага: UI.Таблицы.Фильтр формы списка	
@Описание: Позволяет установить фильтр на список через меню "Ещё/Настроить список"
@ПримерИспользования: И Я устанавливаю фильтр на список
@ПримерИспользования:   	    | Наименование | Содержит | Товар1 | 

Сценарий: Я устанавливаю фильтр на список

	И     я нажимаю на кнопку с именем "*НастройкаСписка"
	#Если появилось окно с заголовком "Настройка списка" Тогда
	#ИначеЕсли появилось окно с заголовком "List Options" Тогда
	#Иначе
	#	Тогда я вызываю исключение "Обнаружено неизвестное окно."
		
	#Тогда открылось окно "Настройка списка"
	И     я нажимаю на кнопку с именем "ФормаСтандартныеНастройки"
	И для каждой строки таблицы отбора я устанавливаю отбор в списке
		| ИмяФильтр | ТипСравнения | ЗначениеФильтра | 
		
	И     я нажимаю на кнопку с именем "ФормаЗакончитьРедактирование"	




@ТипШага: UI.Таблицы.Фильтр формы списка		
@Описание: Позволяет установить фильтр на список через меню "Ещё/Настроить список". Причём если такого поля нет, то исключение вызываться не будет.
@ПримерИспользования: И Я устанавливаю фильтр на список если это возможно
@ПримерИспользования:   	    | Наименование | Содержит | Товар1 | 

Сценарий: Я устанавливаю фильтр на список если это возможно

	И     я нажимаю на кнопку с именем "*НастройкаСписка"
	#Если появилось окно с заголовком "Настройка списка" Тогда
	#ИначеЕсли появилось окно с заголовком "List Options" Тогда
	#Иначе
	#	Тогда я вызываю исключение "Обнаружено неизвестное окно."
		
	#Тогда открылось окно "Настройка списка"
	И     я нажимаю на кнопку с именем "ФормаСтандартныеНастройки"
	И для каждой строки таблицы отбора я устанавливаю отбор в списке если это возможно
		| ИмяФильтр | ТипСравнения | ЗначениеФильтра | 
		
	И     я нажимаю на кнопку с именем "ФормаЗакончитьРедактирование"	



	
@ТипШага: UI.Таблицы.Фильтр формы списка		
@Описание: Позволяет сбросить фильтр на список через меню "Ещё/Настроить список"
@ПримерИспользования: И Я очищаю фильтр на форме списка

Сценарий: Я очищаю фильтр на форме списка
	И     я нажимаю на кнопку с именем "ФормаНастройкаСписка"
	#Тогда открылось окно "Настройка списка"
	И     я нажимаю на кнопку с именем "ФормаСтандартныеНастройки"
	И     я нажимаю на кнопку с именем "ФормаЗакончитьРедактирование"	
