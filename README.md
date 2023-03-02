# Chargefox Code Test

Make sure you read **all** of this document carefully, and follow the guidelines in it. Pay particular attention to the "What We Care About" section.

## Background

When customers charge their cars at a charging station, the charger sends meter values in order to update the user on the progress of their charging session. 

With this app we want to display the final meter value for each charge session and calculate the average rate of charge for each user.

## Glossary

### kWh (Kilowatt-hour)
It is the unit of measurement of electricity. A kilowatt-hour (kWh) measures how much energy is transferred from the charging station to your electric car in one hour. 1 kilowatt-hour is equal to 1,000 watt-hours (Wh).

### kW (Kilowatt)
It is a unit for measuring real-time electrical power. It is the rate at which power is transferred from a charging station to an electric vehicle. 1 kilowatt is equal to 1,000 watts (W).

### Rate of Charge
The speed of the charge (at the time the meter value was created). Normally expressed in kW but in the code we use W.

### Meter Value
The cumulative amount of energy sent to the car in a charging session. Normally expressed in kWh but in the code we use Wh.

## Requirements

* Load the charge sessions and link the meter values based on the id
  * Calculate the total of each session
  * Calculate the average rate of charge for each session
* Return a JSON string containing the result of all of the charge sessions for each user

See `spec/charger_app_integration_spec.rb` 

## What We Care About

We are interested in your approach to the problem and not just the end result. We will go through your code with you afterwards and you can talk with us about how you tackled the problem.

There are some things you should aim for in your code:

- Good object modelling and design. Even if this could be solved with a procedural approach, we want to see an object oriented solution. 
- Production quality code. Code that could be used in a much larger codebase, easily extensible
- Good testing approach. Hint: you should write more tests than are provided, maybe some unit tests
- Great usage of Git and commit messages. Commit small changes often so we can see your approach (please include the `.git` directory in your final submission)

## Submitting your solution

When you are ready to submit your solution, use `git bundle` to package up a copy of your repository (with complete commit history) as a single file and send it to us as an email attachment.

```
git bundle create chargefox-code-test.bundle main
```
