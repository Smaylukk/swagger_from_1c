﻿
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	//Вставить содержимое обработчика.
	Текст = ПроверитьНаСервере(ПараметрКоманды);
	ТекстДок = Новый ТекстовыйДокумент;
	ТекстДок.УстановитьТекст(Текст);
	ТекстДок.Показать();
КонецПроцедуры

&НаСервере
Функция ПроверитьНаСервере(Ссылка)
	Возврат Ссылка.ПолучитьОбъект().СформироватьJsonSwagger();
КонецФункции
