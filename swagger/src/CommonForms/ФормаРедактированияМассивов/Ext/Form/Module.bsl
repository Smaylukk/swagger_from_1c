﻿
&НаКлиенте
Процедура Ок(Команда)
	Закрыть(Список.ВыгрузитьЗначения());
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Свойство("Массив") Тогда
		Список.ЗагрузитьЗначения(Параметры.Массив);
	КонецЕсли;
КонецПроцедуры
