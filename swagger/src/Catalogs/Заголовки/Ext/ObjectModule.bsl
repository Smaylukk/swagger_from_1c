﻿
Функция СформироватьJsonSwagger() Экспорт 
	Описание = Новый Соответствие;
	
	Если ЗначениеЗаполнено(ЭтотОбъект._description) Тогда
		Описание.Вставить("description", ЭтотОбъект._description);
	КонецЕсли;
	
	Описание.Вставить("required", ЭтотОбъект.required);
	Описание.Вставить("deprecated", ЭтотОбъект.deprecated);
	
	Если ЗначениеЗаполнено(ЭтотОбъект.schema) Тогда
		Описание.Вставить("schema", ОбщегоНазначенияSwagger.СформироватьОписаниеОбъектаSwagger(ЭтотОбъект.schema));
	КонецЕсли;
	
	Возврат КоннекторHTTP.ОбъектВJson(Описание);
КонецФункции
