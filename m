Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F174651839
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 18:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbfFXQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 12:18:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728776AbfFXQSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:18:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OGGYMt011421
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:18:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tb16rthyh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:18:15 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 24 Jun 2019 17:18:14 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Jun 2019 17:18:09 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5OGI8O650725204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 16:18:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C41FB205F;
        Mon, 24 Jun 2019 16:18:08 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E9B9B2065;
        Mon, 24 Jun 2019 16:18:08 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jun 2019 16:18:08 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 38C8C16C120D; Mon, 24 Jun 2019 09:18:11 -0700 (PDT)
Date:   Mon, 24 Jun 2019 09:18:11 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools: memory-model: Improve data-race detection
Reply-To: paulmck@linux.ibm.com
References: <20190624152126.GA828@linux.ibm.com>
 <Pine.LNX.4.44L0.1906241137380.1609-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906241137380.1609-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062416-0072-0000-0000-0000044008AC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011321; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01222667; UDB=6.00643367; IPR=6.01003828;
 MB=3.00027447; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-24 16:18:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062416-0073-0000-0000-00004CB02640
Message-Id: <20190624161811.GE26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:39:23AM -0400, Alan Stern wrote:
> On Mon, 24 Jun 2019, Paul E. McKenney wrote:
> 
> > On Sun, Jun 23, 2019 at 09:34:55PM -0700, Paul E. McKenney wrote:
> > > On Sun, Jun 23, 2019 at 11:15:06AM -0400, Alan Stern wrote:
> > > > On Sun, 23 Jun 2019, Akira Yokosawa wrote:
> > > > 
> > > > > Hi Paul and Alan,
> > > > > 
> > > > > On 2019/06/22 8:54, Paul E. McKenney wrote:
> > > > > > On Fri, Jun 21, 2019 at 10:25:23AM -0400, Alan Stern wrote:
> > > > > >> On Fri, 21 Jun 2019, Andrea Parri wrote:
> > > > > >>
> > > > > >>> On Thu, Jun 20, 2019 at 11:55:58AM -0400, Alan Stern wrote:
> > > > > >>>> Herbert Xu recently reported a problem concerning RCU and compiler
> > > > > >>>> barriers.  In the course of discussing the problem, he put forth a
> > > > > >>>> litmus test which illustrated a serious defect in the Linux Kernel
> > > > > >>>> Memory Model's data-race-detection code.
> > > > > 
> > > > > I was not involved in the mail thread and wondering what the litmus test
> > > > > looked like. Some searching of the archive has suggested that Alan presented
> > > > > a properly formatted test based on Herbert's idea in [1].
> > > > > 
> > > > > [1]: https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org/
> > > > 
> > > > Yes, that's it.  The test is also available at:
> > > > 
> > > > https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-2.litmus
> > > > 
> > > > Alan
> > > > 
> > > > > If this is the case, adding the link (or message id) in the change
> > > > > log would help people see the circumstances, I suppose.
> > > > > Paul, can you amend the change log?
> > > > > 
> > > > > I ran herd7 on said litmus test at both "lkmm" and "dev" of -rcu and
> > > > > confirmed that this patch fixes the result.
> > > > > 
> > > > > So,
> > > > > 
> > > > > Tested-by: Akira Yokosawa <akiyks@gmail.com>
> > > 
> > > Thank you both!  I will apply these changes tomorrow morning, Pacific Time.
> > 
> > And done.  Please see below for the updated commit.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit 46a020e9464aff884df56e5fd483134c8801e39f
> > Author: Alan Stern <stern@rowland.harvard.edu>
> > Date:   Thu Jun 20 11:55:58 2019 -0400
> > 
> >     tools/memory-model: Improve data-race detection
> >     
> >     Herbert Xu recently reported a problem concerning RCU and compiler
> >     barriers.  In the course of discussing the problem, he put forth a
> >     litmus test which illustrated a serious defect in the Linux Kernel
> >     Memory Model's data-race-detection code [1].
> >     
> >     The defect was that the LKMM assumed visibility and executes-before
> >     ordering of plain accesses had to be mediated by marked accesses.  In
> >     Herbert's litmus test this wasn't so, and the LKMM claimed the litmus
> >     test was allowed and contained a data race although neither is true.
> >     
> >     In fact, plain accesses can be ordered by fences even in the absence
> >     of marked accesses.  In most cases this doesn't matter, because most
> >     fences only order accesses within a single thread.  But the rcu-fence
> >     relation is different; it can order (and induce visibility between)
> >     accesses in different threads -- events which otherwise might be
> >     concurrent.  This makes it relevant to data-race detection.
> >     
> >     This patch makes two changes to the memory model to incorporate the
> >     new insight:
> >     
> >             If a store is separated by a fence from another access,
> >             the store is necessarily visible to the other access (as
> >             reflected in the ww-vis and wr-vis relations).  Similarly,
> >             if a load is separated by a fence from another access then
> >             the load necessarily executes before the other access (as
> >             reflected in the rw-xbstar relation).
> >     
> >             If a store is separated by a strong fence from a marked access
> >             then it is necessarily visible to any access that executes
> >             after the marked access (as reflected in the ww-vis and wr-vis
> >             relations).
> >     
> >     With these changes, the LKMM gives the desired result for Herbert's
> >     litmus test and other related ones [2].
> >     
> >     [1]     https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org/
> >     
> >     [2]     https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-1.litmus
> >             https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-2.litmus
> >             https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-3.litmus
> >             https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-4.litmus
> 
> Please add:
> 
> https://github.com/paulmckrcu/litmus/blob/master/manual/plain/strong-vis.litmus

Done, and calling this version final.  Thank you all again!

							Thanx, Paul

