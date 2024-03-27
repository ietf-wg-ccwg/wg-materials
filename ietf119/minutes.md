# CCWG Working Group - IETF 119

Thursday March 21, 13:00 - 15:00 GMT+10

## Chair Slides - Chairs

* Welcome, Hybrid Meeting Details, Note Well, Code of Conduct, Agenda

## 5033bis: Specifying New Congestion Control Algorithms - draft-ietf-ccwg-rfc5033bis - Martin Duke

Martin presents 5033bis Overview
* Not many reviews yet
* More reviews would be nice

Zaheduzzaman Sarker (as individual): RMCAT has published some documents, can we generalize something from there?

Martin: 95% sure we name checked the RMCAT documents in the draft. However, not sure what guidelines to give with respect to RMCAT algorithms, given the level of deployment. If they gain wide adoption, it would become more important.

Christian Huitema: Want to reinforce that being fair has multiple dimensions. We used to measure being fair using simulation and compare regards to bandwidth. Other dimensions of being fair is increasing packet loss rate in one of the compared algorithms or increase RTT which would both be bad. So one of the value of what we're doing here is say: Be careful when you analyze, there's multiple dimesions. It's ok to be a bit fuzzy on bandwidth equality if in return you get better fairness to other metrics. You have to control what you're doing and you have to understand what you're doing.

Lars Eggert: Something we could put in document is that you shouldn't impair the path for others.

Filed [Issue #97](https://github.com/ietf-wg-ccwg/rfc5033bis/issues/97).

Martin: Invite people to read what is there and comment.

Lars: Real Time CCs are different: Typically real-time workflows have bandwidth cap, they aren't like bulk transfers, which is nice because the harm potential is lower. And they are typicaly deployed in conference system which require tight feeback loops. Feedback loops are probably more real-time than the ones we see for TCP or other CCs. Those things together make real-time less problematic than we thought it to be when we did RMCAT. Maybe it's okay to not lump those in here.

Martin: Some of the real-time properties are in the document, but we are not doing a CC tutorial, we are trying to focus on what you have to do/show. It's harder to find a good test when nobody has written down what the deployed protocols are doing in a stable way.

Martin continues presenting

Martin: Should we proceed?

Eric: Now is a good time to review.

Gorry Fairhurst: Agree with what Martin said. Joined the mic line because Jonathan Lennox said in the chat: Should data center really include small RTTs among special cases?

Martin: Yes, datacenter is in scope for WG, file an issue

Gorry: Datacenter was out of scope of original spec. That has changed. Should create an issue in github.

[Issue #98](https://github.com/ietf-wg-ccwg/rfc5033bis/issues/98)

Christian: Regarding datacenter deployments, we have to be very specific what we mean. Some are very uniquely datacenter, e.g. sending a query to 1000 nodes at the same time. These are not typically found on the Internet. Please give some details on the scenarios.

Lars: Good point. The other thing that is special is that they typically use co-designed forwarding plane CC proposals that rely on the fabric doing something non-internety which makes it not applicable to the internet. They're still interesting, we still want people to present them, but they should tell us what they do.

Martin: I know a lot of people are here to standardize CCs rather than argue about process. Once we recharter, it might be more interesting to you.

Lars: Had a bunch of sidemeetings with people unhappy with RoCE (RDMA over Converged Ethernet) there's a desire to come up with solution for ethernet fabrics. That would be interesting to see here: What do you expect from your fabric? What can you then do with your CC?

Jeff Tantsura: Couple of discussion on IPPM meant for datacenters, There's a number of CCs deployed today, DCQCN with a combination of ECN marking forward and EHC (?) backwards. From 1000 GPUs last year we went to 100k this year, so that's 100k endpoints talking to each other all the time. Special cc is needed. If your GPU is idle 20% of time you lose 20% of value. You'll see in the presentation on HPCC there's similar efforts with different signals. We need something that is very fast in the order of a few RTTs, that really makes a difference in terms of how the network behaves. Secondary where it is done (endpoints/switch/NICs/...). But these things need to happen and we believe CCWG is the right place to do it.

Martin: This doc is has language that it's okay to standardize something that's not usable in the general internet (with appropriate scoping), comments to make that more clear are welcome - please follow-up in the github, or via email. We will open an issue. The CCWG charter has it in scope.

Reese: Who has read the draft? Show of hands:

Yes: 12

No: 13

No Opinion: 0

Participants: 60

## Increase of the Congestion Window when the Sender Is Rate-Limited - draft-welzl-ccwg-ratelimited-increase - Gorry Fairhurst

Gorry presents

Christian: I am uneasy when I see doc equating CC with CWND, there are a number of protocols that don't use CWND as the primary control to sending, e.g., BBR in which the limiting is done on the pacing rate as a primary control variable and you only use CWND as a kind of safelty belt. So I'd like when we do an RFC like that we first explain in neutral terms what the goal is and then define that goal into what it does to the values implemented in a control protocol. You mention Reno and Cubic, I'd like to add Hystart, which is in that category. All these documents I'd like to separate principles and implementation. CWND is the implementation, not the principle.

Gorry: This proposes a small change to update specific RFCs, and these are defined in terms of the CWND. 

Christian: Fine to say for Reno we need to do this and that. But, there should be some sort of first principle based approach. If you are not fully using your capacity and you can measure that, then you should not augment it. And that declines differently for different algorithms.

Gorry: Does BBR do something different to this in reality?

Ian Swett: In general you need to be not app-limited for an entire round or some portion of the round to increase the rate. Especially in the growth phase. But the point is, you need some code to not just to check for cwnd, you need a check for 'have you been app limited?'. It's a little more subtle but that's just the nature of BBR.

Ian: This is an important point, this should be written down somewhere, we should try to come to a set of principles. Not to be overly prescriptive, I don't think we need a number like two, but we do need to say 'are you app limited?' RFC 9002 has some text around this. Not perfect, quite vague, but more in the right direction than not. Question: Does this belong in 5033bis as a general principle of how CC should be? I think we should update the RFCs as we update them, not sure if its worth a update just for this one thing.

Martin: 5033 is about evaluating, not this.

Gorry: Motivation for updating is that the topic touches several RFCs, that we think ought to be consistent. This would be a place to write one update rather than for all of these RFCs.

Eric: We will start quick polls to see if the WG understands each piece of work and to prioritize future work.

Ian: I think the answer to "is this worth addressing" is "yes". But how to address it is more of a question.

Lars: We should remind ourselves that an option is to declare some specs as historic, because it doesn't have deployment. Rather than updating we may just say an RFC is historic, rather than waste effort

This is a problem that we understand enough to tackle and the wg should take this on:

Yes: 22

No: 0

No Opinion: 7

Participants: 64

## 8298bis: Updated SCReAM congestion control - draft-johansson-ccwg-rfc8298bis-screamv2 - Ingemar Johansson

Ingemar presents.

Ian: This is nice. Nit: calling it cwnd and saying it can go above it is blowing my mind. I get your algorihtm, and have no concerns about the implementation, but maybe we need another variable. The concept of max bytes in flight and cwnd exists, maybe another name would be better. 

Zahed: You showed some results, can we get like some comparison of SCREaM and SCReAMv2?

Ingemar: Some answer is given here on the slide comparing L4S with non-L4S, though at that time the congestion window was a harder limit, but you need to blow up the cwnd a bit more to cope with change, now we keep it a soft limit and do validation of the window. We are more adapted to the case where throughput drops or we go from an application-limited state to a non-application-limited state. On top of that, the computation of the video rate is simpler, more stable, more comprehensible.

Zahed: So it is implementation learnings and new kind of congestion indicators

Ingemar: Yes, repair of past mistakes

Gorry: Thanks for bringing this here. I think CWND is a limit of the max bytes in flight, so maybe as Ian said it's just a wording thing.

Ingemar: Perhaps we should rename, cause it caused confusion?

Gorry: Don't need to discuss name now.

Abhishek Tiwari: Two questions: 1. Results for L4S were on cellular? Congestion indication was added at the scheduler? Moving to 75% on an operating point if the variation between I and P frames is large. On a real-time video stream, how to know beforehand?

Ingemar: First question: In this case is very simple wireline bottleneck with an AQM that does L4S marking, 4ms queuing delay. But this can be dual queue AQM as well. For cellular, we do congestion detection on the lower layers. Second: This is based on a computed histogram of frame sizes, it's a leaky histogram so if your video properties change you get a new histogram. It's not documented in an RFC but it is somewhat documented in proposed draft.

Eric: Show of hands: This is worth addressing, and the working group should take this on

Yes: 16

No: 1

No Opinion: 13

Participants: 73

## HPCC++ - draft-miao-ccwg-hpcc, draft-miao-ccwg-hpcc-info - Rui Miao

Rui Miao presents.

Xiao Min: In HPCC info draft, you provide 3 options for CC notifications. For the three options, do you have any comparison? Are they similar in performance?

Rui: Those formats are just the way you can encode the information into the packet, the information of all formats is the same. They may have some differences in accuracy, but the point is you capture the necessary information so the algorithm can run correctly. Different vendors have flexibility do choose format. Wanted to decouple format from algorithm.

Xiao: Have you tested all options?

Rui: We have deployed and tested some of them but not all, but that should be our future work.

Xiao: 3 options use different layer to encode the information, so maybe they have different performances. If you have any test, would be great if you could pass results.

Lawrence Stewart: Wondered if you could speak whether the switching fabric you're showing here uses virtual output queueing or regular queuing?

Rui: Queueing mechanism is orthogonal to the algorithm. Switches may have multiple queues, if you support multiple especially virtual, if you have traffic in other queues, computing control becomes very complex. In our draft we have an algorithm to address that.

Eric: Show of hands: This is a problem that is worth addressing, and the working group should take this on

Yes: 9

No: 3

No Opinion: 15

Participants: 72

## BBRv3 Update and Deployment Status - Neal Cardwell

Neal presents.

Ingemar: Question about 2%, is it based on some kind of empirical studies? Can be different depending on BDP.

Neal: It is based on experience on youtube and google.com on our internal LAN. If we turn this document into a WG item, that magic number will receive lots of attention and we can put some more science and engineering into it. The timescale over which it's measured is about a single RTT, the average loss rate is typically lower than that, but that's the maximum it's willing to tolerate over a single Round Trip.

Ingemar: You mentioned L4S: We have BBRv2 you have like find a limit, is that lifted?

Neal: That magic number is still in code, We've only been using ECN within google at low RTTs. For using shallow threshold ECN over the public Internet, that should happen in a context that coexists well with Prague, that support is not in the code at the moment.

Martin: Can you speak about what non-Google entities are using BBR and what version?

Neal: I think Amazon Cloud CDN uses BBRv1, Akamai uses BBR some version for significant percentage of traffic, DropBox uses BBRv2. Maybe Meta folks in the room can chime in?

Martin: Thanks, the fact that we have all these versions is a compelling argument to standardize

Alessandro Ghedini: Cloudflare is also using BBR for TCP and trying for QUIC. We found that defining the algorithm in the draft is one thing and actually implementing it and making performant is another, it required reverse engineering of the Linux implementation to learn Gotchas that are probably not that uncommon. I would like to see WG work on the BBR algorithm itself but also figure out what work we need to do to implement it properly. You're gonna replace V1 in Linux upstream, that makes sense. But it would also be useful to keep having the out of tree with both v3 and v1 to be able to test it better. Do you have thoughts on whether you'll be able to maintain that out of tree fork for some time?

Neal: Think we could do that. Github fork has the old v1 code for folks that want to do AB testing on large sites, is that what you had in mind?

Alessandro: Yea, we could deploy our own Linux patches and ideally we wouldn't maintain that patch ourselves. Some other folks might be interested in the same kind of changes.

Cullen Jennings: This is largely in context of MoQ. We're using it a lot, work that Cisco is doing in conjunction with Christian Huitema. What testing is done in particular in Wifi and what network characteristics do you have?

Neal: We talked about it at IETF 101 I think. [Audio lost] It's maximum aggregation estimate which is particularly important for Wifi but is also relevant for Cellular and DOCSIS which also have significant aggregation.

Cullen: I find it shocking, given the huge deployment and everything going on, that it is not a working group draft yet. I think we should adopt this and figure out what we need to do.

Matt Joras: To the question about deployment, Meta uses BBRv1-ish with our QUIC deployment which is the vast majority and rest uses v1 in Linux TCP. We are currently working on what is maybe v2.5 plus other stuff in our QUIC implementation and we're experimenting with that. Echoing Cullen, we think the WG should work on it and happy to support editorial work.

Mo Zanaty: Echo Cullen, experimenting with it in MoQ. Tested V3 is better that v2 in our experiments, still lots of impedience mismatches with media. When you said it's default for Youtube, is that only VoD Youtube or is it also live/TV and live/real-time critical? Anything Media App specific or do you model media as typical elephant flows?

Neal: As far as I'm aware, BBR is used for all of the YouTube TCP connections. Maybe Ian can speak about transport used for live services. Our experience has been that BBR is not great for real-time, it was not designed for that. Have ideas for how it could be improved to make it a better fit, but haven't deployed anything like that.

Ian: All Youtube products that are user facing are TCP or QUIC BBR. Ingestion is different. Real-time has challenges with BBR. Mostly about app-limited nature.

Mo: Like to see adopted and would like to contribute to make it work for real-time media and app-limited flows. Rather than having SCReAM and 10 different rate controls for different applications, it'd be better to have a common rate control for most applications.

Eric: Show of hands: This is a problem that is worth addressing, and the working group should take this on

Yes: 36

No: 1

No Opinion: 0

Participants: 71

Lars: First step to work on something here is to get rid of the versions and ++ etc. I'm really interested in BBR, we definitely should be doing this, this is the right group. But the plethora of variants is making it real hard to understand what's working and what isn't. If we could agree on focusing on v3 ish variant that would make me happier.

## Next steps for CCWG - Chairs

Eric presents.

Lars: You said we can put stuff on the independent submission stream, but it's up to the editor, the proponent of a CC scheme can take it directly to the ISE and get an RFC number, the WG need not even hear about it. It is possible to publish something for posterity on the IRTF or IETF stream, we can choose to publish that through the WG.

Reese: ICCRG can have presentations on algorithms that are worked on in CCWG, just wanted to clarify that. We can totally have a research-y BBR presentation in ICCRG.

Eric: Yes, this also means we get to have more than one 2 hour block in an IETF week where we can talk about awesome congestion control concepts. We're coordinating closely with ICCRG and we'd love your feedback.

Eric continues presenting

Martin: I'm curious what timeline you think of. Would be disappointed if 5033bis isn't done well before Vancouver. Do you want a draft charter before Vancouver via the list?

Eric: We've already started on updates to the charter. We are chartered right now to talk about everything on this list, the main change is to reflect the fact that 5033bis is done. Agree with you, try to move that on before Vancouver

Alessandro: One thing is defining CC, another is implementing. Is there any room for work on testing CC, implementations, things to look for, what scenarios one should test?

Reese: We have 5033bis, but also ICCRG talked about testing CC earlier today, brought up idea of Hackathon in Vancouver.

Eric: Brief thumbs up for the Hackathon in Vancouver? I see a couple thumbs up. It'll be good to be on the same page on what kinds of tests we want to see.

