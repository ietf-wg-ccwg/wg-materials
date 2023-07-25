
# CCWG - IETF 117
Time and Date

Tuesday, July 25, 2023, 15:00 - 16:30 (GMT -7)
Location: Plaza B

Administrivia

- Blue sheets / scribe selection / NOTE WELL
- Agenda revision


## Chair Slides - Chairs, 10 minutes

Gorry: Q if his work may fit into the charter of this WG

Reese: Let's discuss after your presentation.


## 5033bis - Martin Duke, 10 minutes

[RFC5033 Specifying New Congestion Control Algorithms](https://datatracker.ietf.org/doc/html/rfc5033)
[RFC5033BIS draft-00](https://datatracker.ietf.org/doc/html/draft-scheffenegger-congress-rfc5033bis-00)

Christian: Discussing before; big issue in 5033 - some recommendation having negative effects. This makes me wary of makeing a carbon copy. 

Martin: If we adopted this, we evaluate all text. Or should we have a completely new draft.

Christian: It's a starting point.

Ian: No one will be found to provide a better starting point. Empty new document has too much scorched earth with it.

Gorry: Agree with Ian.

(Physical) Show of hands - who has skimmed 5033 and know what it is about. (~15 hands up)

Show of hands - is 5033 a good starting point: pro 30, con 1, undecided 11

5033bis will acknowledge authors of RFC 5033, Sally Floyd and Mark Allman. Sally Floyd died in 2019 and it would be presumptuous to add her name as author of a new document, but her contributions in this area should be recognized and acknowledged.

Christian: Not enough experience 

Gorry: Keep this on the radar. We may know the point what people should look at.

Ian: We don't have enough information for a solid recommendation

Matt: No worse than browsers opening multiple connections.

(fairness)
Matt: Replace Fairness with Freedom from Starvation. Bandwidth is typically very high.

Christian: Agree with Matt.


## Analysis for the Differences Between Standard Congestion Control Schemes - Yoshifumi Nishida, 10 minutes

Vidhi: Are we telling devs to match with 5681 or 9002. 

Martin: This shows we should update some of the TCP RFC - none of this was controversial in QUIC. 

Vidhi: I think there is a small issue, you can not use cwnd direct, cwnd validation draft is also talking about. So 9002 is also missing some minor details really.

Martin: 9002 is certainly not perfect.

Michael: If we sync TCP and QUIC, we should sync SCTP too.


Martin: Another way is to make a transport agnostic reno CC document. Lots of space for someone to take this up.


## Guidelines for Internet Congestion Control at Endpoints - Gorry Fairhurst, 15 minutes

Bob: Point about effectively policing: Need evidence that things are broken. Fixinung unbroken things is problematic

Christian: I am a bit worried that if we do two of these at the same time, you end up having two simultaneous ways of saying almost the same thing, but not quite, and I don't think that's a good outcome.

Stuart: Idea: Working Group should consider adopting a new term instead of "congestion control". That term puts the wrong idea in many people's minds. I suggest something like "Rate optimizer algorithm". Many software engineers think they can build their own protocol running over UDP that will work better than TCP or QUIC, and they think their protocol doesn't need any congestion control because they've been told that modern networks don't have any congestion. A good protocol should (in most cases) strive to give the best user experience by adjusting its sending rate to the maximum it can achieve without exceeding its share of its bottleneck link. This is what we actually mean when we say "congestion control", but it would be understandable to more people if we called it something like the "throughput maximizer algorithm". It doesn't take a stadium full of sports fans to make a network congested — one person sending one photograph from their smartphone should be able to fully utilize their bottleneck link to 100% capacity, whether that bottleneck is their first-hop Wi-Fi link or their cable modem uplink. If it didn't, that would be a bug. Being used at or near 100% capacity is what we call "congestion", that is exactly the state we want our networks to be in whenever they are being used. There's generally no reward for leaving network capacity unused, letting it go to waste.

Spencer: Thinking about names: I agree with Stuart that it's useful to think about "rate optimization" by any name, and Stuart's reasoning matches my experience. I think this is an important thing to do for another reason - most of the conversations I have with people about media protocols are using the term "rate adaptation", and talking about rate adaptation, rate control, etc. I hope those kinds of protocols are also in scope for this WG, especially since RMCAT has just concluded, and all of their mechanisms were published as Experimental.

Christian: Yes. But there is a limit to any self option 

(from google): Don't rename things away from Congestion Control, this is a relatively good name. Long list of documents who says slightly different thind. I tend to have a single document

Matt: Van Jacobsen said he doesn't like the term congestion control as it is ambigious


Show of hands: Who has read Gorry's draft: 2 persons.

Gorry: Don't see people running to me - so will stop working more on this old document.

Reese: Will shuffle this excellent discussion into 5033bis.

## BBR - Neal Cardwell, 20 minutes

Barak Gafni: On Convergence of different Flows: Can you disclose the assumptions about the buffering and queuing in the fabric.

Neal: Simple Fifo Queues with drop tail behavior.


Vidhi: In the first two bugs - I noticed the trend its more aggresive during probing. Did you measure in that phase:

Neal: Latency seems to be in the same range; Change mainly shifted between flows not reduce queue on bottleneck.

Gorry: IRTF work, or submit the draft for discussion. 

Neal: No concrete plans - there may be drafts that are dependent on this. Would be good to know the plan

Rui Paulo: Are there impacts on L4S, I noticed a note on GitHub that there might be?

Neal: No high level conceptional changes. Deployment model is in spirt with DCTCP - in Linux specific CC per route on the host. New feature: Knowledge that this route is low latency ECN - use then this functionality in BBRv3. Discussion in readme document

Christian: Less efficient than HyStart: BBR tends to exit later. Considered to use hystart++ with BBR.

Neal: We haven't experimented with that, makes sense to use Hystart++

Abishek Tiwari: Are the changes of magic numbers backed by analytics, or based on measurement

Neal: There are some reasons for this which make logical sense.



## Datagram Congestion Control Protocol (DCCP) Congestion Control - Nathalie Romo Moreno, 10 minutes

Spencer: Having a stable reference would matter more than having an RFC. For Cubic, the thinking has been that it wasn't important to standardize congestion controllers because they have been works in progress for decades, and I think that's still true unless something has changed recently. Referring to an informational RFC for a DCCP CC profile works for me.

Michael(TCPM): There is a Cubic bis document that will be out soon (RFC editor)

Gorry(TSVWG): This is TSVWG decision. I think we need a standards action there for the DCCP spec. Some of the values are with IANA, 

Martin (AD): Registration should be done in TSVWG, rather than in this venue.

## HPCC++: Enhanced High Precision Congestion Control and Inband Telemetry for HPCC++ - Jeff Tantsura, 15 minutes

Greg Mirsky: How critical is it that the telemetric info is collected in the data packet. There are several mechanisms. Trigger packet AIM gives what information is expected. This could be raw, aggregated or exported via the control plane.

Jeff: We assumed, the packet carries this data forward to the receiver as the initial approach. More discussions around this are done. Introduce this approach to the community and see if we can build on top of that a better network.

Greg: Congestion in a particaler place could be cause by single flow or multiple flow. 

Jeff: Trade off is reaction time: Assuming offloading capabilities - in a control plane the feedback would take a long time.

Dimitry: Reaction time - DC few round times in O(microseconds). This kind of congestion information source - allows to distiguish between end host and the middle. Modern DC have many hundred paths - could repath to different path. Therefore you need to differentiate betwnnt endpoint and network

Jeff: Once per RTT seems to be a good speed. 

Altanai: Did you weigh oob impacts 

Jeff: We focussed on this apprach when starting this work.

