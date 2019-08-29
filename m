Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D9A0FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 05:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfH2DoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 23:44:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfH2DoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:44:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7T3h0Nt127938;
        Wed, 28 Aug 2019 23:43:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up31jdtpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 23:43:39 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7T3hctq129903;
        Wed, 28 Aug 2019 23:43:38 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up31jdtp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 23:43:38 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7T3ewBu008633;
        Thu, 29 Aug 2019 03:43:37 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03wdc.us.ibm.com with ESMTP id 2ujvv6t3dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 03:43:37 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7T3hb0T53346654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 03:43:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01EC4B2064;
        Thu, 29 Aug 2019 03:43:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCC3AB205F;
        Thu, 29 Aug 2019 03:43:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.151.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 03:43:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9547D16C0727; Wed, 28 Aug 2019 20:43:36 -0700 (PDT)
Date:   Wed, 28 Aug 2019 20:43:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
Message-ID: <20190829034336.GD4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <5d648897.1c69fb81.5e60a.fc70@mx.google.com>
 <20190828202330.GS26530@linux.ibm.com>
 <20190828210525.GB75931@google.com>
 <20190828211904.GX26530@linux.ibm.com>
 <20190828214241.GD75931@google.com>
 <20190828220108.GC26530@linux.ibm.com>
 <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com>
 <20190829015155.GB100789@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829015155.GB100789@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 09:51:55PM -0400, Joel Fernandes wrote:
> On Wed, Aug 28, 2019 at 04:12:47PM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 28, 2019 at 06:14:44PM -0400, Joel Fernandes wrote:
> > > On Wed, Aug 28, 2019 at 03:01:08PM -0700, Paul E. McKenney wrote:
> > > > On Wed, Aug 28, 2019 at 05:42:41PM -0400, Joel Fernandes wrote:
> > > > > On Wed, Aug 28, 2019 at 02:19:04PM -0700, Paul E. McKenney wrote:
> > > > > > On Wed, Aug 28, 2019 at 05:05:25PM -0400, Joel Fernandes wrote:
> > > > > > > On Wed, Aug 28, 2019 at 01:23:30PM -0700, Paul E. McKenney wrote:
> > > > > > > > On Mon, Aug 26, 2019 at 09:33:54PM -0400, Joel Fernandes (Google) wrote:
> > > > > > > > > The dynticks_nmi_nesting counter serves 4 purposes:
> > > > > > > > > 
> > > > > > > > >       (a) rcu_is_cpu_rrupt_from_idle() needs to be able to detect first
> > > > > > > > >           interrupt nesting level.
> > > > > > > > > 
> > > > > > > > >       (b) We need to detect half-interrupts till we are sure they're not an
> > > > > > > > >           issue. However, change the comparison to DYNTICK_IRQ_NONIDLE with 0.
> > > > > > > > > 
> > > > > > > > >       (c) When a quiescent state report is needed from a nohz_full CPU.
> > > > > > > > >           The nesting counter detects we are a first level interrupt.
> > > > > > > > > 
> > > > > > > > > For (a) we can just use dyntick_nesting == 1 to determine this. Only the
> > > > > > > > > outermost interrupt that interrupted an RCU-idle state can set it to 1.
> > > > > > > > > 
> > > > > > > > > For (b), this warning condition has not occurred for several kernel
> > > > > > > > > releases.  But we still keep the warning but change it to use
> > > > > > > > > in_interrupt() instead of the nesting counter. In a later year, we can
> > > > > > > > > remove the warning.
> > > > > > > > > 
> > > > > > > > > For (c), the nest check is not really necessary since forced_tick would
> > > > > > > > > have been set to true in the outermost interrupt, so the nested/NMI
> > > > > > > > > interrupts will check forced_tick anyway, and bail.
> > > > > > > > 
> > > > > > > > Skipping the commit log and documentation for this pass.
> > > > > > > [snip] 
> > > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > > index 255cd6835526..1465a3e406f8 100644
> > > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > > @@ -81,7 +81,6 @@
> > > > > > > > >  
> > > > > > > > >  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> > > > > > > > >  	.dynticks_nesting = 1,
> > > > > > > > > -	.dynticks_nmi_nesting = 0,
> > > > > > > > 
> > > > > > > > This should be in the previous patch, give or take naming.
> > > > > > > 
> > > > > > > Done.
> > > > > > > 
> > > > > > > > >  	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
> > > > > > > > >  };
> > > > > > > > >  struct rcu_state rcu_state = {
> > > > > > > > > @@ -392,15 +391,9 @@ static int rcu_is_cpu_rrupt_from_idle(void)
> > > > > > > > >  	/* Check for counter underflows */
> > > > > > > > >  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> > > > > > > > >  			 "RCU dynticks_nesting counter underflow!");
> > > > > > > > > -	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> > > > > > > > > -			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> > > > > > > > >  
> > > > > > > > > -	/* Are we at first interrupt nesting level? */
> > > > > > > > > -	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
> > > > > > > > > -		return false;
> > > > > > > > > -
> > > > > > > > > -	/* Does CPU appear to be idle from an RCU standpoint? */
> > > > > > > > > -	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
> > > > > > > > > +	/* Are we the outermost interrupt that arrived when RCU was idle? */
> > > > > > > > > +	return __this_cpu_read(rcu_data.dynticks_nesting) == 1;
> > > > > > > > >  }
> > > > > > > > >  
> > > > > > > > >  #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch ... */
> > > > > > > > > @@ -564,11 +557,10 @@ static void rcu_eqs_enter(bool user)
> > > > > > > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > > > > > > >  
> > > > > > > > >  	/* Entering usermode/idle from interrupt is not handled. These would
> > > > > > > > > -	 * mean usermode upcalls or idle entry happened from interrupts. But,
> > > > > > > > > -	 * reset the counter if we warn.
> > > > > > > > > +	 * mean usermode upcalls or idle exit happened from interrupts. Remove
> > > > > > > > > +	 * the warning by 2020.
> > > > > > > > >  	 */
> > > > > > > > > -	if (WARN_ON_ONCE(rdp->dynticks_nmi_nesting != 0))
> > > > > > > > > -		WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> > > > > > > > > +	WARN_ON_ONCE(in_interrupt());
> > > > > > > > 
> > > > > > > > And this is a red flag.  Bad things happen should some common code
> > > > > > > > that disables BH be invoked from the idle loop.  This might not be
> > > > > > > > happening now, but we need to avoid this sort of constraint.
> > > > > > > > How about instead merging ->dyntick_nesting into the low-order bits
> > > > > > > > of ->dyntick_nmi_nesting?
> > > > > > > > 
> > > > > > > > Yes, this assumes that we don't enter process level twice, but it should
> > > > > > > > be easy to add a WARN_ON() to test for that.  Except that we don't have
> > > > > > > > to because there is already this near the end of rcu_eqs_exit():
> > > > > > > > 
> > > > > > > > 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> > > > > > > > 
> > > > > > > > So the low-order bit of the combined counter could indicate process-level
> > > > > > > > non-idle, the next three bits could be unused to make interpretation
> > > > > > > > of hex printouts easier, and then the rest of the bits could be used in
> > > > > > > > the same way as currently.
> > > > > > > > 
> > > > > > > > This would allow a single read to see the full state, so that 0x1 means
> > > > > > > > at process level in the kernel, 0x11 is interrupt (or NMI) from process
> > > > > > > > level, 0x10 is interrupt/NMI from idle/user, and so on.
> > > > > > > > 
> > > > > > > > What am I missing here?  Why wouldn't this work, and without adding yet
> > > > > > > > another RCU-imposed constraint on some other subsystem?
> > > > > > > 
> > > > > > > What about replacing the warning with a WARN_ON_ONCE(in_irq()), would that
> > > > > > > address your concern?
> > > > > > > 
> > > > > > > Also, considering this warning condition is most likely never occurring as we
> > > > > > > know it, and we are considering deleting it soon enough, is it really worth
> > > > > > > reimplementing the whole mechanism with a complex bit-sharing scheme just
> > > > > > > because of the BH-disable condition you mentioned, which likely doesn't
> > > > > > > happen today? In my implementation, this is just a simple counter. I feel
> > > > > > > combining bits in the same counter will just introduce more complexity that
> > > > > > > this patch tries to address/avoid.
> > > > > > > 
> > > > > > > OTOH, I also don't mind with just deleting the warning altogether if you are
> > > > > > > Ok with that.
> > > > > > 
> > > > > > The big advantage of combining the counters is that all of the state is
> > > > > > explicit and visible in one place.  Plus it can be accessed atomically.
> > > > > > And it avoids setting a time bomb for some poor guys just trying to get
> > > > > > their idle-loop jobs done some time in the dim distant future.
> > > > > 
> > > > > I could try the approach you're suggesting but I didn't actually see an issue
> > > > > with the patch in its current state other than the WARN_ON_ONCE which I could
> > > > > change to WARN_ON_ONCE(in_irq()) to remove the concern. AFAICS, we don't
> > > > > detect "half soft-interrupts" in this code in anyway.
> > > > > 
> > > > > I do feel the approach you're suggesting can be a follow up, these 2 patches
> > > > > just focus on deleting dynticks_nmi_nesting counter and we can test this
> > > > > approach thoroughly for a release or so.
> > > > > 
> > > > > > Besides, this pair of patches already makes a large change from a
> > > > > > conceptual viewpoint.  If we are going to make a large change, let's
> > > > > > get our money's worth out of that change!
> > > > > 
> > > > > IMHO, most of the changes are to code comments, the actual code change is
> > > > > very little and is just removal of dynticks_nmi_nesting and simplification;
> > > > > its not really an introduction of a new mechanism.
> > > > 
> > > > This change is not fixing a bug, so there is no need for an emergency fix,
> > > > and thus no point in additional churn.  I understand that it is a bit
> > > > annoying to code and test something and have your friendly maintainer say
> > > > "sorry, wrong rocks", and the reason that I understand this is that I do
> > > > that to myself rather often.
> > > 
> > > The motivation for me for this change is to avoid future bugs such as with
> > > the following patch where "== 2" did not take the force write of
> > > DYNTICK_IRQ_NONIDLE into account:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=13c4b07593977d9288e5d0c21c89d9ba27e2ea1f
> > 
> > Yes, the current code does need some simplification.
> > 
> > > I still don't see it as pointless churn, it is also a maintenance cost in its
> > > current form and the simplification is worth it IMHO both from a readability,
> > > and maintenance stand point.
> > > 
> > > I still don't see what's technically wrong with the patch. I could perhaps
> > > add the above "== 2" point in the patch?
> > 
> > I don't know of a crash or splat your patch would cause, if that is
> > your question.  But that is also true of the current code, so the point
> > is simplification, not bug fixing.  And from what I can see, there is an
> > opportunity to simplify quite a bit further.  And with something like
> > RCU, further simplification is worth -serious- consideration.
> > 
> > > We could also discuss f2f at LPC to see if we can agree about it?
> > 
> > That might make a lot of sense.
> 
> Sure. I am up for a further redesign / simplification. I will think more
> about your suggestions and can also further discuss at LPC.

One question that might (or might not) help:  Given the compound counter,
where the low-order hex digit indicates whether the corresponding CPU
is running in a non-idle kernel task and the rest of the hex digits
indicate the NMI-style nesting counter shifted up by four bits, what
could rcu_is_cpu_rrupt_from_idle() be reduced to?

> And this patch is on LKML archives and is not going anywhere so there's no
> rush I guess ;-)

True enough!  ;-)

> > In the meantime, could you please create an independent series (or
> > more than one series, as the case may be) of the other patches?
> 
> The only other patch in this series is to repurpose the dyntick_nesting
> counter to do the job of the dynticks_nmi_nesting counter. Did you mean that
> one? Or did you mean the dntick tracing patch? I think I should indeed submit
> the tracing patch separately.

Heh!

You have sent me a number of patches over the past day or two.  Respin
them as needed and resend.  My feeling was that one of the groups could
be split, but then again there might have been dependencies among the
patches that I didn't see.  You decide.

On the tracing patch...  That patch might be a good idea regardless,
but I bet that the reason that you felt the sudden need for it was due
to the loss of information in your eventual ->dynticks_nesting field.
After all, the value 0x1 might be an interrupt from idle, or it might
just as easily be a task running in the kernel at process level.

The reason the patch might nevertheless be a good idea is that redundant
information can be helpful when debugging.  Especially when debugging
new architecture-specific code, which is when RCU's dyntick-idle warnings
tend to find bugs.

							Thanx, Paul
