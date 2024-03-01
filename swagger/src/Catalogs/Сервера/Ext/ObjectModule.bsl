﻿
Функция СформироватьJsonSwagger() Экспорт 
	Описание = Новый Соответствие;
	
	Если ЗначениеЗаполнено(ЭтотОбъект._description) Тогда
		Описание.Вставить("description", ЭтотОбъект._description);
	КонецЕсли;
	
	Описание.Вставить("url", ЭтотОбъект.url);
	
	Если ЭтотОбъект.variables.Количество() > 0 Тогда
		Переменные = Новый Соответствие;
		Для каждого keyValue Из ЭтотОбъект.variables Цикл
			Переменная = Новый Соответствие;
			Переменная.Вставить("default", keyValue.default);
			
			Если ЗначениеЗаполнено(keyValue._description) Тогда
				Переменная.Вставить("description", keyValue._description);
			КонецЕсли;
			
			Если ЗначениеЗаполнено(keyValue.enum) Тогда
				Переменная.Вставить("enum", СтрРазделить(keyValue.enum, ",", Ложь));
			КонецЕсли;
			
			Переменные.Вставить(keyValue.key, Переменная);
		КонецЦикла;
		
		Описание.Вставить("variables", Переменные);
	КонецЕсли;
	
	Возврат КоннекторHTTP.ОбъектВJson(Описание);
КонецФункции
