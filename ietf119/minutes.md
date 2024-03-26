# CCWG Working Group - IETF 119

Thursday March 21, 13:00 - 15:00 GMT+10

## Chair Slides - Chairs, onsite, 10 minutes

* Welcome, Hybrid Meeting Details, Note Well, Code of Conduct, Agenda

## 5033bis: Specifying New Congestion Control Algorithms - draft-ietf-ccwg-rfc5033bis, slides - Martin Duke, onsite, 15 minutes

Martin presents 5033bis Overview
* Not many reviews yet
* More reviews would be nice

Zahed: RMCAT has published some documents, can we generalize something from there?
Martin: 95% sure we checked the documents in the draft, not sure what guidelines to give with respect to RMCAT algorithms, it is hard to say what is deployed vs. what is in the RFCs
Christian: Want to reinforce that being fair has multiple dimensions, used to do simulation and compare regards to bandwidth, other dimension is increasing packet loss rate in one of the compared algorithms or increase RTT which would both be bad. It's ok to be a bit fuzzy on bandwidth equality if in return you get better fairness to other metrics.
Lars: Something we could put in document is that you shouldn't impair the path for others
Filed [Issue #97](https://github.com/ietf-wg-ccwg/rfc5033bis/issues/97).
Martin: Invite people to read what is there and comment
Lars: Typically real-time workflows have bandwidth cap, which is nice because harm potential is capped. They are typically deployed in conference system which require tight feedback loops. Feedback loops are probably more real-time than TCP or other CCs. Those things together make real-time less problematic than we thought it to be
Martin: Some of the real-time properties are in the document, but trying to focus on what you have to do/show.

Martin continues presenting

Martin: Should we proceed?
Eric: Now is a good time to review
Gorry: Agree with what MArtin said. Should data center really include small RTTs among special cases?
Martin: Yes, datacenter is in scope for WG, file an issue
Gorry: Datacenter was out of scope of original spec. That has changed. Should create an issue in GitHub.
[Issue #98](https://github.com/ietf-wg-ccwg/rfc5033bis/issues/98)
Christian: Regarding datacenter deployments, we have to be very specific what we mean. Some are very uniquely, e.g. sending a query to 1000 nodes at the same time. Please also look at that.
Lars: Good point. The other thing that is special is that they use something non-internety which makes it not applicable to the internet.
Martin: 
Lars: Had a bunch of sidemeetings with people unhappy with RoCE (RDMA over Converged Ethernet) there's a desire to come up with solution for Ethernet fabrics
Jeff: Couple of discussion on IPPM meant for datacenters,  [...] special cc is needed, if GPU is idle 20% of time you lose 20% of value, secondary where it is done (endpoints/switch/NICs/...)
Martin: Doc is intended/has language to standardize something that's not usable in the general internet (with appropriate scoping), comments to make that more clear are wellcome - please follow-up in the GitHub, or via email. We will open an issue. The CCWG charter has it in scope.
Reese: Who has read the draft? Show of hands:
Yes: 12
No: 12
No Opinion: 0
Participants: 60

## Increase of the Congestion Window when the Sender Is Rate-Limited - draft-welzl-ccwg-ratelimited-increase, slides - Gorry Fairhurst, remote, 15 minutes

Gorry presents

Christian: I am uneasy when I see doc equating CC with CWND, there are a number of protocols that don't use CWND as the primary control to sending, e.g., BBR in which CWND is set to about twice what you need because the rate limiting is based on the pacing rate as primary control variable. This only uses CWND as some kind of safety belt. So I'd like when we do an RFC like that we first explain in neutral terms what the goal is and then define that goal into what it does to the values implemented in a control protocol. You mention Reno and Cubic, I'd like to add Hystart, which is in that category. All these documents I'd like to separate principles and implementation. 
Gorry: This proposes a small change to update specific RFCs, and these are defined in terms of the CWND. 
Christian: Fine to say for Reno we need to do this and that. But, there should be some sort of first principle based approach.
Gorry: Does BBR do something different in reality?
Ian: In general you need to be not app-limited for an entire round or some portion of the round to increase the rate. Especially in the growth phase. You need some case to have a check for 'have you been app limited?'
Ian: Important point, this should be written down somewhere. I don't think we need a number like two, but we do need to say 'are you app limited?' RFC 9002 has some text around this. Not perfect, quite vague, but more in the right direction than not. Does this belong in 5033bis or somewhere else? I think we should update the RFCs as we update them, not sure if its worth a update now
Martin: 5033 is about evaluating, not this.
Gorry: Motivation for updating is that the topic touches several RFCs, that we think ought to be consistent. This would be a place to write one update rather than for all of these RFCs.
Eric: We will start quick polls to see if the WG understands each piece of work and to prioritize future work.
Ian: I think the answer "is this worth addressing" is "yes".
Lars: We should remind ourselves that an option is to declare some specs as historic. Rather than updating we may just say an RFC is historic, rather than waste effort

This is a problem that we understand enough to tackle and the wg should take this on:
Yes: 22
No: 0
No Opinion: 7
Participants: 64

## 8298bis: Updated SCReAM congestion control - draft-johansson-ccwg-rfc8298bis-screamv2, slides - Ingemar Johansson, remote, 20 minutes

Ingemar presents.

Ian: Nit: calling it cwnd and saying it can go above it is blowing my mind. I get your algorithm, and have no concerns, but maybe we need another variable. The concept of max bytes in flight and cwnd exists, maybe another name would be better. 
Zahed: You showed some ratios, can we get like some comparison of scream and scream v2?
Ingemar: [...?] On top, computation of video rate is simpler, more stable, more comprehensible
Zahed: So it is implementation learnings and new kind of congestion indicators
Ingemar: Yes, learned from past mistakes
Gorry: Thanks for bringing it here. I think CWND is a limit of the max bytes in flight, so maybe as Ian said it's just a wording thing.
Ingemar: Perhaps we should rename, cause it caused confusion?
Gorry: Don't need to discuss name now.
Abishek: Results for L4S were on cellular?
Abishek: Moving to 75% on operating point, variation between I and P frames is large, how to know beforehand?
Ingemar: First question: In this case is very simple wireline bottleneck. Can be dual queue [L4S or AQM?] as well. second: Frame sizes is a histogram, is documented in proposed draft.

Eric: Show of hands: This is worth addressing, and the working group should take this on
Yes: 15
No: 1
No Opinion: 13
Participants: 73

## HPCC++ - draft-miao-ccwg-hpcc, draft-miao-ccwg-hpcc-info, slides - Rui Miao, 20 minutes

Rui Miao presents.

Xiao Min: In HPCC info draft, you provide 3 options for CC notifications. For the three options, do you have any comparison? Are they similar in performance?
Rui: Those formats are just the way you can encode the format, the information of all formats is the same. They may have some differences in accuracy, but the point is you capture the necessary information so the algorithm can run correctly. Different vendors have flexibility do choose format. Wanted to decouple format from algorithm.
Xiao: Have you tested all options?
Rui: We have deployed and tested some of them but not all
Xiao: 3 options use different layer to encode the information, so maybe they have different performances. If you have any test, would be great if you could pass results.
Lawrence: Wondered if you could speak whether switching fabric using virtual output queuing or regular queuing?
Rui: Switching may have multiple queues, if you support multiple especially virtual, computing control becomes very complex.

Eric: Show of hands: This is a problem that is worth addressing, and the working group should take this on
Yes: 9
No: 3
No Opinion: 15
Participants: 72

## BBRv3 Update and Deployment Status - slides - Neal Cardwell, remote, 10 minutes

Neil presents.

Ingemar: Question about 2%, is it based on some kind of analysis [...?]
Neil: It is based on experience on YouTube and google.com on the internal LAN. If we turn this into WG item, that magic number will receive lots of attention and will need some more science and measurements. The timescale is about a single RTT, the average loss rate is typically lower than that.
Ingemar: Mentioned L4S: We have BBRv2 you have like ... limit?
Neil: The magic number is still in code, We've been using ECN with google at low RTTs 
Martin: Can you speak about what non-Google entities are using BBR and what version?
Neil: I think Amazon Cloud CDN use BBRv1, Akamai use BBR some version for significant amount of traffic, DropBox uses BBRv2. Maybe Meta folks in the room can chime in?
Martin: Thanks, compelling argument to standardize
Alessandro: Cloudflare, also using BBR for TCP trying for QUIC. Actually implementing it and making performant, required reverse engineering of the Linux implementation to learn Gotchas I would like to see WG work on standardizing. You're gonna replace V1 in Linux upstream, would also be useful to keep having the out of tree with v1 and v2 to be able to test it better. Do you have thoughts on whether you'll be able to maintain that out of tree fork for some time?
Neil: Think we could do that. Github fork has v1 and v2 code , is that what you have in mind?
ALessandr: Yea, we could patch ourselves.
Cullen: This is largely in context of MoQ. We're using it a lot at Cisco. What testing is done in particular in Wifi and what network characteristics you have.
Neil: We talked about it at IETF 101 I think. [Audio lost]
Cullen: Find it shocking, given deployment, that it is not a working group draft yet.
Matt Joras: Question about deployment, meta uses BBRv1-ish with QUIC deployment with is vast majority and rest uses v1 in Linux TCP. Maybe working on what is maybe v2.5. Echoing Cullen, WG should work on it and happy to support editorially.
Mo: Experimenting with it in MoQ. Tested V3 is better that v2 in media. When you said it's default for YouTube, is that live/TV and live/real-time critical? Anything Media App specific or model media as typical elephant flows?
Neil: As far as I'm aware, BBR si used for all of the YouTube TCP connections. Guess, maybe Ian can speak about transport used for live services. Experience has been that BBR is not great for real-time. Have ideas for how it could be improved to make it a better fit. 
Ian: All YouTube products that are user facing are TCP or QUIC BBR. Ingestion is different. Real-time has challenges with BBR. Mostly about app-limited nature.
Mo: Like to see adopted and would like to contribute to make it work for real-time media and different applications.

Eric: Show of hands: This is a problem that is worth addressing, and the working group should take this on
Yes: 30
No: 1
No Opinion: 0
Participants: 71

Lars: First step to work on something here is to get rid of the versions and ++ etc. Plethora of variants is making it real hard to understand what's working and what isn't. If we could agree on focusing on v3 ish variant that would make me happier.

## Next steps for CCWG - slides - Chairs, onsite, 30 minutes

Eric: next steps.

Lars: You said we can put stuff on the independent submission stream, but it's up to the editor. WG can decide what to work on in the WG[?].
Reese: ICCRG can have presentations on algorithms, just wanted to clarify that.
Eric: Yes, can have more than one time during an IETF meeting to talk about congestion control, since we're coordinating across ICCRG and CCWG.

Eric continues presenting

Martin: I'm curious what timeline you think of. Would be disappointed if 5033bis isn't done before Vancouver. 
Eric: We've already started on updates to the charter. Agree with you, try to move that on before Vancouver
Alessandro: One think is defining CC, another is implementing. Is there any room for work on testing CC, things to look for, what scenarios one should test?
Reese: We have 5033bis, but also ICCRG talked about that earlier today, brought up idea of Hackathon in Vancouver
Eric: Brief thumbs up for the Hackathon in Vancouver, this looks positive. [...?]


