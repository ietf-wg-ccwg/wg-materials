# CCWG Meeting, IETF 124, Montreal. 3 November 2025 9:30

## Hackathon Update: "Testing Congestion Control and Queue Management Mechanisms"

_Vishal Kamath, Hemang J. Jamadagni, Tanay Praveen Shekokar_, [slides](https://datatracker.ietf.org/meeting/124/materials/slides-124-ccwg-hackathon-updates-00)

Alessandro Ghedini (Cloudflare): I can't answer your multipath question unless you explain how you use multipath, i.e., does the application combine multiple paths to increase throughput, does it use another path if one breaks. How you measure things depends on how you use multipath.

Tanay: We'd like to know what use cases to test in general.

Alessandro: Are you doing algorithm-specific tests?

Hemang: We're open to anything.

Lars Eggert (Mozilla): How reproducible are the results? When using a simulator like ns3, the results are 100% reproducible run after run, down to the exact packet timestamps. That sounds unrealistic with Linux network namespaces. How close to the ideal do you intend to get? I'd like something stable enough to run in CI.

Hemang: Not sure. We should minimize variability, but we'd like input. It should take all parameters into account.

Kyle Rose (Akamai): Is this to run on one machine?

Hemang: Yes.

Gorry Fairhurst: Dealing with outliers is important. Thank you for presenting this.

## BBRv3

_Ian Swett_, [slides](https://datatracker.ietf.org/meeting/124/materials/slides-124-ccwg-bbr-update-00), [draft-ietf-ccwg-bbr](https://datatracker.ietf.org/doc/draft-ietf-ccwg-bbr/)

- [PR #6: Use consistent value for drain pacing gain which matches derivation doc](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/pull/6): The authors want more data, and are looking for collaborators to run experiments.

- [Issue #71: Consider adding test cases to an appendix](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/issues/71)

Ian: Should we have an appendix to list things that can go wrong?

Alessandro: Yes. Test cases would be better.

- [PR #5: Remove BBR.ack_phase from pseudocode](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/pull/5): The authors want another implementation, and experience to validate the change is fine.

Reese: Anyone willing to gather data?

Eric: How are the implementations going?

Ian: There's at least one in development that was less far along before.

Alessandro: We have a BBRv2/v3 implementation based on Chrome's. Running experiments, hard to get clear results when tweaking. We can run experiments if we figure out how to tweak the specific proposals.

Antonio Vicente (Cloudflare): We have an implementation, are running into issues with pacing, and app-limited calculations. We're working on internal testbeds, trying to open-source more tooling, run against other implementations.

Christian Huitema (Private Octopus Inc.): I implemented it in picoquic.

## Feedback request from MBONED: Circuit Breaker Assisted Congestion Control

_Max Franke_, [draft-ietf-mboned-cbacc](https://datatracker.ietf.org/doc/draft-ietf-mboned-cbacc/)

Q: Should we map CBACC to RFC8084? Should we update 8084?

Kyle Rose: Tension between shared pain in TCP and picking losers in CBACC. The application can be an important input as to what flow to throttle. I would like to have a deeper discussion with folks who have strong opinions on how circuit breakers are used in real-world scenarios.

Gorry (as individual): The congestion control rate adaption should fit in the envelope per 8084. I'll happily join the discussion. Please discuss on the CCWG list.

## SCReAMv2

_Ingemar Johansson_, [slides](https://datatracker.ietf.org/meeting/124/materials/slides-124-ccwg-scream-v2-00), [draft-johansson-ccwg-rfc8298bis-screamv2](https://datatracker.ietf.org/doc/draft-johansson-ccwg-rfc8298bis-screamv2/)

Koen De Schepper (Nokia): We are doing similar things in UDP-Prague and Realtime-Prague. We have Prague congestion control that mainly does marking, with an optional delay-based component, and a different aspects of how it's applied to applications. Does it make sense to split this into congestion control and how applications are using the congestion control?

Ingemar: A combined approach might make sense.

Neal Cardwell (Google): Is this an algorithm for the public internet?

Ingemar: It might fail miserably, as other delay-based CCs. I haven't tested vs Reno recently.

Jonathan Lennox (8x8 / Jitsi): Video codec steering is separable from CC. Maybe two drafts, one not in CCWG?

Mirja Kühlewind (Ericsson): This work came out of RMCAT, that's why it's coupled. Maybe there's cases where we can generalize, but this one was specifically designed to have this ability.

**Show of hands: How many have read a recent revision of the draft? Yes: 10, No: 28.**

**Show of hands: Should CCWG focus on this topic (media congestion control)? Yes: 22, No: 2, No opinion: 20.**

Ian: Has anyone implemented this for MOQ?

**Show of hands: Is SCREAM a good starting point to work on this topic? Yes: 16, No: 1, No opinion: 20**

Lars: I think it's worthwhile to talk about this here. We couldn't get enough feedback last time we tried in RMCAT. This seems experimental. Let's try again.

Eric: As we have more bandwidth as a group, we want to make sure we can get the right congestion control focus with the right media focus. This is one particular place where we can start, there have been other proposals as well. We may ask the authors to get together and see if we can combine ideas, or give an overview of the different proposals.

Christian: I voted no. I would like two layers: one for video adaptation, one for control. In media adaptation: there are two approaches. Real-time adaptation, where I get the parameters and tune my codec to meet these parameters. This doesn't work well with multiple receivers. The other approach is layered or simultaneous encoding with priorities.

Zahed Sarker (Nokia): I have no opinion. I would like to see the other options. I agree we should work on media rate control, and we have some experience from RMCAT.

Mirja Kühlewind (Ericsson): It would be interesting if there is a generic framework that can plug other CCs in.

## NDTC (Network Delivery Time Control)

_Paul-Louis Ageneau_, [slides](https://datatracker.ietf.org/meeting/124/materials/slides-124-ccwg-network-delivery-time-control-00), [draft-ageneau-ccwg-ndtc](https://datatracker.ietf.org/doc/draft-ageneau-ccwg-ndtc/)

Stuart: It reminds me of TCP paced chirping, Briscoe NETDEV 2019. This is a good idea.

Ingemar: +1 to Stuart

Jonathan: Do you need arrival timestamps (i.e. RTCP TWCC)? Would this be a problem if you didn't have them, such as original QUIC without extensions?

Paul-Louis: Yes, you need feedback with timestamps. TWCC or RFC 8888 are good.

Magnus Westerlund (Ericsson): Have you tried it over capacity-granting schedulers (eg, mobile)?

Paul-Louis: No, but any AQM that prioritizes non queue building flows is good.

## SEARCH -- a New Slow Start Algorithm for TCP and QUIC

_Mark Claypool_, [slides](https://datatracker.ietf.org/meeting/124/materials/slides-124-ccwg-update-search-better-slow-start-for-tcp-and-quic-00), [draft-chung-ccwg-search](https://datatracker.ietf.org/doc/draft-chung-ccwg-search/)

Mirja: Hystart++ is based on delay, SEARCH is based on rate, which is bytes over time. What is the algorithmic difference between Hystart++ and SEARCH? 

Mark: Yes, they are similar. We could tease out the key differences.

**Show of hands: How many people have read the draft? Yes: 6, No: 19**

**Show of hands: How many people think CCWG should focus on this topic (slow start improvements)? Yes: 27, No: 0, No opinion: 5**

## Christian's Congestion Control Code (C4)

Christian Huitema, [slides](https://datatracker.ietf.org/meeting/124/materials/slides-124-ccwg-christians-congestion-control-code-c4-00), [draft-huitema-ccwg-c4-design](https://datatracker.ietf.org/doc/draft-huitema-ccwg-c4-design/), [draft-huitema-ccwg-c4-spec](https://datatracker.ietf.org/doc/draft-huitema-ccwg-c4-spec/), [draft-huitema-ccwg-c4-test](https://datatracker.ietf.org/doc/draft-huitema-ccwg-c4-test/)


