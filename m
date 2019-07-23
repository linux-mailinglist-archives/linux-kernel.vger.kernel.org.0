Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469CA719AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfGWNrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 09:47:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390366AbfGWNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:47:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NDhfuQ122867
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:47:21 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tx25fks1m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:47:20 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Jul 2019 14:47:19 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 14:47:15 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NDlFLl51380614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 13:47:15 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBF5EB206B;
        Tue, 23 Jul 2019 13:47:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B784DB2067;
        Tue, 23 Jul 2019 13:47:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.166])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 13:47:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A223C16C2E3A; Tue, 23 Jul 2019 06:47:17 -0700 (PDT)
Date:   Tue, 23 Jul 2019 06:47:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Make jiffies_till_sched_qs writable
Reply-To: paulmck@linux.ibm.com
References: <20190713154257.GE133650@google.com>
 <20190713174111.GG26519@linux.ibm.com>
 <CAEXW_YTcL-nOfJXkChGhvQtqqfSLpAYr327PLu1SmGEEADCevw@mail.gmail.com>
 <20190719003942.GA28226@X58A-UD3R>
 <CAEXW_YQij-N2-NFjUQtsmYxVLtWxcQk_Kb16fGBzzPAZtWg+sg@mail.gmail.com>
 <20190719074329.GY14271@linux.ibm.com>
 <CANrsvRM7ehvqcPtKMV7RyRCiXwe_R_TsLZiNtxBPY_qnSg2LNQ@mail.gmail.com>
 <20190719195728.GF14271@linux.ibm.com>
 <CAEXW_YQADrPRtJW7yJZyROH1_d2yOA7_1HVgm50wxpOC80+=Wg@mail.gmail.com>
 <20190723110521.GA28883@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723110521.GA28883@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19072313-0060-0000-0000-000003646153
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011481; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01236309; UDB=6.00651599; IPR=6.01017666;
 MB=3.00027852; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-23 13:47:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072313-0061-0000-0000-00004A42B60A
Message-Id: <20190723134717.GT14271@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:05:21PM +0900, Byungchul Park wrote:
> On Fri, Jul 19, 2019 at 04:33:56PM -0400, Joel Fernandes wrote:
> > On Fri, Jul 19, 2019 at 3:57 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > >
> > > On Fri, Jul 19, 2019 at 06:57:58PM +0900, Byungchul Park wrote:
> > > > On Fri, Jul 19, 2019 at 4:43 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > > >
> > > > > On Thu, Jul 18, 2019 at 08:52:52PM -0400, Joel Fernandes wrote:
> > > > > > On Thu, Jul 18, 2019 at 8:40 PM Byungchul Park <byungchul.park@lge.com> wrote:
> > > > > > [snip]
> > > > > > > > - There is a bug in the CPU stopper machinery itself preventing it
> > > > > > > > from scheduling the stopper on Y. Even though Y is not holding up the
> > > > > > > > grace period.
> > > > > > >
> > > > > > > Or any thread on Y is busy with preemption/irq disabled preventing the
> > > > > > > stopper from being scheduled on Y.
> > > > > > >
> > > > > > > Or something is stuck in ttwu() to wake up the stopper on Y due to any
> > > > > > > scheduler locks such as pi_lock or rq->lock or something.
> > > > > > >
> > > > > > > I think what you mentioned can happen easily.
> > > > > > >
> > > > > > > Basically we would need information about preemption/irq disabled
> > > > > > > sections on Y and scheduler's current activity on every cpu at that time.
> > > > > >
> > > > > > I think all that's needed is an NMI backtrace on all CPUs. An ARM we
> > > > > > don't have NMI solutions and only IPI or interrupt based backtrace
> > > > > > works which should at least catch and the preempt disable and softirq
> > > > > > disable cases.
> > > > >
> > > > > True, though people with systems having hundreds of CPUs might not
> > > > > thank you for forcing an NMI backtrace on each of them.  Is it possible
> > > > > to NMI only the ones that are holding up the CPU stopper?
> > > >
> > > > What a good idea! I think it's possible!
> > > >
> > > > But we need to think about the case NMI doesn't work when the
> > > > holding-up was caused by IRQ disabled.
> > > >
> > > > Though it's just around the corner of weekend, I will keep thinking
> > > > on it during weekend!
> > >
> > > Very good!
> > 
> > Me too will think more about it ;-) Agreed with point about 100s of
> > CPUs usecase,
> > 
> > Thanks, have a great weekend,
> 
> BTW, if there's any long code section with irq/preemption disabled, then
> the problem would be not only about RCU stall. And we can also use
> latency tracer or something to detect the bad situation.
> 
> So in this case, sending ipi/nmi to the CPUs where the stoppers cannot
> to be scheduled does not give us additional meaningful information.
> 
> I think Paul started to think about this to solve some real problem. I
> seriously love to help RCU and it's my pleasure to dig deep into kind of
> RCU stuff, but I've yet to define exactly what problem is. Sorry.
> 
> Could you share the real issue? I think you don't have to reproduce it.
> Just sharing the issue that you got inspired from is enough. Then I
> might be able to develop 'how' with Joel! :-) It's our pleasure!

It is unfortunately quite intermittent.  I was hoping to find a way
to make it happen more often.  Part of the underlying problem appears
to be lock contention, in that reducing contention made it even more
intermittent.  Which is good in general, but not for exercising the
CPU-stopper issue.

But perhaps your hardware will make this happen more readily than does
mine.  The repeat-by is simple, namely run TREE04 on branch "dev" on an
eight-CPU system.  It appear that the number of CPUs used by the test
should match the number available on the system that you are running on,
though perhaps affinity could allow mismatches.

So why not try it and see what happens?

							Thanx, Paul

