﻿
Функция СформироватьJsonSwagger() Экспорт 
	Описание = Новый Соответствие;
	
	Если ЗначениеЗаполнено(ЭтотОбъект._description) Тогда
		Описание.Вставить("description", ЭтотОбъект._description);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ЭтотОбъект.summary) Тогда
		Описание.Вставить("summary", ЭтотОбъект.summary);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ЭтотОбъект.operationId) Тогда
		Описание.Вставить("operationId", ЭтотОбъект.operationId);
	КонецЕсли;
	
	Описание.Вставить("deprecated", ЭтотОбъект.deprecated);
	
	Если ЗначениеЗаполнено(ЭтотОбъект.externalDocs) Тогда
		Описание.Вставить("externalDocs", ОбщегоНазначенияSwagger.СформироватьОписаниеОбъектаSwagger(ЭтотОбъект.externalDocs));
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ЭтотОбъект.requestBody) Тогда
		Описание.Вставить("requestBody", ОбщегоНазначенияSwagger.СформироватьОписаниеОбъектаSwagger(ЭтотОбъект.requestBody));
	КонецЕсли;
	
	Если ЭтотОбъект.responses.Количество() > 0 Тогда
		Описание.Вставить("responses", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "responses", "statusCode", "response"));
	КонецЕсли;
	
	Если ЭтотОбъект.parameters.Количество() > 0 Тогда
		Описание.Вставить("parameters", ОбщегоНазначенияSwagger.СформироватьМассивИзТЧ(ЭтотОбъект, "parameters", "parameter"));
	КонецЕсли;
	
	Если ЭтотОбъект.servers.Количество() > 0 Тогда
		Описание.Вставить("servers", ОбщегоНазначенияSwagger.СформироватьМассивИзТЧ(ЭтотОбъект, "servers", "server"));
	КонецЕсли;
	
	Если ЭтотОбъект.security.Количество() > 0 Тогда
		Описание.Вставить("security", ОбщегоНазначенияSwagger.СформироватьМассивИзТЧ(ЭтотОбъект, "security", "securityRequirement"));
	КонецЕсли;
	
	Если ЭтотОбъект.callbacks.Количество() > 0 Тогда
		Описание.Вставить("callbacks", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "callbacks", "statusCode", "callback"));
	КонецЕсли;
	
	Если ЭтотОбъект.tags.Количество() > 0 Тогда
		Массив = Новый Массив;
		Для каждого ТекСтрока Из ЭтотОбъект.tags Цикл
			Массив.Добавить(Строка(ТекСтрока.tag));
		КонецЦикла;
		Описание.Вставить("tags", Массив);
	КонецЕсли;
	
	Возврат КоннекторHTTP.ОбъектВJson(Описание);
КонецФункции
