*** Settings ***
Library  String
Library  Selenium2Library
Library  Collections
Library  ecoex_service.py

*** Variables ***
${locator.edit.title}  id=ePosition_title
${locator.edit.description}  id=ePosition_description
${locator.edit.dgfID}  id=ePosition_dgfID
${locator.edit.dgfDecisionID}  id=ePosition_dgfDecisionID
${locator.edit.dgfDecisionDate}  id=dtpPosition_dgfDecisionDate
${locator.edit.tenderAttempts}  id=slPosition_tenderAttempts
${locator.edit.minimalStep.amount}  id=ePosition_minimalStep_amount
${locator.edit.guarantee.amount}  id=ePosition_guarantee_amount
${locator.title}  id=tePosition_title
${locator.description}  id=tePosition_description
${locator.minimalStep.amount}  id=tPosition_minimalStep_amount
${locator.guarantee.amount}  id=tPosition_guarantee_amount
${locator.value.amount}  id=tePosition_value_amount
${locator.value.valueAddedTaxIncluded}  id=cbPosition_value_valueAddedTaxIncluded
${locator.value.currency}  id=tslPosition_value_currency
${locator.auctionPeriod.startDate}  id=tdtpPosition_auctionPeriod_startDate_Date
${locator.enquiryPeriod.startDate}  id=tdtpPosition_enquiryPeriod_startDate_Date
${locator.enquiryPeriod.endDate}  id=tdtpPosition_enquiryPeriod_endDate_Date
${locator.tenderPeriod.startDate}  id=tPosition_tenderPeriod_startDate_Date
${locator.tenderPeriod.endDate}  id=tPosition_tenderPeriod_endDate_Date
${locator.tenderId}  id=tPosition_tenderID
${locator.procuringEntity.name}  id=tew_Org_0_PE_name
${locator.dgf}  id=tePosition_dgfID
${locator.dgfDecisionID}  id=tePosition_dgfDecisionID
${locator.dgfDecisionDate}  id=tdtpPosition_dgfDecisionDate
${locator.eligibilityCriteria}  id=tPosition_eligibilityCriteria
${locator.tenderAttempts}  id=tPosition_tenderAttempts
${locator.procurementMethodType}  id=tPosition_procurementMethodType
${locator.items[0].quantity}  id=tew_item_0_quantity
${locator.items[0].description}  id=tew_item_0_description
${locator.items[0].unit.code}  id=tw_item_0_unit_code
${locator.items[0].unit.name}  id=tslw_item_0_unit_code
${locator.items[0].deliveryAddress.postalCode}  id=tw_item_0_Address_short
${locator.items[0].deliveryAddress.countryName}  id=tw_item_0_Address_short
${locator.items[0].deliveryAddress.region}  id=tw_item_0_Address_short
${locator.items[0].deliveryAddress.locality}  id=tw_item_0_Address_short
${locator.items[0].deliveryAddress.streetAddress}  id=tw_item_0_Address_short
${locator.items[0].deliveryDate.endDate}  id=tdtpw_item_0_deliveryDate_endDate_Date
${locator.items[0].classification.scheme}  id=tw_item_0_classification_scheme
${locator.items[0].classification.id}  id=tew_item_0_classification_id
${locator.items[0].classification.description}  id=tw_item_0_classification_description
${locator.items[0].additionalClassifications.scheme}  id=tw_item_0_additionalClassifications_scheme
${locator.items[0].additionalClassifications.id}  id=tew_item_0_additionalClassifications_id
${locator.items[0].additionalClassifications.description}  id=tw_item_0_additionalClassifications_description
${locator.items[1].description}  id=tew_item_1_description
${locator.items[1].classification.id}  id=tew_item_1_classification_id
${locator.items[1].classification.description}  id=tw_item_1_classification_description
${locator.items[1].classification.scheme}  id=tw_item_1_classification_scheme
${locator.items[1].additionalClassifications.scheme}  id=tw_item_0_additionalClassifications_scheme
${locator.items[1].additionalClassifications.id}  id=tew_item_0_additionalClassifications_id
${locator.items[1].additionalClassifications.description}  id=tw_item_0_additionalClassifications_description
${locator.items[1].unit.code}  id=tw_item_1_unit_code
${locator.items[1].unit.name}  id=tslw_item_1_unit_code
${locator.items[1].quantity}  id=tew_item_1_quantity
${locator.items[2].description}  id=tew_item_2_description
${locator.items[2].classification.id}  id=tew_item_2_classification_id
${locator.items[2].classification.description}  id=tw_item_2_classification_description
${locator.items[2].classification.scheme}  id=tw_item_2_classification_scheme
${locator.items[2].additionalClassifications.scheme}  id=tw_item_0_additionalClassifications_scheme
${locator.items[2].additionalClassifications.id}  id=tew_item_0_additionalClassifications_id
${locator.items[2].additionalClassifications.description}  id=tw_item_0_additionalClassifications_description
${locator.items[2].unit.code}  id=tw_item_2_unit_code
${locator.items[2].unit.name}  id=tslw_item_2_unit_code
${locator.items[2].quantity}  id=tew_item_2_quantity
${locator.questions[0].title}  css=.qa_title
${locator.questions[0].description}  css=.qa_description
${locator.questions[0].date}  css=.qa_question_date
${locator.questions[0].answer}  css=.qa_answer
${locator.cancellations[0].status}  css=.cancel_status
${locator.cancellations[0].reason}  css=.cancel_reason
${locator.contracts.status}  css=.contract_status

*** Keywords ***
Підготувати клієнт для користувача
  [Arguments]  ${username}
  ${alias}=   Catenate   SEPARATOR=   role_  ${username}
  Set Global Variable   ${BROWSER_ALIAS}   ${alias}
  Open Browser  ${USERS.users['${username}'].homepage}  ${USERS.users['${username}'].browser}  alias=${BROWSER_ALIAS}
  Set Window Size  @{USERS.users['${username}'].size}
  Set Window Position  @{USERS.users['${username}'].position}
  Run Keyword If  '${username}' != 'ecoex_Viewer'  Login  ${username}

Підготувати дані для оголошення тендера
  [Arguments]  ${username}  ${tender_data}  ${role_name}
  [Return]  ${tender_data}

Login
  [Arguments]  ${username}
  Input text  id=eLogin  ${USERS.users['${username}'].login}
  Click Element  id=btnLogin

Змінити користувача
  [Arguments]  ${username}
  Go to  ${USERS.users['${username}'].homepage}
  Sleep  2
  Input text  id=eLogin  ${USERS.users['${username}'].login}
  Click Element  id=btnLogin

Створити тендер
  [Arguments]  ${username}  ${tender_data}
  Set Global Variable  ${TENDER_INIT_DATA_LIST}  ${tender_data}
  ${title}=  Get From Dictionary  ${tender_data.data}  title
  ${dgf}=  Get From Dictionary  ${tender_data.data}  dgfID
  ${dgfDecisionDate}=  convert_ISO_DMY  ${tender_data.data.dgfDecisionDate}
  ${dgfDecisionID}=  Get From Dictionary  ${tender_data.data}  dgfDecisionID
  ${tenderAttempts}=  Convert To String  ${tender_data.data.tenderAttempts}
  ${description}=  Get From Dictionary  ${tender_data.data}  description
  ${procuringEntity_name}=  Get From Dictionary  ${tender_data.data.procuringEntity}  name
  ${items}=  Get From Dictionary  ${tender_data.data}  items
  ${budget}=  Convert To String  ${tender_data.data.value.amount}
  ${step_rate}=  Convert To String  ${tender_data.data.minimalStep.amount}
  ${guarantee}=  Convert To String  ${tender_data.data.guarantee.amount}
  ${currency}=  Get From Dictionary  ${tender_data.data.value}  currency
  ${valueAddedTaxIncluded}=  Get From Dictionary  ${tender_data.data.value}  valueAddedTaxIncluded
  ${start_day_auction}=  get_tender_dates  ${tender_data}  StartDate
  ${start_time_auction}=  get_tender_dates  ${tender_data}  StartTime
  ${descr_lot}=  Get From Dictionary  ${items[0]}  description
  ${unit}=  Get From Dictionary  ${items[0].unit}  code
  ${cav_id}=  Get From Dictionary  ${items[0].classification}  id
  ${quantity}=  Convert To String  ${items[0].quantity}
  Switch Browser  ${BROWSER_ALIAS}
  Wait Until Page Contains Element  id=btAddTender  20
  Click Element  id=btAddTender
  Wait Until Page Contains Element  id=ePosition_title
  Select From List By Value  id=slPosition_procurementMethodType  ${tender_data.data.procurementMethodType}
  Input text  id=dtpPosition_auctionPeriod_startDate_Date  ${start_day_auction}
  Input text  id=ePosition_auctionPeriod_startDate_Time  ${start_time_auction}
  Input text  id=ew_Org_0_PE_name  ${procuringEntity_name}
  Input text  id=ePosition_title  ${title}
  Input text  id=ePosition_description  ${description}
  Input text  id=ePosition_dgfID  ${dgf}
  Input text  id=ePosition_dgfDecisionID  ${dgfDecisionID}
  Input text  id=dtpPosition_dgfDecisionDate  ${dgfDecisionDate}
  Select From List By Value  id=slPosition_tenderAttempts  ${tenderAttempts}
  Input text  id=ePosition_value_amount  ${budget}
  Click Element  id=lcbPosition_value_valueAddedTaxIncluded
  Input text  id=ePosition_minimalStep_amount  ${step_rate}
  Input text  id=ePosition_guarantee_amount  ${guarantee}
  ${items}=  Get From Dictionary  ${tender_data.data}  items
  ${Items_length}=  Get Length  ${items}
  :FOR  ${index}  IN RANGE  ${Items_length}
  \	 Click Element  id=btn_items_add
  \  Додати предмет  ${items[${index}]}  ${index}
  Click Element  id=btnSend
  Wait Until Page Contains  Збереження виконано
  Click Element  id=btnPublic
  Wait Until Page Contains  Публікацію виконано
  ${tender_id}=  Get Text  id=tPosition_tenderID
  ${TENDER}=  Get Text  id=tPosition_tenderID
  log to console  ${TENDER}
  [return]  ${TENDER}

Додати предмет
  [Arguments]  ${item}  ${index}
  Wait Until Element Is Visible  id=ew_item_${index}_description
  Input text  id=ew_item_${index}_description  ${item.description}
  Input text  id=ew_item_${index}_quantity  ${item.quantity}
  Select From List By Value  id=slw_item_${index}_unit_code  ${item.unit.code}
  Input text  id=ew_item_${index}_classification_id  ${item.classification.id}
  Wait Until Page Contains Element  xpath=(//ul[contains(@class, 'ui-autocomplete') and not(contains(@style,'display: none'))]//li//a)
  Click Element  xpath=(//ul[contains(@class, 'ui-autocomplete') and not(contains(@style,'display: none'))]//li//a)
  Input text  id=ew_item_${index}_address_countryName  ${item.deliveryAddress.countryName}
  Input text  id=ew_item_${index}_address_postalCode  ${item.deliveryAddress.postalCode}
  Input text  id=ew_item_${index}_address_region  ${item.deliveryAddress.region}
  Input text  id=ew_item_${index}_address_locality  ${item.deliveryAddress.locality}
  Input text  id=ew_item_${index}_address_streetAddress  ${item.deliveryAddress.streetAddress}

Завантажити документ
  [Arguments]  ${username}  ${filepath}  ${TENDER}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${TENDER}
  Wait Until Element Is Visible  xpath=(//*[@id='btn_documents_add']) 
  Click Element  id=btn_documents_add
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${filepath}
  Sleep  2
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 
  Reload Page

Пошук тендера по ідентифікатору
  [Arguments]  ${username}  ${tender_uaid}
  Switch Browser  ${BROWSER_ALIAS}
  Set Global Variable   ${SEARCH_MODE}   'tenders'
  Go to  ${USERS.users['${username}'].default_page}
  Wait Until Element Is Visible  id=btnFilter
  Wait Until Element Contains  id=records_shown  Y
  Input Text  id=ew_fv_0_value  ${tender_uaid}
  Click Element  id=btnFilter
  Wait Until Element Contains  id=records_shown  Y
  Click Element  xpath=(//a[contains(@class, 'record_title')])
  Wait Until Element Is Visible  xpath=(//*[@id='tPosition_status'])

Перейти до сторінки запитань
  Wait Until Element Is Visible  id=questions_ref
  Click Element  id=questions_ref
  Wait Until Element Contains  id=records_shown  Y

Перейти до сторінки відмін
  Wait Until Element Is Visible  id=cancels_ref
  Click Element  id=cancels_ref
  Wait Until Element Contains  id=records_shown  Y

Скасувати закупівлю
  [Arguments]  ${username}  ${tender_uaid}  ${reason}  ${filepath}  ${description}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid} 
  Wait Until Element Is Visible  xpath=(//*[@id='btnСancel'])
  Click Element  id=btnСancel
  Sleep  2
  Input text  id=e_reason  ${reason} 
  Click Element  id=SendCancellation
  Wait Until Element Is Visible  xpath=(//*[@id='pnList']//span[contains(@class, 'add_document')])
  Click Element  xpath=(//*[@id='pnList']//span[contains(@class, 'add_document')])
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${filepath}
  Sleep  2
  Input text  id=eFile_accessDetails  ${description}
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено
  Reload Page
  Click Element  xpath=(//*[@id='pnList']/div[1]/div[2]/div[2]/span)

Отримати інформацію про cancellations[0].status
  Перейти до сторінки відмін
  Wait Until Element Is Visible  xpath=(//span[contains(@class, 'rec_cancel_status')])
  ${return_value}=  Get text  xpath=(//span[contains(@class, 'rec_cancel_status')])
  [return]  ${return_value}

Отримати інформацію про cancellations[0].reason
  Перейти до сторінки відмін
  Wait Until Element Is Visible  xpath=(//span[contains(@class, 'rec_cancel_reason')])
  ${return_value}=  Get text  xpath=(//span[contains(@class, 'rec_cancel_reason')])
  [return]  ${return_value}

Оновити сторінку з тендером
  [Arguments]  ${username}  ${tender_uaid}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}

Отримати інформацію із предмету
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${field_name}
  ${return_value}=  Run Keyword If  '${field_name}' == 'description'
  ...  Get Text  xpath=(//div[starts-with(@id, 'pn_w_item') and contains(@class, '${item_id}')////span[contains(@id, 'description')]) 
  ...  ELSE IF  '${field_name}' == 'classification.scheme'  Get Text  xpath=(//div[starts-with(@id, 'pn_w_item') and contains(@class, '${item_id}')////span[contains(@id, 'classification_scheme')]) 
  ...  ELSE IF  '${field_name}' == 'classification.id'  Get Text  xpath=(//div[starts-with(@id, 'pn_w_item') and contains(@class, '${item_id}')////span[contains(@id, 'classification_id')]) 
  ...  ELSE IF  '${field_name}' == 'classification.description'  Get Text  xpath=(//div[starts-with(@id, 'pn_w_item') and contains(@class, '${item_id}')////span[contains(@id, 'classification_description')]) 
  ...  ELSE IF  '${field_name}' == 'unit.name'  Get Text  xpath=(//div[starts-with(@id, 'pn_w_item') and contains(@class, '${item_id}')////span[contains(@id, 'unit_name') and contains(@id, 'tslw_item')]) 
  ...  ELSE IF  '${field_name}' == 'unit.code'  Get Text  xpath=(//div[starts-with(@id, 'pn_w_item') and contains(@class, '${item_id}')////span[contains(@id, 'unit_code') and contains(@id, 'tw_item')]) 
  ...  ELSE IF  '${field_name}' == 'quantity'  Get Text  xpath=(//div[starts-with(@id, 'pn_w_item') and contains(@class, '${item_id}')////span[contains(@id, 'quantity')]) 
  [return]  ${return_value}

Перейти на сторінку тендера
  [Arguments]  ${username}  ${tender_uaid}  
  ${present}=  Run Keyword And Return Status  Element Should Be Visible  id=tPosition_status
  Run Keyword Unless  ${present}  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}

Отримати інформацію із тендера
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}
  Run Keyword If  '${fieldname}' == 'tenderPeriod.endDate'
  ...  Перейти на сторінку тендера  ${username}  ${tender_uaid}
  ${return_value}=  Run Keyword  Отримати інформацію про ${fieldname}
  [return]  ${return_value}

Отримати текст із поля і показати на сторінці
  [Arguments]  ${fieldname}
  ${return_value}=  Get Text  ${locator.${fieldname}}
  [return]  ${return_value}

Отримати інформацію про title
  ${return_value}=  Отримати текст із поля і показати на сторінці  title
  [return]  ${return_value}

Отримати інформацію про procurementMethodType
  ${return_value}=  Отримати текст із поля і показати на сторінці  procurementMethodType
  [return]  ${return_value}

Отримати інформацію про dgfID
  ${return_value}=  Отримати текст із поля і показати на сторінці  dgf
  [return]  ${return_value}

Отримати інформацію про dgfDecisionID
  ${return_value}=  Отримати текст із поля і показати на сторінці  dgfDecisionID
  [return]  ${return_value}

Отримати інформацію про dgfDecisionDate
  ${date_value}=  Отримати текст із поля і показати на сторінці  dgfDecisionDate
  ${return_value}=  ecoex_service.convert_date  ${date_value}
  [return]  ${return_value}

Отримати інформацію про tenderAttempts
  ${return_value}=  Отримати текст із поля і показати на сторінці  tenderAttempts
  ${return_value}=  Convert To Integer  ${return_value}
  [return]  ${return_value}

Отримати інформацію про eligibilityCriteria
  ${return_value}=  Отримати текст із поля і показати на сторінці  eligibilityCriteria

Отримати інформацію про status
  Reload Page
  Wait Until Element Is Visible  xpath=(//*[@id='tPosition_status'])
  Sleep  2
  ${return_value}=  Get Text  id=tPosition_status
  [return]  ${return_value}

Отримати інформацію про description
  ${return_value}=  Отримати текст із поля і показати на сторінці  description
  [return]  ${return_value}

Отримати інформацію про value.amount
  ${return_value}=  Отримати текст із поля і показати на сторінці  value.amount
  ${return_value}=  Convert To Number  ${return_value.replace(' ', '').replace(',', '.')}
  [return]  ${return_value}

Отримати інформацію про minimalStep.amount
  ${return_value}=  Отримати текст із поля і показати на сторінці  minimalStep.amount
  ${return_value}=  Convert To Number  ${return_value.replace(' ', '').replace(',', '.')}
  [return]  ${return_value}

Отримати інформацію про guarantee.amount
  ${return_value}=  Отримати текст із поля і показати на сторінці  guarantee.amount
  ${return_value}=  Convert To Number  ${return_value.replace(' ', '').replace(',', '.')}
  [return]  ${return_value}

Внести зміни в тендер
  [Arguments]  ${username}  ${tender_uaid}  ${fieldname}  ${fieldvalue}
  Wait Until Element Is Visible  ${locator.edit.${fieldname}}  5
  ${fieldvalue}=  Run Keyword If  '${field_name}' == 'tenderAttempts'  Convert To String  ${fieldvalue}
  ...  ELSE IF  '${field_name}' == 'minimalStep.amount'  Convert To String  ${fieldvalue}
  ...  ELSE IF  '${field_name}' == 'guarantee.amount'  Convert To String  ${fieldvalue}
  ...  ELSE IF  '${field_name}' == 'dgfDecisionDate'  convert_ISO_DMY  ${fieldvalue}
  ...  ELSE  Set Variable  ${fieldvalue}
  Run Keyword If  '${field_name}' == 'tenderAttempts'  Select From List By Value  id=slPosition_tenderAttempts  ${fieldvalue}
  ...  ELSE  Input Text  ${locator.edit.${fieldname}}  ${fieldvalue}
  Click Element  id=btnPublic
  Sleep  2
  Wait Until Page Contains  Публікацію виконано

Отримати інформацію про items[${index}].quantity
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].quantity
  ${return_value}=  Convert To Number  ${return_value.replace(' ', '').replace(',', '.')}
  [return]  ${return_value}

Отримати інформацію про items[${index}].unit.code
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].unit.code
  [return]  ${return_value}

Отримати інформацію про items[${index}].unit.name
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].unit.name
  [return]  ${return_value}

Отримати інформацію про items[${index}].description
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].description
  [return]  ${return_value}

Отримати інформацію про items[${index}].classification.id
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].classification.id
  [return]  ${return_value}

Отримати інформацію про items[${index}].classification.scheme
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].classification.scheme
  [return]  ${return_value}

Отримати інформацію про items[${index}].classification.description
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[${index}].classification.description
  [return]  ${return_value}

Отримати інформацію про value.currency
  ${return_value}=  Get Selected List Value  slPosition_value_currency
  [return]  ${return_value}

Отримати інформацію про value.valueAddedTaxIncluded
  ${return_value}=  is_checked  cbPosition_value_valueAddedTaxIncluded
  [return]  ${return_value}

Отримати інформацію про auctionID
  ${return_value}=  Отримати текст із поля і показати на сторінці  tenderId
  [return]  ${return_value}

Отримати інформацію про procuringEntity.name
  ${return_value}=  Отримати текст із поля і показати на сторінці  procuringEntity.name
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.latitude
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryLocation.latitude
  ${return_value}=  Convert To Number  ${return_value}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryLocation.longitude
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryLocation.longitude
  ${return_value}=  Convert To Number  ${return_value}
  [return]  ${return_value}

Отримати інформацію про auctionPeriod.startDate
  ${date_value}=  Get Text  id=tdtpPosition_auctionPeriod_startDate_Date
  ${time_value}=  Get Text  id=tePosition_auctionPeriod_startDate_Time
  ${return_value}=  convert_date_to_iso  ${date_value}  ${time_value}
  [return]  ${return_value}

Отримати інформацію про auctionPeriod.endDate
  ${date_value}=  Get Text  id=tdtpPosition_auctionPeriod_endDate_Date
  ${time_value}=  Get Text  id=tePosition_auctionPeriod_endDate_Time
  ${return_value}=  convert_date_to_iso  ${date_value}  ${time_value}

Отримати інформацію про tenderPeriod.startDate
  ${date_value}=  Get Text  id=tPosition_tenderPeriod_startDate_Date
  ${time_value}=  Get Text  id=tPosition_tenderPeriod_startDate_Time
  ${return_value}=  convert_date_to_iso  ${date_value}  ${time_value}
  [return]  ${return_value}

Отримати інформацію про tenderPeriod.endDate
  ${date_value}=  Get Text  id=tPosition_tenderPeriod_endDate_Date
  ${time_value}=  Get Text  id=tPosition_tenderPeriod_endDate_Time
  ${return_value}=  convert_date_to_iso  ${date_value}  ${time_value}
  [return]  ${return_value}

Отримати інформацію про enquiryPeriod.startDate
  ${date_value}=  Get Text  id=tdtpPosition_enquiryPeriod_startDate_Date
  ${time_value}=  Get Text  id=tePosition_enquiryPeriod_startDate_Time
  ${return_value}=  convert_date_to_iso  ${date_value}  ${time_value}
  [return]  ${return_value}

Отримати інформацію про enquiryPeriod.endDate
  ${date_value}=  Get Text  id=tdtpPosition_enquiryPeriod_endDate_Date
  ${time_value}=  Get Text  id=tePosition_enquiryPeriod_endDate_Time
  ${return_value}=  convert_date_to_iso  ${date_value}  ${time_value}
  [return]  ${return_value}

Отримати інформацію про items[0].deliveryAddress.countryName
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.countryName
  [return]  ${return_value.split(', ')[0]}

Отримати інформацію про items[0].deliveryAddress.postalCode
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.postalCode
  [return]  ${return_value.split(', ')[1]}

Отримати інформацію про items[0].deliveryAddress.region
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.region
  [return]  ${return_value.split(', ')[2]}

Отримати інформацію про items[0].deliveryAddress.locality
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.locality
  [return]  ${return_value.split(', ')[3]}

Отримати інформацію про items[0].deliveryAddress.streetAddress
  ${return_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryAddress.streetAddress
  [return]  ${return_value.split(', ')[4]}

Отримати інформацію про items[0].deliveryDate.endDate
  ${date_value}=  Отримати текст із поля і показати на сторінці  items[0].deliveryDate.endDate
  ${return_value}=  ecoex_service.convert_date  ${date_value}
  [return]  ${return_value}

Отримати інформацію про questions[${index}].title
  ${index}=  inc  ${index}
  Wait Until Page Contains Element  xpath=(//span[contains(@class, 'rec_qa_title')])[${index}]
  ${return_value}=  Get text  xpath=(//span[contains(@class, 'rec_qa_title')])[${index}]
  [return]  ${return_value}

Отримати інформацію про questions[${index}].description
  ${index}=  inc  ${index}
  Wait Until Page Contains Element  xpath=(//span[contains(@class, 'rec_qa_description')])[${index}]
  ${return_value}=  Get text  xpath=(//span[contains(@class, 'rec_qa_description')])[${index}]
  [return]  ${return_value}

Отримати інформацію про questions[${index}].answer
  ${index}=  inc  ${index}
  Wait Until Page Contains Element  xpath=(//span[contains(@class, 'rec_qa_answer')])[${index}]
  ${return_value}=  Get text  xpath=(//span[contains(@class, 'rec_qa_answer')])[${index}]
  [return]  ${return_value}

Отримати інформацію про questions[${index}].date
  ${index}=  inc  ${index}
  Wait Until Page Contains Element  xpath=(//span[contains(@class, 'rec_qa_date')])[${index}]
  ${return_value}=  Get text  xpath=(//span[contains(@class, 'rec_qa_date')])[${index}]
  ${return_value}=  convert_date_time_to_iso  ${return_value}
  [return]  ${return_value}

Отримати інформацію із запитання
  [Arguments]  ${username}  ${tender_uaid}  ${question_id}  ${field_name}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Перейти до сторінки запитань
  ${return_value}=  Run Keyword If  '${field_name}' == 'title'
  ...  Get Text  xpath=(//span[contains(@class, 'qa_title') and contains(@class, '${item_id}')]) 
  ...  ELSE IF  '${field_name}' == 'answer'  Get Text  xpath=(//span[contains(@class, 'qa_answer') and contains(@class, '${item_id}')]) 
  ...  ELSE  Get Text  xpath=(//span[contains(@class, 'qa_description') and contains(@class, '${item_id}')]) 
  [return]  ${return_value}

Задати запитання на тендер
  [Arguments]  ${username}  ${tender_uaid}  ${question}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Задати питання  ${username}  ${tender_uaid}  ${question}

Задати питання
  [Arguments]  ${username}  ${tender_uaid}  ${question}
  ${title}=  Get From Dictionary  ${question.data}  title
  ${description}=  Get From Dictionary  ${question.data}  description
  Wait Until Element Is Visible  xpath=(//*[@id='btn_question'])
  Click Element  id=btn_question
  Sleep  3
  Input text  id=e_title  ${title}
  Input text  id=e_description  ${description}
  Click Element  id=SendQuestion
  Wait Until Page Contains  Публікацію виконано

Задати запитання на предмет
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}  ${question}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='tPosition_status'])
  Click Element  xpath=(//span[contains(@class, 'bt_item_question') and contains(@class, '${item_id}')])
  Sleep  3
  Input text  id=e_title  ${question.data.title}
  Input text  id=e_description  ${question.data.description}
  Click Element  id=SendQuestion
  Wait Until Page Contains  Публікацію виконано

Відповісти на запитання
  [Arguments]  ${username}  ${tender_uaid}  ${answer_data}  ${item_id}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Перейти до сторінки запитань
  Wait Until Element Is Visible  xpath=(//span[contains(@class, 'btAnswer') and contains(@class, '${item_id}')])
  Click Element  xpath=(//span[contains(@class, 'btAnswer') and contains(@class, '${item_id}')])
  Input Text  id=e_answer  ${answer_data.data.answer}
  Click Element  id=SendAnswer
  Wait Until Page Contains  Публікацію виконано

Подати цінову пропозицію
  [Arguments]  ${username}  ${tender_uaid}  ${bid_data}
  ${is_qualified}=  is_qualified  ${bid_data}
  ${is_eligible}=  is_eligible  ${bid_data}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btnBid']) 
  Click Element  id=btnBid
  Wait Until Element Is Visible  xpath=(//*[@id='bid_load_status']) 
  ${present}=  Run Keyword And Return Status  Element Should Be Visible  id=eBid_price
  Run Keyword If  ${present}  ecoex.Введення ціни пропозиії  ${bid_data}
  Run Keyword If  ${is_qualified}  Click Element  id=lcbBid_selfQualified
  Run Keyword If  ${is_eligible}  Click Element  id=lcbBid_selfEligible
  Click Element  id=btn_save
  Wait Until Element Is Visible  xpath=(//*[@id='btn_public'])
  Click Element  id=btn_public
  sleep  1
  ${resp}=  Get Value  id=eBid_price
  [return]  ${resp}

Введення ціни пропозиії  
  [Arguments]  ${bid_data}
  ${amount}=  Get From Dictionary  ${bid_data.data.value}  amount
  ${amount}=  Convert To String  ${amount}
  Input Text  id=eBid_price  ${amount}

Скасувати цінову пропозицію
  [Arguments]  ${username}  ${tender_uaid}  
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btnShowBid'])
  Click Element  id=btnShowBid
  Wait Until Element Is Visible  xpath=(//*[@id='btn_delete'])
  Click Element  id=btn_delete

Отримати інформацію із пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${field}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btnShowBid'])
  Click Element  id=btnShowBid
  Wait Until Element Is Visible  xpath=(//*[@id='bid_load_status']) 
  ${value}=  Get Value  id=eBid_price
  ${value}=  Convert To Number  ${value}
  [Return]  ${value}

Змінити цінову пропозицію
  [Arguments]  ${username}  ${tender_uaid}  ${amount}  ${amount_value}  
  ${amount}=  Convert To String  ${amount_value}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btnShowBid'])
  Click Element  id=btnShowBid
  Wait Until Element Is Visible  xpath=(//*[@id='bid_load_status']) 
  Input Text  id=eBid_price  ${amount}
  sleep  1
  Click Element  id=btn_public

Завантажити документ в ставку
  [Arguments]  ${username}  ${file}  ${bid_id}
  Wait Until Element Is Visible  xpath=(//*[@id='btnShowBid'])
  Click Element  id=btnShowBid
  Wait Until Element Is Visible  xpath=(//*[@id='btn_documents_add'])
  Click Element  id=btn_documents_add
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${file}
  Sleep  2
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 
  Reload Page

Змінити документ в ставці
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${docid}
  Reload Page
  Wait Until Element Is Visible  xpath=(//*[@id='btn_documents_add'])
  Click Element  css=.bt_ReUpload:first-child
  Sleep  2
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${filepath}
  Sleep  2
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 
  Reload Page

Завантажити фінансову ліцензію
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btnShowBid'])
  Click Element  id=btnShowBid
  Wait Until Element Is Visible  xpath=(//*[@id='btn_documents_add'])
  Click Element  id=btn_documents_add
  Sleep  2
  Select From List By Value  id=slFile_documentType  financialLicense
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${filepath}
  Sleep  2
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 
  Reload Page

Отримати інформацію про bids
  [Arguments]  ${username}  ${tender_uaid}  
  Викликати для учасника  ${username}  Оновити сторінку з тендером  ${tender_uaid}
  Click Element  id=bids_ref

Отримати посилання на аукціон для глядача
  [Arguments]  ${username}  @{arguments}
  [Documentation]
  ...  ${ARGUMENTS[0]} ==  ${username}
  ...  ${ARGUMENTS[1]} ==  ${tender_uaid}
  ...  ${ARGUMENTS[2]} ==  ${lot_id} for multilot request in auction stage
  Switch Browser  ${BROWSER_ALIAS}
  Wait Until Element Is Visible  xpath=(//*[@id='aPosition_auctionUrl'])
  ${result} =  Get Element Attribute  id=aPosition_auctionUrl@href
  [return]  ${result}

Отримати посилання на аукціон для учасника
  [Arguments]  ${username}  @{arguments}
  [Documentation]
  ...  ${ARGUMENTS[0]} ==  ${username}
  ...  ${ARGUMENTS[1]} ==  ${tender_uaid}
  ...  ${ARGUMENTS[2]} ==  ${lot_id} for multilot request in auction stage
  Switch Browser  ${BROWSER_ALIAS}
  Wait Until Element Is Visible  xpath=(//*[@id='aPosition_auctionUrl'])
  ${result}=  Get Element Attribute  id=aPosition_auctionUrl@href
  [return]  ${result}

Завантажити документ в тендер з типом
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${doc_type}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btn_documents_add']) 
  Click Element  id=btn_documents_add
  Select From List By Value  id=slFile_documentType  ${doc_type}
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${filepath}
  Sleep  2
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 

Завантажити ілюстрацію
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btn_documents_add'])
  Click Element  id=btn_documents_add
  Select From List By Value  id=slFile_documentType  illustration
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${filepath}
  Sleep  2
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 

Додати Virtual Data Room
  [Arguments]  ${username}  ${tender_uaid}  ${vdr_url}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btn_documents_add'])
  Click Element  id=btn_documents_add
  Select From List By Value  id=slFile_documentType  virtualDataRoom
  Input text  id=eFile_url  ${vdr_url}
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 

Додати публічний паспорт активу
  [Arguments]  ${username}  ${tender_uaid}  ${vdr_url}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btn_documents_add'])
  Click Element  id=btn_documents_add
  Select From List By Value  id=slFile_documentType  x_dgfPublicAssetCertificate
  Input text  id=eFile_url  ${vdr_url}
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 

Додати офлайн документ
  [Arguments]  ${username}  ${tender_uaid}  ${accessDetails}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='btn_documents_add'])
  Click Element  id=btn_documents_add
  Select From List By Value  id=slFile_documentType  x_dgfAssetFamiliarization
  Input text  id=eFile_accessDetails  ${accessDetails}
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 

Отримати інформацію із документа по індексу
  [Arguments]  ${username}  ${tender_uaid}  ${document_index}  ${field}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  ${doc_value}=  Get Text  xpath=(//*[@id='pn_documentsContent_']/table[${document_index + 1}]//span[contains(@class, 'documentType')])
  [return]  ${doc_value}

Отримати інформацію із документа
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}  ${field_name}
  ${doc_value}=  Run Keyword If  '${field_name}' == 'description'
  ...  Get Text  xpath=(//span[contains(@class, 'description') and contains(@class, '${doc_id}')]) 
  ...  ELSE  Get Text  xpath=(//a[contains(@class, 'doc_title') and contains(@class, '${doc_id}')]) 
  [Return]  ${doc_value}

Отримати кількість предметів в тендері
  [Arguments]  ${username}  ${tender_uaid}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  ${return_value}=  Get Matching Xpath Count  xpath=(//div[starts-with(@id, 'pn_w_item')])
  [return]  ${return_value}

Додати предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  ${index}=  ecoex.Отримати кількість предметів в тендері  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  id=btn_items_add
  ${ItemAddButtonVisible}=  Page Should Contain Element  id=btn_items_add
  Run Keyword If  '${ItemAddButtonVisible}'=='PASS'  Run Keywords
  ...  Додати предмет  ${item}  ${index}
  ...  AND  Click Element  id=btnPublic
  ...  AND  Wait Until Page Contains  Публікацію виконано

Видалити предмет закупівлі
  [Arguments]  ${username}  ${tender_uaid}  ${item_id}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  ${ItemAddButtonVisible}=  Page Should Contain Element  id=btn_items_add
  Run Keyword If  '${ItemAddButtonVisible}'=='PASS'  Run Keywords
  ...  Wait Until Element Is Visible  xpath=(//ul[contains(@class, 'bt_item_delete') and contains(@class, ${item_id})])
  ...  AND  Click Element  xpath=(//ul[contains(@class, 'bt_item_delete') and contains(@class, ${item_id})])
  ...  AND  Click Element  id=btnPublic
  ...  AND  Wait Until Page Contains  Публікацію виконано

Отримати кількість документів в тендері
  [Arguments]  ${username}  ${tender_uaid}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  ${tender_doc_number}=  Get Matching Xpath Count  xpath=(//*[@id='pn_documentsContent_']/table)
  [Return]  ${tender_doc_number}

Отримати документ
  [Arguments]  ${username}  ${tender_uaid}  ${doc_id}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Click Element  xpath=(//a[contains(@class, 'doc_title') and contains(@class, '${doc_id}')])
  sleep  3
  ${file_name}=  Get Text  xpath=(//a[contains(@class, 'doc_title') and contains(@class, '${doc_id}')])
  ${url}=  Get Element Attribute  xpath=(//a[contains(@class, 'doc_title') and contains(@class, '${doc_id}')])@href
  download_file  ${url}  ${file_name.split('/')[-1]}  ${OUTPUT_DIR}
  [return]  ${file_name.split('/')[-1]}

Отримати дані із документу пропозиції
  [Arguments]  ${username}  ${tender_uaid}  ${bid_index}  ${document_index}  ${field}
  ${document_index}=  inc  ${document_index}
  ${result}=  Get Text  xpath=(//*[@id='pnAwardList']/div[last()]/div/div[1]/div/div/div[2]/table[${document_index}]//span[contains(@class, 'documentType')])
  [Return]  ${result}

Отримати кількість документів в ставці
  [Arguments]  ${username}  ${tender_uaid}  ${bid_index}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  ${bid_doc_number}=  Get Matching Xpath Count  xpath=(//*[@id='pnAwardList']/div[last()]/div/div[1]/div/div/div[2]/table)
  [Return]  ${bid_doc_number}

Скасування рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${tender_uaid}  ${award_index}
  ${award_index}=  inc  ${award_index}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Page Contains Element  xpath=(//*[@id='pnAwardList']/div[${award_index}]//*[contains(@class, 'Cancel_button')])
  Sleep  1
  Click Element  xpath=(//*[@id='pnAwardList']/div[${award_index}]//*[contains(@class, 'Cancel_button')])

Підтвердити постачальника
  [Arguments]  ${username}  ${tender_uaid}  ${award_index}
  ${award_index}=  inc  ${award_index}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='pnAwardList']/div[${award_index}]//*[contains(@class, 'award_button')])
  Sleep  1
  Click Element  xpath=(//*[@id='pnAwardList']/div[${award_index}]//*[contains(@class, 'award_button')])
  Wait Until Page Contains  Публікацію виконано

Дискваліфікувати постачальника
  [Arguments]  ${username}  ${tender_uaid}  ${award_index}  ${description}
  ecoex.Оновити сторінку з тендером  ${username}  ${tender_uaid}
  ${award_index}=  inc  ${award_index}
  Wait Until Page Contains Element  xpath=(//*[@id='pnAwardList']/div[${award_index}]//*[contains(@class, 'Reject_description')])
  Input text  xpath=(//*[@id='pnAwardList']/div[${award_index}]//*[contains(@class, 'Reject_description')])  ${description}
  Click Element  xpath=(//*[@id='pnAwardList']/div[${award_index}]//*[contains(@class, 'Reject_button')])
  Wait Until Page Contains  Публікацію виконано

Завантажити документ рішення кваліфікаційної комісії
  [Arguments]  ${username}  ${filepath}  ${tender_uaid}  ${award_index}
  ${award_index}=  inc  ${award_index}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='tPosition_status'])
  Click Element  xpath=(//*[@id='pnAwardList']/div[${award_index}]//div[contains(@class, 'award_docs')]//span[contains(@class, 'add_document')])
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${filepath}
  Sleep  2
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 
  Reload Page

Завантажити угоду до тендера
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}  ${filepath}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Page Contains Element  xpath=(//div[contains(@id, 'pn_doc_contract_')][1]//span[contains(@class, 'add_document')])
  Click Element  xpath=(//div[contains(@id, 'pn_doc_contract_')][1]//span[contains(@class, 'add_document')])
  Select From List By Value  id=slFile_documentType  contractSigned
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${filepath}
  Sleep  2
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 
  Reload Page

Підтвердити підписання контракту
  [Arguments]  ${username}  ${tender_uaid}  ${contract_num}
  ${file_path}  ${file_title}  ${file_content}=  create_fake_doc
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Page Contains Element  xpath=(//div[contains(@id, 'pn_control_contract')][1]//span[contains(@class, 'contract_register')])
  Click Element  xpath=(//div[contains(@id, 'pn_control_contract')][1]//span[contains(@class, 'contract_register')])
  Wait Until Page Contains  Публікацію виконано

Завантажити протокол аукціону
  [Arguments]  ${username}  ${tender_uaid}  ${filepath}  ${award_index}
  ${award_index}=  inc  ${award_index}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='tPosition_status'])
  Click Element  xpath=(//*[@id='pnAwardList']/div[${award_index}]//div[contains(@class, 'award_docs')]//span[contains(@class, 'add_document')])
  Select From List By Value  id=slFile_documentType  auctionProtocol
  Choose File  xpath=(//*[@id='upload_form']/input[2])  ${filepath}
  Sleep  2
  Click Element  id=upload_button
  Wait Until Element Contains  id=tFileMessage  Файл завантажено 
  Reload Page

Підтвердити наявність протоколу аукціону
  [Arguments]  ${username}  ${tender_uaid}  ${award_index}
  ${award_index}=  inc  ${award_index}
  ecoex.Пошук тендера по ідентифікатору  ${username}  ${tender_uaid}
  Wait Until Element Is Visible  xpath=(//*[@id='tPosition_status'])
  Click Element  xpath=(//*[@id='pnAwardList']/div[${award_index}]//*[contains(@class, 'award_protocol_button')])
  Wait Until Page Contains  Публікацію виконано

Отримати інформацію про awards[${index}].status
  ${index}=  inc  ${index}
  Wait Until Element Is Visible  xpath=(//span[contains(@class, 'rec_award_status')])[${index}]
  ${return_value}=  Get text  xpath=(//span[contains(@class, 'rec_award_status')])[${index}]
  [return]  ${return_value}

Отримати інформацію про contracts[${index}].datePaid
  ${return_value}=  Get text  id=t_contract_0_datePaid
  ${return_value}=  convert_date_time_to_iso  ${return_value}
  [return]  ${return_value}

Отримати інформацію про contracts[${index}].status
  ${index}=  inc  ${index}
  Wait Until Element Is Visible  xpath=(//span[contains(@class, 'contract_status')])[${index}]
  ${return_value}=  Get text  xpath=(//span[contains(@class, 'contract_status')])[${index}]
  [return]  ${return_value}