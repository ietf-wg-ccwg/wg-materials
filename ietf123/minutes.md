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

## **Hackathon Updates**, _Mohit Tahiliani_, onsite, 10 minutes

- Mohit: Queue management project, FQ-CODEL and FQ-PIE. It mostly met objectives. See slides. https://datatracker.ietf.org/meeting/123/materials/slides-123-ccwg-hackathon-update-00

- Should AQM Evaluation suite be part of the ns-3 suite or a separate ns3 app?

- Lars: Direct Code Execution is available in ns3 for arbitrary code. Have you worked with this?

- Mohit: our users found it very difficult to set up. There are not enough maintainers to keep the Linux kernel up to date.

- Alessandro: Lars +1. Transport implmenters find use case generation laborious, so this is very helpful. Algorithm specific test cases (like BBR startup) would be useful.

- Roland Bless: Did you look at network simulation cradle?

- Mohit: it's obsolete. DCE is the new version.

## **Rate-limited senders**, [draft-ietf-ccwg-ratelimited-increase](https://datatracker.ietf.org/doc/draft-ietf-ccwg-ratelimited-increase/), _Michael Welzl_, onsite, 15 minutes

- Lars: Are pacing rules relevant to application-layer things like QUIC?

- Michael: This paragraph is just saying that pacing is otrhogonal.

- Marwan Fayed: I still don't understand 3.2.2 (pacing)

- Gorry: Please read the section to understand this, not just the slide.

- Ian: I will read the whole section. I am concerned about the sentence "This is sually without limiting the number of packets that are sent per RTT."

- Michael: we can remove this sentence. Logically, it's unnecessary.

- Eric: no open issues modulo this 3.2.2 discussion. This is good time to read the draft.

- Martin Duke: Let's just WGLC after this issue is resolved.

- Eric: agreed

## **BBRv3**, [draft-ietf-ccwg-bbr](https://datatracker.ietf.org/doc/draft-ietf-ccwg-bbr/), _Ian Swett_, onsite, 30 minutes

- Christian: ProbeRTT matters for competition. BBR has some latecomer advantage issues. Probes are useful when you detect competition. Should it be a fixed number of seconds, or some kind of condition that indicates sharing is happening.

- Neal: That makes sense. It's a good direction to investigate, but that's a complex research project.

- Marwan: How does this work with Starlink 15s reconfiguration rhythm? Maybe 5s is better.

- Ian: good point. Maybe path change indications are a good signal. e.g. flow label changes

- Martin Duke: Maybe ProbeRTT can be part of the experiment.

- Gorry: 10s is bad if the RTT indicates it is wrong.

- Ian: are there good path change indications besides flow lablels? Maybe OS indications.

- Gorry: yes, they're a little odd. Tunnels, etc. But maybe minRTT changes?

- Eric: Different OSes have different signals.

- Joseph: This only affects the frequency of probing, not the minRTT estimation.

- Neal: This is very tricky. Adaptive probeRTT means that some hosts might not probe enough, lead to feedback loops of overestimated minRTT. Put it in the Experiment section, don't change the design now.

- Ian: We could get this done by the end of the year if things not in production are experimental.


# As Time Permits

## **Insights into BBRv3’s Performance and Behavior by Experimental Evaluation**, [Academic paper](https://doc.tm.kit.edu/2025-bbrv3-eval-networking2025-authors-copy.pdf), _Roland Bless_, 15 minutes

- Ian: delay-jitter might be better because our recent code has extra ACKed feature.

- Roland: maybe, but I think the authors may also may not have understood what BBR is doing.

- Christian: did you simulate extreme wi-fi jitter?

- Roland: One was random, one was "burst" jitter. We didn't have realistic jitter models.

- Christian: We see misconfigured WiFi that has huge jitter due to L2 retransmission. It'd be good to model that kind of thing. Exponential backoff makes things bad.

- Neal: The decision to allow higher queueing delay fixed early problems with DC and wifi links. MinRTT can be much lower than the typical. Longer probes help us find the minRTT. Wifi links are another good research area.

## Closing remarks

- Eric: What are our next steps for BBR?

- Ian: get experimental data for the questions raised today. About 3 months of editorial work.

- Eric: Great. after that, what is our comfort level with the design to finish?

- Ian: how many implementations are enough? Probably 3-4 if they're deployed.

- Alessandro: CF is working on a v3 implementation. Testing is an issue, defining test scnearios would be useful. Maybe Mohit's tools would be helpful here. It is hard to implement from the draft; maybe implementation guidance?

- Neal: sure, do a github issue or send it to the list.

- Ian: We created a whole simulator for BBR over QUIC. It's open source. Neal has packetdrill tests that are non-trivial to port. What would be most helpful?

- Alessandro: If the simulator indicates if the result is good/compliant or not, that would be great. Focus on QUIC because there are only so many TCP implementations.

- Ian: We can start with something simpler.

- Martin: Should this be in the draft?

- Eric: If practical, yes, but meh

- Lucas: More QUIC would be great. We have qlog, which makes it easier to log BBR state. It might be a good basis for tooling.

- Eric: OK, let's work out some of the rough edges in the design and do some work to make it easier for implementers.
