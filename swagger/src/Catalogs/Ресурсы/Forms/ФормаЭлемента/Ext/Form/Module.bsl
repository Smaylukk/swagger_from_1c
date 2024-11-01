﻿


&НаКлиенте
Процедура ЗагрузитьФайл(Команда)
	ОО = Новый ОписаниеОповещения("ПослеПомещенияФайла", ЭтотОбъект);
	НачатьПомещениеФайла(ОО, , , Истина, УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ПослеПомещенияФайла(Результат, Адрес, ИмяФайла, ДопПараметры) Экспорт
	Если Результат Тогда
		АдресФайла = Адрес;
		Модифицированность = Истина;
		Файл = Новый Файл(ИмяФайла);
		Объект.Наименование = Файл.Имя;
		
		Если Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Файл") Тогда
			Если Объект.ТекстовыйФайл Тогда
				АдресТекста = ИзвлечьТекст(АдресФайла);
				Если ЭтоАдресВременногоХранилища(АдресТекста) Тогда
					Объект.Текст = ПолучитьИзВременногоХранилища(АдресТекста);
				КонецЕсли;
			КонецЕсли;
		ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Скрипт") Тогда
			Если Объект.ТекстовыйФайл Тогда
				АдресТекста = ИзвлечьТекст(АдресФайла);
				Если ЭтоАдресВременногоХранилища(АдресТекста) Тогда
					Объект.Текст = ПолучитьИзВременногоХранилища(АдресТекста);
					РедакторКлиент.ЗагрузитьТекстВРедактор(Монако(), Объект.Текст);
				КонецЕсли;
			КонецЕсли;
		ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Стиль") Тогда
			АдресТекста = ИзвлечьТекст(АдресФайла);
			Если ЭтоАдресВременногоХранилища(АдресТекста) Тогда
				Объект.Текст = ПолучитьИзВременногоХранилища(АдресТекста);
				РедакторКлиент.ЗагрузитьТекстВРедактор(Монако(), Объект.Текст);
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ИзвлечьТекст(АдресФайла)
	АдресТекста = Неопределено;
	Если ЭтоАдресВременногоХранилища(АдресФайла) Тогда 
		ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресФайла);
		Если ДвоичныеДанные <> Неопределено Тогда
			ИмяВремФайла = ПолучитьИмяВременногоФайла("tmp");
			ДвоичныеДанные.Записать(ИмяВремФайла);
			
			ТД = Новый ТекстовыйДокумент;
			ТД.Прочитать(ИмяВремФайла, КодировкаТекста.UTF8);
			АдресТекста = ПоместитьВоВременноеХранилище(ТД.ПолучитьТекст());
			
			УдалитьФайлы(ИмяВремФайла);
		КонецЕсли;
	КонецЕсли;
	Возврат АдресТекста;
КонецФункции

&НаКлиенте
Процедура ВставитьИзбражение(Команда)
	ОО = Новый ОписаниеОповещения("ПослеВыбораИзображения", ЭтотОбъект);
	П = Новый Структура;
	Отбор = Новый Структура("ВидРесурса", ПредопределенноеЗначение("Перечисление.ВидыРесурса.Изображение"));
	П.Вставить("Отбор", Отбор);
	ОткрытьФорму("Справочник.Ресурсы.ФормаВыбора", П, ЭтаФорма, , , , ОО, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Функция ПослеВыбораИзображения(РезультатВыбора, ДополнительныеПараметры) экспорт
	Если РезультатВыбора <> Неопределено Тогда
		ТекстСсылкиНаРесурс = УправлениеКонтентом.ПолучитьПредставлениеРесурсаНаСервере(РезультатВыбора);
		Если Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Стиль") Или Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Скрипт") Тогда
			РедакторКлиент.УстановитьТекстМонако(Монако(), ТекстСсылкиНаРесурс);
		ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Файл") Тогда
			Элементы.ТекстФайл.ВыделенныйТекст = ТекстСсылкиНаРесурс;
		КонецЕсли;
	КонецЕсли;
КонецФункции

&НаКлиенте
Процедура ЭкспортЛокально(Команда)
	НастройкаЭкспорта = УправлениеКонтентом.ПолучитьНастройкиЭкспортаОбъекта(ПредопределенноеЗначение("Перечисление.HTMLОбъекты.Стили"));
	Если НастройкаЭкспорта = Неопределено  Тогда
		ОО = Новый ОписаниеОповещения("ПослеВыбораКаталогаДляЭкспорта", ЭтотОбъект, Объект.Ссылка);
		
		ДВФ = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
		ДВФ.Показать(ОО);
	ИначеЕсли ПустаяСтрока(НастройкаЭкспорта.Сетевойкаталог) Тогда
		ОО = Новый ОписаниеОповещения("ПослеВыбораКаталогаДляЭкспорта", ЭтотОбъект, Объект.Ссылка);
		
		ДВФ = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
		ДВФ.Показать(ОО);
	Иначе
		ТекстОшибки = ""; 
		Каталог = НастройкаЭкспорта.Сетевойкаталог; 
		МассивСсылок = Новый Массив; МассивСсылок.Добавить(Объект.Ссылка);
		Если УправлениеКонтентомКлиент.ЭкспортСтилейВлокальныйКаталог(ТекстОшибки, Каталог, Ложь, МассивСсылок) Тогда
			Прочитать();
		Иначе
			ПоказатьПредупреждение(, ТекстОшибки);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораКаталогаДляЭкспорта(Результат, ДопПараметры) Экспорт 
	Если Результат <> Неопределено Тогда
		Если Не ПустаяСтрока(Результат[0]) Тогда
			ТекстОшибки = ""; 
			Каталог = Результат[0]; 
			МассивСсылок = Новый Массив; МассивСсылок.Добавить(ДопПараметры);
			Если УправлениеКонтентомКлиент.ЭкспортСтилейВлокальныйКаталог(ТекстОшибки, Каталог, Ложь, МассивСсылок) Тогда
				Прочитать();
			Иначе
				ПоказатьПредупреждение(, ТекстОшибки);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВставитьФайл(Команда)
	ОО = Новый ОписаниеОповещения("ПослеВыбораФайла", ЭтотОбъект);
	П = Новый Структура;
	Отбор = Новый Структура("ВидРесурса", ПредопределенноеЗначение("Перечисление.ВидыРесурса.Файл"));
	П.Вставить("Отбор", Отбор);
	ОткрытьФорму("Справочник.Ресурсы.ФормаВыбора", П, ЭтаФорма, , , , ОО, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Функция ПослеВыбораФайла(РезультатВыбора, ДополнительныеПараметры) экспорт
	Если РезультатВыбора <> Неопределено Тогда
		ТекстСсылкиНаРесурс = УправлениеКонтентом.ПолучитьПредставлениеРесурсаНаСервере(РезультатВыбора);
		Если Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Стиль") Или Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Скрипт") Тогда
			Если РежимВебКлиента Тогда
				Элементы.ТекстОбычный.ВыделенныйТекст = ТекстСсылкиНаРесурс;
			Иначе
				РедакторКлиент.УстановитьТекстМонако(Монако(), ТекстСсылкиНаРесурс);
			КонецЕсли;
			
		ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Файл") Тогда
			Элементы.ТекстФайл.ВыделенныйТекст = ТекстСсылкиНаРесурс;
		КонецЕсли;
	КонецЕсли;
КонецФункции

&НаКлиенте
Процедура ПослеВыбораПеременной(ВыбранныйЭлемент, ДопПараметры) Экспорт
	Если ВыбранныйЭлемент <> Неопределено Тогда
		ТекстСсылки = ВыбранныйЭлемент.Значение;
		Если Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Стиль") Или Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Скрипт") Тогда
			РедакторКлиент.УстановитьТекстМонако(Монако(), ТекстСсылки);
		ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Файл") Тогда
			Элементы.ТекстФайл.ВыделенныйТекст = ТекстСсылки;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВставитьСсылку(Команда)
	СписокПеременных = Ответы.ПолучитьСписокСсылок();
	
	ОО = Новый ОписаниеОповещения("ПослеВыбораПеременной", ЭтотОбъект);
	ПоказатьВыборИзМеню(ОО, СписокПеременных, Элементы.ВставитьСсылку); 
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзображение(Команда)
	ОО = Новый ОписаниеОповещения("ПослеПомещенияФайлаИзображения", ЭтотОбъект);
	НачатьПомещениеФайла(ОО, , , Истина, УникальныйИдентификатор);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеПомещенияФайлаИзображения(Результат, Адрес, ИмяФайла, ДопПараметры) Экспорт
	Если Результат Тогда
		АдресФайла = Адрес;
		Модифицированность = Истина;
		Файл = Новый Файл(ИмяФайла);
		Объект.Наименование = Файл.Имя;
		
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТекстовыйФайлПриИзменении(Элемент)
	Если Объект.ТекстовыйФайл Тогда
		АдресФайла = ПоместитьФайлВоВременноеХранилище();
		
		АдресТекста = ИзвлечьТекст(АдресФайла);
		Если ЭтоАдресВременногоХранилища(АдресТекста) Тогда
			Объект.Текст = ПолучитьИзВременногоХранилища(АдресТекста);
		КонецЕсли;
	Иначе
		Объект.Текст = "";
	КонецЕсли;
	
	УстановитьВидимость();
КонецПроцедуры

&НаСервере
Функция ПоместитьФайлВоВременноеХранилище()
	Возврат РеквизитФормыВЗначение("Объект").ПоместитьФайлВоВременноеХранилище();
КонецФункции

&НаКлиенте
Процедура УстановитьВидимость()
	Элементы.ГруппаДоступКФайлу.ТекущаяСтраница = Элементы.ГруппаФайл;
	Если Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.ПустаяСсылка") Тогда
		Элементы.ГруппаВидРесурса.ТекущаяСтраница = элементы.СтраницаПустая;
	ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Изображение") Тогда
		Элементы.ГруппаВидРесурса.ТекущаяСтраница = элементы.СтраницаИзображение;
	ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Стиль") Тогда
		Элементы.ГруппаВидРесурса.ТекущаяСтраница = элементы.СтраницаСтильСкрипт;
		Элементы.ГруппаТекстСтильСкрипт.Видимость = Объект.ТекстовыйФайл;
	ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Скрипт") Тогда
		Элементы.ГруппаВидРесурса.ТекущаяСтраница = элементы.СтраницаСтильСкрипт;
		Элементы.ГруппаТекстСтильСкрипт.Видимость = Объект.ТекстовыйФайл;
		//Элементы.ГруппаВидРесурса.ТекущаяСтраница = элементы.СтраницаСкрипт;
		//Элементы.ГруппаТекстСкрипт.Видимость = Объект.ТекстовыйФайл;
	ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Файл") Тогда
		Элементы.ГруппаВидРесурса.ТекущаяСтраница = элементы.СтраницаФайл;
		
		Элементы.ТекстФайл.Видимость = Объект.ТекстовыйФайл;
	КонецЕсли;
		
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Состояние("Инициализация...");
	#Если ВебКлиент Тогда
		РежимВебКлиента = Истина;
	#иначе
		РежимВебКлиента = Ложь;
	#КонецЕсли
	
	Если РежимВебКлиента Тогда
		Элементы.ГруппаРедактор.ТекущаяСтраница = Элементы.ГруппаРедакторОбычный;
	Иначе
		Элементы.ГруппаРедактор.ТекущаяСтраница = Элементы.ГруппаРедакторМонако;
	КонецЕсли;
	
	Если Не РежимВебКлиента Тогда
		РедакторКлиент.ИзвлечьИсходники(АдресМакета, ЭтотОбъект);
	КонецЕсли;
	
	УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура ВидРесурсаПриИзменении(Элемент)
	ОчиститьДанные();
	УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьДанные()
	АдресФайла = "";
	Объект.Текст = "";
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ЭтоАдресВременногоХранилища(АдресФайла) Тогда 
		ДвоичныеДанные = ПолучитьИзВременногоХранилища(АдресФайла);
		ТекущийОбъект.Файл = Новый ХранилищеЗначения(ДвоичныеДанные, Новый СжатиеДанных());
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	АдресФайла = ПолучитьНавигационнуюСсылку(ТекущийОбъект.Ссылка, "Файл");
	//АдресКартинки = ПолучитьНавигационнуюСсылку(ТекущийОбъект.Ссылка, "Изображение");
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ЭтоАдресВременногоХранилища(АдресФайла) Тогда 
		УдалитьИзВременногоХранилища(АдресФайла);
	КонецЕсли;
	АдресФайла = ПолучитьНавигационнуюСсылку(ТекущийОбъект.Ссылка, "Файл");

	//Если ЭтоАдресВременногоХранилища(АдресКартинки) Тогда 
	//	УдалитьИзВременногоХранилища(АдресКартинки);
	//КонецЕсли;
	//АдресКартинки = ПолучитьНавигационнуюСсылку(ТекущийОбъект.Ссылка, "Изображение");
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	АдресМакета = ПоместитьВоВременноеХранилище(ПолучитьОбщийМакет("monaco"));
КонецПроцедуры

&НаКлиенте
Функция Монако()
	Возврат Элементы.ТекстСтильСкрипт.Документ.defaultView;
КонецФункции

&НаКлиенте
Функция Editor()
	Возврат Элементы.ТекстСтильСкрипт.Документ.monaco.editor;
КонецФункции

&НаКлиенте
Процедура ОбработкаИнициализации(Результат, ДопПараметры) Экспорт
	HTML = ДопПараметры.КаталогИсходников + "index.html";
	
	РедакторРаспакован = истина;
КонецПроцедуры

&НаКлиенте
Процедура ОшибкаИнициализацииРедактора(ТекстОшибки)
	ПоказатьПредупреждение(, ТекстОшибки);
КонецПроцедуры

&НаКлиенте
Процедура ТекстСтильДокументСформирован(Элемент)
	Если РедакторРаспакован 
		И (Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Стиль") 
			Или Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Скрипт")) Тогда
			
		Если Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Стиль") Тогда
			КодЯзыка = "css";
		ИначеЕсли Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Скрипт") Тогда
			КодЯзыка= "javascript";
		Иначе
			КодЯзыка= "";
		КонецЕсли;
		РедакторКлиент.ИнициализироватьРедакторMonaco(Монако(), КодЯзыка);
		РедакторКлиент.ЗагрузитьТекстВРедактор(Монако(), Объект.Текст);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТекстСтильПриИзменении(Элемент)
	ЭтаФорма.Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ТекстСкриптПриИзменении(Элемент)
	ЭтаФорма.Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Если Не ЗавершениеРаботы Тогда
		Если Объект.ТекстовыйФайл И 
			(Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Стиль") Или Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Скрипт")) Тогда
			Если Объект.Текст <> РедакторКлиент.ПолучитьТекстМонако(Монако()) Тогда
				Объект.Текст = РедакторКлиент.ПолучитьТекстМонако(Монако());
				ЭтаФорма.Модифицированность = Истина;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	Если Объект.ТекстовыйФайл И 
		(Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Стиль") Или Объект.ВидРесурса = ПредопределенноеЗначение("Перечисление.ВидыРесурса.Скрипт")) Тогда
		ТекстМонако = РедакторКлиент.ПолучитьТекстМонако(Монако());
		Если Объект.Текст <> ТекстМонако Тогда
			Объект.Текст = ТекстМонако;
			ЭтаФорма.Модифицированность = Истина;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВставитьТекст(Команда)
	ОО = Новый ОписаниеОповещения("ПослеВводаТекста", ЭтотОбъект);
	ПоказатьВводСтроки(ОО, "", , , Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПослеВводаТекста(Текст, ДопПараметры) Экспорт 
	Если Текст <> Неопределено Тогда
		РедакторКлиент.УстановитьТекстМонако(Монако(), Объект.Текст);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьТекст(Команда)
	Текст = РедакторКлиент.ПолучитьВыделенныйТекстМонако(Монако());
	ОчиститьСообщения();
	Сообщить(Текст);
КонецПроцедуры

&НаКлиенте
Процедура СтильТекстовыйФайлПриИзменении(Элемент)
	Если Объект.ТекстовыйФайл Тогда
		АдресФайла = ПоместитьФайлВоВременноеХранилище();
		
		АдресТекста = ИзвлечьТекст(АдресФайла);
		Если ЭтоАдресВременногоХранилища(АдресТекста) Тогда
			Объект.Текст = ПолучитьИзВременногоХранилища(АдресТекста);
			
			//РедакторКлиент.УстановитьТекстМонако(Монако(), Объект.Текст);
		КонецЕсли;
	Иначе
		Объект.Текст = "";
	КонецЕсли;
	
	
	УстановитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура EditorСтандартныеКоманды(Команда)
	Соответствие = New Соответствие;
	Соответствие.Вставить("ClipboardCut", "editor.action.clipboardCutAction");
	Соответствие.Вставить("ClipboardCopy", "editor.action.clipboardCopyAction");
	Соответствие.Вставить("ClipboardPaste", "editor.action.clipboardPasteAction");
	Соответствие.Вставить("EditFind", "actions.find");
	Соответствие.Вставить("EditFindNext", "editor.action.nextMatchFindAction");
	Соответствие.Вставить("EditFindPrevious", "editor.action.previousMatchFindAction");
	Соответствие.Вставить("EditUndo", "undo");
	Соответствие.Вставить("EditRedo", "redo");
	Соответствие.Вставить("EditReplace", "editor.action.startFindReplaceAction");
	ИмяКоманды = СтрЗаменить(Команда.Имя, "Editor", "");
	
	
	Элементы.ТекстСтильСкрипт.Документ.defaultView.editor.trigger("", Соответствие[ИмяКоманды]);
КонецПроцедуры