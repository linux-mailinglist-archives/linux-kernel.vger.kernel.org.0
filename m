Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C997C9272E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 16:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfHSOkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 10:40:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfHSOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:40:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JEbGVY014829;
        Mon, 19 Aug 2019 10:40:21 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufwdf0vy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 10:40:21 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7JEdqUW023028;
        Mon, 19 Aug 2019 14:40:20 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2ue976egf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 14:40:20 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JEeJx251642700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 14:40:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E51ECB2066;
        Mon, 19 Aug 2019 14:40:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8319B2067;
        Mon, 19 Aug 2019 14:40:19 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 14:40:19 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CD40816C17BA; Mon, 19 Aug 2019 07:40:23 -0700 (PDT)
Date:   Mon, 19 Aug 2019 07:40:23 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in
 advance
Message-ID: <20190819144023.GU28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-3-joel@joelfernandes.org>
 <20190816162404.GB10481@google.com>
 <20190816165242.GS28441@linux.ibm.com>
 <20190819125907.GD27088@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819125907.GD27088@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 02:59:08PM +0200, Frederic Weisbecker wrote:
> On Fri, Aug 16, 2019 at 09:52:42AM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 16, 2019 at 12:24:04PM -0400, Joel Fernandes wrote:
> > > On Thu, Aug 15, 2019 at 10:53:11PM -0400, Joel Fernandes (Google) wrote:
> > > > I really cannot explain this patch, but without it, the "else if" block
> > > > just doesn't execute thus causing the tick's dep mask to not be set and
> > > > causes the tick to be turned off.
> > > > 
> > > > I tried various _ONCE() macros but the only thing that works is this
> > > > patch.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  kernel/rcu/tree.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 856d3c9f1955..ac6bcf7614d7 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > > >  {
> > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >  	long incby = 2;
> > > > +	int dnn = rdp->dynticks_nmi_nesting;
> > > 
> > > I believe the accidental sign extension / conversion from long to int was
> > > giving me an illusion since things started working well. Changing the 'int
> > > dnn' to 'long dnn' gives similar behavior as without this patch! At least I
> > > know now. Please feel free to ignore this particular RFC patch while I debug
> > > this more (over the weekend or early next week). The first 2 patches are
> > > good, just ignore this one.
> > 
> > Ah, good point on the type!  So you were ending up with zero due to the
> > low-order 32 bits of DYNTICK_IRQ_NONIDLE being zero, correct?  If so,
> > the "!rdp->dynticks_nmi_nesting" instead needs to be something like
> > "rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE", which sounds like
> > it is actually worse then the earlier comparison against the constant 2.
> > 
> > Sounds like I should revert the -rcu commit 805a16eaefc3 ("rcu: Force
> > nohz_full tick on upon irq enter instead of exit").
> 
> I can't find that patch so all I can say so far is that its title doesn't
> inspire me much. Do you still need that change for some reason?

It is in -rcu branch dev, but has been rebased.  The current version
is 227482fd4f3e ("rcu: Force nohz_full tick on upon irq enter instead
of exit").

It is not yet clear to me whether this is needed or not.  I -think- that
it is not, but without it, it is possible that some chain of events would
result in the rcu_data structure's ->rcu_urgent_qs field being cleared
before the interrupt-exit code could sample it, which might possibly
result in the tick remaining off.

							Thanx, Paul
