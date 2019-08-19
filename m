Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF564926C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfHSOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 10:33:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfHSOdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:33:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JEWjTX061676
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:33:15 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ufvxda40y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:33:14 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 19 Aug 2019 15:33:14 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Aug 2019 15:33:11 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JEXAFu49086838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 14:33:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D03BB2066;
        Mon, 19 Aug 2019 14:33:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 707A2B2065;
        Mon, 19 Aug 2019 14:33:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 14:33:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 75F5416C17BA; Mon, 19 Aug 2019 07:33:14 -0700 (PDT)
Date:   Mon, 19 Aug 2019 07:33:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Reply-To: paulmck@linux.ibm.com
References: <20190818221210.GP28441@linux.ibm.com>
 <20190818223230.GA143857@google.com>
 <20190818223511.GB143857@google.com>
 <20190818233135.GQ28441@linux.ibm.com>
 <20190818233839.GA160903@google.com>
 <20190819012153.GR28441@linux.ibm.com>
 <20190819014143.GB160903@google.com>
 <20190819014623.GC160903@google.com>
 <20190819022927.GS28441@linux.ibm.com>
 <20190819125757.GA6946@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819125757.GA6946@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081914-0052-0000-0000-000003EC4E72
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011618; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249099; UDB=6.00659367; IPR=6.01030626;
 MB=3.00028231; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 14:33:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081914-0053-0000-0000-000062262091
Message-Id: <20190819143314.GT28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 05:57:57AM -0700, Paul E. McKenney wrote:
> On Sun, Aug 18, 2019 at 07:29:27PM -0700, Paul E. McKenney wrote:
> > On Sun, Aug 18, 2019 at 09:46:23PM -0400, Joel Fernandes wrote:
> > > On Sun, Aug 18, 2019 at 09:41:43PM -0400, Joel Fernandes wrote:
> > > > On Sun, Aug 18, 2019 at 06:21:53PM -0700, Paul E. McKenney wrote:
> > > [snip]
> > > > > > > Also, your commit log's point #2 is "in_irq() implies in_interrupt()
> > > > > > > which implies raising softirq will not do any wake ups."  This mention
> > > > > > > of softirq seems a bit odd, given that we are going to wake up a rcuc
> > > > > > > kthread.  Of course, this did nothing to quell my suspicions.  ;-)
> > > > > > 
> > > > > > Yes, I should delete this #2 from the changelog since it is not very relevant
> > > > > > (I feel now). My point with #2 was that even if were to raise a softirq
> > > > > > (which we are not), a scheduler wakeup of ksoftirqd is impossible in this
> > > > > > path anyway since in_irq() implies in_interrupt().
> > > > > 
> > > > > Please!  Could you also add a first-principles explanation of why
> > > > > the added condition is immune from scheduler deadlocks?
> > > > 
> > > > Sure I can add an example in the change log, however I was thinking of this
> > > > example which you mentioned:
> > > > https://lore.kernel.org/lkml/20190627173831.GW26519@linux.ibm.com/
> > > > 
> > > > 	previous_reader()
> > > > 	{
> > > > 		rcu_read_lock();
> > > > 		do_something(); /* Preemption happened here. */
> > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > 		do_something_else();
> > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > 		do_some_other_thing();
> > > > 		local_irq_enable();
> > > > 	}
> > > > 
> > > > 	current_reader() /* QS from previous_reader() is still deferred. */
> > > > 	{
> > > > 		local_irq_disable();  /* Might be the scheduler. */
> > > > 		do_whatever();
> > > > 		rcu_read_lock();
> > > > 		do_whatever_else();
> > > > 		rcu_read_unlock();  /* Must still defer reporting QS. */
> > > > 		do_whatever_comes_to_mind();
> > > > 		local_irq_enable();
> > > > 	}
> > > > 
> > > > One modification of the example could be, previous_reader() could also do:
> > > > 	previous_reader()
> > > > 	{
> > > > 		rcu_read_lock();
> > > > 		do_something_that_takes_really_long(); /* causes need_qs in
> > > > 							  the unlock_special_union to be set */
> > > > 		local_irq_disable(); /* Cannot be the scheduler! */
> > > > 		do_something_else();
> > > > 		rcu_read_unlock();  /* Must defer QS, task still queued. */
> > > > 		do_some_other_thing();
> > > > 		local_irq_enable();
> > > > 	}
> > > 
> > > The point you were making in that thread being, current_reader() ->
> > > rcu_read_unlock() -> rcu_read_unlock_special() would not do any wakeups
> > > because previous_reader() sets the deferred_qs bit.
> > > 
> > > Anyway, I will add all of this into the changelog.
> > 
> > Examples are good, but what makes it so that there are no examples of
> > its being unsafe?
> > 
> > And a few questions along the way, some quick quiz, some more serious.
> > Would it be safe if it checked in_interrupt() instead of in_irq()?
> > If not, should the in_interrupt() in the "if" condition preceding the
> > added "else if" be changed to in_irq()?  Would it make sense to add an
> > "|| !irqs_were_disabled" do your new "else if" condition?  Would the
> > body of the "else if" actually be executed in current mainline?
> > 
> > In an attempt to be at least a little constructive, I am doing some
> > testing of this patch overnight, along with a WARN_ON_ONCE() to see if
> > that invoke_rcu_core() is ever reached.
> 
> And that WARN_ON_ONCE() never triggered in two-hour rcutorture runs of
> TREE01, TREE02, TREE03, and TREE09.  (These are the TREE variants in
> CFLIST that have CONFIG_PREEMPT=y.)
> 
> This of course raises other questions.  But first, do you see that code
> executing in your testing?

Never mind!  Idiot here forgot the "--bootargs rcutree.use_softirq"...

							Thanx, Paul

