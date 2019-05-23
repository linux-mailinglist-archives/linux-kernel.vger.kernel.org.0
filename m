Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F121F27F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfEWOE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 10:04:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45592 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730323AbfEWOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:04:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4NE2lp7078599
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 10:04:27 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2snub2587m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 10:04:11 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 23 May 2019 15:04:00 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 May 2019 15:03:56 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4NE3tF025428200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 14:03:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D9A5B205F;
        Thu, 23 May 2019 14:03:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EDE3B2070;
        Thu, 23 May 2019 14:03:55 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 May 2019 14:03:55 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 418F516C0FB0; Thu, 23 May 2019 07:03:56 -0700 (PDT)
Date:   Thu, 23 May 2019 07:03:56 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        knut omang <knut.omang@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Linux Testing Microconference at LPC
Reply-To: paulmck@linux.ibm.com
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <20190423102250.GA56999@lakrids.cambridge.arm.com>
 <20190512004008.GA6062@andrea>
 <CACT4Y+aj8i0VNad91F-QkHNsXYXUFrYF+j=wnG-USzfQfoD55A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aj8i0VNad91F-QkHNsXYXUFrYF+j=wnG-USzfQfoD55A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19052314-0052-0000-0000-000003C5FE0C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011149; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01207468; UDB=6.00634135; IPR=6.00988448;
 MB=3.00027018; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-23 14:04:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052314-0053-0000-0000-00006103E0A6
Message-Id: <20190523140356.GN28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 05:52:17PM +0200, Dmitry Vyukov wrote:
> On Sun, May 12, 2019 at 2:40 AM Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> >
> > On Tue, Apr 23, 2019 at 11:22:50AM +0100, Mark Rutland wrote:
> > > On Thu, Apr 11, 2019 at 10:37:51AM -0700, Dhaval Giani wrote:
> > > > Hi Folks,
> > > >
> > > > This is a call for participation for the Linux Testing microconference
> > > > at LPC this year.
> > > >
> > > > For those who were at LPC last year, as the closing panel mentioned,
> > > > testing is probably the next big push needed to improve quality. From
> > > > getting more selftests in, to regression testing to ensure we don't
> > > > break realtime as more of PREEMPT_RT comes in, to more stable distros,
> > > > we need more testing around the kernel.
> > > >
> > > > We have talked about different efforts around testing, such as fuzzing
> > > > (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> > > > testing, test frameworks such as ktests, smatch to find bugs in the
> > > > past. We want to push this discussion further this year and are
> > > > interested in hearing from you what you want to talk about, and where
> > > > kernel testing needs to go next.
> > >
> > > I'd be interested to discuss what we could do with annotations and
> > > compiler instrumentation to make the kernel more amenable to static and
> > > dynamic analysis (and to some extent, documenting implicit
> > > requirements).
> > >
> > > One idea that I'd like to explore in the context of RT is to annotate
> > > function signatures with their required IRQ/preempt context, such that
> > > we could dynamically check whether those requirements were violated
> > > (even if it didn't happen to cause a problem at that point in time), and
> > > static analysis would be able to find some obviously broken usage. I had
> > > some rough ideas of how to do the dynamic part atop/within ftrace. Maybe
> > > there are similar problems elsewhere.
> > >
> > > I know that some clang folk were interested in similar stuff. IIRC Nick
> > > Desaulniers was interested in whether clang's thread safety analysis
> > > tooling could be applied to the kernel (e.g. based on lockdep
> > > annotations).
> >
> > FWIW, I'd also be interested in discussing these developments.
> >
> > There have been several activities/projects related to such "tooling"
> > (thread safety analysis) recently:  I could point out the (brand new)
> > Google Summer of Code "Applying Clang Thread Safety Analyser to Linux
> > Kernel" project [1] and (for the "dynamic analysis" side) the efforts
> > to revive the Kernel Thread sanitizer [2].  I should also mention the
> > efforts to add (support for) "unmarked" accesses and to formalize the
> > notion of "data race" in the memory consistency model [3].
> >
> > So, again, I'd welcome a discussion on these works/ideas.
> >
> > Thanks,
> >   Andrea
> 
> I would be interested in discussing all of this too: thread safety
> annotations, ktsan, unmarked accesses.

Sounds like a great discussion!  Might this fit into Sasha Levin's
and Dhaval Giani's proposed Testing & Fuzzing MC?

							Thanx, Paul

