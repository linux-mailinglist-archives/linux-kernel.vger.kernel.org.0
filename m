Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6609267ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2019 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfGMPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jul 2019 11:13:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727626AbfGMPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 11:13:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6DFBToP112924
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 11:13:37 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tqb5yhg4y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 11:13:37 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 13 Jul 2019 16:13:36 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 13 Jul 2019 16:13:32 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6DFDVJ250659696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jul 2019 15:13:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 324BDB2064;
        Sat, 13 Jul 2019 15:13:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFDFDB206B;
        Sat, 13 Jul 2019 15:13:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.158.189])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 13 Jul 2019 15:13:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 94C6C16C8E7F; Sat, 13 Jul 2019 08:13:30 -0700 (PDT)
Date:   Sat, 13 Jul 2019 08:13:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Reply-To: paulmck@linux.ibm.com
References: <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
 <CANrsvRMh6L_sEmoF_K3Mx=1VcuGSwQAT8CZHep69aSZUTBvwpA@mail.gmail.com>
 <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTeAUuVqViBfiOTQhckMDH229oQdPXG6SNqGK0xYm-yzA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19071315-0064-0000-0000-000003FB5249
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011421; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231618; UDB=6.00648815; IPR=6.01012910;
 MB=3.00027705; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-13 15:13:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071315-0065-0000-0000-00003E3F4E49
Message-Id: <20190713151330.GE26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907130185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 10:20:02AM -0400, Joel Fernandes wrote:
> On Sat, Jul 13, 2019 at 4:47 AM Byungchul Park
> <max.byungchul.park@gmail.com> wrote:
> >
> > On Fri, Jul 12, 2019 at 9:51 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Fri, Jul 12, 2019 at 03:32:40PM +0900, Byungchul Park wrote:
> > > > On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > > > > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > > > > period ever is recorded in rcu_state.gp_max. However it is not read from
> > > > > anywhere.
> > > > >
> > > > > Any idea why it was added but not used?
> > > > >
> > > > > I am interested in dumping this value just for fun, and seeing what I get.
> > > > >
> > > > > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > > > > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > > > > look like.
> > > >
> > > > Hi,
> > > >
> > > >       commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> > > >       rcu: Remove debugfs tracing
> > > >
> > > > removed all debugfs tracing, gp_max also included.
> > > >
> > > > And you sounds great. And even looks not that hard to add it like,
> > > >
> > > > :)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index ad9dc86..86095ff 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> > > >       raw_spin_lock_irq_rcu_node(rnp);
> > > >       rcu_state.gp_end = jiffies;
> > > >       gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > > > -     if (gp_duration > rcu_state.gp_max)
> > > > +     if (gp_duration > rcu_state.gp_max) {
> > > >               rcu_state.gp_max = gp_duration;
> > > > +             trace_rcu_grace_period(something something);
> > > > +     }
> > >
> > > Yes, that makes sense. But I think it is much better off as a readable value
> > > from a virtual fs. The drawback of tracing for this sort of thing are:
> > >  - Tracing will only catch it if tracing is on
> > >  - Tracing data can be lost if too many events, then no one has a clue what
> > >    the max gp time is.
> > >  - The data is already available in rcu_state::gp_max so copying it into the
> > >    trace buffer seems a bit pointless IMHO
> > >  - It is a lot easier on ones eyes to process a single counter than process
> > >    heaps of traces.
> > >
> > > I think a minimal set of RCU counters exposed to /proc or /sys should not
> > > hurt and could do more good than not. The scheduler already does this for
> > > scheduler statistics. I have seen Peter complain a lot about new tracepoints
> > > but not much (or never) about new statistics.
> > >
> > > Tracing has its strengths but may not apply well here IMO. I think a counter
> > > like this could be useful for tuning of things like the jiffies_*_sched_qs,
> > > the stall timeouts and also any other RCU knobs. What do you think?
> >
> > I prefer proc/sys knob for it to tracepoint. Why I've considered it is just it
> > looks like undoing what Paul did at ae91aa0ad.
> >
> > I think you're rational enough. I just wondered how Paul think of it.
> 
> I believe at least initially, a set of statistics can be made
> available only when rcutorture or rcuperf module is loaded. That way
> they are purely only for debugging and nothing needs to be exposed to
> normal kernels distributed thus reducing testability concerns.
> 
> rcu_state::gp_max would be trivial to expose through this, but for
> other statistics that are more complicated - perhaps
> tracepoint_probe_register can be used to add hooks on to the
> tracepoints and generate statistics from them. Again the registration
> of the probe and the probe handler itself would all be in
> rcutorture/rcuperf test code and not a part of the kernel proper.
> Thoughts?

It still feels like you guys are hyperfocusing on this one particular
knob.  I instead need you to look at the interrelating knobs as a group.

On the debugging side, suppose someone gives you an RCU bug report.
What information will you need?  How can you best get that information
without excessive numbers of over-and-back interactions with the guy
reporting the bug?  As part of this last question, what information is
normally supplied with the bug?  Alternatively, what information are
bug reporters normally expected to provide when asked?

							Thanx, Paul

