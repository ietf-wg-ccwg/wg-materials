# CCWG Working Group Agenda - IETF 121
Chairs: Eric Kinnear, Reese Enghardt

Notetaker: Gorry

## Hackathon Update from CCWG table


## Administrivia

* Blue sheets / scribe selection / [NOTE WELL](https://www.ietf.org/about/note-well.html) / [Code of Conduct](https://www.rfc-editor.org/rfc/rfc7154.html)

# Topics

## **Chair slides**

- Rechartering: The charter has been [updated on Github](https://github.com/ietf-wg-ccwg/wg-materials/blob/main/charter.md) since the last meeting, editorial changes only. The chairs will send the recharter off shortly.
- Contribution model: Continuing the collaboration model we used for 5033bis, the WG will use Github to comment on and develop the documents. Consensus on this process will be confirmed on the list.

- Christian Huitema: I'd like to see a set of test cases/scenario that are representative of environments that make sense, one recent example is LEO satellites - perhaps a couple dozen test cases.
  - Eric: Yes, that's step 3 here ([slide 9 of chair slides](https://datatracker.ietf.org/meeting/121/materials/slides-121-ccwg-chair-02)), and that's what we've been talking about for simulation. We want a test suite and we could start from the RFC 5033 considerations.
  - Christian: Yes, and this kind of thing is even more valuable in the research group.
  - Mohit Tahillani: There was a previous draft looking at evaluating TCP congestion control. QUIC has emerged and it would be good to have a set of tests for congestion control with TCP or QUIC, with a set of standardized topologies. I'd be happy to contribute this around ns-3. Me and my students have built several ns-3 models for many I-Ds and RFCs, such as BBR, DCTCP, LEDBAT, FQ-CoDel. We also built an [AQM evaluation suite](https://aqm-eval-suite.github.io/) as per RFC 7928 and you can run test cases for specific sections of RFC 7928 in an automated fashion.
  - Colin Perkins: I agree test cases are useful, in the past we have done this for RMCAT. It's useful. It can also become out of date quickly. For example, Pantheon was great, while it was maintained. The challenge is supporting it over time so that it doesn't bit-rot. It would be useful to get long-term support to maintain these test suites.
- Christian: Agree with Colin that maintaining is important and I really like the idea of having ns-3 simulations available. I think we need more than some executable tests, people need to understand the scenarios, and then interpret the results. The description of a (cellular, LEO satellite) scenario are also important when they represent real systems. If you can get telemetry from a vast number of systems, you can find scenarios that are part of the tail that you care about, the difference between working on 95% of the systems and 99.9%. I'd like to document cases like Wifi suspension, set up channels so people who are running networks and have vast amount of telemetry can contribute it to the IETF or some research organization. It has to be a live system, as we care about other things now than we did 20 years ago. 
  - Eric: I think this would be useful to talk about on the mailing list or have a side chat. It would be good to define this list of scenarios.
  - Zahed (Individual): I like this. There is a problem with how you see the network scenario, there can be multiple views. RMCAT defined defined test cases for cellular and Wifi network, we spent a lot of time to describe the scenarios, looking at them might be a good starting point, I'm willing to help with that one. I'd also like to see running the specific measurements in real networks - results might not be independent of other flows (demands on the L2 resources), this is important also before you do parameter tuning.
  - Martin Duke: We're here to deploy things on the Internet - good ideas come from various places, and 5033bis accomodates that with document status, but standards-track documents need some form of widescale experience.
  - Eric: Yes, and part of that can be to have folks with infrastructure step forward and help the community, we appreciate that.
  
- Upcoming Work: We have adopted BBR. In terms of energy and focus, we've discussed adopting proposals that are not specific to any particular congestion control algorithm. We want to evaluate whether we have time to also focus on another algorithm such as SCReAMv2. We want to practice the model we were just talking about, and also, where we have energy and the folks implementing and testing don't overlap as much, there doesn't have to be a blocking relationship.

## **BBRv3**
[draft-ietf-ccwg-bbr](https://datatracker.ietf.org/doc/draft-ietf-ccwg-bbr), _Neal Cardwell_

- [Github is being used](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr), please do leave comments/open issues to contribute. The more detailed the suggestion is and the higher up the "ladder" ([slide 8](https://datatracker.ietf.org/meeting/121/materials/slides-121-ccwg-bbr-congestion-control-00)), the more likely that we'll have time as a community to finalize the suggestion into a well-tested proposal. Email to the list might be a starting point, Github issue or Pull Request on the draft, could also offer patches to an open source implementation of BBR, results from tests. Collaboration is encouraged: Person A might have an idea, it might be implemented by person B and tested by other sites. That way, we won't have the problem that folks must be "this tall to contribute".
- Open issues and Pull Requests:
  - [Proposal to change the drain/pacing gain to 0.5](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/pull/6)
  - [Proposal to remove BBR ack phase](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/pull/5) 
  - [Open issue to try be less TCP specific and to generalise the draft to other transports](https://github.com/ietf-wg-ccwg/draft-ietf-ccwg-bbr/issues/4), especially to include QUIC.
- Gorry: Are we considering the harm of doing the 0.5 change as well as the benefit?
  - Neal: Yes, that is something we'd always consider. As historical context, the value of 0.35 was derived from the previous value of startup cwnd gain to reduce the inflight data one 1 BDP of data. Since then, we reduced the startup cwnd gain to 2 instead of 2.89, so we'll have a smaller queue as a starting point, so we can use a larger pacing gain and still reduce the amount of inflight data to 1 BDP. So the net impact of the change should be equivalent to the old value.

- Martin: Have you thought about ECN?
  - Neal: For now I propose we don't include prose or pseudocode for ECN behavior. The experience we have with ECN so far is only for Google's internal WAN network and only for certain ranges of Round Trip Times. Ultimately I'd like to see a version of BBR in the L4S ecosystem, but I haven't seen one yet, and I'd like to not codify a version that is incompatible with the L4S ecosystem.
  - Martin: What about ECT(0), which could be a similar reaction to loss.
  - Neal: That's something we'd need to discuss if people are interested, we'd do lab testing and real-world testing as we discussed with the process.
- Christian: At the previous meeting, I presented a draft with issues we found when running BBR with Webex. As a first step, I'd probably file an issue rather than do a PR. Should we slice that draft into issues and PRs?
  - Neal: You're welcome to do whatever feels easiest for you. If you have concrete suggestions, it might be most useful to slice it into Github issues, you could offer the ideas as emails, as a separate draft...
  - Eric: A bunch of Christian's ideas are written down as a draft. Maybe we want an editor's meeting with Christian and the editors of his draft.
  - Christian: I don't want to bypass the process. In our case, we are probably somewhere between the lab simulation result and the moderate scale deployment, so it's not at the top of the ladder. But we want to have a discussion and have other people looking at the issues. So we'll slice the draft into issues and put them on Github.
- Tim Chown: In the HP-WAN BoF we've been reporting on testing of BBR to distribute data from CERN to 160 sites around the world. We understand there can be good performance, but we haven't looked at fairness. What might be done to explore fairness?
  - Neal: I have some algorithm ideas that I'm implementing and intend to test, they are somewhat speculative at this stage and would take some time to get into, so I'm not sure it makes sense to discuss them now. I welcome other suggestions. I'm optimistic we can get closer to fairness.
  - Tim: Could there be a kernel option to set an "aggression level" for BBR?
  - Neal: That should probably be discussed in this forum. My sense is that we'd want that baked in to algorithm implementations.
  - Tim: This is an EXP RFC. How does that relate to implementation in the mainline Linux kernel?
  - Neal: BBRv3 is not in the mainline Linux TCP code, it is available on Github. Getting it into mainlin Linux would need developer time. Another question is what is the level of coexistence with Reno/Cubic that we'd like to see before integrating these changes into mainline Linux. This is something we are currently weighing, we're also open to thoughts from the community.
  - Tim: The CERN community is reluctant to deploy anything that isn't in a production Linux distribution. So having it in there is going to be great value to getting it in use. Last question - Is EEfingo using BBR?
  - Neal: Yes, BBRv3.
- Michael Welzl: Following-up on ECN, there is ABE (RFC8511), which is a simple change, which uses a smaller backoff to an ECN mark using ECT(0), rather than the full L4S approach, but still with significant benefit. 
  - Neal: Yes, this is something to consider if anyone out there is going to make a proposal for how BBR should use ECN.
- Mo Zanaty: I think automated tests can lose real-world data and we can miss things about real interactions with real hardware endpoints and links (e.g. WiFi). Interactions can be more complex (e.g., wifi suspension). What are people doing for their labs, and can we simulate real-world physical devices?
  - Neal: It is up to the community, currently we have not explored BBRv3 with a range of Wifi tests. We do run lab tests, after emulation tests we run BBR through real-world internet paths before then running it through small percentage A/B experiments. Your suggestion makes a ton of sense and if there are folks out there who have the time and resources to set up labs like that and then run proposals through those labs, that'll be great.
  - Mo: Yes, I don't think the burden should be on the authors to set up that, but maybe the WG can figure out what resources we have collectively and who can slice that, particularly on the client access networks, those are not modeled well by any of the current simluation. So any data we can get from real-world Wifi, real-world mobile, we should figure out how to simulate.

_Chairs: Please do read the draft since this has now become a WG I-D, and file issues._

## **SEARCH: Slow-start Exit At Right CHokepoint**
[draft-chung-ccwg-search](https://datatracker.ietf.org/doc/draft-chung-ccwg-search/), _Mark Claypool_

- Algorithm update on the use of bins to track the history. Intended to reduce bytes needed per flow (e.g., storing u8 or u16). Rate limited streams. Looking for volunteers to experiment with, we can help with SEARCH deployment, please email claypool@wpi.edu

- Michael: On [slide 15](https://datatracker.ietf.org/meeting/121/materials/slides-121-ccwg-search-a-new-slow-start-algorithm-for-tcp-and-quic-00), is this Linux behavior going back to slow-start when there's a pause? 
  - Mark: The default doesn't do this, we set an option.
  - Neal: I think this is "TCP slow-start after idle" the shipping default, but pretty devastating for performance, so many sites do not set it as their default.
- Neal: Thank you for this work. Can we re-cast the algorithm to use another method than "bins"? What is the timescale that makes sense for comparing the expected throughput with actual throughput, a natural scale could be the RTT. There's an existing data source in Linux TCP, for every SKB upon the receipt of the ACK, the TCP stack has the send rate and delivery rate for that Round Trip of data, we added it for BBR. Could we use these as the inputs to implement SEARCH perhaps?
  - Mark: Single RTT isn't always helpful, because the RTT can be varying also in resource-managed links, so this needs more than one RTT of history, e.g., 3.5 RTTs.
  - Neal: Perhaps we could use 3 RTTs of history as a thought?
  - Joseph Beshay: 3.5 RTTs seems similar to BBRv3 startup, is this similar? Have you compared SEARCH to BBR startup instead of slow start, and would this function as an alternative to BBR startup?
  - Mark: This could be similar. You could imagine a modular slow start where you can plug and play multiple slow start exit conditions, you could try BBR startup, SEARCH, Hystart, Hystart++, maybe in a test lab and in reality. I'd like to explore that more. Some of our early testing suggests they often have a similar exit point.
- Gorry: This is good work, and a real problem. We see the benefit of such a method when Careful Resume is used, and would love to do experiments with this. Did you have any code for QUIC?
  - Mark: We implemented SEARCH in Quicly and did some testing.

_Chairs: How many people have read (any revision) of the draft? (11 people had read, of 71 total)._

_Chairs: How many people think CCWG should focus on this topic? (28 people supported this work, 1 no, 12 no opinion, of 71 total)_

_Chairs: Are people interested in testing and/or implementing this? (11 people said yes, of 71 total)_

_The chairs will start an adoption call on the list._

## **Increase of the Congestion Window when the Sender is Rate-Limited**
[draft-welzl-ccwg-ratelimited-increase](https://datatracker.ietf.org/doc/draft-welzl-ccwg-ratelimited-increase/), _Michael Welzl_

- Minor changes. Asking for adoption. Feel free to file issues [on Github](https://github.com/mwelzl/draft-ccwg-ratelimited-increase).

- Lars: Regarding the "MAY" to an EXP RFC: The question is whether the reference is normative, which would make this a downref. I think this use of a "MAY" is not normative, so the reference need not be normative, therefore, it's okay.

_Chairs: How many people have read (a recent revision) of the draft? (12 people had read, of 72 total)_

_Chairs: How many people think CCWG should focus on this topic? (20 people said yes, 0 no, 9 no opinion, of 72 total)_

_The chairs will start an adoption call on the list._

## **SCReAMv2**
[draft-johansson-ccwg-rfc8298bis-screamv2](https://datatracker.ietf.org/doc/draft-johansson-ccwg-rfc8298bis-screamv2/), _Ingemar Johansson_

- Reviewed changes and experiments. Asking for adoption.

- Gorry: This is something that has been worked on in the past and we have lots of experience. Can I ask if the WG doesn't adopt now, is this something that fits in the charter and can be continued to be discussed here?
    - Chairs: Yes this can be discussed here.
- Colin: We did the original version of this in RMCAT. I would support the group working on it if people have cycles to do so, as I think it's important to have a media congestion control as well as the more traditional ones.

_Chairs: How many people have read the draft? (4 yes, of 71 total)_

_Chairs: How many people think CCWG should focus on this topic (18 yes, 4 no, 14 no opinion, of 71 total)_

- Zahed (as AD): I think one important question is does the WG have capacity to work on this topic and BBR at the same time? I agree media congestion control is important. If this is a starting point - I think there might be more congestion control algorithms for media or non-media traffic. If we work on this one, we can still work on other media-related congestion controllers.
  - Ingemar: It has been mostly me working on this proposal, with this I am hoping that others contribute from the group, and I hope others come up with different angles and other solutions.
  - Zahed: As Gorry said, even if we don't adopt it now, Ingemar can come and present here and in ICCRG to gather more information.

_Chairs: CCWG has the bandwidth to work on SCReAMv2 and BBR in parallel (9 Yes, 6 No, 23 no opinion, of 71 total)_

- Martin: We've had four drafts presented today, so a binary question about this draft does not seem right to me.
  - Eric: You may recall [slide 14 of the chair slides](https://datatracker.ietf.org/meeting/121/materials/slides-121-ccwg-chair-02), we're about to do an adoption call for SEARCH and Rate-limited senders. So the question is, do we have bandwidth for SCReAMv2 in addition.

_Chairs: How many people are interested in implementing and/or testing this proposal? (3 Yes, of 71 total)_


The following items were under any other business, but no time was available:

- **CCA and Wi-Fi interop** _Robert McMahon_

- **Congestion control in LEO satellite networks** _Zeqi Lai_

- **CCA testing using iperf 2** _Robert McMahon_

