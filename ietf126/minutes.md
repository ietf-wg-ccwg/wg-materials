CCWG - IETF 126
=============

## Hackathon Update — Congestion Control and Queue Management

Presented by Mohit Prakash Tahiliani (National Institute of Technology Karnataka, Surathkal) and Abhyuday Hegde

Raffaello Secchi (University of Aberdeen): How difficult is this to maintain?

Mohit Tahiliani: We do not expect this to be difficult.

Alessandro Ghedini (Cloudflare): How difficult is the integration?

Mohit Tahiliani: It should not be difficult, depending on the details of the QUIC implementation.


## Hackathon Update — L4S Interop

Presented by Greg White (CableLabs)


## BBRv3, draft-ietf-ccwg-bbr, Ian Swett

Altanai Bisht (Cisco Meraki): Is the Precautionary Bandwidth Probing mandatory?

Ian Swett: Yes, it is mandatory.

Roland Bless (Karlsruhe Institute of Technology (KIT)): Is this already implemented?

Ian Swett: Yes, implemented for TCP since 2019.

Alessandro Ghedini (Cloudflare): We have been implementing BBR for QUIC.


## SCReAMv2, draft-ietf-ccwg-rfc8298bis-screamv2, Magnus Westerlund

Christian Huitema (Private Octopus Inc.): How much loss is due to sending too fast (queue overflow) compared to simple unexplained spurious loss? If we don't back off on every loss, several models will be inaccurate.

Mirja Kühlewind (Ericsson): This is only for non-ECN queues

Martin Duke (Google): I wonder if the ECN marking is the problem.

Neal Cardwell (Google): Rather than trying to design an algorithm specifically to handle traffic policers, it is better to make an algorithm that handles packet loss gracefully, which will also make it cope with traffic policers.

Gorry Fairhurst (University of Aberdeen): On RFC 9743, make sure it's documented somewhere. Could be an ICCRG talk, an academic paper, or a separate document which does not to be published.

Martin Duke: Agree with Gorry that we don't need tons of extra text there. Experimental is nice here, depends on what you mean by evaluation.

Stuart Cheshire (Apple): Policers has come up a couple of times, I would agree that I don't think it's productive to try to put special code in to do something special for policers. They do one thing: Something in the network wants to tell the sender what speed they should be sending, and the only tool they have to do that is packet loss. They are very insidious, when you have a queue, the queue length grows, and you can use the round-trip delay to infer a queue, with policers you have no warning. I do hold out hope that one day we'll see policers that use ECN, since that's a good way to get feedback to a sender without forcing it to retransmit, let's shoot for that as our goal rather than try to work around today's policers.


## SEARCH, draft-chung-ccwg-search, Jae Chung

Ian Swett (Google): 

Gorry Fairhurst (University of Aberdeen): What are you actually measuring here? What is the path?

Jae Chung: This is an emulated network.

Gorry Fairhurst: It would be more informative to see data from a real network.

Altanai Bisht (Cisco Meraki): Would the results be different if the traffic was application-limited?

Jae Chung: In that case the flow will not exit slow-start.

Christian Huitema: These are the theoretical curves. For example, these curves assume that the round-trip time is constant, which is not true in Wi-Fi networks. There is a lot of noise in the rate measurement because of jitter in the round-trip time.

Neal Cardwell (Google): Regarding application-limited flows, what is the mechanism to avoid prematurely exiting slow-start?

Jae Chung: This is work we are currently doing.

Neal Cardwell: Can you give us some intuition about how that would work?

Martin Duke: Do not focus too much on fast retransmit, now that we have things like [TCP RACK](https://datatracker.ietf.org/doc/html/rfc8985).

Christian Huitema: I think the big problem addressed by SEARCH is the large discrepancy between Slow Start and Congestion Avoidance. Exiting Slow Start too soon is a problem because it then takes a long time to reach the right rate on high-BDP paths. The better solution is to fix this fundamental discrepancy, rather than focussing on tuning the algorithm for deciding when to switch from Slow Start to Congestion Avoidance.


## QUIC slow start evaluation at Mozilla: Traditional, HyStart++, SEARCH, Oskar Mansfeld

Martin Duke: Does this mean that HyStart++ kicks in at a rate that is too low?

Antonio Vicente (Cloudflare): Some of those results may be because of incorrect early exits.

Matt Joras (Meta): Did you collect other browser metrics too? It is hard to draw conclusions from these metrics in isolation.

Oskar Mansfeld: Most of the other browser metrics relate to receiving, not sending.

Mirja Kühlewind (Ericsson): I agree with Martin Duke that a time-based metric would be useful.

Kazuho Oku (Fastly): I would like to see how these results compare with other browser vendors.

Martin Duke: Thank you for doing this work. We need to work out how to make sense of these results. Is an early slow-start exit good, or bad?


## C4, draft-huitema-ccwg-c4-spec, draft-huitema-ccwg-c4-design, draft-huitema-ccwg-c4-test, Christian Huitema

No time for discussion.

