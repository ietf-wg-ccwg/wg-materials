# CCWG Working Group - IETF 123

### Time and Date

* Monday July 21, 14:30 - 16:30 CEST ([See this time in your local timezone](https://www.timeanddate.com/worldclock/fixedtime.html?msg=CCWG+at+IETF+123&iso=20250721T1430&p1=141&ah=2))
* Location: [El Prado](https://datatracker.ietf.org/meeting/123/floor-plan?room=el-prado)
* [IETF Agenda Link](https://datatracker.ietf.org/meeting/123/agenda/?show=ccwg)

### Links

* [Onsite Tool](https://meetings.conf.meetecho.com/onsite123/?group=ccwg&short=ccwg&item=1)
* [Meetecho Room](https://meetings.conf.meetecho.com/ietf123/?group=ccwg&short=ccwg&item=1)
* [Meeting chat](https://zulip.ietf.org/#narrow/stream/ccwg)
* [Notes](https://notes.ietf.org/notes-ietf-123-ccwg)
* [Minutes](https://datatracker.ietf.org/doc/minutes-123-ccwg/)

### Administrivia

* Blue sheets / scribe selection / [NOTE WELL](https://www.ietf.org/about/note-well.html) / [Code of Conduct](https://www.rfc-editor.org/rfc/rfc7154.html)
* Agenda revision

# Topics

- **Chair slides**, _Chairs_, onsite, 10 minutes

## **Hackathon Updates**, _Mohit Tahiliani_

- Mohit: Queue management project, FQ-CODEL and FQ-PIE. It mostly met objectives. See [slides](https://datatracker.ietf.org/meeting/123/materials/slides-123-ccwg-hackathon-update-00)

- Should AQM Evaluation suite be part of the ns-3 suite or a separate ns3 app?

- Lars Eggert: Direct Code Execution is available in ns3 for arbitrary code. Have you worked with this?

- Mohit: Our users found it very difficult to set up. There are not enough maintainers in ns-3 to keep the Linux kernel version supported by DCE up to date. We current support Linux 4.9.

- Alessandro Ghedini: Lars +1. We have a QUIC implementation that does not go through the Linux kernel and it would be helpful to set up test environments. Transport implementers find it hard to come up with test cases, so this is very helpful. Algorithm specific test cases (like BBR startup) would be useful.

- Roland Bless: Did you look at network simulation cradle?

- Mohit: It's obsolete. DCE is the new version.

- Eric: This seems like a particularly good place to compile the list of topology design cases. Thank you for this work, this energy helps us have the ecosystem that enables us to do the design work we do in this Working Group.

## **Rate-limited senders**, [draft-ietf-ccwg-ratelimited-increase](https://datatracker.ietf.org/doc/draft-ietf-ccwg-ratelimited-increase/), _Michael Welzl_

- Lars: Are pacing rules relevant to application-layer things like QUIC? How much of this will be measurable in the network? Is the specificity here going to do anything in the real world?

- Michael: This paragraph is just saying that pacing is orthogonal and doesn't make a difference.

- Marwan Fayed: I still don't understand the paragraph.

- Gorry: Please read the whole section to understand this, not just this paragraph.

- Ian: I will read the whole section to provide full feedback. I am concerned about the sentence "This is usually without limiting the number of packets that are sent per RTT", as for congestion controllers like BBR, the typical pacing rate is less than the cwnd.

- Michael: We can remove this sentence. Logically, it's unnecessary.

- Eric: No open issues modulo this 3.2.2 discussion. This is good time to read the draft.

- Martin Duke: Let's just WGLC after this issue is resolved.

- Eric: Agreed.

## **BBRv3**, [draft-ietf-ccwg-bbr](https://datatracker.ietf.org/doc/draft-ietf-ccwg-bbr/), _Ian Swett_

- [Issue #17](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/issues/17), slide 9:

- Christian: ProbeRTT matters for competition. BBR has some latecomer advantage issues. Probes are useful when you detect competition. Should it be a fixed number of seconds, or some kind of condition to enter ProbeRTT.

- Neal: That makes sense. It's a good direction to investigate, but that's a complex research project.

- Marwan: How does this work with Starlink 15s reconfiguration rhythm? With 10s boundaries you might miss changes, maybe 5s is better.

- Ian: Good point. Maybe 10s or path change indications are a good signal. e.g. flow label changes.

- Martin Duke: Maybe add ProbeRTT to the experiment section.

- Gorry: 10s is bad if the RTT information is wrong. Maybe we should use path change information to check sooner.

- Ian: Are there good path change indications besides flow labels? Maybe OS indications.

- Gorry: Yes, in some OSes, they're a little odd. Tunnels, etc. But maybe minRTT changes?

- Eric (as individual): Different OSes have different signals. It'd be nice to provision external knowledge, e.g., from the cellular modem. Not necessarily just satellite access changes.

- Joseph: This only affects the frequency of probing, not the minRTT filter length. If we have a bad minRTT, probing more frequently does not change much, we still have to keep using it for the 10s filter.

- Neal: This is very tricky. Adaptive probeRTT means that some hosts might not probe enough, lead to feedback loops of overestimated minRTT. Put it in the Experiment section, don't change the design now.

- Ian: The design issues be resolvable by the next meeting. We could get this done by the end of the year if things not in production are in the experiment section.


# As Time Permits

## **Insights into BBRv3’s Performance and Behavior by Experimental Evaluation**, [Academic paper](https://doc.tm.kit.edu/2025-bbrv3-eval-networking2025-authors-copy.pdf), _Roland Bless_, 15 minutes

- Ian: The delay-jitter results might be better in your test because our recent code has extra ACKed feature, prior work may not have had it.

- Roland: Maybe, but I think the authors may also may not have understood what BBR is doing.

- Christian: Did you simulate extreme WiFi jitter?

- Roland: One was random, one was "burst" jitter. We didn't have realistic jitter models.

- Christian: We see misconfigured WiFi that has huge jitter due to L2 retransmission. It'd be good to model that kind of thing. Exponential backoff makes things bad.

- Neal: The decision to allow higher queueing delay fixed early problems with DC and WiFi links. In these cases, minRTT can be much lower than the typical RTT because of the link technology. Longer probes help us find the minRTT. WiFi links are another good research area.

# Closing remarks

- Eric: What are our next steps for BBR?

- Ian: Get experimental data for the two algorithm changes [PR #6: Use consistent value for drain pacing gain which matches derivation doc](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/pull/6) and [PR #5: Remove BBR.ack_phase from pseudocode](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/pull/5), as well as the questions raised today: [Issue #17](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/issues/17), getting a resolution to the Probe RTT issue. These are not big issues but we need data. And, about 3 months of editorial work.

- Eric: Great. After that, what is our comfort level with the current design, how are we going to apply the different experiments against it and make sure it does all that we say it needs to?

- Ian: How many implementations are enough? Probably 3-4 if they're deployed.

- Alessandro: Cloudflare is working on a BBRv3 implementation for our QUIC stack. Testing is an issue, defining test scenarios would be useful. Maybe Mohit's tools would be helpful here, and input from experienced developers. It is hard to implement from the draft; if others have similar issues, maybe we could write down some implementation guidance?

- Neal: Sure, please open a Github issue for specific issues or send it to the list.

- Ian: We created a whole simulator for BBR over QUIC. It's open source. We can provide instructions if helpful. Neal has packetdrill tests for TCP that are non-trivial to port to other OSes and environments. What would be most helpful?

- Alessandro: If the simulator indicates if the result is good/compliant or not, that would be great. Focus on QUIC because there are only so many TCP implementations.

- Ian: Before the simulator, we can start with some simpler checks. I assume we will end up with more QUIC implementations than TCP.

- Martin: Should we have test cases in the draft or should the draft point to test code?

- Eric: If we can find a reasonable set to put in the draft, yes, but we'd want to see concretely.

- Lucas: More BBRv3 QUIC implementations would be great. We have qlog, which makes it easier to log congestion controller state. It might be a good basis for tooling.

- Eric: OK, we want the WG and community to go through the common scenarios - knowing how BBR works, what are the edge cases, find the scenarios we want to test and walk through them with our tooling, bring them into the draft if we think it'd be helpful. Plus, do some work to make it easier for implementers.
