
# Meeting minutes

## Meeting 01 - Introductions and data exploration

- **Date and time:** Monday 02/11/20 11:00am
- **Attendees:** Everyone

### Agenda

- Discuss the contents of the assignment specification
- Create a Github repository to store any work
- Allocate data analysis work and figure out a due date

### Meeting notes

- Data exploration seems easy; seems best to do the analysis for both `P_t` and `y_t`
- Data exploration can be in any language you want
- Not sure how to implement MCMC for this problem
- Need to figure out how to choose priors for the transformed parameters

### Tasks to complete by next meeting

- Everyone should aim to complete the data exploration stage individually (08/11/20)

## Meeting 02 - Data exploration results

- **Date and time:** Sunday 08/11/20 7:00pm
- **Attendees:** Everyone

### Agenda

- Compare and discuss the results of the data exploration
- Figure out what to comment for the data exploration
- Set up a shared document file
- Figure out how to approach the estimation of the posterior distribution

### Meeting notes

- Compared results of data exploration, but not really sure what to comment in the report
- Successfully set up an overleaf document for the report
- Pushed data exploration files to Github

### Tasks to complete by next meeting

- Have a go at figuring out how to approach the estimation of the posterior distribution (by 15/11/20)

## Meeting 03 - Approaching the estimation of the posterior

- **Date and time:** Sunday 15/11/20 7:00pm
- **Attendees:** Everyone

### Agenda

- Check how everyone is going with trying to estimate the posterior
- Get starting on planning out the report structure

### Meeting notes

- Best approach seems to be to pick the priors of the theta tildes empirically - normal distributions seemed to work quite well
- After the prior was chosen, the posterior distribution was able to be easily derived
- MCMC was able to be implemented with mostly no problems, so we now have our estimates for the GARCH model parameters
- Predicting the volatility on the next day was easily done using the GARCH model parameter estiamtes
- VB seems interesting, but it looks like we might not have time to attempt it
- We should look online to check what what else we might need to put into the data exploration section

### Tasks to complete by next meeting

- Upload the prior experimentation and MCMC code onto Github (by 19/11/20)
- Finish writing up the section on the MCMC implementation (by 19/11/20)
- Finish writing up the section on data exploration (by 19/11/20)
- Get started on the discussion section (by 19/11/20)

## Meeting 04 - Getting starting on the report

- **Date and time:** Friday 20/11/20 7:00pm
- **Attendees:** Everyone

### Agenda

- Get started on writing up the bulk of the report

### Meeting notes

- Started and edited the introduction
- Edited parts of the EDA
- Discussed what to the in discussion and results

### Tasks to complete by next meeting

- Finish writing up the dicussion and results sections (by 23/11/20)

## Meeting 05 - Finishing up writing the report

- **Date and time:** Monday 23/11/20 7:30pm
- **Attendees:** Everyone

### Agenda

- Make any final edits to the report and code

### Meeting notes

- Edited the code to include SD estimates for the original parameters and the trace plots for the original parameters
- Put the tables and trace plots for the original parameters in the report

### Tasks to complete by next meeting

- Nothing of note
