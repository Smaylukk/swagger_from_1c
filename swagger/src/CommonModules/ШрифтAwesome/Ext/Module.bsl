
///////////////////////////////////////////////////////////
// КОНВЕРТАЦИЯ
///////////////////////////////////////////////////////////

// Перевод в десятичную систему
// взята отсюда: http://infostart.ru/public/95428/
//
Функция ИзХСчислВЧисло(аф,Шаблон="0123456789ABCDEF")
    аф = ВРег(аф); // на всякий случай.
    ДлинаШаблона = СтрДлина(Шаблон);

    ДлинаСтроки = СтрДлина(аф);
    Результат = 0;

    Для ТекСимвол = 1 По ДлинаСтроки Цикл
        ОбрабатываемыйСимвол = Сред(аф, ТекСимвол,1);
        ПозицияВШаблоне = Найти(Шаблон,ОбрабатываемыйСимвол)-1;
        Результат = Результат * ДлинаШаблона + ПозицияВШаблоне;
    КонецЦикла;

    Возврат(Результат);

КонецФункции

// Очистка от символов, которых нет в 16-й системе
Функция Только16(Знач Стр16)

	Результат="";
	ДлинаСтроки=СтрДлина(Стр16);
	Для Индекс=1 По ДлинаСтроки Цикл
		
		ТекСимвол16=Сред(Стр16,Индекс,1);
		ТекСимвол16Код=КодСимвола(ТекСимвол16);
		
		// от 0 до 9, от A до F
		Если (ТекСимвол16Код>47 И ТекСимвол16Код<58) ИЛИ (ТекСимвол16Код>64 И ТекСимвол16Код<71) Тогда
			Результат=Результат+ТекСимвол16;
		КонецЕсли; 
	
	КонецЦикла; 
	
	Возврат Результат;

КонецФункции
 
Функция HTMLHexdec2Dec(Знач HTMLHex)

	Dec=0;
	Если ЗначениеЗаполнено(HTMLHex) Тогда
	
		HTMLHex=ВРег(HTMLHex);
		HTMLHex=СтрЗаменить(HTMLHex,"X","0");
		HTMLHex=СтрЗаменить(HTMLHex,"U","0");
		HTMLHex=Только16(HTMLHex);
		Dec=ИзХСчислВЧисло(HTMLHex);
	
	КонецЕсли; 
	
	Возврат Dec; 

КонецФункции
 

///////////////////////////////////////////////////////////
// ФУНКЦИИ ОБЩЕГО МОДУЛЯ "ШРИФТЫ"
///////////////////////////////////////////////////////////

Функция ПолучитьКартуШрифта()
	
	Ключи="adjust ,adn ,align_center ,align_justify ,align_left ,align_right ,ambulance ,anchor ,android ,angellist ,angle_double_down ,angle_double_left ,
	|angle_double_right ,angle_double_up ,angle_down ,angle_left ,angle_right ,angle_up ,apple ,archive ,area_chart ,arrow_circle_down ,arrow_circle_left,
	|arrow_circle_o_down ,arrow_circle_o_left ,arrow_circle_o_right ,arrow_circle_o_up ,arrow_circle_right ,arrow_circle_up ,arrow_down ,arrow_left,
	|arrow_right ,arrow_up ,arrows ,arrows_alt ,arrows_h ,arrows_v ,asterisk ,at ,automobile_alias ,backward ,ban ,bank_alias ,bar_chart,
	|bar_chart_o_alias ,barcode ,bars ,beer ,behance ,behance_square ,bell ,bell_o ,bell_slash ,bell_slash_o ,bicycle ,binoculars ,birthday_cake ,
	|bitbucket ,bitbucket_square ,bitcoin_alias ,bold ,bolt ,bomb ,book ,bookmark ,bookmark_o ,briefcase ,btc ,bug ,building ,building_o ,bullhorn ,
	|bullseye ,bus ,cab_alias ,calculator ,calendar ,calendar_o ,camera ,camera_retro ,car ,caret_down ,caret_left ,caret_right ,caret_square_o_down ,
	|caret_square_o_left ,caret_square_o_right ,caret_square_o_up ,caret_up ,cc ,cc_amex ,cc_discover ,cc_mastercard ,cc_paypal ,cc_stripe ,cc_visa,
	|certificate ,chain_alias ,chain_broken ,check ,check_circle ,check_circle_o ,check_square ,check_square_o ,chevron_circle_down ,chevron_circle_left ,
	|chevron_circle_right ,chevron_circle_up ,chevron_down ,chevron_left ,chevron_right ,chevron_up ,child ,circle ,circle_o ,circle_o_notch ,circle_thin ,
	|clipboard ,clock_o ,close_alias ,cloud ,cloud_download ,cloud_upload ,cny_alias ,code ,code_fork ,codepen ,coffee ,cog ,cogs ,columns ,comment ,
	|comment_o ,comments ,comments_o ,compass ,compress ,copy_alias ,copyright ,credit_card ,crop ,crosshairs ,css3 ,cube ,cubes ,cut_alias ,cutlery ,
	|dashboard_alias ,database ,dedent_alias ,delicious ,desktop ,deviantart ,digg ,dollar_alias ,dot_circle_o ,download ,dribbble ,dropbox ,drupal ,
	|edit_alias ,eject ,ellipsis_h ,ellipsis_v ,empire ,envelope ,envelope_o ,envelope_square ,eraser ,eur ,euro_alias ,exchange ,exclamation ,
	|exclamation_circle ,exclamation_triangle ,expand ,external_link ,external_link_square ,eye ,eye_slash ,eyedropper ,facebook ,facebook_square ,
	|fast_backward ,fast_forward ,fax ,female ,fighter_jet ,file ,file_archive_o ,file_audio_o ,file_code_o ,file_excel_o ,file_image_o ,
	|file_movie_o_alias ,file_o ,file_pdf_o ,file_photo_o_alias ,file_picture_o_alias ,file_powerpoint_o ,file_sound_o_alias ,file_text ,
	|file_text_o ,file_video_o ,file_word_o ,file_zip_o_alias ,files_o ,film ,filter ,fire ,fire_extinguisher ,flag ,flag_checkered ,flag_o ,flash_alias ,
	|flask ,flickr ,floppy_o ,folder ,folder_o ,folder_open ,folder_open_o ,font ,forward ,foursquare ,frown_o ,futbol_o ,gamepad ,gavel ,gbp ,ge_alias ,
	|gear_alias ,gears_alias ,gift ,git ,git_square ,github ,github_alt ,github_square ,gittip ,glass ,globe ,google ,google_plus ,google_plus_square ,
	|google_wallet ,graduation_cap ,group_alias ,h_square ,hacker_news ,hand_o_down ,hand_o_left ,hand_o_right ,hand_o_up ,hdd_o ,header ,headphones,
	|heart ,heart_o ,history ,home ,hospital_o ,html5 ,ils ,image_alias ,inbox ,indent ,info ,info_circle ,inr ,instagram ,institution_alias ,ioxhost ,
	|italic ,joomla ,jpy ,jsfiddle ,key ,keyboard_o ,krw ,language ,laptop ,lastfm ,lastfm_square ,leaf ,legal_alias ,lemon_o ,level_down ,level_up ,
	|life_bouy_alias ,life_buoy_alias ,life_ring ,life_saver_alias ,lightbulb_o ,line_chart ,link ,linkedin ,linkedin_square ,linux ,list ,list_alt ,
	|list_ol ,list_ul ,location_arrow ,lock ,long_arrow_down ,long_arrow_left ,long_arrow_right ,long_arrow_up ,magic ,magnet ,mail_forward_alias ,
	|mail_reply_alias ,mail_reply_all_alias ,male ,map_marker ,maxcdn ,meanpath ,medkit ,meh_o ,microphone ,microphone_slash ,minus ,minus_circle ,
	|minus_square ,minus_square_o ,mobile ,mobile_phone_alias ,money ,moon_o ,mortar_board_alias ,music ,navicon_alias ,newspaper_o ,openid ,
	|outdent ,pagelines ,paint_brush ,paper_plane ,paper_plane_o ,paperclip ,paragraph ,paste_alias ,pause ,paw ,paypal ,pencil ,pencil_square ,
	|pencil_square_o ,phone ,phone_square ,photo_alias ,picture_o ,pie_chart ,pied_piper ,pied_piper_alt ,pinterest ,pinterest_square ,plane ,play ,
	|play_circle ,play_circle_o ,plug ,plus ,plus_circle ,plus_square ,plus_square_o ,power_off ,print ,puzzle_piece ,qq ,qrcode ,question ,question_circle ,
	|quote_left ,quote_right ,ra_alias ,random ,rebel ,recycle ,reddit ,reddit_square ,refresh ,remove_alias ,renren ,reorder_alias ,repeat ,reply ,
	|reply_all ,retweet ,rmb_alias ,road ,rocket ,rotate_left_alias ,rotate_right_alias ,rouble_alias ,rss ,rss_square ,rub ,ruble_alias ,rupee_alias ,
	|save_alias ,scissors ,search ,search_minus ,search_plus ,send_alias ,send_o_alias ,share ,share_alt ,share_alt_square ,share_square ,share_square_o ,
	|shekel_alias ,sheqel_alias ,shield ,shopping_cart ,sign_in ,sign_out ,signal ,sitemap ,skype ,slack ,sliders ,slideshare ,smile_o ,
	|soccer_ball_o_alias ,sort ,sort_alpha_asc ,sort_alpha_desc ,sort_amount_asc ,sort_amount_desc ,sort_asc ,sort_desc ,sort_down_alias ,
	|sort_numeric_asc ,sort_numeric_desc ,sort_up_alias ,soundcloud ,space_shuttle ,spinner ,spoon ,spotify ,square ,square_o ,stack_exchange ,
	|stack_overflow ,star ,star_half ,star_half_empty_alias ,star_half_full_alias ,star_half_o ,star_o ,steam ,steam_square ,step_backward ,
	|step_forward ,stethoscope ,stop ,strikethrough ,stumbleupon ,stumbleupon_circle ,subscript ,suitcase ,sun_o ,superscript ,support_alias ,table ,
	|tablet ,tachometer ,tag ,tags ,tasks ,taxi ,tencent_weibo ,terminal ,text_height ,text_width ,th ,th_large ,th_list ,thumb_tack ,thumbs_down ,
	|thumbs_o_down ,thumbs_o_up ,thumbs_up ,ticket ,times ,times_circle ,times_circle_o ,tint ,toggle_down_alias ,toggle_left_alias ,toggle_off ,
	|toggle_on ,toggle_right_alias ,toggle_up_alias ,trash ,trash_o ,tree ,trello ,trophy ,truck ,try ,tty ,tumblr ,tumblr_square ,turkish_lira_alias ,
	|twitch ,twitter ,twitter_square ,umbrella ,underline ,undo ,university ,unlink_alias ,unlock ,unlock_alt ,unsorted_alias ,upload ,usd ,user ,user_md ,
	|users ,video_camera ,vimeo_square ,vine ,vk ,volume_down ,volume_off ,volume_up ,warning_alias ,wechat_alias ,weibo ,weixin ,wheelchair ,wifi ,
	|windows ,won_alias ,wordpress ,wrench ,xing ,xing_square ,yahoo ,yelp ,yen_alias ,youtube ,youtube_play ,youtube_square";
	
	
	fa_map=Новый Структура(Ключи,61506,61808,61495,61497,61494,61496,61689,61757,61819,61961,61699,61696,61697,61698,61703,61700,61701,
	61702,61817,61831,61950,61611,61608,61466,61840,61838,61467,61609,61610,61539,61536,61537,61538,61511,61618,61566,61565,61545,61946,61881,
	61514,61534,61852,61568,61568,61482,61641,61692,61876,61877,61683,61602,61942,61943,61958,61925,61949,61809,61810,61786,61490,61671,61922,
	61485,61486,61591,61617,61786,61832,61869,61687,61601,61760,61959,61882,61932,61555,61747,61488,61571,61881,61655,61657,61658,61776,61841,
	61778,61777,61656,61962,61939,61938,61937,61940,61941,61936,61603,61633,61735,61452,61528,61533,61770,61510,61754,61751,61752,61753,61560,
	61523,61524,61559,61870,61713,61708,61902,61915,61674,61463,61453,61634,61677,61678,61783,61729,61734,61899,61684,61459,61573,61659,61557,
	61669,61574,61670,61774,61542,61637,61945,61597,61733,61531,61756,61874,61875,61636,61685,61668,61888,61499,61861,61704,61885,61862,61781,
	61842,61465,61821,61803,61865,61508,61522,61761,61762,61905,61664,61443,61849,61741,61779,61779,61676,61738,61546,61553,61541,61582,61772,
	61550,61552,61947,61594,61570,61513,61520,61868,61826,61691,61787,61894,61895,61897,61891,61893,61896,61462,61889,61893,61893,61892,61895,
	61788,61686,61896,61890,61894,61637,61448,61616,61549,61748,61476,61726,61725,61671,61635,61806,61639,61563,61716,61564,61717,61489,61518,
	61824,61721,61923,61723,61667,61780,61905,61459,61573,61547,61907,61906,61595,61715,61586,61828,61440,61612,61856,61653,61652,61934,61853,
	61632,61693,61908,61607,61605,61604,61606,61600,61916,61477,61444,61578,61914,61461,61688,61755,61963,61502,61468,61500,61737,61530,61782,
	61805,61852,61960,61491,61866,61783,61900,61572,61724,61785,61867,61705,61954,61955,61548,61667,61588,61769,61768,61901,61901,61901,61901,
	61675,61953,61633,61665,61580,61820,61498,61474,61643,61642,61732,61475,61813,61815,61816,61814,61648,61558,61540,61714,61730,61827,61505,
	61750,61964,61690,61722,61744,61745,61544,61526,61766,61767,61707,61707,61654,61830,61853,61441,61641,61930,61851,61499,61836,61948,61912,
	61913,61638,61917,61674,61516,61872,61933,61504,61771,61508,61589,61592,61502,61502,61952,61863,61864,61650,61651,61554,61515,61764,61469,
	61926,61543,61525,61694,61846,61457,61487,61742,61910,61481,61736,61529,61709,61710,61904,61556,61904,61880,61857,61858,61473,61453,61835,
	61641,61470,61714,61730,61561,61783,61464,61749,61666,61470,61784,61598,61763,61784,61784,61782,61639,61636,61442,61456,61454,61912,61913,
	61540,61920,61921,61773,61509,61963,61963,61746,61562,61584,61579,61458,61672,61822,61848,61918,61927,61720,61923,61660,61789,61790,61792,
	61793,61662,61661,61661,61794,61795,61662,61886,61847,61712,61873,61884,61640,61590,61837,61804,61445,61577,61731,61731,61731,61446,61878,
	61879,61512,61521,61681,61517,61644,61860,61859,61740,61682,61829,61739,61901,61646,61706,61668,61483,61484,61614,61882,61909,61728,61492,
	61493,61450,61449,61451,61581,61797,61576,61575,61796,61765,61453,61527,61532,61507,61776,61841,61956,61957,61778,61777,61944,61460,61883,
	61825,61585,61649,61845,61924,61811,61812,61845,61928,61593,61569,61673,61645,61666,61852,61735,61596,61758,61660,61587,61781,61447,61680,
	61632,61501,61844,61898,61833,61479,61478,61480,61553,61911,61834,61911,61843,61931,61818,61785,61850,61613,61800,61801,61854,61929,61783,
	61799,61802,61798);
	
	Возврат fa_map;
	
КонецФункции
 
Функция ПолучитьШрифт(Размер=0,Жирный=Ложь) Экспорт;

	Возврат Новый Шрифт("FontAwesome",Размер,Жирный);

КонецФункции

Функция ПолучитьСимволыШрифта() Экспорт;

	fa_chars=ПолучитьКартуШрифта();
	Для каждого СимволШрифта Из fa_chars Цикл
	
		fa_chars.Вставить(СимволШрифта.Ключ, Символ(СимволШрифта.Значение));
	
	КонецЦикла; 

	Возврат fa_chars;
	
КонецФункции

Функция ПолучитьСписокСимволов() Экспорт;
	Список = Новый СписокЗначений;
	fa_chars=ПолучитьКартуШрифта();
	Для каждого СимволШрифта Из fa_chars Цикл
	
		Список.Добавить(СимволШрифта.Ключ);
	
	КонецЦикла; 

	Возврат Список;
	
КонецФункции
