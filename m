Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C750257EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 11:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfF0JJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 05:09:09 -0400
Received: from foss.arm.com ([217.140.110.172]:49694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0JJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:09:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0B772B;
        Thu, 27 Jun 2019 02:09:07 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06B373F718;
        Thu, 27 Jun 2019 02:09:05 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:09:03 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ", Sascha Hauer" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andre Przywara <andre.przywara@arm.com>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V2 2/2] mailbox: introduce ARM SMC based mailbox
Message-ID: <20190627090903.GD13572@e107155-lin>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-3-peng.fan@nxp.com>
 <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
 <AM0PR04MB44813A4DE544E53EB7B6F02B88E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY38MAZqVOhjyV+GByPvpFcTfKbNG1rJ8YDRd1vi1F4fqg@mail.gmail.com>
 <AM0PR04MB44814D3BD59033ECDDE3094C88E20@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <e49278ba-f734-e019-ab44-53afe558bd85@gmail.com>
 <CABb+yY2B_bGqZhd3HRm2qOwGNXG8UYvRo0_uBmwGbx_1gA-vfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY2B_bGqZhd3HRm2qOwGNXG8UYvRo0_uBmwGbx_1gA-vfA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 01:27:41PM -0500, Jassi Brar wrote:
> On Wed, Jun 26, 2019 at 11:44 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 6/26/19 6:31 AM, Peng Fan wrote:
> > >>> The firmware driver might not have func-id, such as SCMI/SCPI.
> > >>> So add an optional func-id to let smc mailbox driver could
> > >>> use smc SiP func id.
> > >>>
> > >> There is no end to conforming to protocols. Controller drivers should
> > >> be written having no particular client in mind.
> > >
> > > If the func-id needs be passed from user, then the chan_id suggested
> > > by Sudeep should also be passed from user, not in mailbox driver.
> > >
> > > Jassi, so from your point, arm_smc_send_data just send a0 - a6
> > > to firmware, right?
> > >
> > > Sudeep, Andre, Florian,
> > >
> > > What's your suggestion? SCMI not support, do you have
> > > plan to add smc transport in SCMI?
> >
> > On the platforms that I work with, we have taken the liberty of
> > implementing SCMI in our monitor firmware because the other MCU we use
> > for dynamic voltage and frequency scaling did not have enough memory to
> > support that and we still had the ability to make that firmware be
> > trusted enough we could give it power management responsibilities. I
> > would certainly feel more comfortable if the SCMI specification was
> > amended to indicate that the Agent could be such a software entity,
> > still residing on the same host CPU as the Platform(s), but if not,
> > that's fine.
> >
> > This has lead us to implement a mailbox driver that uses a proprietary
> > SMC call for the P2A path ("tx" channel) and the return being done via
> > either that same SMC or through SGI. You can take a look at it in our
> > downstream tree here actually:
> >
> > https://github.com/Broadcom/stblinux-4.9/blob/master/linux/drivers/mailbox/brcmstb-mailbox.c
> >
> > If we can get rid of our own driver and uses a standard SMC based
> > mailbox driver that supports our use case that involves interrupts (we
> > can always change their kind without our firmware/boot loader since FDT
> > is generated from that component), that would be great.
> >
> static irqreturn_t brcm_isr(void)
> {
>          mbox_chan_received_data(&chans[0], NULL);
>          return IRQ_HANDLED;
> }
> 
> Sorry, I fail to understand why the irq can't be moved inside the
> client driver itself? There can't be more cost to it and there
> definitely is no functionality lost.

What if there are multiple clients ?
And I assume you are referring to case like this where IRQ is not tied
to the mailbox IP.

--
Regards,
Sudeep

