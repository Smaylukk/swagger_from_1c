﻿
&НаСервере
Процедура ЗаполнитьПараметрыНаСервере()
	Объект.ПараметрыОтчета.Очистить();
	
	ПараметрыОтчета = Новый Структура;
	ПараметрыОтчета.Вставить("СсылкаВарианта", Объект.ВариантОтчета.Ссылка);
	ПараметрыОтчета.Вставить("СсылкаОтчета", Объект.ВариантОтчета.Отчет);
	ПараметрыОтчета.Вставить("КлючВарианта", Объект.ВариантОтчета.КлючВарианта);
	ПараметрыОтчета.Вставить("ИдентификаторФормы", Неопределено);
	Отчет = ВариантыОтчетов.ПодключитьОтчетИЗагрузитьНастройки(ПараметрыОтчета);
	
	Для каждого ЭлементКД Из Отчет.НастройкиКД.ПараметрыДанных.Элементы Цикл
		Если ТипЗнч(ЭлементКД) = Тип("ЗначениеПараметраНастроекКомпоновкиДанных") И ЭлементКД.Использование = Истина Тогда
			НоваяСтрока = Объект.ПараметрыОтчета.Добавить();
			НоваяСтрока.ИмяПараметра = Строка(ЭлементКД.Параметр);
			НоваяСтрока.Представление = ЭлементКД.ПредставлениеПользовательскойНастройки ;
			НоваяСтрока.Идентификатор = ЭлементКД.ИдентификаторПользовательскойНастройки ;
		КонецЕсли;
	КонецЦикла;
		
	а = 1;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПараметры(Команда)
	ЗаполнитьПараметрыНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
КонецПроцедуры

