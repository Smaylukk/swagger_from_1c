﻿
Функция СформироватьJsonSwagger() Экспорт 
	Описание = Новый Соответствие;
	Если ЗначениеЗаполнено(ЭтотОбъект.contentType) Тогда
		Описание.Вставить("contentType", ЭтотОбъект.contentType);
	КонецЕсли;
	Если ЗначениеЗаполнено(ЭтотОбъект.style) Тогда
		Описание.Вставить("style", ЭтотОбъект.style);
	КонецЕсли;
	
	
	Описание.Вставить("explode", ЭтотОбъект.explode);
	Описание.Вставить("allowReserved", ЭтотОбъект.allowReserved);
	
	Если ЭтотОбъект.headers.Количество() > 0 Тогда
		Описание.Вставить("headers", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "headers", "key", "header"));
	КонецЕсли;
	
	Возврат КоннекторHTTP.ОбъектВJson(Описание);
КонецФункции
