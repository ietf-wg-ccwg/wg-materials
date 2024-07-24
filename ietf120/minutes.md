# CCWG at IETF 120
Chairs: Eric Kinnear, Reese Enghardt
Notetaker: Gorry Fairhurst

## Increase of the Congestion Window when the Sender is Rate-Limited, draft-welzl-ccwg-ratelimited-increase, Michael Welzl.

Stuart Cheshire: Slide 4, (agreeing with slide) absence of indication of congestion is not evidence that there is no congestion. 

Neil Cardwell: Stuart's comment is interesting. The MaxFS could seem to be over a time longer than an RTT, versus a structuring use FS over the last round.
- Michael: CWV controls this case, either way this is just a SHOULD.

Ian Swett: RFC9002 is slghtly different to the words in the slides.
- Michael: This would play out in the same way.

Chairs:
Who has read draft: 10.
Who thinks we should work on this topic: 19.
Who thinks we should not do work on this topic: none.
Who thinks this draft is a starting point for a solution: 24.

## BBRv3, draft-cardwell-ccwg-bbr, Neal Cardwell.

Draft has been moved to github, allowing contributions there.

John Border: At ANRW yesterday, there was a talk that claimed fairness was reduced for BBRv3.

Neal: Not sure exactly which paper that was, but I have seen some papers in various places with that kind of result. If you think about the dynamics of the changes, you can understand why that would be. We've been able to reproduce issues like that in the lab as well, this is an area where we'd like to make improvements, open to suggestions. We do hope to continue to make improvements, know that it's a thorny problem.

Jana: Backward fairness is exciting to think about. This is important.

Chairs: We can talk about the bar to reach PS, and what sort of document is the correct outcome based on recommendations in 5033.bis.

Matt: I worry about being backwards compatibility with Reno. This depends on the scale. I'd like to work on this here.

Jana: I think this is the WG to do this work.

Christian: One of the changes in BBRv3 is to space out the transition. It takes longer to detect an increase. Is it OK to make things worse because Cubic exists?

Matt: We could decide to make a CC that makes things worse for the general Internet, because we decide that is OK in the WG.

Martin: RFC5033.bis says a lot about this. 

Neil: My goal is to not be bug-compatible with Reno. BBR has room to improve by being smarter in using RTT signals as short term indicators and to keep the queues in the network small for the sake of other flows co-existing.

Koen: I think there are opportunities to improve Reno's response to loss, but we need a reference for the Classic category to drive L4S to that rate. It's good to avoid loss in the Classic category. Delay-based CC also experience loss and need to match this. Can we sustain more loss on high BDP paths? 

Jana: I think it is fine for people to deploy more aggressive behvaiour. I want to see what happens in the wild documented. I don't know how we can say what is more agressive. I think this is a good thing to be published as EXP.

Mo Zanty: On fairness and aggressivenes, the ANRW paper showed it took an order of magnitude time to gain fairness. A QUIC flow can contains many subflows, and may behave as an aggregate.

Zahed: The IETF can provide feedback on the mechanism, at some times we should decide if this is good for an RFC, and whether this is enough for a PS.

Jana: Enagaging with the WG allows an EXP Spec, and is only a PS when we make a recommendation on what to deploy.

Zahed: Keep doing research. Keep giving perspectives. At some stage we can ship a PS.

Christian: Is this going to become an IETF-managed document (not a company proposal)?

Eric: Yes, the IETF would expect change control.

Martin: RFC5033.bis has a set of test cases defined with the expectation for an IETF document.

Chairs:
Have you read this or a recent revision of BBR? 34
Is this a topic we should work on?  41 (yes) 0 (no) 6 (no opinion)
Is the currnet draft a good starting point? 36 (yes) 2 (no) 8 (no opinion)

Michael: I think this I-D is very long, and has lots of pseudo code, which has many heuristics and makes choices. It is hard to read, and may not be the vest starting point.
Michael Welzl, from chat:
I wanted to explain my concern with the BBR draft a bit better. Why do I think that "so many hardcoded heuristics" and "long and complex" is a problem? Simply - BBR seems to me to be one basic idea, amended with 15 patches (heuristics). If these all work well, I have nothing against that - but, browsing through the draft, I am almost certain that, if a variant of this document becomes an RFC, there will be no single implementation out there that's really 100% true to the RFC. With so many knobs, everyone will twist and turn them in a different way, constantly. I think this is a problem - BUT: I also don't know what to do about that. E.g., would there be possibilities like: thinking about the BBR principles as providing a framework, and then a particular way of doing it is an instantiation (i.e., two drafts)? Maybe this makes no sense for BBR at all. I just want to explain how I try to think about this. Anyway, surely, having a spec is better than not having a spec!


## BBR Improvements for Real-time Connections, draft-huitema-ccwg-bbr-realtime, Christian Huitema.

Stuart: I agree regarding the WiFi suspension you described. When computing a PTO, the WiFi can sit on packets in the queue when the radio is used for scanning.

Subdir: Which version of WiFi was used (WiFi 5 or 6)? Answer: both. Data would be helpful.

Stuart: There are lots of reasons the WiFi radio is sometimes not available for sending packets.

Suhas: MoQ is chartered to work on media, and we would like some form of solution to be discussed in this WG.

Magnus: We should consider the application-limited case.

Chairs:
How many had read this draft? 10

## HPCC++: Enhanced High Precision Congestion Control, draft-miao-ccwg-hpcc and draft-miao-ccwg-hpcc-info, Rui Miao.

Neal: Most cloud links have multiple queues to support differentiated services, how do you account for multiple queues?
- Rui: We assume that there are multiple queues.

Chairs:
Have you read this draft? 7 (yes) 30 (no) 
Who thinks this is a topic to work on?  4 (yes) 6 (no)
Is this document a good starting point? 1 (yes) 2 (no)

Stuart: This isn't the Internet, but IP is a good technology for use in other places.

Gorry: Who is the expected use-case? Who are the actors needing the specification? This could be good to do, or it could waste our time making a standard here.

## SEARCH: A New Slow Start Algorithm for TCP and QUIC, draft-chung-ccwg-search, Feng Li.

Gorry: Was this Hystart++ (RFC9046) or Hystart? We saw similar effects with satellite with Careful Resume - where it is less impactful - but without this was a big issue,, but I am more interested in Hystart++ data.
- It was Hystart, but we have some other initial work on Hystart++ which we can share.
Neal: There are spurious conditions we have seen with application limited cases, there's quite a lot of state if we use all the bins.
- Yes, we are aware of the implementation concerns and would be interested to look at this?

Chairs:
Is this something the working group ought to work on? 22 (yes) 1 (no)
Is this document a good starting point? 12 (yes)  1 (no)

## Prague Congestion Control, draft-briscoe-iccrg-prague-congestion-control, Koen De Schepper.

Chairs:
Have you read this draft? 9 (yes)

Chairs: It would good to see an updated document with experience from implementing.
Martin: Where is the correct place to work on this?

## Rechartering, Chairs.

Matt: Application developers also need to know about CC.
Chairs: Please see the pull-request on the WG github.
Greg: CC can minimise the delay variation.

Chairs: We might be able to adopt things slowly to try and refine the process. The Hackathon might be a place where we can develop this body of information. This info can come from various places.

Gorry: We might be able to develop some kinds of document in parallel, some don't require a high level of scrutiny to complete.

Mirja: The biggest reason for a CC RFC is a stable reference. Putting the testing level too high is a problem, we might be able to publish things with appropriate disclaimers. I think we can adopt multiple things if we have a way to progress these

Matt: I think there can be two levels - one where we have change control; and one is where we track work.

Chairs: ICCRG can be used as an incubator for new ideas (come along on Friday!)

Martin: RFC5033.bis does define a low bar for adpation of an INFO spec.


## CC Response While Application-Limited, Matt Mathis (no time remaining for this talk).

