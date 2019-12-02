Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 353A010EAC0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 14:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLBNXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 08:23:02 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:42112 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727381AbfLBNXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:23:02 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iblfI-0001C6-C7; Mon, 02 Dec 2019 14:23:00 +0100
To:     yaohongbo <yaohongbo@huawei.com>
Subject: Re: ITS restore/save state when HCC =?UTF-8?Q?=3D=3D=20=30?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Dec 2019 13:22:59 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Yangyingliang <yangyingliang@huawei.com>,
        Linuxarm <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <fd89d78030914d19939a1fc1c6eb5048@huawei.com>
References: <fd89d78030914d19939a1fc1c6eb5048@huawei.com>
Message-ID: <e04e35e0a14f1507ac4a3d56899adcae@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: yaohongbo@huawei.com, guohanjun@huawei.com, yangyingliang@huawei.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yaohongbo,

In the future, please refrain from sending HTML emails, they
don't render very well and force me to reformat your email
by hand.

On 2019-12-02 12:52, yaohongbo wrote:
> Hi, marc.
>
> I met a problem with GIC ITS when I try to power off gic logic in
> suspend.
>
> In hisilicon hip08, the value of GIC_TYPER.HCC is zero, so that
> ITS_FLAGS_SAVE_SUSPEND_STATE will have no chance to be set to 1.

And that's a good thing. HCC indicates that you have collections that
are backed by registers, and not memory. Which means that once the GIC
is powered off, the state is lost.

> It goes well for s4, when I simply remove the condition judgement in
> the code.

What is "s4"? Doing so means you are reprogramming the ITS with 
mappings
that already exist in the tables, and that is UNPRED territory.

<quote>
Behavior is unpredictable if there are interrupts that are mapped to 
the
specified collection and the collection is currently mapped to a 
Redistributor
[...]
</quote>

> --- a/drivers/irqchip/irq-gic-v3-its.c
>
> +++ b/drivers/irqchip/irq-gic-v3-its.c
>
> @@ -3670,8 +3670,8 @@ static int __init its_probe_one(struct resource
> *res,
>
>  ctlr |= GITS_CTLR_ImDe;
>
>  writel_relaxed(ctlr, its->base + GITS_CTLR);
>
> - if (GITS_TYPER_HCC(typer))
>
> - its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
>
> + its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
>
>  err = its_init_domain(handle, its);
>
>  if (err)
>
> @@ -4005,3 +4005,17 @@ int __init its_init(struct fwnode_handle
> *handle, struct rdists *rdists,
>
>  return 0;
>
> }
>
> Do you have any suggestion for this case?

The expectations are that across a GIC power-off, the firmware
will restore the state of the GIC (recondiguring the various
memory tables), and that this is enough for the ITS to be
functional again, having reloaded its state from memory.

Does firmware perform this on your machine? Or are there
implementation-specific issues that require the ITS to be
reprogrammed?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
