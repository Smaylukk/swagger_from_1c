﻿
Функция СформироватьJsonSwagger() Экспорт 
	Описание = Новый Соответствие;
	
	Если ЭтотОбъект.schemas.Количество() > 0 Тогда
		Описание.Вставить("schemas", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "schemas", "name", "schema"));
	КонецЕсли;
	
	Если ЭтотОбъект.responses.Количество() > 0 Тогда
		Описание.Вставить("responses", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "responses", "name", "response"));
	КонецЕсли;
	
	Если ЭтотОбъект.parameters.Количество() > 0 Тогда
		Описание.Вставить("parameters", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "parameters", "name", "parameter"));
	КонецЕсли;
	
	Если ЭтотОбъект.examples.Количество() > 0 Тогда
		Описание.Вставить("examples", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "examples", "name", "example"));
	КонецЕсли;
	
	Если ЭтотОбъект.requestBodies.Количество() > 0 Тогда
		Описание.Вставить("requestBodies", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "requestBodies", "name", "requestBody"));
	КонецЕсли;
	
	Если ЭтотОбъект.headers.Количество() > 0 Тогда
		Описание.Вставить("headers", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "headers", "name", "header"));
	КонецЕсли;
	
	Если ЭтотОбъект.securitySchemes.Количество() > 0 Тогда
		Описание.Вставить("securitySchemes", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "securitySchemes", "name", "securityScheme"));
	КонецЕсли;
	
	Если ЭтотОбъект.links.Количество() > 0 Тогда
		Описание.Вставить("links", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "links", "name", "link"));
	КонецЕсли;
	
	Если ЭтотОбъект.callbacks.Количество() > 0 Тогда
		Описание.Вставить("callbacks", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "callbacks", "name", "callback"));
	КонецЕсли;
	
	Если ЭтотОбъект.pathItems.Количество() > 0 Тогда
		Описание.Вставить("pathItems", ОбщегоНазначенияSwagger.СформироватьСоответствиеИзТЧ(ЭтотОбъект, "pathItems", "name", "pathItem"));
	КонецЕсли;
	
	
	Возврат КоннекторHTTP.ОбъектВJson(Описание);
КонецФункции
