﻿
// Функция возвращает объект (соответствие, массив или значение примитивного типа)
//  из переданой ссылка на объект
// Параметры (название, тип, дифференцированное значение)
//  СсылкаНаОбъект - СправочникСсылка
// Возвращаемое значение: 
//  Соответствие, Массив или значение примитивного типа
Функция СформироватьОписаниеОбъектаSwagger(СсылкаНаОбъект) Экспорт 
	Возврат КоннекторHTTP.JsonВОбъект(СсылкаНаОбъект.ПолучитьОбъект().СформироватьJsonSwagger());
КонецФункции

// Функция возвращает объект (соответствие, массив или значение примитивного типа)
//  из переданого текста json
// Параметры (название, тип, дифференцированное значение)
//  JSON - Строка
// Возвращаемое значение: 
//  Соответствие, Массив или значение примитивного типа
Функция СформироватьОбъектаНаОснованииJSON(JSON) Экспорт 
	Возврат КоннекторHTTP.JsonВОбъект(JSON);
КонецФункции

// Функция формирует соответствие из ТЧ переданого объекта
//
// Параметры (название, тип, дифференцированное значение)
//   Объект - СпрочникОбъект
//   ИмяТЧ - Строка
//   ИмяКолонкиКлюч - Строка
//   ИмяКолонкиЗначение - Строка
// Возвращаемое значение: 
//  Соответствие
Функция СформироватьСоответствиеИзТЧ(Объект, ИмяТЧ, ИмяКолонкиКлюч, ИмяКолонкиЗначение) Экспорт 
	Соответствие = Новый Соответствие;
	Для каждого keyValue Из Объект[ИмяТЧ] Цикл
		Соответствие.Вставить(keyValue[ИмяКолонкиКлюч], СформироватьОписаниеОбъектаSwagger(keyValue[ИмяКолонкиЗначение]));
	КонецЦикла;
	
	Возврат Соответствие;
КонецФункции

// Функция формирует Массив из ТЧ переданого объекта
//
// Параметры (название, тип, дифференцированное значение)
//   Объект - СпрочникОбъект
//   ИмяТЧ - Строка
//   ИмяКолонки - Строка
// Возвращаемое значение: 
//   Массив
Функция СформироватьМассивИзТЧ(Объект, ИмяТЧ, ИмяКолонки) Экспорт 
	Массив = Новый Массив;
	Для каждого ТекСтрока Из Объект[ИмяТЧ] Цикл
		Массив.Добавить(СформироватьОписаниеОбъектаSwagger(ТекСтрока[ИмяКолонки]));
	КонецЦикла;
	
	Возврат Массив;
КонецФункции
