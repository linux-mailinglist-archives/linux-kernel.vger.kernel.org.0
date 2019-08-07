Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C709D84EDC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfHGOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Aug 2019 10:37:42 -0400
Received: from foss.arm.com ([217.140.110.172]:49550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfHGOhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:37:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F7CF1570;
        Wed,  7 Aug 2019 07:37:41 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D6603F706;
        Wed,  7 Aug 2019 07:37:40 -0700 (PDT)
Date:   Wed, 7 Aug 2019 15:37:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: Use {get,put}_unaligned_le32
 accessors
Message-ID: <20190807143738.GB27278@e107155-lin>
References: <20190807130038.26878-1-sudeep.holla@arm.com>
 <1565184971.5048.8.camel@pengutronix.de>
 <20190807135757.GA27278@e107155-lin>
 <4e6de98c-833b-a80b-acef-6e88391e80f2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e6de98c-833b-a80b-acef-6e88391e80f2@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 03:07:39PM +0100, Robin Murphy wrote:
> On 07/08/2019 14:57, Sudeep Holla wrote:
> > On Wed, Aug 07, 2019 at 03:36:11PM +0200, Philipp Zabel wrote:
> > > Hi Sudeep,
> > > 
> > > On Wed, 2019-08-07 at 14:00 +0100, Sudeep Holla wrote:
> > > > Instead of type-casting the {tx,rx}.buf all over the place while
> > > > accessing them to read/write __le32 from/to the firmware, let's use
> > > > the nice existing {get,put}_unaligned_le32 accessors to hide all the
> > > > type cast ugliness.
> > > > 
> > > > Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >   drivers/firmware/arm_scmi/base.c    |  2 +-
> > > >   drivers/firmware/arm_scmi/clock.c   | 10 ++++------
> > > >   drivers/firmware/arm_scmi/common.h  |  2 ++
> > > >   drivers/firmware/arm_scmi/perf.c    |  8 ++++----
> > > >   drivers/firmware/arm_scmi/power.c   |  6 +++---
> > > >   drivers/firmware/arm_scmi/reset.c   |  2 +-
> > > >   drivers/firmware/arm_scmi/sensors.c | 12 +++++-------
> > > >   7 files changed, 20 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> > > > index 204390297f4b..f804e8af6521 100644
> > > > --- a/drivers/firmware/arm_scmi/base.c
> > > > +++ b/drivers/firmware/arm_scmi/base.c
> > > [...]
> > > > @@ -204,14 +204,12 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
> > > >   	if (ret)
> > > >   		return ret;
> > > > 
> > > > -	*(__le32 *)t->tx.buf = cpu_to_le32(clk_id);
> > > > +	put_unaligned_le32(clk_id, t->tx.buf);
> > > > 
> > > >   	ret = scmi_do_xfer(handle, t);
> > > >   	if (!ret) {
> > > > -		__le32 *pval = t->rx.buf;
> > > > -
> > > > -		*value = le32_to_cpu(*pval);
> > > > -		*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
> > > > +		*value = get_unaligned_le32(t->rx.buf);
> > > > +		*value |= (u64)get_unaligned_le32(t->rx.buf + 1) << 32;
> > > 
> > > Isn't t->rx.buf a void pointer? If I am not mistaken, you'd either have
> > > to keep the pval local variables, or cast to (__le32 *) before doing
> > > pointer arithmetic.
> > > 
> > 
> > Ah right, that's the reason I added it at the first place. I will fix that.
> 
> Couldn't you just use get_unaligned_le64() here anyway?

Indeed, that's what I found as I wanted to avoid pval, testing now.

--
Regards,
Sudeep
