# CTCS-Cidorz-Train-Concurrent-System
Programs running inside the fCPUs of a train concurrent scheduling system for the game Factorio

This is a new development based on the idea of my [sequential train system](https://github.com/cid0rz/CTS-Cidorz-Train-System) but in a concurrent way. Please have a look at that project to get familiar with naming and mods used I'll assume you know the basics described there. 
I'll give a general idea of the system and then go into more details of each step.

The principle is there is a Depot that serves to some requesters and providers. The depot sends first a dictionary with all stack sizes so stations can make their calculations and a list of channels permitted for communication. The number of stations/channels/trains should be balanced, the system needs some sensible settings to run smoothly.

Then the depot starts the booking cycle:
* All the requesters that need something can try to use a communication channel (it is chosen randomly from the list). Then collisions are resolved retrying until the channel list is exhausted (actually till channel count is below 3). 
* Once each active requester has either a channel or has desisted from asking this turn (it will try next) the active requesters are synced and they emit their requests at the same time. 
* All available providers will be listening and will record all the orders at once. 
* The list of orders will then be filtered on the providers so only the suitable orders will remain in a list, this is a list of the possible requesters each provider can serve with the current limitations: quantity of the desired product, number of locomotives and number of wagons.
* The providers bid for a requester to serve, they try to serve a certain channel they pick randomly, if there is more than one trying to talk on that channel, 20% of the times they will remove the request from the list and they will try picking another random channel from the list. This process is repeated for a number of times until depot sends a terminating negative signal. (Default retries are 10)
*Finally once each provider has a unique channel and thus request to fulfill we can record the orders in the depot. 

For now The depot I've built is not capable of supplying multiple configurations of trains, the system supports it but the depot has to be built so it can really deliver them. There are many ways of doing so, a simple way is to have multiple stations each with one of the possible train compositions in the system and that can deliver the correct one for the order, other one is to have a similar polling system inside the depot which i find a bit slow. A third one would be if the train compositions is not correct send it back to the depot... I have to think better on a way to do this that I really like so for now all the trains on the system must be identical and must be according to the settings on the stations. 

In this depot each station is responsible for a channel, when its channel has an order it dispatches the trains (that have the correct composition) to the provider. To make it compatible with multiple compositions will increase complexity quite a lot.

