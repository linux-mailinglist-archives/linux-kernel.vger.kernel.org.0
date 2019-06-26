Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B336456F56
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfFZRJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 13:09:24 -0400
Received: from foss.arm.com ([217.140.110.172]:37470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZRJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:09:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AD402B;
        Wed, 26 Jun 2019 10:09:23 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DAB53F718;
        Wed, 26 Jun 2019 10:09:21 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:09:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20190626170919.GC13572@e107155-lin>
References: <20190603083005.4304-1-peng.fan@nxp.com>
 <20190603083005.4304-3-peng.fan@nxp.com>
 <CABb+yY1wW-arSMQSYjrezXOZ0Ar_shAr78MOyUD3hBxXohWx3g@mail.gmail.com>
 <AM0PR04MB44813A4DE544E53EB7B6F02B88E30@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY38MAZqVOhjyV+GByPvpFcTfKbNG1rJ8YDRd1vi1F4fqg@mail.gmail.com>
 <AM0PR04MB44814D3BD59033ECDDE3094C88E20@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <e49278ba-f734-e019-ab44-53afe558bd85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e49278ba-f734-e019-ab44-53afe558bd85@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:44:06AM -0700, Florian Fainelli wrote:
> On 6/26/19 6:31 AM, Peng Fan wrote:
> >>> The firmware driver might not have func-id, such as SCMI/SCPI.
> >>> So add an optional func-id to let smc mailbox driver could
> >>> use smc SiP func id.
> >>>
> >> There is no end to conforming to protocols. Controller drivers should
> >> be written having no particular client in mind.
> >
> > If the func-id needs be passed from user, then the chan_id suggested
> > by Sudeep should also be passed from user, not in mailbox driver.
> >
> > Jassi, so from your point, arm_smc_send_data just send a0 - a6
> > to firmware, right?
> >
> > Sudeep, Andre, Florian,
> >
> > What's your suggestion? SCMI not support, do you have
> > plan to add smc transport in SCMI?
>
> On the platforms that I work with, we have taken the liberty of
> implementing SCMI in our monitor firmware because the other MCU we use
> for dynamic voltage and frequency scaling did not have enough memory to
> support that and we still had the ability to make that firmware be
> trusted enough we could give it power management responsibilities. I
> would certainly feel more comfortable if the SCMI specification was
> amended to indicate that the Agent could be such a software entity,
> still residing on the same host CPU as the Platform(s), but if not,
> that's fine.
>

That's completely legal and there's nothing in the specification that
prohibits. I understand it's not explicitly not mentioned and I have
been trying to get such things clarified. But since it's main focus
is on the message protocol, the clarity on transport mechanism is very
thin and there's hesitation to add more details under the impression
that it may restrict the usage.

But as I mentioned, I understand what you need there :)

> This has lead us to implement a mailbox driver that uses a proprietary
> SMC call for the P2A path ("tx" channel) and the return being done via
> either that same SMC or through SGI. You can take a look at it in our
> downstream tree here actually:
>
> https://github.com/Broadcom/stblinux-4.9/blob/master/linux/drivers/mailbox/brcmstb-mailbox.c
>

Just curious, I see it's fast call and why do you still depend on
interrupt to indicate completion of the message. Will the return from
SMC not suffice ? Sorry if I am missing something obvious.

--
Regards,
Sudeep
