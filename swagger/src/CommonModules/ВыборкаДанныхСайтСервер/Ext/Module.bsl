﻿
////////////////////////////////////////////////////////////////////////////////
// <Заголовок модуля: краткое описание и условия применения модуля.>
//  Модуль для выборки данных з БД для запросов
////////////////////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

// Возвращает ссылку на вариант отчета.
//
// Параметры:
//  ИнфоОПользователе - структура, которая формируется в http-сервисах
//
// Возвращаемое значение:
//  Структура с произвольным набором ключей
//
Функция ПолучитьДанныеПользователя(ИнфоОПользователе) Экспорт 
	Результат = ПолучитьПустуюСтруктуруДанныхПользователя();
	
	Пользователь = ИнфоОПользователе.Пользователь;
	Результат.Вставить("Пользователь", Пользователь);
	Результат.Вставить("Сессия", ИнфоОПользователе.Сессия);
	Результат.Вставить("ИмяПользователя", ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Пользователь, "Наименование"));
	
	//В некоторых случаях необходимо предоставить авторизацию в личном кабинете в разрезе других 
	//справочников (Контрагенты, партнеры и т.д.)
	//тип этих справочников можно задать в определяемом типе ОбъектАвторизации, т.к. он от базы к базе может меняться
	//тут для примера добавлен справочник ОбъектыАвторизации
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ОбъектыАвторизации.Ссылка КАК ОбъектАвторизации
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
			Результат.Вставить("ОбъектАвторизации", Выборка.ОбъектАвторизации)
		КонецЦикла; 
		
		//структуру можно дополнять каким угодно способом, чтобы потом использовать 
		//в http-сервисах
		//данные Объекта
		Результат.Вставить("ДанныеОбъектАвторизации", ПолучитьДанныеОбъектАвторизации(Результат.ОбъектАвторизации));
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

Функция ПолучитьМакетБлокаПоИД(ИД) Экспорт 
	Возврат Справочники.МакетыБлоков.ПолучитьСсылку(Новый УникальныйИдентификатор(ИД));
КонецФункции

Функция ЭкранированиеКавычек(Знач Текст) Экспорт 
	Результат = СтрЗаменить(Текст, "", "&quot;");
	
	Возврат Результат;
КонецФункции

Функция ПолучитьСписокСервисов() Экспорт 
	Результат = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПредоставляемыеСервисы.Идентификатор КАК Идентификатор,
	|	ПредоставляемыеСервисы.ИсточникСервиса КАК ИсточникСервиса,
	|	ПредоставляемыеСервисы.UrlРесурса КАК UrlРесурса,
	|	ПредоставляемыеСервисы.Наименование КАК Наименование
	|ИЗ
	|	Справочник.ПредоставляемыеСервисы КАК ПредоставляемыеСервисы
	|ГДЕ
	|	ПредоставляемыеСервисы.ПометкаУдаления = ЛОЖЬ
	|	И ПредоставляемыеСервисы.Отключен = ЛОЖЬ";
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл
		Сервис = Новый Соответствие;
		Сервис.Вставить("url", ?(Выборка.ИсточникСервиса = ПредопределенноеЗначение("Перечисление.ИсточникиСервиса.ВнешняяСсылка"), Выборка.UrlРесурса, "/" + ОбщегоНазначенияСайтПовтИсп.ИмяПубликации() + "/index/service/" + Выборка.Идентификатор));
		Сервис.Вставить("name", Выборка.Наименование);
		
		Результат.Добавить(Сервис);
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

Функция ПолучитьОписаниеСервиса(ИдентификаторСервиса) Экспорт 
	Результат = Новый Соответствие;
	
	Сервис = Неопределено;
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПредоставляемыеСервисы.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ПредоставляемыеСервисы КАК ПредоставляемыеСервисы
	|ГДЕ
	|	ПредоставляемыеСервисы.ПометкаУдаления = ЛОЖЬ
	|	И ПредоставляемыеСервисы.Отключен = ЛОЖЬ
	|	И ПредоставляемыеСервисы.Идентификатор = &Идентификатор";
	Запрос.УстановитьПараметр("Идентификатор", ИдентификаторСервиса);
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Если Выборка.Следующий() Тогда
		Ссылка = Выборка.Ссылка;
		Сервис = Ссылка.ПолучитьОбъект();
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
	Если Ложь Тогда
		Сервис = Справочники.ПредоставляемыеСервисы.СоздатьЭлемент();
	КонецЕсли;
	
	Если Сервис.ИсточникСервиса = ПредопределенноеЗначение("Перечисление.ИсточникиСервиса.ТекстоваяСпецификация") Тогда
		Возврат Сервис.Описание;
	КонецЕсли;
	
	Возврат Сервис.СформироватьJsonSwagger();
КонецФункции
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьДанныеОбъектАвторизации(ОбъектАвторизации)
	Результат = Неопределено;
	
	
	
	Возврат Результат;
КонецФункции

Функция ПолучитьПустуюСтруктуруДанныхПользователя()
	Результат = Новый Структура;
	
	Результат.Вставить("ОбъектАвторизации", Неопределено);
	Результат.Вставить("Пользователь", Неопределено);
	Результат.Вставить("ИмяПользователя", Неопределено);
	
	
	Возврат Результат;
КонецФункции

#КонецОбласти

