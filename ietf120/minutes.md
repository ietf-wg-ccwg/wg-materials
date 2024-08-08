# CCWG at IETF 120
Chairs: Eric Kinnear, Reese Enghardt
Notetaker: Gorry Fairhurst

## Increase of the Congestion Window when the Sender is Rate-Limited, draft-welzl-ccwg-ratelimited-increase, Michael Welzl.

Stuart Cheshire: Slide 4, (agreeing with slide) the absence of indication of congestion is not evidence that there is no congestion. 

Neal Cardwell: Stuart's comment is interesting to incorporate. Question about how the spec is structured: The MaxFS could seem to be over a time longer than an RTT, so we could use evidence from minutes, hours, days ago to justify the increase of the cwnd now. I wonder if we want to structure it so you can only use the flight size in the most recent round trip time, that's how the Linux code is structured.
- Michael: New congestion window validation (CWV) controls this case, which is an Experimental spec. Either way this is just a SHOULD.

Ian Swett: RFC9002 already has text similar to the words in the slides. Not sure it's worth bothering to update RFC 9002.
- Michael: This would play out in the same way. We're just trying to find simpler words for the same thing.

Matt Mathis: There needs to be a clear boundary between this work and new experimental CWND validation work.
- Michael: Exactly, that's what we're trying to do.

Chairs:
* I have read draft-welzl-ccwg-ratelimited-increase: 10 Yes, 30 No (of 74).
* The working group should work on this topic: 19 (physical hands in the room due to Meetecho poll issue).
* The working group should NOT work on this topic: none.
* This document is a good starting point for a solution: 25 Yes, 2 No, 5 No Opinion (of 82).

## BBRv3, draft-cardwell-ccwg-bbr, Neal Cardwell.

Draft has been moved to [Github](https://github.com/ietf-wg-ccwg/draft-cardwell-ccwg-bbr), welcoming contributions there.

John Border: At ANRW yesterday, there was a talk that claimed fairness was reduced for BBRv3 ([Link to paper](https://dl.acm.org/doi/abs/10.1145/3673422.3674889) via chat)

Neal: Not sure exactly which paper that was, but I have seen some papers in various places with that kind of result. If you think about the dynamics of the changes, you can understand why that would be. We've been able to reproduce issues like that in the lab as well, this is an area where we'd like to make improvements, open to suggestions. We do hope to continue to make improvements in coexistence, know that it's a thorny problem.

Jana: Backward fairness is exciting to think about. This seems like the perfect candidate for an Experimental for this WG, its relevance and importance to the community is well understood. However, this shouldn't mean that it's a standard that we encourage everybody to deploy, just something to document the current state.

Chairs: We can talk about the bar to reach PS, and what sort of document is the correct outcome based on recommendations in 5033bis.

Matt: I worry about too much emphasis on bug compatibility with Reno. This community should discuss where to draw the line regarding scale and when Reno has no hope of doing well, so we don't have to worry about it. Neal has drawn the line conservatively, I'd like us to move it back. I'd like to work on this here.

Jana: I think this is the WG to do this work. Real-world data from deployment is very useful and we should bring it into this room.

Christian: One of the changes in BBRv3 is to space out the transition. It takes longer to detect that the bandwidth of the link has increased. Is it OK to make a solution worse because Cubic exists?

Matt: That's exactly the problem I was referring to, BBR has been made sluggish and somewhat cautious in environments where it doesn't need to be for technical reasons, but for policy reasons. This WG can make the decision and value judgment of what level of features it'll tolerate.

Chairs: Yes, that's why we're here. As we consider making BBR a WG item, we'd hand over change control to the IETF and this WG, where we go with that debate is something we'll need to be on board with. At the same time, we all are realistic humans with goodwill and the risk associated with diverging.

Martin: RFC5033bis says a lot about this. I'd like to also encourage Neal to be aggressive, to the extent that you have data that can support it, because it's easier to reign in for the WG, rather than make it more aggressive.

Neil: It's not my goal to be bug-compatible with Reno. I agree we don't want to spread the bandwidth probing out too far. BBR has room to improve by being smarter in using RTT signals as short term indicators of congestion and to keep the queues in the network small and reduce loss for the sake of both the BBR flow itself and other flows co-existing.

Koen: I think there are opportunities to improve Reno's or classic CC's response to loss, but we need a reference for what is the assumed rate in the Classic category to drive L4S to match that rate. It's good to avoid loss in the Classic category, but as long as there are loss-based CCs, there should be a way to coordinate what is the assumed rate. Delay-based CC also experience loss and need to match this. Not to say we should be Reno-compliant, we already go a bit further with CUBIC. Can we sustain more loss on high BDP paths? 

Jana: I think it is fine for people to deploy more aggressive behavior. I want to see what happens in the wild documented. There's a difference between Experimental and recommendations. If we say that by recommendation you can be x times more aggressive than Reno, I don't know where we stop, then it's not just Reno, it's CUBIC and L4S and whatever else. I don't know how we can say what is more agressive, Neal is not asking for permission to be more aggressive, the decisions are made elsewhere. We can engage with the decisions and try to understand the consequences and try to influence them. I think it's good to document what is deployed, this is a good thing to be published as EXP.

Mo Zanaty: On fairness and aggressivenes, the ANRW paper showed it took an order of magnitude of Reno of CUBIC flows to achieve parity with BBRv3. That wasn't alarming to me, the research methodology is typically just flow in an abstract sense, if you look at an operational deployment, a lot if geared at going over QUIC which is a heavily multiplexed transport. A QUIC flow can contains many subflows, and may behave as an aggregate, which muddies the water with traditional research approaches. In the real-world deployments, I don't have a problem with this heavy flow having 8-15 times of a Reno or CUBIC flow. Back it IETF 84, when we had the congestion control workshop that founded RMCAT, that was the first conclusion that almost everybody arrived at, TCP friendliness would not be a goal for a single flow but it may be weighted fairness for n TCP flows, and that was deemed okay for a single media flow back then.

Zahed: The IETF can provide feedback on the mechanism and how someone tests their CC, that's the value. We may start with experimenting, but at some time we should decide if this is good enough for the Internet, a Standards Track RFC.

Jana: Engaging with the WG allows an EXP Spec, and is only a PS when we make a recommendation on what to deploy.

Zahed: Keep doing research. Keep giving perspectives. At some stage we can decide what's good enough and ship a PS.

Eric: The value we bring as a WG is a place to have some of those ideas, what is the edge case we should test. But also, we explicitly don't want to ask authors to go fetch infinite rocks of infinite cases. So how can we as a WG help making these pieces of data obtainable, help people with a testbed, hackathon-style participation, test different tuning for CCs and how they compete. How can we as a community enable that experimentation and data collection, likely in simulation, to help provide that input? In CCWG we build on top of that by using actual real-world data of how does this behave on the Internet and at scale. To Zahed's point, we are trying to have actual PS in some cases, it doesn't have to be everything we do here. Never stop iterating, that doesn't mean we don't say we've run this through our suite of criteria and it's sufficient for us to go with right now.

Christian: Is this going to become an IETF-managed document (not a company proposal)?

Eric: Yes, the IETF would expect change control.

Martin: RFC5033.bis has a set of test cases defined with the expectation for an IETF document.

Eric: Yes, and operationally we'd be interested in chatting with the group about how do we turn that into something that is approachable, especially researchers or folks in academia who'd like to propose changes to one of the algorithms that we're talking about.

Chairs:
* I have read draft-cardwell-ccwg-bbr or a recent revision of BBR: 34 Yes, 13 No (of 92).
* The working group should work on this topic:  41 Yes, 0 No, 6 No Opinion (of 92).
* This draft is a good starting point for this work: 36 Yes, 2 No, 8 No Opinion (of 95).

Eric: Would anyone who said "No" to "This draft is a good starting point" like to come to the queue? 

Michael: I think this I-D is very long, and has lots of pseudo code, which has many heuristics and makes choices. It is hard to read, and may not be the best starting point. If we'd start with a shorter one from scratch, we might end up with a simpler and cleaner document that doesn't have so many heuristics built in as a hardcoded suggestion.
Michael Welzl, from chat:
I wanted to explain my concern with the BBR draft a bit better. Why do I think that "so many hardcoded heuristics" and "long and complex" is a problem? Simply - BBR seems to me to be one basic idea, amended with 15 patches (heuristics). If these all work well, I have nothing against that - but, browsing through the draft, I am almost certain that, if a variant of this document becomes an RFC, there will be no single implementation out there that's really 100% true to the RFC. With so many knobs, everyone will twist and turn them in a different way, constantly. I think this is a problem - BUT: I also don't know what to do about that. E.g., would there be possibilities like: thinking about the BBR principles as providing a framework, and then a particular way of doing it is an instantiation (i.e., two drafts)? Maybe this makes no sense for BBR at all. I just want to explain how I try to think about this. Anyway, surely, having a spec is better than not having a spec!


## BBR Improvements for Real-time Connections, draft-huitema-ccwg-bbr-realtime, Christian Huitema.

Stuart: I agree regarding the WiFi suspension you described. When measuring RTT and computing a PTO, the WiFi can sit on packets in the queue when the radio is used for scanning, it can result in spurious retransmission. You really should be measuring RTT from the time the packet leaves the device. Better cross-layer communication would be valuable, especially when latency matters.

Subdir: Which version of WiFi was used (WiFi 5 or 6)? Answer: both. Data on the behavior of the Wifi would be helpful. I can take it to the IEEE.

Stuart: There are lots of good reasons the WiFi radio is sometimes not available for sending packets.

Suhas: MoQ is chartered to work on media, and we would like some form of solution to be discussed in this WG.

Magnus: We should consider the application-limited case.

Chairs:
* I have read draft-huitema-ccwg-bbr-realtime: 13 Yes, 33 No, 0 No Opinion (of 97)

Eric: It sounds like our goal here is to fold this into the BBR work.

## HPCC++: Enhanced High Precision Congestion Control, draft-miao-ccwg-hpcc and draft-miao-ccwg-hpcc-info, Rui Miao.

Neal: I saw a few places where it was talking about taking the queue length and divide it by the link bandwidth. Most cloud links have multiple queues to support differentiated services, so we may not get what we want by dividing queue length by bandwidth.
- Rui: Great observation. When there's traffic contributed by HPCC and by TCP, and we assume that traffic contributed by HPCC is under high priority because people care more about the latency there and it will get higher bandwidth share, which is the minimal bandwidth guarantee of the link. In most cases there's enough bandwidth. Second, we talk about multi-queue support in our draft. When we see congestion, we can always fall back to the minimum bandwidth guarantee.

Chairs:
* I have read draft-miao-ccwg-hpcc: 7 Yes, 30 No (of 94)
* The WG should take on this work: 4 Yes, 6 No, 13 No Opinion (of 94)
* This document is a good starting point for a solution: 1 Yes, 2 No

Stuart: I said No opinion. We work on the Internet here, and all these things where the buckets have to be configured, there's no way to have this on the global Internet. At the same time, IP is a good technology to use in the datacenter, so as long as it's clear that this is for a specific use of IP technology, it is very much in charter, so we can make IP useful in other scenarios.

Gorry: Agree with Stuart. Who is the customer here? Who are the actors needing the specification? This could be good to do, or it could waste our time making a standard here.

Eric: Thank you Gorry, I saw a couple of thumbs up in the room. Our charter explicitly mentions datacenters and Real-Time protocols, which does not require us to do anything in that space. Perhaps the feedback I'm hearing here for Rui is: Let's make it clear what is the expected use-case, who are the intended audience. If we can get a number of proponents who all say they'd like to use this, it's a good signal.

Rui: For the customer, the big one is Google, it's already deployed and supported, and also other companies, such as my previous employer. People are on board because they really care about the latency for these emerging use applications like storage and AI training. The reason we want this draft is that different vendors want to have alignment how to support the customers, what is the data format, what is the algorithm you want to use, we've had many discussions on this. This is why we want to have a draft ready.

## SEARCH: A New Slow Start Algorithm for TCP and QUIC, draft-chung-ccwg-search, Mark Claypool.

Gorry: Was this Hystart++ (RFC9046) or Hystart? We saw similar effects with satellite with Careful Resume - where it is less impactful - but without this was a big issue,, but I am more interested in Hystart++ data.
- It was Hystart, but we have some other initial work on Hystart++ which we can share.

Neal: It would be worth incorporating into the document considerations for exiting spuriously based application limited or receive limited behavior. We've found them critical to incorporate into BBR, those are very common issues and we don't want to exit spuriously. Otherwise, the draft has 25 bins of data, presumably that's about 4 Bytes each, and 100 Bytes of state would double the congestion control state on a Linux TCP connection, so there might be concerns about incorporating that into mainline Linux. It'd be great to iterate on this algorithm and reduce the state use, maybe take this on as a Working Group item. 
- Yes, we handle application limited cases. We are aware of the implementation concerns with state.

Chairs:
* I have read draft-chung-ccwg-search: 5 Yes, 27 No (of 94)
* The WG should take on this work: 22 Yes, 1 No, 5 No Opinion (of 94)
* This document is a good starting point for a solution: 12 Yes, 1 No, 8 No Opinion (of 94)

## Prague Congestion Control, draft-briscoe-iccrg-prague-congestion-control, Koen De Schepper.

Chairs:
* I have read draft-briscoe-iccrg-prague-congestion-control: 7 Yes, 11 No, 1 No Opinion (of 93)
* The WG should take on this work: 10 Yes, 1 No, 10 No Opinion (of 93)
* This document is a good starting point for a solution: 9 Yes, 0 No, 11 No Opinion (of 93)

Chairs: It would good to see an updated document with experience from implementing and send a note to the list.

Martin: To clarify, are they seeking adoption in CCWG and not ICCRG?

Chairs: We're having a conversation among the chairs on where we should take this work. The poll is just to get WG interest.

Koen: Yes, the chairs requested a presentation on Prague. For us authors it's not necessarily an adoption call.

## Rechartering, Chairs.

Chairs: Can we get a thumbs-up for adding some introductory text on what congestion control is and its motivation? Then we'll happily wordsmith [on Github](https://github.com/ietf-wg-ccwg/wg-materials/pull/2). We got some thumbs-up.

Matt: Comment on the introductory paragraph: Application developers also need to know about CC and worry about congestion collapse.

Chairs: Please see the [pull-request on the WG github](https://github.com/ietf-wg-ccwg/wg-materials/pull/2) and help us wordsmith it. Right now we're most interested in: How much can we take on at once, and what should these things be?

Greg Mirsky: Delay is bounded by the laws of physics, but CC can minimise the delay variation. This is something to mention explicitly.

Gorry: About how we do potential work: In 5033bis, somebody needs to get data out there on how well this works. If we take on that broad a scope, that's a lot of heads that have to look at all these different things. If we adopt them slowly, then we need to evaluate it, then we need to progress it. How do these mechanisms work?

Chairs: We have many ideas that we're interested in feedback on, one of them is: How can the Working Group help contribute some of that kind of data? One of the things that has made this work hard in the past is: A proponent of an idea ends up with infinite work to satisfy a questionably actionable set of questions. With 5033bis we have a nicer scope of questions that we're asking. Do folks have interest in helping build this evaluation environment, in hackathons and otherwise? Our most concrete proposal right now: Let's pick one thing and adopt it, and as we run through that process, build the tools that we can then apply to the next one.

Gorry: I like that. We might be able to develop some kinds of document in parallel, some don't require a high level of scrutiny to complete. Do you adopt it and then do that, or do you get that work done before you adopt it?

Chairs: The idea is to have a scientific study of the pros and cons when we ship the proposal to IESG, so the Working Group's job is to make sure that that evidence exists, it can come from various places: Authors, academic papers, ICCRG presentations... We had a hackathon table this time to test congestion control, we'll come back in Dublin. Adoption is where we take over change control of the proposal, and we take on responsibility for helping gather that data. So there is an initial bar of: Have the authors done enough work to show this is a serious proposal and a plan with use cases and people are interested in working on it. But then as we move forward, we all want these things to succeed, so it's our responsibility to help make that progress happen.

Mirja: The biggest benefit for a CC RFC is a stable reference. The reason we never published something earlier is we were afraid to recommend and then break the internet. It should be very clear that the stable reference is the benefit. Putting the testing level too high is a problem, as it drives people away who just want a stable reference. We might be able to publish things with appropriate disclaimers. I think the evaluation burden shouldn't be that high, so we can adopt multiple things if we have a way to progress these.

Matt: I think there can be two levels - one is adoption where we have change control; and one is monitoring or supervision where we track work but not take it on as something we're responsible for.

Chairs: Something alng those lines has so far been our litmus test for the delta between ICCRG and CCWG. ICCRG can be used as an incubator for new ideas.

Martin: RFC5033bis does define a low bar for adpation of an INFO spec.

Chairs: Yes, we have built that litmus test, now is our opportunity to run a real-world example against that litmus test and learn from our mistakes.

## CC Response While Application-Limited, Matt Mathis (no time remaining for this talk).

