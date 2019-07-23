Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5F716AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 13:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbfGWLAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 07:00:03 -0400
Received: from foss.arm.com ([217.140.110.172]:52910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbfGWLAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:00:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6D6F337;
        Tue, 23 Jul 2019 04:00:01 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C820A3F71A;
        Tue, 23 Jul 2019 04:00:00 -0700 (PDT)
Date:   Tue, 23 Jul 2019 11:59:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 11/11] firmware: arm_scmi: Use asynchronous
 CLOCK_RATE_SET when possible
Message-ID: <20190723105958.GB2815@e107155-lin>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
 <20190708154730.16643-12-sudeep.holla@arm.com>
 <20190722212954.8924D21900@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722212954.8924D21900@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 02:29:53PM -0700, Stephen Boyd wrote:
> Quoting Sudeep Holla (2019-07-08 08:47:30)
> > CLOCK_PROTOCOL_ATTRIBUTES provides attributes to indicate the maximum
> > number of pending asynchronous clock rate changes supported by the
> > platform. If it's non-zero, then we should be able to use asynchronous
> > clock rate set for any clocks until the maximum limit is reached.
> >
> > Keeping the current count of pending asynchronous clock set rate
> > requests, we can decide if we can you asynchronous request for the
>
> This last part of the sentence doesn't read properly. Please rewrite.
>

Will fix.

> > incoming/new request.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/clock.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> > index dd215bd11a58..70044b7c812e 100644
> > --- a/drivers/firmware/arm_scmi/clock.c
> > +++ b/drivers/firmware/arm_scmi/clock.c
> > @@ -221,21 +222,35 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
> >                                u64 rate)
> >  {
> >         int ret;
> > +       u32 flags = 0;
> >         struct scmi_xfer *t;
> >         struct scmi_clock_set_rate *cfg;
> > +       struct clock_info *ci = handle->clk_priv;
> >
> >         ret = scmi_xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
> >                                  sizeof(*cfg), 0, &t);
> >         if (ret)
> >                 return ret;
> >
> > +       if (ci->max_async_req) {
> > +               if (atomic_inc_return(&ci->cur_async_req) < ci->max_async_req)
> > +                       flags |= CLOCK_SET_ASYNC;
> > +               else
> > +                       atomic_dec(&ci->cur_async_req);
>
> Can this be combined with the atomic_dec() below and done after either
> transfer?
>

Yes but cleaner.

> > +       }
> > +
> >         cfg = t->tx.buf;
> > -       cfg->flags = cpu_to_le32(0);
> > +       cfg->flags = cpu_to_le32(flags);
> >         cfg->id = cpu_to_le32(clk_id);
> >         cfg->value_low = cpu_to_le32(rate & 0xffffffff);
> >         cfg->value_high = cpu_to_le32(rate >> 32);
> >
> > -       ret = scmi_do_xfer(handle, t);
> > +       if (flags & CLOCK_SET_ASYNC) {
> > +               ret = scmi_do_xfer_with_response(handle, t);
> > +               atomic_dec(&ci->cur_async_req);
> > +       } else {
> > +               ret = scmi_do_xfer(handle, t);
> > +       }
>
> I mean putting the atomic_dec() here.
>

Understood and done locally, will post as v2.

--
Regards,
Sudeep
