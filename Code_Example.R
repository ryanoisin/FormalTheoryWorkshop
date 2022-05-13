# robinaugh@gmail.com & jonashaslbeck@gmail.com; May 13, 2022

# ------------------------------------------------
# -------- What is this? -------------------------
# ------------------------------------------------

# Code & exercises to play around with the Panic Model; 
# Designed for the Saardland University Theory Workshop


# --------------------------------------------------------------
# -------- Step 1: Install & Load ------------------------------
# --------------------------------------------------------------

# The first step is to install the Panic Model. 
# Go aehad and run the code below to have it installed. 

library(devtools)
install_github("jmbh/PanicModel")
library(PanicModel)

# --------------------------------------------------------------
# -------- Step 2: Introducing simPanic ------------------------
# --------------------------------------------------------------

# Now that the panic model is installed,
# you have a tool to evaluate precisely what this theory predicts. 
# This tool is the function: simPanic. 

# Let's run a quick simulation of 60 time steps. You can think 
# of a time step as being about 1 minute, so a 60 time step
# simulation will give us 1 hour of simulated time. 

out0 <- simPanic(time = 0:60,    
                 stepsize = .001)

# In our output file out0, we have a matrix (outmat) of all the components
# of our theory at each of our 60 time steps. This is our simulated data. 
# We can take a look at it here.

data<-out0$outmat
head(data)

# There is quite a bit of information here. 
# We'll focus on just 2 key components for now.

# A = Physiological Arousal (as indicated by e.g., heart rate)
# PT = Perceived Threat (how much one perceives a threat in that moment)

# Let's visualize how arousal and perceived threat evolve over time
# according to our theory. 

plot.new()
plot.window(xlim = c(0, length(data$A)),  ylim=c(-.75, 1))
axis(1); axis(2)
mtext("Simulation Results", side = 3,line=1,cex=2,adj=0)
mtext("Minutes", side = 1,line=3,cex=1.25)
lines(data$A, col="grey")
lines(data$PT, col="black")
text(50,.9,paste0("(AS = ",round(data$AS[1],2),")"),cex=1.25)
legend("topleft", legend=c("Arousal","Perceived Threat"),
       col = c("grey","black"),
       lty = c(1,1),bty="n",cex=1.25)

# The particular behavior of arousal and perceived threat 
# aren't especially important here. What is important, is that
# using this computational model, you were able to deduce
# precisely what the theory predicts. This gives you a really 
# powerful tool for evaluating what the theory can produce 
# and, thus, what it can explain. 

# --------------------------------------------------------------
# -------- Run a Simulated "Biological Challenge" --------------
# --------------------------------------------------------------

# One of the core phenomena that set out to explain was a very simple one: 
# some people are vulnerable to panic attacks, but others are not.
# In our theory, the key component that explains this individual difference
# is one's beliefs about the danger posed by physiological arousal. We
# refer to this component as "Arousal Schema" (AS).

# Arousal schema defaults to .5 and cna range from 0 to 1. Let's 
# specify a low level of arousal schema so we can take a look at
# someone who should be unlikely to experience a panic attack according
# to our theory. 

initial_spec <- list("AS" = 0.2)

# To evaluate how that person responds to elevations in arousal, let's 
# add an intervention on the system at minute 10 that perturbs arousal,
# pushing it all the way up to 0.5. How do you think this simulated 
# person will respond to this perturbation?

pars_spec <- list("Tx" = list("minuteP"= 10))

# Let's run our simulation again
data <- simPanic(time = 0:60,
                 stepsize = .001, 
                 parameters = pars_spec, 
                 initial = initial_spec)$outmat

# Run the code below to visualize the results: 

plot.new()
plot.window(xlim = c(0, length(data$A)),  ylim=c(-.75, 1))
axis(1); axis(2)
mtext("Simulated Perturbation", side = 3,line=1,cex=2,adj=0)
mtext("Minutes", side = 1,line=3,cex=1.25)
rect(10, -.5, 11,.5, col="grey90",border=FALSE)
lines(data$A, col="grey")
lines(data$PT, col="black")
text(10.5,-0.6,"Perturbation",cex=1.25)
text(50,.9,paste0("(AS = ",round(data$AS[1],2),")"),cex=1.25)
legend("topleft", legend=c("A","PTt"),
       col = c("grey","black"),
       lty = c(1,1),bty="n",cex=1.25)


# Try the simulation a few times. Because there is stochastic 
# variation in arousal, the results will be at least a little
# different every time. Once you have a good sense of how 
# the system responds when Arousal Schema (AS) is set to 0.2, 
# change the Arousal Schema to something new, like 0.8. How
# do you expect the system will respond now? Run the simPanic
# function and visualize the results again to see if you 
# were right in your prediction. 


initial_spec <- list("AS" = 0.4)

# Try a range of AS values (from 0 to 1) to see how the 
# system responds to perturbation under different
# conditions. Can the theory explain individual differences
# in panic attacks?

# --------------------------------------------------------------
# -------- Evaluating Phenomenon 1 ------------------------------
# --------------------------------------------------------------

# The previous simulation does a good job of evaluating
# whether some individuals are more vulnerable to panic than
# others in response to a perturbation. But, remember, that
# our first phenomenon we wanted to explain was the sudden
# surge of arousal and perceived threat *out of the blue.*
# Can the model produce panic attacks that arise from natural
# fluctuations in arousal. To evaluate, let's again 
# start with someone with low Arousal schema to see how 
# the theory predicts arousal and perceived threat will evolve
# over time in someone who is not vulnerable to panic attacks. 

initial_spec <- list("AS" = 0.2) 
pars_spec <- list("Tx" = list("minuteP"= NULL))


# To give a little more time for things to evolve, let's run 24 hours
# of simulated time (60*12). This will take a little bit longer to run.

data <- simPanic(time = 0:(60*24),
                 stepsize = .001, 
                 parameters = pars_spec, 
                 initial = initial_spec)$outmat


# Visualize the findings
plot.new()
plot.window(xlim = c(0, length(data$A)),  ylim=c(-.75, 1))
axis(1); axis(2)
mtext("Simulation Results", side = 3,line=1,cex=2,adj=0)
mtext("Minutes", side = 1,line=3,cex=1.25)
rect(10, -.5, 11,.5, col="grey90",border=FALSE)
lines(data$A, col="grey")
lines(data$PT, col="black")
text(5,-.5,paste0("(AS = ",round(data$AS[1],2),")"),cex=1.25,adj=0)
legend("topleft", legend=c("A","PT"),
       col = c("grey","black"),
       lty = c(1,1),bty="n",cex=1.25)

# What does the theory predict about someone with AS = .20?

# What about AS = 1.0? Run the code below, then rerun the
# simulation above to find out.

initial_spec <- list("AS" = 1.0) 

# Can the theory explain individual difference in vulnerability to panic attacks?

# --------------------------------------------------------------
# -------- Phenomenon 3 ----------------------------------------
# --------------------------------------------------------------

# Let's take a look at one last phenomenon: panic disorder. Can 
# the model explain the tendency for some individuals to become
# increasingly concerned about the danger posed by arousal and
# more vulnerable to recurrent panic attacks? 

initial_spec <- list("AS" = 0.9, "ES"=0) 

# To give even a little more time for things to evolve, let's run 
# just over 2 days of simulated time. This will take a little bit. 

set.seed(2)
data <- simPanic(time = 0:(60*24*2.1),
                 stepsize = .001, 
                 parameters = pars_spec, 
                 initial = initial_spec)$outmat


# Visualize the findings
plot.new()
plot.window(xlim = c(0, length(data$A)),  ylim=c(-.75, 1))
axis(1); axis(2)
mtext("Simulation Results", side = 3,line=1,cex=2,adj=0)
mtext("Minutes", side = 1,line=3,cex=1.25)
rect(10, -.5, 11,.5, col="grey90",border=FALSE)
lines(data$A, col="grey")
lines(data$PT, col="black")
lines(data$AS, col="red")
legend("topleft", legend=c("A","PT","AS"),
       col = c("grey","black","red"),
       lty = c(1,1,1),bty="n",cex=1.25)

# What happens to AS after the experience of a panic attack?
# With this change, is the system more or less vulnerable to
# panic attacks in the future? 

# --------------------------------------------------------------
# -------- Conclusion -------------------------------------------
# --------------------------------------------------------------

# Overall, how did the model do? Was it able to produce the
# phenomena it set out to explain? 
