﻿
//основные обработчики http-запросов

Функция НачальнаяСтраницаGet(Запрос) Экспорт
	Ответ = Новый HTTPСервисОтвет(200);
	//получаем текст страницы
	Ответы.ПолучитьОтвет(ПредопределенноеЗначение("Перечисление.ВидыСтраниц.НачальнаяСтраница"), Ответ, Новый Структура);
	
	Возврат Ответ;
КонецФункции

Функция APIPOST(Запрос) Экспорт
	Ответ = Новый HTTPСервисОтвет(200);
	
	ИнфоОПользователе = Авторизация.СессияАктивна(Запрос, "");
	Если ИнфоОПользователе.Успех Тогда
		//получаем данные
		ДанныеПользователя = ОбщегоНазначенияСайтПовтИсп.ПолучитьДанныеПользователя(ИнфоОПользователе);
		
		ПараметрыЗапроса = Ответы.ПолучитьПараметры(Запрос.ПолучитьТелоКакСтроку());
		Результат = "#"; //в результате успешного выполнения переменная будет со значением
		Ошибка = "";
		Если ПараметрыЗапроса.Свойство("method")Тогда
			Метод = ПараметрыЗапроса["method"];
			Авторизация.ЗаписатьАктивность(Запрос, ИнфоОПользователе.Пользователь, "API, метод - " + Метод);
			Если Метод = "temp" Тогда //получение параметров отчета
				
			Иначе 
				Ошибка = "Вызов неизвестного метода - " + Метод;
			КонецЕсли;
		Иначе
			Ошибка = "Неправильный вызов - не указан метод";
		КонецЕсли;
		
		ДанныеСериализации = Новый Структура;
		ДанныеСериализации.Вставить("result", Результат);
		ДанныеСериализации.Вставить("error", Ошибка);
		РезультатJSON = Ответы.СериализоватьВJSON(ДанныеСериализации);
		
		Ответ.УстановитьТелоИзСтроки(РезультатJSON);
		
		Ответ.Заголовки.Вставить("Content-Type","application/json");
	КонецЕсли;
	
	
	Возврат Ответ;
КонецФункции

Функция APIGET(Запрос) Экспорт
	Ответ = Новый HTTPСервисОтвет(200);
	
	ИнфоОПользователе = Авторизация.СессияАктивна(Запрос, "");
	Если ИнфоОПользователе.Успех Тогда
		//получаем данные
		ДанныеПользователя = ОбщегоНазначенияСайтПовтИсп.ПолучитьДанныеПользователя(ИнфоОПользователе);
		
		ПараметрыЗапроса = Запрос.ПараметрыЗапроса;
		Результат = "#"; //в результате успешного выполнения переменная будет со значением
		Ошибка = "";
		Если ПараметрыЗапроса.Получить("method") <> Неопределено Тогда
			Метод = ПараметрыЗапроса.Получить("method");
			Авторизация.ЗаписатьАктивность(Запрос, ИнфоОПользователе.Пользователь, "API, метод - " + Метод);
			Если Метод = "temp" Тогда //получение параметров отчета
				
			Иначе 
				Ошибка = "Вызов неизвестного метода - " + Метод;
			КонецЕсли;
		Иначе
			Ошибка = "Неправильный вызов - не указан метод";
		КонецЕсли;
		
		ДанныеСериализации = Новый Структура;
		ДанныеСериализации.Вставить("result", Результат);
		ДанныеСериализации.Вставить("error", Ошибка);
		РезультатJSON = Ответы.СериализоватьВJSON(ДанныеСериализации);
		
		Ответ.УстановитьТелоИзСтроки(РезультатJSON);
		
		Ответ.Заголовки.Вставить("Content-Type","application/json");
	КонецЕсли;
	
	
	Возврат Ответ;
КонецФункции

Функция СервисGET(Запрос) Экспорт
	Ответ = Новый HTTPСервисОтвет(200);
	
	ДанныеСериализации = Новый Массив;
	ПараметрыЗапроса = Запрос.ПараметрыURL;
	
	ДанныеСериализации = ВыборкаДанныхСайтСервер.ПолучитьОписаниеСервиса(ПараметрыЗапроса.Получить("ИмяСервиса"));
	
	Если ДанныеСериализации = Неопределено Тогда
		Ответ.УстановитьТелоИзСтроки("Wrong service identifier");
		Ответ.КодСостояния = 400;
	Иначе
		Ответ.УстановитьТелоИзСтроки(ДанныеСериализации);
		Ответ.Заголовки.Вставить("Content-Type","application/json");
	КонецЕсли;
	
	Ответ.Заголовки.Вставить("Access-Control-Allow-Origin","*");
	
	Возврат Ответ;
КонецФункции

Функция СписокСервисовGET(Запрос) Экспорт
	Ответ = Новый HTTPСервисОтвет(200);
	
	//получаем данные
	ДанныеСериализации = Новый Массив;
	ПараметрыЗапроса = Запрос.ПараметрыURL;
	
	ДанныеСериализации = ВыборкаДанныхСайтСервер.ПолучитьСписокСервисов();
	
	РезультатJSON = Ответы.СериализоватьВJSON(ДанныеСериализации);
	Ответ.УстановитьТелоИзСтроки(РезультатJSON);
	Ответ.Заголовки.Вставить("Content-Type","application/json");
	
	Возврат Ответ;
КонецФункции

/////////////////////API///////////////////////
Функция ПолучитьСоединение()
	Соединение = Справочники.НастройкиAPI.ПолучитьСоединение(Перечисления.СервисыAPI.СлужбаДоставки);
	Возврат Соединение;
КонецФункции

Функция ПолучитьHTTPЗапрос(АдресРесурса, СтрокаПараметровЗапроса, ДобавитьПараметрыВТелоЗапроса = Ложь)
	HTTPЗапрос = Справочники.НастройкиAPI.ПолучитьHTTPЗапросПоимениМетода(Перечисления.СервисыAPI.СлужбаДоставки, АдресРесурса, СтрокаПараметровЗапроса, ДобавитьПараметрыВТелоЗапроса);
	
	Возврат HTTPЗапрос;
КонецФункции



// вспомагательные методы
Процедура ПолучитьПараметрыОтчета(ДанныеПользователя, ПараметрыЗапроса, Результат, Ошибка) Экспорт 
	Если ПараметрыЗапроса.Свойство("id_report")Тогда
		ИД_отчета = ПараметрыЗапроса["id_report"];
		ИДБлока = ПараметрыЗапроса["block"];
		Отчет = XMLЗначение(Тип("СправочникСсылка.ОтчетыЛичногоКабинета"), ИД_отчета);
		Если ЗначениеЗаполнено(Отчет) Тогда
			МакетБлока = ВыборкаДанныхСайтСервер.ПолучитьМакетБлокаПоИД(ИДБлока);
			Если Не МакетБлока.Пустая() Тогда
				Результат = МакетБлока.ПолучитьОбъект().ПолучитьТекстМакета(Новый Структура("ОбъектАвторизации, Отчет", ДанныеПользователя.ОбъектАвторизации, Отчет));
			Иначе
				Ошибка = "Ошибка с поиском макета блока страницы";
			КонецЕсли;
		Иначе
			Ошибка = "Не найден отчет по ИД - " + ИД_отчета;
		КонецЕсли;
	Иначе
		Ошибка = "Ошибка при передаче ИД отчета - нет ИД";
	КонецЕсли;
КонецПроцедуры



Процедура ПечатьПриемки(ДанныеПользователя, ПараметрыЗапроса, Ответ)
	//Если ПараметрыЗапроса.Получить("id_doc") <> Неопределено Тогда
	//	ИД = ПараметрыЗапроса.Получить("id_doc");
	//	ОснованиеПриемки = ВыборкаДанныхСайтСервер.ПолучитьОснованиеПриемки(ИД);
	//	Если Не ОснованиеПриемки.Пустая() Тогда
	//		ТабДок = Документы.ПеремещениеЗаказов.СформироватьАктПриемаПередачиНаКурьера(ОснованиеПриемки, Новый СписокЗначений);
	//		ИмяВременногоФайла = ПолучитьИмяВременногоФайла("html");
	//		ТабДок.Записать(ИмяВременногоФайла,ТипФайлаТабличногоДокумента.HTML5);
	//		ДД = Новый ДвоичныеДанные(ИмяВременногоФайла);
	//		
	//		Ответ.УстановитьТелоИзДвоичныхДанных(ДД);
	//		//Ответ.Заголовки.Вставить("Content-Type","application/pdf");
	//		Ответ.Заголовки.Вставить("Content-Type", "text/html; charset=utf-8");
	//	Иначе
	//		Ошибка = "Невозможно напечатать документ с ИД - " + ИД + "!";
	//		
	//		Ответ.УстановитьТелоИзСтроки(Ответы.ПолучитьHTMLПредставлениеОшибки(Ошибка));
	//		Ответ.Заголовки.Вставить("Content-Type", "text/html; charset=utf-8");
	//	КонецЕсли;
	//Иначе
	//	Ошибка = "Ошибка при передаче идентификатора акта приема-передачи - нет идентификатора";
	//	
	//	Ответ.УстановитьТелоИзСтроки(Ответы.ПолучитьHTMLПредставлениеОшибки(Ошибка));
	//	Ответ.Заголовки.Вставить("Content-Type", "text/html; charset=utf-8");
	//КонецЕсли;
	//
	//Ответ.Заголовки.Вставить("Title", "Печать приемки");
КонецПроцедуры

Процедура ПечатьЭтикеткиЗаказа(ДанныеПользователя, ПараметрыЗапроса, Ответ) Экспорт 
	//Если ПараметрыЗапроса.Получить("id") <> Неопределено Тогда
	//	Ид = ПараметрыЗапроса.Получить("id");
	//	Заказ = ВыборкаДанныхСайтСервер.ПолучитьЗаказПоИД(Ид);
	//	Если Не Заказ.Пустая() Тогда
	//		Если ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Заказ, "Поклажедатель") = ДанныеПользователя.Контрагент Тогда
	//			МассивОбъектов = Новый Массив; 
	//			МассивОбъектов.Добавить(Заказ);
	//			ОбъектыПечати = Новый СписокЗначений;
	//			ПараметрыПечати = Неопределено;
	//			ТабДок = Документы.ЗаказКлиента.СформироватьЭтикеткуЗаказа(МассивОбъектов, ОбъектыПечати, ПараметрыПечати);
	//			ИмяВременногоФайла = ПолучитьИмяВременногоФайла("html");
	//			ТабДок.Записать(ИмяВременногоФайла,ТипФайлаТабличногоДокумента.HTML5);
	//			ДД = Новый ДвоичныеДанные(ИмяВременногоФайла);
	//			
	//			Ответ.УстановитьТелоИзДвоичныхДанных(ДД);
	//			//Ответ.Заголовки.Вставить("Content-Type","application/pdf");
	//			Ответ.Заголовки.Вставить("Content-Type", "text/html; charset=utf-8");
	//		Иначе
	//			Ошибка = СтрШаблон("Заказ с ИД %1 не принадлежит %2!", ИД);
	//			
	//			Ответ.УстановитьТелоИзСтроки(Ответы.ПолучитьHTMLПредставлениеОшибки(Ошибка));
	//			Ответ.Заголовки.Вставить("Content-Type", "text/xml; charset=utf-8");
	//		КонецЕсли;
	//	Иначе
	//		Ошибка = СтрШаблон("Не найден заказ с ИД - %1!", ИД, ДанныеПользователя.ДанныеКонтрагента.Контрагент);
	//		
	//		Ответ.УстановитьТелоИзСтроки(Ответы.ПолучитьHTMLПредставлениеОшибки(Ошибка));
	//		Ответ.Заголовки.Вставить("Content-Type", "text/xml; charset=utf-8");
	//	КонецЕсли;
	//Иначе
	//	Ошибка = "Ошибка при передаче идентификатора заказа - нет идентификатора";
	//	
	//	Ответ.УстановитьТелоИзСтроки(Ответы.ПолучитьHTMLПредставлениеОшибки(Ошибка));
	//	Ответ.Заголовки.Вставить("Content-Type", "text/xml; charset=utf-8");
	//КонецЕсли;
КонецПроцедуры

Процедура ПечатьприходнойНакладной(ДанныеПользователя, ПараметрыЗапроса, Ответ)
	//Если ПараметрыЗапроса.Получить("id") <> Неопределено Тогда
	//	ИД = ПараметрыЗапроса.Получить("id");
	//	Закупка = ВыборкаДанныхСайтСервер.ПолучитьЗакупкуПоИД(ИД);
	//	Если Не Закупка.Пустая() Тогда
	//		МассивОбъектов = Новый Массив;
	//		МассивОбъектов.Добавить(Закупка);
	//		ТабДок = Документы.ПриобретениеТоваровУслуг.СформироватьПечатнуюФормуПриходнаяНакладная(МассивОбъектов, Новый СписокЗначений);
	//		ИмяВременногоФайла = ПолучитьИмяВременногоФайла("html");
	//		ТабДок.Записать(ИмяВременногоФайла,ТипФайлаТабличногоДокумента.HTML5);
	//		ДД = Новый ДвоичныеДанные(ИмяВременногоФайла);
	//		
	//		Ответ.УстановитьТелоИзДвоичныхДанных(ДД);
	//		//Ответ.Заголовки.Вставить("Content-Type","application/pdf");
	//		Ответ.Заголовки.Вставить("Content-Type", "text/html; charset=utf-8");
	//	Иначе
	//		Ошибка = "Невозможно напечатать документ с ИД - " + ИД + "!";
	//		
	//		Ответ.УстановитьТелоИзСтроки(Ответы.ПолучитьHTMLПредставлениеОшибки(Ошибка));
	//		Ответ.Заголовки.Вставить("Content-Type", "text/html; charset=utf-8");
	//	КонецЕсли;
	//Иначе
	//	Ошибка = "Ошибка при передаче идентификатора акта приема-передачи - нет идентификатора";
	//	
	//	Ответ.УстановитьТелоИзСтроки(Ответы.ПолучитьHTMLПредставлениеОшибки(Ошибка));
	//	Ответ.Заголовки.Вставить("Content-Type", "text/html; charset=utf-8");
	//КонецЕсли;
	//
	//Ответ.Заголовки.Вставить("Title", "Печать приемки");
КонецПроцедуры

//==============чтение файла из multi part form data===============
&НаСервере
Функция ПрочитатьСообщениеСФайлами(заголовки, тело)
	Результат = Новый Массив;
	
	Разделитель = ПолучитьРазделительСоставногоСообщения(заголовки);
	Маркеры = Новый Массив();
	Маркеры.Добавить(Разделитель);
	Маркеры.Добавить(Разделитель + Символы.ПС);
	Маркеры.Добавить(Разделитель + Символы.ВК);
	Маркеры.Добавить(Разделитель + Символы.ВК + Символы.ПС);
	Маркеры.Добавить(Разделитель + "--");
	Текст = Неопределено;
	Файл = Неопределено;
	
	ЧтениеДанных = Новый ЧтениеДанных(Тело);
	// Переходим к началу первой части
	ЧтениеДанных.ПропуститьДо(Маркеры);
	// Далее в цикле читаем все части
	Пока Истина Цикл
		Часть = чтениеДанных.ПрочитатьДо(Маркеры);
		Если Не Часть.МаркерНайден Тогда
			// Неправильно сформированное сообщение
			Прервать;
		КонецЕсли;
		ЧтениеЧасти = Новый ЧтениеДанных(Часть.ОткрытьПотокДляЧтения());
		ЗаголовкиЧасти = ПрочитатьЗаголовки(ЧтениеЧасти);
		ИмяЧасти = ПолучитьИмяСообщения(ЗаголовкиЧасти);
		Если ИмяЧасти <> Неопределено Тогда
			Файл = ЧтениеЧасти.Прочитать().ПолучитьДвоичныеДанные();
			
			Результат.Добавить(Новый Структура("ИмяФайла, Файл", ИмяЧасти, Файл));
		КонецЕсли;
		
		Если Часть.ИндексМаркера = 4 Тогда
			// Прочитали последнюю часть
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат; 
КонецФункции

&НаСервере
Функция ПрочитатьЗаголовки(Чтение)
	Заголовки = Новый Соответствие();
	Пока Истина Цикл
		Стр = Чтение.ПрочитатьСтроку();
		Если Стр = "" Тогда
			Прервать;
		КонецЕсли;
		Части = СтрРазделить(Стр, ":");
		ИмяЗаголовка = СокрЛП(Части[0]);
		Значение = СокрЛП(Части[1]);
		Заголовки.Вставить(ИмяЗаголовка, Значение);
	КонецЦикла;
	Возврат Заголовки;
КонецФункции

// Поиск строки-разделителя составного сообщения из заголовков
// Предполагается, что значение разделителя задается в заголовке
// Content-Type в следующем виде:
// Content-Type: multipart/form-data; boundary=<Разделитель>
&НаСервере
Функция ПолучитьРазделительСоставногоСообщения(Заголовки)
	ТипСодержимого = Заголовки.Получить("Content-Type");
	Свойства = СтрРазделить(ТипСодержимого, ";", Ложь);
	Граница = Неопределено;
	Для Каждого Свойство Из Свойства Цикл
		Части = СтрРазделить(Свойство, "=", Ложь);
		ИмяСвойства = СокрЛП(Части[0]);
		Если ИмяСвойства <> "boundary" Тогда
			Продолжить;
		КонецЕсли;
		Граница = СокрЛП(Части[1]);
		Прервать;
	КонецЦикла;
	Возврат Граница;
КонецФункции

// Имя сообщения получается из заголовка
// Content-Disposition
// Content-Disposition: form-data; name=<Имя сообщения>
&НаСервере
Функция ПолучитьИмяСообщения(Заголовки)
	Описание = Заголовки.Получить("Content-Disposition");
	Свойства = СтрРазделить(Описание, ";", Ложь);
	Имя = Неопределено;
	Для Каждого Свойство Из Свойства Цикл
		Части = СтрРазделить(Свойство, "=", Ложь);
		ИмяСвойства = СокрЛП(Части[0]);
		Если ИмяСвойства <> "filename" Тогда
			Продолжить;
		КонецЕсли;
		Имя = СтрЗаменить(СокрЛП(Части[1]), """", "");
		Прервать;
	КонецЦикла;
	Возврат Имя;
КонецФункции
//==============чтение файла из multi part form data===============
