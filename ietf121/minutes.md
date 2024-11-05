# CCWG Working Group Agenda - IETF 121
Chairs: Eric Kinnear, Reese Enghardt

Notetaker: Gorry

## Hackathon Update from CCWG table


## Administrivia

* Blue sheets / scribe selection / [NOTE WELL](https://www.ietf.org/about/note-well.html) / [Code of Conduct](https://www.rfc-editor.org/rfc/rfc7154.html)

# Topics

## **Chair slides**
The charter has been updated since the last meeting.
github will be used to comment on and develop the documents.
    
- Christian Huitema: I'd like to see a set of test cases/scenario - perhaps a couple dozen test cases.
  - Eric: Yes, we could start from the RFC 5033 considerations.
  - Mohit Tahillani: There was a previous draft looking at TCP evaluation. QUIC has emerged and it would be good to have a set of tests. I'd be happy to contribute this around ns3. We have some ns-3 tests that can be run in an automated fashion for AQM testing as per RFC 7928.
  - Colin Perkins: I agree test cases are useful, in the past we have done this for RMCAT. It's useful. It can also become out of date quickly. For example, Pantheon was great, while it was maintained. The challenge is supporting it over time so that it doesn't bit-rot. It would be useful to get long-term support to maintain these test suites.
- Christian: I think we need more than some executable tests, people ned to understand the scenarios, and then interpret the results. The description of a (cellular, LEO satellite) scenario are also important when they represent real systems.
  - Eric: I think this would be useful to talk about this on the list. It would be good to define this list.
  - Zahed (Individual): I like this. There is a problem with how you see the network scenario, there can be multiple views. RMCAT test cases defined test cases, this might be a good starting point. I'd also like to see running the specific measurements in real networks - results might not be independent of other flows (demands on the L2 resources), this is important also before you do parameter tuning.
  - Martin Duke: We're here to deploy things on the Internet - good ideas come from various places, but standards progression needs some form of widescale experience.
  

## **BBRv3**
[draft-ietf-ccwg-bbr](https://datatracker.ietf.org/doc/draft-ietf-ccwg-bbr), _Neal Cardwell_, remote

- github is being used, please do leave comments/make issues to contribute. Email to the list might be a starting point, ..., could also offer patches to open source, results from tests. Collaboration is encouraged at each stage.
- Proposal to change the drain/pacing gain to 0.5.
- Proposal to remove BBR ack
- There is an open issue to try to generalise the draft to other transports, especially to include QUIC.
- Gorry: "Are we considering the harm of doing the 0.5 change as well as the benefit?" Reply - Yes [plus longer technical justification] This balances other changes within the draft.

- Martin: Have you thought about ECN? Reply - have not yet got to looking at L4S.
  - Martin: What about ECT(0), which could be a smilair reaction to loss. Reply - would need to look at this.
  - Michael Welzl: Following-up, there is ABE (RFC8511), which is a simple change, which uses a smaller backoff to an ECN mark using ECT(0), rather than the full L4S approach, but still with significant benefit. Reply - This is something to consider if we consider ECN.
- Christian: Ought we first to file single issues, and discuss these? - this could allow more people to think about the topics before we look at a PR?
    - Eric: We already have some text, but it would be good to involve others in the editing.
    - Christian: I'd like to see more discussion of the issues in chewable bites.
- Tim Chown: In the HP-WAN BoF we've been reporting on testing of BBR to high performance sites, we understand there can be good performance, but we haven't looked at fairness. What might be done to explore fairness? Reply - there are ideas that might help, and I welcome other suggestions. 
    - Tim is this an EXP RFC? How does that relate to implementation in the mainline kernel? Reply - BBRv3 would need developer time. Another question is how will this coexist with Reno/Cubic, which is something to decide.
    - Is EEfingo using BBR? Reply - Yes, BBRv3.
- Mo Zanaty: I think real tests can loose real-world data and we can miss things about real interactions with endpoints and links (e.g. WiFi). Interactions can be more complex (e.g., wifi suspension). Do people know how this would be explored? Reply - it is up to the community, currently we have not explored BBRv3 with a range of wifi tests, but this suggestion makes a ton of sense.

_Chairs: Please do read the draft since this has now become a WG I-D, and see if you find issues._

## **SEARCH: Slow-start Exit At Right CHokepoint**
[draft-chung-ccwg-search](https://datatracker.ietf.org/doc/draft-chung-ccwg-search/), _Mark Claypool_, remote.

- Algorithm update on the use of bins to track the history. Intended to reduce bytes needed per flow (e.g., storing u8 or u16). Rate limited streams. looking for people to experiment with.

- Michael: Is this going back to slow-start, the default doesn't do this, we chose an option.
   - Neal: I think this is "slow-start after idle" the shipping default, which many sites do not deploy as their default.
- Neal: Can we re-cast the algorithm to use another method than "bins"? Could we use the TCP SKB, which has send and delivery rates in Linux (added for BBR), could we use these as the inputs to implement SEARCH perhaps? Reply - single RTT isn't always helpful, because the RTT can be varying also in resource-managed links, so this needs more than one RTT of history, e.g., 3 RTTs. Neal: Perhaps we could use 3 RTTs of history as a thought?
- Joseph: 3.5 RTTs seems similar to BBRv3 startup, is this similar? Reply: This could be similar. More thoughts needed.
- Gorry: This is good work, and a real problem. We see the benefit of such a method when Careful Resume  is used, and would love to do experiments with this.

_Chairs: How many people have read (any revision) of the draft? (11 people had read)._

_Chairs: How many people think CCWF ought to work on this? (28 people supported this work, 1 no)_

_Chairs: Are people interested in testing and/or implementing this? (11 people said yes)_

_The chairs would like input from the list to consider an adoption call._

## **Increase of the Congestion Window when the Sender is Rate-Limited**
[draft-welzl-ccwg-ratelimited-increase](https://datatracker.ietf.org/doc/draft-welzl-ccwg-ratelimited-increase/), _Michael Welzl_

- Lars: Regarding the "MAY" to an EXP RFC. I think thsi use of a "MAY" is not normative. 

_Chairs: How many people have read (any revision) of the draft? (12 people had read, 16 no)._

_Chairs: How many people think there should be a focus on the WG doing this? (20 people had read, 0 no)._

_The chairs will start an adoption call on the list._

## **SCReAMv2**
[draft-johansson-ccwg-rfc8298bis-screamv2](https://datatracker.ietf.org/doc/draft-johansson-ccwg-rfc8298bis-screamv2/), _Ingemar Johansson_, remote.

- Reviewed changes and experiments.

- Gorry: This is something that has been worked on iun the past and we have lots of experience. Can I ask if the WG doesn't adopt now, is this something that fits in the charter and can be continued to be discussed here?
    - Chairs: Yes this can be discussed here.

_Chairs: How many people think CCWG should work on this topic (18: yes, 4 no, 14 no opinon)_

- Zahed (as AD): I think one important question is does the WG have capacity to work on this topic? Reply - I am hoping that others contribute from the group and this changes with time.

_Chairs: Is this something the WG has capacity to work on in parallel with BBR? (Yes 9, 6 No, No opinion: 4)_

_How many people are interested in testing this type of protocol? (3 yes)_


The following items were under any other business, but no time was available:

 - **CCA and Wi-Fi interop** _Robert McMahon

- **Congestion control in LEO satellite networks** _Zeqi Lai_

- **CCA testing using iperf 2** _Robert McMahon_, remote

