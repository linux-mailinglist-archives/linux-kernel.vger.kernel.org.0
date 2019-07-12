Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA69A66F78
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 15:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfGLNDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 09:03:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727444AbfGLNDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:03:09 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CD2VMV108975;
        Fri, 12 Jul 2019 09:02:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpqvyqfmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 09:02:46 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6CD2gZS111031;
        Fri, 12 Jul 2019 09:02:45 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpqvyqfkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 09:02:45 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6CD0eJG021591;
        Fri, 12 Jul 2019 13:02:44 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 2tjk973qn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 13:02:44 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CD2hE250659670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 13:02:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31CFAB2066;
        Fri, 12 Jul 2019 13:02:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 193D6B2064;
        Fri, 12 Jul 2019 13:02:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.195.235])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 13:02:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CFA5B16C191E; Fri, 12 Jul 2019 06:02:42 -0700 (PDT)
Date:   Fri, 12 Jul 2019 06:02:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Byungchul Park <byungchul.park@lge.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Message-ID: <20190712130242.GM26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190709055815.GA19459@X58A-UD3R>
 <20190709124102.GR26519@linux.ibm.com>
 <20190710012025.GA20711@X58A-UD3R>
 <20190711123052.GI26519@linux.ibm.com>
 <20190711130849.GA212044@google.com>
 <20190711150215.GK26519@linux.ibm.com>
 <20190711164818.GA260447@google.com>
 <20190711195839.GA163275@google.com>
 <20190712063240.GD7702@X58A-UD3R>
 <20190712125116.GB92297@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712125116.GB92297@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 08:51:16AM -0400, Joel Fernandes wrote:
> On Fri, Jul 12, 2019 at 03:32:40PM +0900, Byungchul Park wrote:
> > On Thu, Jul 11, 2019 at 03:58:39PM -0400, Joel Fernandes wrote:
> > > Hmm, speaking of grace period durations, it seems to me the maximum grace
> > > period ever is recorded in rcu_state.gp_max. However it is not read from
> > > anywhere.
> > > 
> > > Any idea why it was added but not used?
> > > 
> > > I am interested in dumping this value just for fun, and seeing what I get.
> > > 
> > > I wonder also it is useful to dump it in rcutorture/rcuperf to find any
> > > issues, or even expose it in sys/proc fs to see what worst case grace periods
> > > look like.
> > 
> > Hi,
> > 
> > 	commit ae91aa0adb14dc33114d566feca2f7cb7a96b8b7
> > 	rcu: Remove debugfs tracing
> > 
> > removed all debugfs tracing, gp_max also included.
> > 
> > And you sounds great. And even looks not that hard to add it like,
> > 
> > :)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index ad9dc86..86095ff 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1658,8 +1658,10 @@ static void rcu_gp_cleanup(void)
> >  	raw_spin_lock_irq_rcu_node(rnp);
> >  	rcu_state.gp_end = jiffies;
> >  	gp_duration = rcu_state.gp_end - rcu_state.gp_start;
> > -	if (gp_duration > rcu_state.gp_max)
> > +	if (gp_duration > rcu_state.gp_max) {
> >  		rcu_state.gp_max = gp_duration;
> > +		trace_rcu_grace_period(something something);
> > +	}
> 
> Yes, that makes sense. But I think it is much better off as a readable value
> from a virtual fs. The drawback of tracing for this sort of thing are:
>  - Tracing will only catch it if tracing is on
>  - Tracing data can be lost if too many events, then no one has a clue what
>    the max gp time is.
>  - The data is already available in rcu_state::gp_max so copying it into the
>    trace buffer seems a bit pointless IMHO
>  - It is a lot easier on ones eyes to process a single counter than process
>    heaps of traces.
> 
> I think a minimal set of RCU counters exposed to /proc or /sys should not
> hurt and could do more good than not. The scheduler already does this for
> scheduler statistics. I have seen Peter complain a lot about new tracepoints
> but not much (or never) about new statistics.
> 
> Tracing has its strengths but may not apply well here IMO. I think a counter
> like this could be useful for tuning of things like the jiffies_*_sched_qs,
> the stall timeouts and also any other RCU knobs. What do you think?

Is this one of those cases where eBPF is the answer, regardless of
the question?  ;-)

							Thanx, Paul
