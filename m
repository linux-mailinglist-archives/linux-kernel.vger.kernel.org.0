Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5151B500CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 06:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfFXEfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 00:35:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726812AbfFXEfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:35:00 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O4WOQs060473
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 00:34:59 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tag07m2tw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 00:34:59 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 24 Jun 2019 05:34:58 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Jun 2019 05:34:53 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5O4YqoP52494796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 04:34:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C40EFB205F;
        Mon, 24 Jun 2019 04:34:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2072B2064;
        Mon, 24 Jun 2019 04:34:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.233.94])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 24 Jun 2019 04:34:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9B35016C3305; Sun, 23 Jun 2019 21:34:55 -0700 (PDT)
Date:   Sun, 23 Jun 2019 21:34:55 -0700
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
References: <91a9c6f8-7bbf-376d-b1e0-0e2693c84ee8@gmail.com>
 <Pine.LNX.4.44L0.1906231112300.24649-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906231112300.24649-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062404-0072-0000-0000-0000043FDB4C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011318; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01222444; UDB=6.00643227; IPR=6.01003593;
 MB=3.00027438; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-24 04:34:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062404-0073-0000-0000-00004CAFF662
Message-Id: <20190624043455.GB26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2019 at 11:15:06AM -0400, Alan Stern wrote:
> On Sun, 23 Jun 2019, Akira Yokosawa wrote:
> 
> > Hi Paul and Alan,
> > 
> > On 2019/06/22 8:54, Paul E. McKenney wrote:
> > > On Fri, Jun 21, 2019 at 10:25:23AM -0400, Alan Stern wrote:
> > >> On Fri, 21 Jun 2019, Andrea Parri wrote:
> > >>
> > >>> On Thu, Jun 20, 2019 at 11:55:58AM -0400, Alan Stern wrote:
> > >>>> Herbert Xu recently reported a problem concerning RCU and compiler
> > >>>> barriers.  In the course of discussing the problem, he put forth a
> > >>>> litmus test which illustrated a serious defect in the Linux Kernel
> > >>>> Memory Model's data-race-detection code.
> > 
> > I was not involved in the mail thread and wondering what the litmus test
> > looked like. Some searching of the archive has suggested that Alan presented
> > a properly formatted test based on Herbert's idea in [1].
> > 
> > [1]: https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org/
> 
> Yes, that's it.  The test is also available at:
> 
> https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-2.litmus
> 
> Alan
> 
> > If this is the case, adding the link (or message id) in the change
> > log would help people see the circumstances, I suppose.
> > Paul, can you amend the change log?
> > 
> > I ran herd7 on said litmus test at both "lkmm" and "dev" of -rcu and
> > confirmed that this patch fixes the result.
> > 
> > So,
> > 
> > Tested-by: Akira Yokosawa <akiyks@gmail.com>

Thank you both!  I will apply these changes tomorrow morning, Pacific Time.

							Thanx, Paul

