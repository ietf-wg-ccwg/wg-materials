CCWG - IETF 126
=============

## Hackathon Update — Congestion Control and Queue Management

Presented by Mohit Prakash Tahiliani (National Institute of Technology Karnataka, Surathkal) and Abhyuday Hegde

Slides: [IETF 126 Hackathon Update](https://datatracker.ietf.org/meeting/126/materials/slides-126-ccwg-ietf-126-hackathon-update-00)

Highlights:
- Evaluated FQ-PIE and FQ-CoDel in mobile hotspot and Wi-Fi access-point scenarios; FQ-PIE's tail latency and jitter were slightly better than FQ-CoDel, though median latencies were similar.
- Completed integration of Christian Huitema's picoquic library into ns-3 using a thin wrapper, supporting multipath QUIC simulation.
- Submitted and merged a patch to FreeBSD to align Proportional Rate Reduction (PRR) with RFC 6937.
- Open-sourced Ledbat++ and Rledbat models in ns-3 (open for review), and built a native FLENT-like bufferbloat testing application in ns-3.

Raffaello Secchi (University of Aberdeen): How difficult is this to maintain?

Mohit Tahiliani: We do not expect this to be difficult. We should not need to change ns-3 unless picoquic changes its API signatures.

Alessandro Ghedini (Cloudflare): How difficult is it to integrate a new QUIC implementation into ns-3?

Mohit Tahiliani: It should not be difficult, depending on the details of the QUIC implementation. After picoquic, we tried MSQUIC, which had challenges because it is multithreaded. You can just pass the data, no actual I/O or sending packets required.


## Hackathon Update — L4S Interop

Presented by Greg White (CableLabs)

Slides: [Hackathon - L4S Interop](https://datatracker.ietf.org/meeting/126/materials/slides-126-ccwg-hackathon-l4s-interop-00)

Highlights:
- Continued testing of the SCReAM integration with LibwebRTC.
- Tested the Netflix Network Delivery Time Control (NDTC) congestion controller.
- Tested Apple's responsiveness tool in L4S mode.
- Prepared for testing of the SRM network configuration and the latest iPerf2 Android client.


## BBRv3, draft-ietf-ccwg-bbr, Ian Swett

Slides: [BBRv3](https://datatracker.ietf.org/meeting/126/materials/slides-126-ccwg-bbrv3-00)

Updates presented:
- Clarified timestamp accuracy, aligned pseudocode with the normative text, and improved TCP undo logic definitions.
- Introduced Precautionary Bandwidth Probing to reduce queue pressure and packet loss: if BBR experiences excess loss during a probe, the next time it enters PROBE_UP it only probes up to the safe long-term inflight limit (inflight_lo), drains the queue, and verifies path safety before proceeding. Implemented in open-source Linux BBRv3 since 2019.
- Added a 15-case test suite to the draft to help implementers validate their code.

Open issue:
- Changing the ProbeRTT interval to 10 seconds (from 5 seconds) can cause the MinRTT filter to expire just as ProbeRTT is entered, artificially inflating the target congestion window. Two mitigations are under consideration: extending the filter length, or saving the MinRTT value before entering ProbeRTT.

Altanai Bisht (Cisco Meraki): Is the Precautionary Bandwidth Probing mandatory?

Ian Swett: Yes, it is mandatory.

Roland Bless (Karlsruhe Institute of Technology (KIT)): Is this already implemented?

Ian Swett: Yes, implemented in the open-source implementation for TCP since 2019.

Alessandro Ghedini (Cloudflare): We have been implementing BBR for QUIC and started to enable it for some of our production traffic. It is still Work In Progress.


## SCReAMv2, draft-ietf-ccwg-rfc8298bis-screamv2, Magnus Westerlund

Slides: [SCReAM v2](https://datatracker.ietf.org/meeting/126/materials/slides-126-ccwg-scream-v2-00)

Updates presented:
- Replaced the queue delay deviation estimation with a simpler average of short- and long-term values to improve robustness against clock drift.
- Introduced an adaptive reference window overhead that restricts bytes in flight when the path is congested but allows more aggressive behavior when uncongested.
- Optimized handling of reference window undershoot to prevent over-aggressive window reductions when the application bitrate drops.
- Added link-layer loss robustness: window reduction on loss is ignored if the loss rate is below a 1% threshold and queue delay is low, preventing spurious drops on lossy links.

Christian Huitema (Private Octopus Inc.): How much loss is due to sending too fast (queue overflow) compared to simple unexplained spurious loss? If we don't back off on every loss, several models and equations will be inaccurate.

Mirja Kühlewind (Ericsson): To the L4S part - This is only for non-ECN or L4S-enabled queues. BBR also has a loss threshold.

Martin Duke (Google): I wonder if the ECN marking is the problem, as these issues might be related to a lack of queueing delay increase.

Neal Cardwell (Google): Rather than trying to design an algorithm specifically to handle traffic policers, it is better to make an algorithm that handles packet loss gracefully, which will also make it cope with traffic policers.

Gorry Fairhurst (University of Aberdeen): On RFC 9743, make sure it's documented somewhere. Could be an ICCRG talk, an academic paper, or a separate document which does not to be published.

Martin Duke: Agree with Gorry that we don't need tons of extra text there. Experimental is nice here, depends on what you mean by evaluation.

Stuart Cheshire (Apple): Policers has come up a couple of times, I would agree that I don't think it's productive to try to put special code in to do something special for policers. They do one thing: Something in the network wants to tell the sender what speed they should be sending, and the only tool they have to do that is packet loss. They are very insidious, when you have a queue, the queue length grows, and you can use the round-trip delay to infer a queue, with policers you have no warning. I do hold out hope that one day we'll see policers that use ECN, since that's a good way to get feedback to a sender without forcing it to retransmit, let's shoot for that as our goal rather than try to work around today's policers.


## SEARCH, draft-chung-ccwg-search, Jae Chung

Slides: [SEARCH Updates on SS Exit Signal Quality and Draining Phase](https://datatracker.ietf.org/meeting/126/materials/slides-126-ccwg-search-updates-on-ss-exit-signal-quality-and-draining-phase-00)

Updates presented:
- Signal quality analysis: explained why SEARCH uses the normalized delivery-rate difference rather than RTT inflation as an exit signal — delivery-rate SNR increases prior to hitting the BDP and remains high, whereas RTT inflation is highly susceptible to noise.
- Draining phase: introduced a gradual draining phase on slow start exit. Instead of immediately slashing the congestion window (which can disrupt fast retransmit), the sender slowly drains the excess queue by reducing the window by 1 packet for every 3 packets acknowledged.

Ian Swett (Google): On slide 4, the bottom left is min RTT and bottom right is normalized diff deviation from the expected bandwidth?

Jae Chung: This is sent bytes one RTT ago and then later, how much was actually acked.

Ian Swett: And after the cutted line is the point at which you should be exiting Slow Start?

Jae Chung: Yes. The dotted line is a BDP.

Ian Swett: What does the solid line drifting above the dashed line mean?

Jae Chung: The quality is getting better. Sent bytes minus delivered bytes converged towards 0.5.

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

Poll 1 — "I have read a version of draft-chung-ccwg-search": Yes: 10, No: 41, No Opinion: 2 (Total: 86)

Poll 2 — "I have implemented or am planning to implement a version of SEARCH": Yes: 5, No: 33, No Opinion: 6 (Total: 86)


## QUIC slow start evaluation at Mozilla: Traditional, HyStart++, SEARCH, Oskar Mansfeld

Slides: [Firefox QUIC Slow Start Experiments (Classic/SEARCH/HyStart++) v2 with bonus plots](https://datatracker.ietf.org/meeting/126/materials/slides-126-ccwg-firefox-quic-slow-start-experiments-classicsearchhystart-v2-with-bonus-plots-00)

Results presented:
- Firefox implemented SEARCH and HyStart++ in its neqo QUIC stack and ran A/B/C testing on production release traffic.
- Over 91% of connections were entirely application-limited and never grew their congestion window; of the remaining flows, only 4.42% exited slow start.
- Heuristic exit rates: Classic 0%, HyStart++ 2.5%, SEARCH 12.6%. Most exits were triggered by actual congestion events (loss/ECN), not the heuristics.
- SEARCH showed a lower packet loss ratio at the 95th and 99th percentiles than HyStart++ and Classic, though throughput metrics were inconclusive.
- In the lower percentiles, SEARCH frequently exited slow start at very low ssthresh values, suggesting possible premature exits under application-limited transmission patterns.

Martin Duke: On Slide 10 - Does this mean that HyStart++ kicks in at a rate that is too low?

Oskar Mansfeld: We don't know exactly, but when it kicks in, it's during these higher percentiles where we see an actual different in ssthresh, and it is lower than what classic saw after reducing its congestion window.

Antonio Vicente (Cloudflare): Some of those results may be because of incorrect early exits. Comparing against the distribution of final windows might be interesting.

Matt Joras (Meta): Did you collect other browser metrics too? It is hard to draw conclusions from these metrics in isolation.

Oskar Mansfeld: Most of the other browser metrics relate to receiving, not sending.

Mirja Kühlewind (Ericsson): I agree with Martin Duke that a time-based metric would be useful.

Kazuho Oku (Fastly): I would like to see how these results compare with other browser vendors.

Martin Duke: Thank you for doing this work. We need to work out how to make sense of these results. Is an early slow-start exit good, or bad?


## C4, draft-huitema-ccwg-c4-spec, draft-huitema-ccwg-c4-design, draft-huitema-ccwg-c4-test, Christian Huitema

Slides: [Updating C4 (Christian's CC Code)](https://datatracker.ietf.org/meeting/126/materials/slides-126-ccwg-updating-c4-christians-cc-code-00)

Updates presented:
- Created a dedicated Careful Resume state to store and test prior path parameters safely over two RTTs, simplifying debugging.
- Added Continuous Pushing: if a probing cycle is predicted to succeed, the algorithm enters an exponential push state (+25%) instead of waiting an entire RTT, improving recovery times.
- Optimized Persistent Congestion Response: if two congestion backsteps occur consecutively, C4 immediately drops its sending rate to the measured link capacity rather than stepping down incrementally.
- Implemented an Initial Startup Pacing Floor of 1 Mbps to prevent flows from getting stuck on short-RTT paths.

No time for discussion.


## Next Steps

- draft-ietf-ccwg-bbr: Implementers and authors will coordinate PRs to resolve the ProbeRTT/MinRTT overlap issue and implement the precautionary bandwidth probing mechanism in QUIC stacks.
- draft-ietf-ccwg-rfc8298bis-screamv2: Complete ongoing field evaluations of SCReAM L4S in WebRTC (with Google) and draft a report assessing the algorithm against the RFC 9743 evaluation criteria.
- draft-chung-ccwg-search: Authors will refine the algorithm's SNR detection to prevent premature slow start exits during application-limited periods, using feedback from the Firefox experiments.
- C4: Christian Huitema will expand simulation scenarios to evaluate performance over satellite networks, with larger bottlenecks (20x BDP), and under active RED/ECN AQMs.
