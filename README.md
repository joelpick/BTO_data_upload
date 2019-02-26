# BTO_data_upload
Code for bulk upload of ringing records to BTO website. This code was made on a mac, unsure how it performs on other OS. Only does ringing records. I can give no guarantee that this will faithfully or successfully upload records.

First docker needs to be installed on computer (https://www.docker.com/products/docker-desktop).
Once its installed and running, in the terminal run the collowing code:

test its working
```sudo docker run hello-world```

to get latest version of firefox into docker
```sudo docker pull selenium/standalone-firefox```

open a port for Rselenium
```sudo docker run -d -p 4445:4444 selenium/standalone-firefox```

check whats been opened
```docker ps```

Then run the R code in BTO_data_upload.R. Rselenium needs to be installed. It should take 6-7 seconds per record, but likely not all records will be imported on first try.

NOTE: Data needs to be in a strict format - see attached csv - times need to be formated as 08:45 and date as 28/05/2018. Ohter fields need to match codes on BTO website.
