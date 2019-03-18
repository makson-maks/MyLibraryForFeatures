﻿
#Область Служебные_функции_и_процедуры

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,
		"ЯУдаляюВсеЭлементыДокумента(Парам01)",
		"ЯУдаляюВсеЭлементыДокумента",
		"И я удаляю все элементы Документа ""ПриходДенежныхСредств""",
		"",
		"");
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,
		"ЯОчищаюЗначениеКонстанты(Парам01)",
		"ЯОчищаюЗначениеКонстанты",
		"И я очищаю значение константы ""ПоследняяДатаРасчетаФактическогоОстаткаЛимита""",
		"",
		"");
	
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯУстанавливаюПараметрСеансаВЗначениеТипаБулево(Парам01,Парам02)","ЯУстанавливаюПараметрСеансаВЗначениеТипаБулево","И Я устанавливаю параметр сеанса ""РежимТестирования"" в значение типа булево ""Истина""","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯУстанавливаюПараметрСеансаВЗначениеТипаДата(Парам01,Парам02)","ЯУстанавливаюПараметрСеансаВЗначениеТипаДата","И Я устанавливаю параметр сеанса ""ДатаТестирования"" в значение типа дата ""20190311000000""","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯУстанавливаюЗначениеКонстантыВЗначение(Парам01,Парам02)","ЯУстанавливаюЗначениеКонстантыВЗначение","И Я устанавливаю значение константы ""РежимТестирования"" в значение ""Истина""","","");
	
	Возврат ВсеТесты;
	
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции

#КонецОбласти

#Область Работа_со_сценариями

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры

#КонецОбласти

///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И я удаляю все элементы Документа "ПриходДенежныхСредств"
//@ЯУдаляюВсеЭлементыДокумента(Парам01)
Процедура ЯУдаляюВсеЭлементыДокумента(ВидДокумента) Экспорт
	ЯУдаляюВсеЭлементыДокументаСервер(ВидДокумента);
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЯУдаляюВсеЭлементыДокументаСервер(ВидДокумента)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Документ1.Ссылка КАК Ссылка
		|ИЗ
		|	Документ.Документ1 КАК Документ1";

	Запрос.Текст = СтрЗаменить(Запрос.Текст, "Документ1", ВидДокумента);	
	Результат = Запрос.Выполнить();

	ВыборкаДетальныеЗаписи = Результат.Выбрать();

	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ДокОбъект = ВыборкаДетальныеЗаписи.Ссылка.ПолучитьОбъект();
		Попытка
			ДокОбъект.Удалить();
		Исключение
			Сообщить(ОписаниеОшибки());
		КонецПопытки;
	КонецЦикла;
	
КонецПроцедуры


&НаКлиенте
//И я очищаю значение константы "ПоследняяДатаРасчетаФактическогоОстаткаЛимита"
//@ЯОчищаюЗначениеКонстанты(Парам01)
Процедура ЯОчищаюЗначениеКонстанты(ИмяКонстанты) Экспорт
	ЯОчищаюЗначениеКонстантыСервер(ИмяКонстанты);
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЯОчищаюЗначениеКонстантыСервер(ИмяКонстанты)
	
	Константы.ПоследняяДатаРасчетаФактическогоОстаткаЛимита.Установить(Неопределено);
	
КонецПроцедуры


&НаКлиенте
//И Я устанавливаю параметр сеанса "РежимТестирования" в значение типа булево "Истина"
//@ЯУстанавливаюПараметрСеансаВЗначениеТипаБулево(Парам01,Парам02)
Процедура ЯУстанавливаюПараметрСеансаВЗначениеТипаБулево(ИмяПараметраСеанса, ЗначениеПараметраСеанса) Экспорт
	ЯУстанавливаюПараметрСеансаВЗначениеТипаБулевоСервер(ИмяПараметраСеанса, ЗначениеПараметраСеанса)
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЯУстанавливаюПараметрСеансаВЗначениеТипаБулевоСервер(ИмяПараметраСеанса, ЗначениеПараметраСеанса)
	
	Если НРег(ЗначениеПараметраСеанса) = "истина" Тогда
		ПараметрыСеанса[ИмяПараметраСеанса] = Истина;
	Иначе
		ПараметрыСеанса[ИмяПараметраСеанса] = Ложь;
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
//И Я устанавливаю параметр сеанса "ДатаТестирования" в значение типа дата "20190311000000"
//@ЯУстанавливаюПараметрСеансаВЗначениеТипаДата(Парам01,Парам02)
Процедура ЯУстанавливаюПараметрСеансаВЗначениеТипаДата(ИмяПараметраСеанса, ЗначениеПараметраСеанса) Экспорт
	ЯУстанавливаюПараметрСеансаВЗначениеТипаДатаСервер(ИмяПараметраСеанса, ЗначениеПараметраСеанса)
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЯУстанавливаюПараметрСеансаВЗначениеТипаДатаСервер(ИмяПараметраСеанса, ЗначениеПараметраСеанса)
	ПараметрыСеанса[ИмяПараметраСеанса] = Дата(ЗначениеПараметраСеанса);
КонецПроцедуры


//И Я устанавливаю значение константы "РежимТестирования" в значение "Истина"
//@ЯУстанавливаюЗначениеКонстантыВЗначение(Парам01,Парам02)
Процедура ЯУстанавливаюЗначениеКонстантыВЗначение(ИмяКонстанты, ЗначениеКонстанты) Экспорт
	ЯУстанавливаюЗначениеКонстантыВЗначениеСервер(ИмяКонстанты, ЗначениеКонстанты);
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЯУстанавливаюЗначениеКонстантыВЗначениеСервер(ИмяКонстанты, ЗначениеКонстанты)
	
	Если НРег(ЗначениеКонстанты) = "истина" Тогда
		ЗначениеКонстанты = Истина;
	ИначеЕсли НРег(ЗначениеКонстанты) = "ложь" Тогда
		ЗначениеКонстанты = Ложь;
	КонецЕсли;
	
	Константы[ИмяКонстанты].Установить(ЗначениеКонстанты);
	
КонецПроцедуры