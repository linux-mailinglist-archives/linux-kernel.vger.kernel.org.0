Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A183114154
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 14:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfLENSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 08:18:47 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:54941 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729099AbfLENSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:18:46 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1icr1n-0006Zm-3t; Thu, 05 Dec 2019 14:18:43 +0100
To:     Gaurav Kohli <gkohli@codeaurora.org>
Subject: Re: [PATCH v0] irqchip/gic-v3: Avoid check of lpi configuration for  non existent cpu
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 05 Dec 2019 13:18:43 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
In-Reply-To: <209f30c6-c03a-daeb-1f01-e03c489f41d8@codeaurora.org>
References: <1575543357-31892-1-git-send-email-gkohli@codeaurora.org>
 <60f61282c1b1e512ca6ce638b6dfca09@www.loen.fr>
 <209f30c6-c03a-daeb-1f01-e03c489f41d8@codeaurora.org>
Message-ID: <18011d088d5202339048ac5e3c224bb5@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: gkohli@codeaurora.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-05 13:01, Gaurav Kohli wrote:
> On 12/5/2019 6:17 PM, Marc Zyngier wrote:
>> Hi Gaurav,
>> On 2019-12-05 10:55, Gaurav Kohli wrote:
>>> As per GIC specification, we can configure gic for more no of cpus
>>> then the available cpus in the soc, But this can cause mem abort
>>> while iterating lpi region for non existent cpu as we don't map
>> Which LPI region? We're talking about RDs, right... Or does LPI mean
>> something other than GIC LPIs for you?
>>
>
> Yes RDs only.
>>> redistrubutor region for non-existent cpu.
>>>
>>> To avoid this issue, put one more check of valid mpidr.
>> Sorry, but I'm not sure I grasp your problem. Let me try and 
>> rephrase it:
>> - Your GIC is configured for (let's say) 8 CPUs, and your SoC has 
>> only 4.
> Yes, suppose gic is configured for 8 cpus but soc has only 4 cpus.
> Then in this case gic_iterate will iterate till it get TYPER_LAST.

And that's what is expected from the architecture.

>
> But as gic is configured for 8, So last bit sets in eight
> redistributor regions only.
>> - As part of the probing, the driver iterates on the RD regions and 
>> explodes
>>    because something isn't mapped?
>> That'd be a grave bug, but I believe the issue is somewhere else.
>
> There are 4 cpus present, that's why we have mapped 4 redistributor
> only, but during probe below function keeps iterating and give mem
> abort for 5th cpu.
>
> static void gic_update_vlpi_properties(void)
> {
>         gic_iterate_rdists(__gic_update_vlpi_properties);
>
> }
>
> We can solve this problem by mapping all eight redistributor in dt,
> but ideally code should also able to handle this and we can avoid
> mappin?

The whole point of DT is to describe the HW, all the HW, nothing but
the HW. This is what is expected by both the architecture and Linux.

So you have the solution already. Don't lie to the kernel, and 
everything
will be fine.

         M.
-- 
Jazz is not dead. It just smells funny...
