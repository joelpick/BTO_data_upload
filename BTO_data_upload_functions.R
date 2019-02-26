

BTO_webpage <- function(){
	## go to BTO DemOn login page
	remDr$navigate("https://app.bto.org/demography/bto/public/login.jsp")

	## brings up screenshot of the webpage so you can check whats going on
	remDr$screenshot(display = TRUE)
}

BTO_login <- function(username,password){
	# enter username and password and login
	# first you have to find the CSS of the box (I used selectorgadget in chrome), then enter text into it
	username_box <- remDr$findElement(using = 'css selector', "#username")
	username_box$sendKeysToElement(list(username))

	password_box <- remDr$findElement(using = 'css selector', "#password")
	password_box$sendKeysToElement(list(password))

	## find login button and click it
	login_button <- remDr$findElement(using = 'css selector', ".btn-block")
	login_button$clickElement()

	remDr$screenshot(display = TRUE)
}

BTO_ringing_page <- function(){
	## navigate to enter ringing data
		ringing_button <- remDr$findElement(using = 'css selector', ".buttonReportRate")
		ringing_button$clickElement()
		# pause R 
		Sys.sleep(5)
		remDr$screenshot(display = TRUE)
	}

BTO_ringing_upload <- function(data, display=FALSE){
	for(i in 1:nrow(data)){
		remDr$refresh()
		Sys.sleep(4)
		if(display) remDr$screenshot(display = TRUE)

		# define box and enter data into it
		Record_type_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(3) .dataInput")
		Record_type_box$sendKeysToElement(list(data$Record_Type[i]))

		Ring_no_box <- remDr$findElement(using = 'css selector', ".alert-warning")
		Ring_no_box$clearElement()
		Ring_no_box$sendKeysToElement(list(data$Ring_No[i]))

		## this is a way of choosing from a dropdown list - use 'option' in the CSS to indicate the value and then 'click' it
		Scheme_box  <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(5) .dataInput option[value='",data$Scheme[i],"']"))
		Scheme_box$clickElement()

		Species_box  <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(6) .ui-autocomplete-input")
		Species_box$clearElement()
		Species_box$sendKeysToElement(list(data$Species_Name[i], key = "enter"))

		Age_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(7) .dataInput")
		Age_box$sendKeysToElement(list(as.character(data$Age[i])))

		if(!is.na(data$Pulli_Ringed[i])){
			Pulli_ringed_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(8) .dataInput")
			Pulli_ringed_box$sendKeysToElement(list(as.character(data$Pulli_Ringed[i])))
		}

		if(!is.na(data$Pulli_Alive[i])){
		Pulli_alive_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(9) .dataInput")
		Pulli_alive_box$sendKeysToElement(list(as.character(data$Pulli_Alive[i])))
		}

		Sex_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(10) .noRepeat")
		Sex_box$sendKeysToElement(list(data$Sex[i]))

		Sexing_method_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(11) .noRepeat")
		Sexing_method_box$sendKeysToElement(list(data$Sexing_Method[i]))

		Breeding_condition_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(12) .noRepeat")
		Breeding_condition_box$sendKeysToElement(list(data$Breeding_Condition[i]))

		Visit_date_box <- remDr$findElement(using = 'css selector', ".hasDatepicker")
		Visit_date_box$clickElement()
		Visit_date_box$clearElement()
		Visit_date_box$sendKeysToElement(list(data$Visit_Date[i]))


		Capture_time_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(15) .dataInput")
		Capture_time_box$clickElement()
		Capture_time_box$sendKeysToElement(list(data$Capture_Time[i], key = "enter"))

		Location_box1 <- remDr$findElement(using = 'css selector', "#select2-chosen-8")
		Location_box1$clickElement()
		Location_box2 <- remDr$findElement(using = 'css selector', "#s2id_autogen8_search")
		Location_box2$sendKeysToElement(list(data$Location[i], key = "enter"))
		
		Habitat_1_box <- remDr$findElement(using = 'css selector', paste0(".chosenFieldSetup:nth-child(17) .dataInput option[value='",data$Habitat_1[i],"']"))
		Habitat_1_box$clickElement()

		##	only enter Wing length is record is not NA
		Wing_length_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(21) .noRepeat")
		Wing_length_box$clearElement()
	 	if(!is.na(data$Wing_Length[i])) Wing_length_box$sendKeysToElement(list(as.character(data$Wing_Length[i])))

		##	only enter Weight is record is not NA, also round to 1d.p. as instructed
		Weight_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(22) .noRepeat")
		Weight_box$clearElement()
		if(!is.na(data$Weight[i]))	Weight_box$sendKeysToElement(list(as.character(round(data$Weight[i],1))))
		
		Capture_method_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(32) .dataInput")
		Capture_method_box$sendKeysToElement(list(data$Capture_Method[i]))

		Ringer_initials_box <- remDr$findElement(using = 'css selector', ".chosenFieldSetup:nth-child(34) .ui-autocomplete-input")
		Ringer_initials_box$clearElement()
		Ringer_initials_box$sendKeysToElement(list(data$Ringer_Initials[i]))


		## to save - press tab on the colour mark info box!!
		Colour_mark_info_box <- remDr$findElement(using = 'css selector', "td:nth-child(56) .dataInput")
		Colour_mark_info_box$sendKeysToElement(list(key="tab"))
		Sys.sleep(2)
		if(display) remDr$screenshot(display = TRUE)		
		cat(i," ")

	}
}

