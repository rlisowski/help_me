* Q: Why you using _docker-compose_ for development?
* A: I usually don't but this time I decided to isolate the dev environment.


* Q: Why an asynchronous worker translates to German in the background?
* A: The translation is done automatically by external service. 
     I want to keep the app up and running even if the service is down or the quota is exceeded.


* Q: Why the questions and answers are limited to 256 chars?
* A: I'm using a free version of [Translator Text API](https://azure.microsoft.com/en-us/services/cognitive-services/translator-text-api/). I didn't want to hit quota too early.


* Q: Why UUIDs?
* A: In task description is written than I should assume high traffic. In such scenario it's very likely that you have HA architecture like master-master synchronization. UUIDs generates less collisions than standard numeric primary keys so that synchronization would be easier.

* Q: Why there is no FactoryBot?
* A: I know that FactoryBot is very popular and I also use it in many projects but this one is really simple and does not need it yet.
