Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFA5618EBEB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 20:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCVTgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 15:36:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgCVTf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 15:35:59 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6172070A;
        Sun, 22 Mar 2020 19:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584905759;
        bh=iL1sjTLvw1JVu+N++3CO4C0/tIF4N6blP9U1IKYS5gQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kAXEx17aS3TrizisnrRafSOkN+ibt5U0Y7672k6/Yrcv7ai6MHzcqZgalHr4qyo/W
         A215K6TVqFPDF3E6GPENUbZiJDMKPTfFhFXiwNllNT5vdOKjOmD9nBjxHQmuWx7aLI
         wpzmhLnSjrqktPegHm6AwDxvzGfDny/5xovTe7Yk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jG6O5-00Eknk-0F; Sun, 22 Mar 2020 19:35:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 22 Mar 2020 19:35:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>, tglx@linutronix.de,
        jason@lakedaemon.net, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Subject: Re: [PATCH] irqchip: irq-imx-gpcv2: Remove unnecessary blank lines
In-Reply-To: <CAEnQRZCcmaU91Ep5kVesaGPsrvujq5mznk2SZccmZG9rbSCG0w@mail.gmail.com>
References: <1584421001-2647-1-git-send-email-Anson.Huang@nxp.com>
 <86mu89zqce.wl-maz@kernel.org>
 <CAEnQRZCcmaU91Ep5kVesaGPsrvujq5mznk2SZccmZG9rbSCG0w@mail.gmail.com>
Message-ID: <a690ecc9169f0594e22b4eae0a056d89@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: daniel.baluta@gmail.com, Anson.Huang@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On 2020-03-22 19:08, Daniel Baluta wrote:
> On Sat, Mar 21, 2020 at 5:22 PM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On Tue, 17 Mar 2020 04:56:41 +0000,
>> Anson Huang <Anson.Huang@nxp.com> wrote:
>> >
>> > Remove unnecessary blank lines for cleanup.
>> >
>> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> > ---
>> >  drivers/irqchip/irq-imx-gpcv2.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
>> > index 4f74c15..4f11b9b 100644
>> > --- a/drivers/irqchip/irq-imx-gpcv2.c
>> > +++ b/drivers/irqchip/irq-imx-gpcv2.c
>> > @@ -17,7 +17,6 @@
>> >  #define GPC_IMR1_CORE2               0x1c0
>> >  #define GPC_IMR1_CORE3               0x1d0
>> >
>> > -
>> >  struct gpcv2_irqchip_data {
>> >       struct raw_spinlock     rlock;
>> >       void __iomem            *gpc_base;
>> > @@ -287,6 +286,5 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
>> >       of_node_clear_flag(node, OF_POPULATED);
>> >       return 0;
>> >  }
>> > -
>> >  IRQCHIP_DECLARE(imx_gpcv2_imx7d, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
>> >  IRQCHIP_DECLARE(imx_gpcv2_imx8mq, "fsl,imx8mq-gpc", imx_gpcv2_irqchip_init);
>> 
>> I honestly don't think this deserves a patch. Next time you work on
>> this driver, add the cleanups to it. But on its own, it's only churn.
> 
> While you are technically right, it's only churn I think we need this
> for code consistency and cleanup.

Get real. We really don't. Two blank lines do not lead to a
misinterpretation of the code, do not get in the way of normal
maintenance, do not lead to *any* practical issue.

What's next? Cc stable?

> Even if we fix this when we work on the driver we still need
> to make the cleanup in a separate patch.

Neither. As well as removing blank lines, you could also remove the
dead code in this driver. That would be a good cleanup. You could
also have a look at what feels like a potential deadlock in the
mask/unmask callbacks. That'd be a good thing to do too.

Certainly more useful than just dropping two blank lines.

         M.
-- 
Jazz is not dead. It just smells funny...
