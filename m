Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79F4894F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 01:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfHKXtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Aug 2019 19:49:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbfHKXto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 19:49:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7BNlLOh117282
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 19:49:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uab1a2gsx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 19:49:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 12 Aug 2019 00:49:41 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Aug 2019 00:49:37 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7BNnaaI49086852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Aug 2019 23:49:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE61AB205F;
        Sun, 11 Aug 2019 23:49:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7935DB2064;
        Sun, 11 Aug 2019 23:49:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Aug 2019 23:49:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4EAB216C9A70; Sun, 11 Aug 2019 16:49:39 -0700 (PDT)
Date:   Sun, 11 Aug 2019 16:49:39 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rao Shoaib <rao.shoaib@oracle.com>, kernel-team@android.com,
        kernel-team <kernel-team@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806235631.GU28441@linux.ibm.com>
 <20190807094504.GB169551@google.com>
 <20190807175215.GE28441@linux.ibm.com>
 <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <CANrsvRPU_u6oKpjZ1368Evto+1hGboNYeOuMdbdzaOfXhSO=5g@mail.gmail.com>
 <20190808180916.GP28441@linux.ibm.com>
 <20190811083626.GA9486@X58A-UD3R>
 <20190811084950.GB9486@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811084950.GB9486@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081123-0060-0000-0000-0000036BB62E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011583; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01245482; UDB=6.00657182; IPR=6.01026979;
 MB=3.00028138; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-11 23:49:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081123-0061-0000-0000-00004A839A72
Message-Id: <20190811234939.GC28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-11_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908110266
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 05:49:50PM +0900, Byungchul Park wrote:
> On Sun, Aug 11, 2019 at 05:36:26PM +0900, Byungchul Park wrote:
> > On Thu, Aug 08, 2019 at 11:09:16AM -0700, Paul E. McKenney wrote:
> > > On Thu, Aug 08, 2019 at 11:23:17PM +0900, Byungchul Park wrote:
> > > > On Thu, Aug 8, 2019 at 9:56 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > On Thu, Aug 08, 2019 at 06:52:32PM +0900, Byungchul Park wrote:
> > > > > > On Wed, Aug 07, 2019 at 10:52:15AM -0700, Paul E. McKenney wrote:
> > > > > > > > > On Tue, Aug 06, 2019 at 05:20:40PM -0400, Joel Fernandes (Google) wrote:
> > > > > > > [ . . . ]
> > > > > > > > > > +     for (; head; head = next) {
> > > > > > > > > > +             next = head->next;
> > > > > > > > > > +             head->next = NULL;
> > > > > > > > > > +             __call_rcu(head, head->func, -1, 1);
> > > > > > > > >
> > > > > > > > > We need at least a cond_resched() here.  200,000 times through this loop
> > > > > > > > > in a PREEMPT=n kernel might not always be pretty.  Except that this is
> > > > > > > > > invoked directly from kfree_rcu() which might be invoked with interrupts
> > > > > > > > > disabled, which precludes calls to cond_resched().  So the realtime guys
> > > > > > > > > are not going to be at all happy with this loop.
> > > > > > > >
> > > > > > > > Ok, will add this here.
> > > > > > > >
> > > > > > > > > And this loop could be avoided entirely by having a third rcu_head list
> > > > > > > > > in the kfree_rcu_cpu structure.  Yes, some of the batches would exceed
> > > > > > > > > KFREE_MAX_BATCH, but given that they are invoked from a workqueue, that
> > > > > > > > > should be OK, or at least more OK than queuing 200,000 callbacks with
> > > > > > > > > interrupts disabled.  (If it turns out not to be OK, an array of rcu_head
> > > > > > > > > pointers can be used to reduce the probability of oversized batches.)
> > > > > > > > > This would also mean that the equality comparisons with KFREE_MAX_BATCH
> > > > > > > > > need to become greater-or-equal comparisons or some such.
> > > > > > > >
> > > > > > > > Yes, certainly we can do these kinds of improvements after this patch, and
> > > > > > > > then add more tests to validate the improvements.
> > > > > > >
> > > > > > > Out of pity for people bisecting, we need this fixed up front.
> > > > > > >
> > > > > > > My suggestion is to just allow ->head to grow until ->head_free becomes
> > > > > > > available.  That way you are looping with interrupts and preemption
> > > > > > > enabled in workqueue context, which is much less damaging than doing so
> > > > > > > with interrupts disabled, and possibly even from hard-irq context.
> > > > > >
> > > > > > Agree.
> > > > > >
> > > > > > Or after introducing another limit like KFREE_MAX_BATCH_FORCE(>=
> > > > > > KFREE_MAX_BATCH):
> > > > > >
> > > > > > 1. Try to drain it on hitting KFREE_MAX_BATCH as it does.
> > > > > >
> > > > > >    On success: Same as now.
> > > > > >    On fail: let ->head grow and drain if possible, until reaching to
> > > > > >             KFREE_MAX_BATCH_FORCE.
> > > > 
> > > > I should've explain this in more detail. This actually mean:
> > > > 
> > > > On fail: Let ->head grow and queue rcu_work when ->head_free == NULL,
> > > >          until reaching to _FORCE.
> > > > 
> > > > > > 3. On hitting KFREE_MAX_BATCH_FORCE, give up batching but handle one by
> > > > > >    one from now on to prevent too many pending requests from being
> > > > > >    queued for batching work.
> > > > 
> > > > This mean:
> > > > 
> > > > 3. On hitting KFREE_MAX_BATCH_FORCE, give up batching requests to be added
> > > >    from now on but instead handle one by one to prevent too many
> > > > pending requests
> > 
> > Oh! I'm sorry for the weird formatted mail that I wrote with another
> > mail client than the one I usually use, outside of office.
> > 
> > > >    from being queued. Of course, the requests already having been
> > > > queued in ->head
> > > >    so far should be handled by rcu_work when it's possible which can
> > > > be checked by
> > > >    the monitor or kfree_rcu() inside every call.
> > > 
> > > But does this really help?  After all, the reason we have piled up a
> > > large number of additional callbacks is likely because the grace period
> > > is taking a long time, or because a huge number of callbacks has been
> > > queued up.  Sure, these callbacks might get a head start on the following
> > > grace period, but at the expense of still retaining the kfree_rcu()
> > > special cases in rcu_do_batch().
> > 
> > Now, I just can see what you want to get with this work. Then we'd
> > better avoid that kind of exception as much as possible.
> > 
> > > Another potential issue is interaction with rcu_barrier().  Currently,
> > > rcu_barrier() waits for memory passed to prior kfree_rcu() calls to be
> > > freed.  This is useful to allow a large amount of memory be be completely
> > > freed before allocating large amounts more memory.  With the earlier
> > > version of the patch, an rcu_barrier() followed by a flush_workqueue().
> > > But #3 above would reorder the objects so that this approach might not
> > > wait for everything.
> > 
> > It doesn't matter by making the queue operated in FIFO manner though,
> > so as to guarantee the order.
> 
> I only explained about the re-order problem but yes, we need to come up
> with how to deal with the synchronization with rcu_barrier() as you said.

Maybe.  Note well that I said "potential issue".  When I checked a few
years ago, none of the uses of rcu_barrier() cared about kfree_rcu().
They cared instead about call_rcu() callbacks that accessed code or data
that was going to disappear soon, for example, due to module unload or
filesystem unmount.

So it -might- be that rcu_barrier() can stay as it is, but with changes
as needed to documentation.

It also -might- be, maybe now or maybe some time in the future, that
there will need to be a kfree_rcu_barrier() or some such.  But if so,
let's not create it until it is needed.  For one thing, it is reasonably
likely that something other than a kfree_rcu_barrier() would really
be what was needed.  After all, the main point would be to make sure
that the old memory really was freed before allocating new memory.
But if the system had ample memory, why wait?  In that case you don't
really need to wait for all the old memory to be freed, but rather for
sufficient memory to be available for allocation.

							Thanx, Paul

> Thanks,
> Byungchul
> 
> > But now that we can see letting the list just grow works well, we don't
> > have to consider this one at the moment. Let's consider this method
> > again once we face the problem in the future by any chance.
> > 
> > > We should therefore just let the second list grow.  If experience shows
> > > a need for callbacks to be sent up more quickly, it should be possible
> > > to provide an additional list, so that two lists on a given CPU can both
> > > be waiting for a grace period at the same time.
> > 
> > Or the third and fourth list might be needed in some system. But let's
> > talk about it later too.
> > 
> > > > > I also agree. But this _FORCE thing will still not solve the issue Paul is
> > > > > raising which is doing this loop possibly in irq disabled / hardirq context.
> > > > 
> > > > I added more explanation above. What I suggested is a way to avoid not
> > > > only heavy
> > > > work within the irq-disabled region of a single kfree_rcu() but also
> > > > too many requests
> > > > to be queued into ->head.
> > > 
> > > But let's start simple, please!
> > 
> > Yes. The simpler, the better.
> > 
> > > > > We can't even cond_resched() here. In fact since _FORCE is larger, it will be
> > > > > even worse. Consider a real-time system with a lot of memory, in this case
> > > > > letting ->head grow large is Ok, but looping for long time in IRQ disabled
> > > > > would not be Ok.
> > > > 
> > > > Please check the explanation above.
> > > > 
> > > > > But I could make it something like:
> > > > > 1. Letting ->head grow if ->head_free busy
> > > > > 2. If head_free is busy, then just queue/requeue the monitor to try again.
> > > > 
> > > > This is exactly what Paul said. The problem with this is ->head can grow too
> > > > much. That's why I suggested the above one.
> > > 
> > > It can grow quite large, but how do you know that limiting its size will
> > > really help?  Sure, you have limited the size, but does that really do
> > 
> > To decide the size, we might have to refer to how much pressure on
> > memory and RCU there are at that moment and adjust it on runtime.
> > 
> > > anything for the larger problem of extreme kfree_rcu() rates on the one
> > > hand and a desire for more efficient handling of kfree_rcu() on the other?
> > 
> > Assuming current RCU logic handles extremly high rate well which is
> > anyway true, my answer is *yes*, because batching anyway has pros and
> > cons. One of major cons is there must be inevitable kfree_rcu() requests
> > that not even request to RCU. By allowing only the size of batching, the
> > situation can be mitigated.
> > 
> > I just answered to you. But again, let's talk about it later once we
> > face the problem as you said.
> > 
> > Thanks,
> > Byungchul
> > 
> > > 							Thanx, Paul
> > > 
> > > > > This would even improve performance, but will still risk going out of memory.
> > > > >
> > > > > Thoughts?
> > > > >
> > > > > thanks,
> > > > >
> > > > >  - Joel
> > > > >
> > > > > >
> > > > > > This way, we can avoid both:
> > > > > >
> > > > > > 1. too many requests being queued and
> > > > > > 2. __call_rcu() bunch of requests within a single kfree_rcu().
> > > > > >
> > > > > > Thanks,
> > > > > > Byungchul
> > > > > >
> > > > > > >
> > > > > > > But please feel free to come up with a better solution!
> > > > > > >
> > > > > > > [ . . . ]
> > > > 
> > > > 
> > > > 
> > > > -- 
> > > > Thanks,
> > > > Byungchul
> > > > 

