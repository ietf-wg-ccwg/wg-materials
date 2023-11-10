# CCWG Working Group - IETF 118

## Chair Slides - Chairs, onsite, 10 minutes

### 5033bis

Martin Duke, onsite, 60 minutes

**Non-standard and unspecified algorithms ([#35](https://github.com/ietf-wg-ccwg/rfc5033bis/issues/35))**: What are our expectations for testing?

Matt Mathis: It is generally the case that best effort is faster than realtime. It's a danger to ever observe a realtime flow that runs faster than best effort under the same conditions, and that is probably a sufficient condition.

Christian: I have a hard time thinking anything that is not publically specified imposes an obligation on anyone else.

Zahed: Maybe SHOULD?

Matt: Typically realtime protocols are attempting to minimise queues, and therefore should be slower. If they need protection, that has to be by separate queues, since bandwidth maximisation has to generate a queue. Therefore the realtime slower than maximising should be sufficient.

Spencer: It's probably not helpful to have a lot of normative language around this topic, but it would be helpful to have guidance. RFC5033bis is targeting BCP, but when we referred to the [RMCAT Requirements RFC 8836](https://datatracker.ietf.org/doc/rfc8836/), that's Informational, not BCP or standards track. It would be good for the group to think about where guidance should be stated. e.g. AVTCORE is working on RTP over QUIC, and has to be careful to say enough to be helpful without overprescribing.

Gorry: I've heard three different topics about the slide: guidance for non-IETF protocols, e.g. RMCAT requirements, perhaps other BCPs. How do we evaluate a protocol if it is not specified? And, thoughts about how we compete with such protocols since they exist in the wild, and what do we think is fair.

Lars: We used to have people presenting things in TCPM, and we'd help them analyse things further. We tried to define a set of scenarios you might want to test before bringing things to the IETF. It didn't work that well, and probably still would not. But we will need to explain that bringing CC to the IETF will require sustained effort, and that we should expect that also.

Martin: That gives me an idea for further text to add.

Lars: We do need to avoid squashing work with never-ending new requirements.

Harald: Replying to realtime... seems that traditional fairness is that it is antisocial to grab more bandwidth than you deserve, but if realtime protocols share the network, it is antisocial to create larger queues than strictly necessary. So maybe we should focus on what kinds of behaviours are antisocial; Reno builds queues. Realtime needs shorter queues, and will go into a fight-or-flight mode, either shutting down or fighting for bandwidth share.

Martin: Avoiding bufferbloat is mentioned. There is some text on fairness; "than you deserve" is under-specific.

Vidhi: Some bandwidth-maximising algorithms do look at queueing delay (e.g. BBR), but then some realtime protocols may also be bandwidth-maximising. So these may coexist in the same protocol. Something can be said about the basic requirements for coexistence, more nuanced.

Bob: New CCs should not be blamed for the problems of the Internet. We want new CCs to be better than Reno, but we also cannot say "unless you are perfect, you cannot come here".

Madhan: Not only best-effort is affecting real-time, since middleboxes started implementing different queues for real-time. Even within real-time, one can be sending at a higher rate than another. If it's in the same queue or a small queue, fairness among real-time may need to be looked at.

Christian: AQM will become more common, and that takes good care of most of the fairness issues. I don't think it is even theoretically possible to ensure fairness by end-to-end means. There are cases when we don't have AQM, and building queues is antisocial. We should take it as a fundamental that we should not build queues, and that Cubic and Reno should be considered obsolete.

Matt: The problem is that in order to measure capacity efficiently, you need to build a queue. The differences are simply which of delay and throughput is prioritised. In high-speed network, that's not a problem, but at the edges there is a conflict, and we should provide different signals for throughput maximisation.

Vidhi: Seperate queues don't exist unless the network operator provides them. Building queues not only hurts other flows, such flows also hurt themselves, so we should not accept bloat.

Gorry: The network is very heterogeneous. There are places where there are many queues, places where there cannot be. We have to make congestion control work on everything.

**AQMs in scope? ([#7](https://github.com/ietf-wg-ccwg/rfc5033bis/issues/7)) and Desynchronised flows ([#11](https://github.com/ietf-wg-ccwg/rfc5033bis/issues/11))**

Bob: There are billions of FIFO buffers in the internet, and a very large proportion of the bottlenecks are those. Majority of operators don't understand AQM. Congestion control therefore must be specified wrt FIFOs, therefore that should be in the list. New CCs should be those that behave better in FIFO queues, but we should not be too dogmatic about that.

Martin: There are two questions here. If someone comes up with a congestion control, how much evaluation are we going to ask for. Second, are we going to ask for AQM evaluation here? (there are documents elsewhere)

Stuart: I hear lots of talk about realtime traffic as if that is a strange case, and I think we need to stop thinking about that. For a start, we are using realtime to mean low-delay. Delay sensitive traffic is not an odd case, it's most of what end user devices do. Second, I don't think you can ever reach low delay if you don't consider how long packets wait, and FIFO means you didn't. Therefore we need both AQM and CC to cooperate.

Lars: There is too much FIFO out there still. We should, unfortunately, to evaluate CC wrt FIFO, but we should also evaluate AQM interactions. So, we should be saying "it needs to work in a FIFO Internet and also in whatever AQM Internet we see it evolving into"

Martin: Of course, running through all the AQMs just because they are specified is excessive.

Madhan: We should also distinguish between maximising best-effort and rate-limited maximising best-effort (e.g. streaming). These behave very differently, and we should consider that.

Ruediger: One should also try not to have the network solving all the problems of transport; complexity for operators is also a consideration.

Tim: We also insist on moving LHC data around the network with terabit rates, and a single infrastructure that can deal with that in parallel with interactive is something we need to look at.

Gorry: We need to have a sensibly configured RED as an option for evaluation. Did I hear that we should consider both FIFO and AQM, but not necessarily all AQMs. New AQMs need a working group, should not be here.

Martin: I'd use a word like 'consider' common AQMs, but not require detailed simulations or experiments; definitely not an interop matrix.

Matt: Desynchronising flows; flows should not control against queue full, which creates a bunch of issues. There are a lot of these considerations which can be demonstrated with a single flow in a vacuum. Control against full queues should be forbidden, that creates a variety of problematic issues we have seen. AQM and delay-sensing CC should both be present.

Gorry: Martin and I would both like to capture what we heard. If you said something, please send email or PRs!

Magnus: What about multicast CC, is that in scope? I don't think we should be silent about that topic.

Martin: Is that so different that we need a different document?

Gorry: I've done a bunch of multicast... this can be a very deep topic in itself. Maybe we should try to find sufficient energy to work on that, and see if that turns into a paragraph or a document.

Lars: I would suggest to rule multicast out of scope, as it is a very special animal, and not widely deployed. It may absorb a lot of time for little benefit.

Bob: I think leaving it out of scope of this document is reasonable, and the multicast CC document would be much easier to write after this one.

## Safe Congestion Control

Matt Mathis, remote, 20 minutes

Bob: There may be a conflict between limited loss and monotonicity.

Matt: This is true, but the rate decreases. When Reno was first implemented there was no SACK, and under a few % loss it becomes timeout driven, and so you could not see the synchronous SACK-driven behaviour. I have seen a flow that sustained 30% loss. That should not be OK. BBR rather makes the assumption that loss should only happen in probing.

Matt: The document should make it clear that this refers to self-induced loss. If you are the only flow in a pipe with a very small buffer, what loss rate do you case? There is a phase-change in ACK-clocked protocols that you don't have to have if pacing.

Bob: Testing over very low round trip times should be mentioned.

Matt: Yes, testing paths where the window size is 1, 2 or 3.

Bob: There are becoming to be more such paths.

Matt: There are DC paths where the ack time is shorter than a TSO bundle...

Gorry: I always worry about minRTT and how we understand this. We have a growing number of L2 networks that do a lot of work and end up naturally varying the minRTT... so what actually is the minRTT in that environment?

Matt: I wish that the queue occupancy limit was the last resort, in other words that other mechanisms come in to effect first. Buffer size should be limited to a small multiple of RTT. You have to have some way to derive a minRTT so you can make decisions that will avoid full queue.

Gorry: The starting assumption is that delay is due to queuing, and one may be at L2 and be necessary, and how do we tell them apart?

Matt: The minRTT is used to limit the backlog, and we're avoiding infinite backlogs. It can be wonky, but it has to stably avoid infinity.

Stuart: Maybe 0.1% loss is not too ambitious. In a world before ECN where CC is designed to inflict loss, loss is inevitable. With ECN, I hope the bottlenecks can signal and the senders respond quickly, I think we should set our goal to much lower loss.

Matt: You're correct, but you can't avoid the situation of slow start hitting the bottleneck queue in a situation where you don't get the ECN marks in time. BBR tried to set a strict limit, but the result was that slowstart would cause it never to be able to open the window again. There needs to be a lot of mechanism for connection-state reuse so as to reduce the number of slowstarts.

Martin Duke: Self-induced loss; 5033bis doesn't have that metric at present. Just created a github issue on this subject. Have you had a chance to look at the reorg? In that framework you have trouble creating the PRs?

Matt: It's a tooling issue...

Martin: lets get together offline

Harald: *clarifying question*

Matt: Overhead bytes should be constant at the receiver under all conditions.

Harald: When you start seeing loss over a certain threshold, some protocols will start sending FEC data, which increases the overhead, but will only do it once. Is that really a bad idea?

Matt: I suspect that fails to allow new flows to enter.

Lars: Feels like we're revising our understanding here, which is great. But 5033 is a BCP, and this feels like best future practice. It seems like we should communicate this widely, and a revised BCP may not be the best way to do that... we should instead figure out what the emerging direction is, and communicate them widely.

Matt: There are 13 criteria, some of which can be immediately merged with wordsmithing, and some of which are not ready. I intend to keep this document up to date with the state of thought, because 5033 is inadequate.

Lars: exposing people to these thoughts earlier would be great, and it would be good to find a way to do that.

## Analysis for the Differences Between Standard Congestion Control Schemes

Yoshifumi Nishida, remote, 10 minutes

Christian: We should go away from the concept that there is one generic TCP congestion control; the usual reference for that is Reno, and we should not be using that as a reference.

Yoshi: In my understanding, Reno and Cubic are the standardised protocols. BBR is not a standard.

Christian: We cannot blind ourselves and say it's not in the IETF therefore it doesn't exist.

Yoshi: in which case we should probably declare Reno obsolete.

Matt: Reno and Cubic both do things which should be banned, comparing with them should not be encouraged. We need to get past those ASAP.

Yoshi: what would be better?

Matt: I think BBR does a pretty good job, but we caused BBR to be bug-compatible with Reno

Martin Duke: Rather than putting energy into this, maybe we should just put energy into 5681bis instead. If it were me, I would update loss recovery parts of 5681 to point at whichever standard CCs there are, and have a seperate document that describes Reno. I think that's the most useful way to contribute in this area.

## Containing the Cambrian Explosion in QUIC Congestion Control

Ayush Mishra, remote, 20 minutes (as time permits)

Randall: It seems like this is more like a measurement of similarity of CCs, rather than a consideration of safety or deployability.

Ayush: Right now you have to way to compare a new implementation to a draft.

Matt: The suggestion of pinning a reference implementation seems like a good idea.
