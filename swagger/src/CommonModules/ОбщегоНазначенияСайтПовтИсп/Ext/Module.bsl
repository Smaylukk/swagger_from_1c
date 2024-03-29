﻿
Функция ИмяПубликации() Экспорт 
	Результат = Константы.ИмяПубликации.Получить();
	
	Возврат Результат;
КонецФункции

Функция ПолныйАдресПубликации() Экспорт 
	Результат = Константы.ПолныйАдресПубликации.Получить();
	
	Возврат Результат;
КонецФункции

Функция ПолучитьДанныеПользователя(ИнфоОПользователе) Экспорт 
	Результат = ПолучитьПустуюСтруктуруДанныхПользователя();
	
	Пользователь = ИнфоОПользователе.Пользователь;
	Результат.Вставить("Пользователь", Пользователь);
	Результат.Вставить("Сессия", ИнфоОПользователе.Сессия);
	Результат.Вставить("ИмяПользователя", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Пользователь, "Наименование"));
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ОбъектыАвторизации.Ссылка КАК ОбъектАвторизации,
	|	ОбъектыАвторизации.Наименование КАК Наименование
	|ИЗ
	|	Справочник.ОбъектыАвторизации КАК ОбъектыАвторизации
	|ГДЕ
	|	ОбъектыАвторизации.Пользователь = &Пользователь
	|	И ОбъектыАвторизации.ПометкаУдаления = ЛОЖЬ";
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	РезультатЗапроса = Запрос.Выполнить();
	Если Не РезультатЗапроса.Пустой() Тогда
		Выборка = РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			Результат.Вставить("ОбъектАвторизации", Выборка.ОбъектАвторизации);
			Результат.Вставить("Наименование", Выборка.Наименование);
			//Результат.Вставить("Контрагент", Выборка.Контрагент);
			//Результат.Вставить("Партнер", Выборка.Партнер);
		КонецЦикла; 
		
		//структуру можно дополнять каким угодно способом, чтобы потом использовать 
		//в http-сервисах
		//данные Объекта
		Результат.Вставить("ДанныеОбъектАвторизации", ПолучитьДанныеОбъектАвторизации(Результат.ОбъектАвторизации));
	КонецЕсли; 
	
	Возврат Результат;
КонецФункции

Функция ПолучитьПустуюСтруктуруДанныхПользователя()
	Результат = Новый Структура;
	
	Результат.Вставить("ОбъектАвторизации", Неопределено);
	Результат.Вставить("Пользователь", Неопределено);
	Результат.Вставить("ИмяПользователя", Неопределено);
	//Результат.Вставить("ПВЗ", Неопределено);
	
	Возврат Результат;
КонецФункции

Функция ПолучитьДанныеОбъектАвторизации(ОбъектАвторизации)
	Результат = Неопределено;
	
	
	
	Возврат Результат;
КонецФункции

Функция ПолучитьМакетБлокаПоИД(ИД) Экспорт 
	Возврат Справочники.МакетыБлоков.ПолучитьСсылку(Новый УникальныйИдентификатор(ИД));
КонецФункции
