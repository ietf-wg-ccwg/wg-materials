# CCWG, 18 March 2025, Bangkok, Thailand

# Chair slides, Chairs, onsite, 10 minutes

# New Tools for Testing Congestion Control and Queue Management Algorithms, Rati Preethi S, Y Supradha Bhat, Shriya Anil, Anuhya Murki, Mahati A Kalale, Mohit P. Tahiliani, onsite, 10 minutes

Lars: Are you going to support QUIC?

Mohit: ccperf is on top of ns-3, but there is no native QUIC model there yet. There is an open pull request for Nest QUIC support.

Lars: I want to test my implementation. The ns-3 cradle doesn't work well.

Mohit: I can help you with that.

Ian: Diverse situations is a big plus. I'm interested in video delivery.

Ingemar: I want L4S support and SCReAM.

Mohit: Possible in ccperf, because ns-3 supports it. But ns-3 doesn't have SCReAM.

Eric: this will really help with RFC9743 compliance.

# BBRv3, draft-ietf-ccwg-bbr, Ian Swett, onsite, 20 minutes

## Slide 5 (Goals of evolving the BBR draft text):

Martin Duke: Thanks Ian. I support the bar you're proposing. How close do you think you are to meeting this bar?

Ian: If all the issues that are filed are the issue we'll deal with? End of this year-ish. If we are open to other changes...

Martin: Experimental is good, we haven't perfected it yet. Later we'll perfect it and get a Standard. An Experimental draft should have an experiment in it, you may want to add a section. I'm conducting some large-scale ECN tests on CUBIC right now, but if you, Neal, and I get together for BBR, I could probably do that simultaneously within the year timescale.

Ian: I agree, one implementation can get reasonable scale testing, but I worry about negotiating end-to-end, especially for L4S. The path towards TCP L4S on the public Internet may not be in the 1-year timeframe. 

Martin: We could do it for QUIC though. Do we feel comfortable with ECT(0) CE being treated as loss?

Ian: That seems plausible to me. Neal also had thoughts.

Gorry: There's a lot to do. How do we get feedback from the group?

Ian: We would appreciate simulation results that show something really, really bad. What are the concerns? We can triage. This is not great for VTC, e.g., though better than Cubic. Concrete test results are much more helpful than vague concerns.

Lucas: I agree with the thesis: get it done. ECN is going to get gummed up.

Christian: Propose some additional goals. Why not real-time? BBR is still better than everything else. Please be explicit that you're not going to solve important problems, so I can be clear that I'm compliant or not.

Ian: RT will take too long.

Christian: Coexistence with Reno/Cubic is potentially bad because of the feedback time scale, and we will not reply correctly to feedback. Waiting 60 RTTs in cruise mode is horrific. App limited case is dicey, too.

Ian: Yes, there will be a "good enough" threshold with respect to Reno/Cubic. Please file issues.

Richard S: Shelve ECN to be faster.

Ian: I expect BBR-bis to start immediately after RFC.

Eric: Yes, many many RFCs. We will never be done.

Neal: ECT(0) probably treating as loss is feasible, but let's punt. Coexistence testing is important, would love help here. We have Linux TCP v3 on github, could plug into testing tools.

Neal: v2/v3 are conservative because of Cubic coexistence. I have ideas, but how long do we want to wait?

Ian: Please use github tip of tree, not mainline Linux. There is a big difference.

Alexander Azimov: I thought BBR was going to have a datacenter flavor (BBR.swift). What happened?

Ian: It exists, is not on public internet. There is no QUIC implementation.

Neal: Not open source because it requires non-standard options. Have to do a lot of TCPM work to make Linux community comfortable. We hope to open source something eventually when dependencies are resolved.

Mirja: I would hope the RFC would be a little more stable. Tasks seem focused on editorial cleanup. What about fairness, etc?

Ian: Some thresholds are supported by derivation, others are magic numbers. Please file an issues where more explanation is needed.

Eric: We need to decide what is in scope for now. ECN seems like next. Are we in a place to answer all the open questions?

Ian: BBRv3 hasn't materially changed in ~18 months, so it's pretty stable.

Eric: we need an actual RFC for activation energy to deploy.

Neal: Eric + 1. We need community consensus on right level of Cubic-friendliness.

Eric: go through issues one-by-one.

## Slide 6 (open PRs): no comments

## Slide 7 (generalization to non-TCP): no comments

Mirja: we don't need full fairness -- can we deep dive into fairness in a future session? and document in the draft.

## Slide 8 (Probe RTT interval 5s/10s):

Christian: 10 is better than 5, but 10 is still bad for real-time, but maybe we're punting RT.

Neal: I have ideas to reduce the 1RTT penalty. Would like research help. Maybe punt to bis.

Mirja: Multi decrease (LEDBAT++) is good for finding minRTT.

## Slide 9: (rename inflight_hi/lo: No comments

## Slide 10: (inflight_shortterm needed?)

Ian: It's complicated, maybe discuss offline.

## Slide 11: ECN

already discussed, probably punt to bis

# Rate-limited senders, draft-ietf-ccwg-ratelimited-increase, Mohit P. Tahiliani, onsite, 10 minutes

Ian: what about pacing limited?

Gorry: We want to include this but need help.

# SEARCH, draft-chung-ccwg-search, Mark Claypool, remote, 20 minutes

Mirja: Hystart Linux implementation has an important error -- there's a paper. Some of this is not that new/unique. It would be helpful to understand the key algorithm differences.

Neal: Have you experimented with WiFi (yes)? We've seen big RTT variation on WiFi. I'm concerned that initial RTT is a bad input.

Mark: yes, wifi results have not been great - we'll look at that suggestion.

Altanai: What happens in asymmetric networks, if the acks are the bottleneck?

Mark: Not sure, have to look into it.

Christian: We are always going to make mistakes at the start of connections. Be aggressive, then be very conservative. We will pay for early mistakes. Early and late algorithm should not be that different.

