Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECD48B623
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 13:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfHMLDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 07:03:51 -0400
Received: from foss.arm.com ([217.140.110.172]:34028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfHMLDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:03:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CAEB344;
        Tue, 13 Aug 2019 04:03:49 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E76203F694;
        Tue, 13 Aug 2019 04:03:47 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:03:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v3 2/2] drivers/perf: Add CCPI2 PMU support in ThunderX2
 UNCORE driver.
Message-ID: <20190813110345.GD866@lakrids.cambridge.arm.com>
References: <1563873380-2003-1-git-send-email-gkulkarni@marvell.com>
 <1563873380-2003-3-git-send-email-gkulkarni@marvell.com>
 <20190812120125.GA50712@lakrids.cambridge.arm.com>
 <CAKTKpr7juHd9Bgam28LESadihFadEAevRAhc-7w3PTMYY7HLNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTKpr7juHd9Bgam28LESadihFadEAevRAhc-7w3PTMYY7HLNw@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 04:25:15PM +0530, Ganapatrao Kulkarni wrote:
> Hi Mark,
> 
> On Mon, Aug 12, 2019 at 5:31 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Jul 23, 2019 at 09:16:28AM +0000, Ganapatrao Kulkarni wrote:
> > > CCPI2 is a low-latency high-bandwidth serial interface for connecting
> > > ThunderX2 processors. This patch adds support to capture CCPI2 perf events.
> >
> > It would be worth pointing out in the commit message how the CCPI2
> > counters differ from the others. I realise you have that in the body of
> > patch 1, but it's critical information when reviewing this patch...
> 
> Ok, I will add in next version.
> >
> > >
> > > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@marvell.com>
> > > ---
> > >  drivers/perf/thunderx2_pmu.c | 248 ++++++++++++++++++++++++++++++-----
> > >  1 file changed, 214 insertions(+), 34 deletions(-)
> > >
> > > diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
> > > index 43d76c85da56..a4e1273eafa3 100644
> > > --- a/drivers/perf/thunderx2_pmu.c
> > > +++ b/drivers/perf/thunderx2_pmu.c
> > > @@ -17,22 +17,31 @@
> > >   */
> > >
> > >  #define TX2_PMU_MAX_COUNTERS         4
> >
> > Shouldn't this be 8 now?
> 
> It is kept unchanged to 4(as suggested by Will), which is same for
> both L3 and DMC.
> For CCPI2 this macro is not used.

Hmmm....

I disagree with that suggestion given that this also affects the
active_counters bitmap size (and thus it is not correctly sized as of
this patch), and it doesn't really save us much.

I think it would be better to bump this to 8 and always update the
events array, even though it will be unused for CCPI2. That's less
surprising, needs fewer special-cases, and we can use the hrtimer
function pointer alone to determine if we need to do any hrtimer work.

Thanks,
Mark.
