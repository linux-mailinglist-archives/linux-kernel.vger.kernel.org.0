Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C39C412088D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLPOXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 09:23:38 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:52574 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727579AbfLPOXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:23:38 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1igrHb-0000wL-Aw; Mon, 16 Dec 2019 15:23:35 +0100
To:     Guoheyi <guoheyi@huawei.com>
Subject: Re: [PATCH] irq-gic-v3: fix NULL dereference of disabled  =?UTF-8?Q?redist=5Fbase?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 16 Dec 2019 14:23:34 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
In-Reply-To: <c1447d9f-df4a-db07-adae-7e7e6c0f6455@huawei.com>
References: <20191216062745.63397-1-guoheyi@huawei.com>
 <36a042f6bcea5b5d5bfd9f6e6f01d6f5@www.loen.fr>
 <c1447d9f-df4a-db07-adae-7e7e6c0f6455@huawei.com>
Message-ID: <a4d0973bae1c50d947e7f84f3ec63d8f@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: guoheyi@huawei.com, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 13:50, Guoheyi wrote:
> 在 2019/12/16 19:14, Marc Zyngier 写道:
>> Hi Heyi,
>>
>> On 2019-12-16 06:27, Heyi Guo wrote:
>>> If we use ACPI MADT GICC structure to pass single redistributor 
>>> base,
>>> and mark some GICC as disabled, we'll get below call trace during
>>> boot:
>>>
>>> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>>> [    0.000000] GICv3: 256 SPIs implemented
>>> [    0.000000] GICv3: 0 Extended SPIs implemented
>>> [    0.000000] GICv3: Distributor has no Range Selector support
>>> [    0.000000] Unable to handle kernel paging request at virtual
>>> address 000000000000ffe8
>>> [    0.000000] Mem abort info:
>>> [    0.000000]   ESR = 0x96000004
>>> [    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [    0.000000]   SET = 0, FnV = 0
>>> [    0.000000]   EA = 0, S1PTW = 0
>>> [    0.000000] Data abort info:
>>> [    0.000000]   ISV = 0, ISS = 0x00000004
>>> [    0.000000]   CM = 0, WnR = 0
>>> [    0.000000] [000000000000ffe8] user address but active_mm is 
>>> swapper
>>> [    0.000000] Internal error: Oops: 96000004 [#1] SMP
>>> [    0.000000] Modules linked in:
>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc1 
>>> #5
>>> [    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
>>> [    0.000000] pc : gic_iterate_rdists+0x58/0x130
>>> [    0.000000] lr : gic_iterate_rdists+0x80/0x130
>>> [    0.000000] sp : ffff8000113d3cb0
>>> [    0.000000] x29: ffff8000113d3cb0 x28: 0000000000000000
>>> [    0.000000] x27: 0000000000000000 x26: 0000000000000018
>>> [    0.000000] x25: 000000000000ffe8 x24: 000000000000003f
>>> [    0.000000] x23: ffff800010588040 x22: 00000000000005e8
>>> [    0.000000] x21: ffff8000113df7d0 x20: 0000030f00003f11
>>> [    0.000000] x19: 0000000000000000 x18: ffffffffffffffff
>>> [    0.000000] x17: 0000000014aeb8dc x16: 00000000c3ba0ccf
>>> [    0.000000] x15: ffff8000113d9908 x14: ffff8000913d3a37
>>> [    0.000000] x13: ffff8000113d3a45 x12: ffff800011402000
>>> [    0.000000] x11: ffff8000113d39d0 x10: ffff8000113db980
>>> [    0.000000] x9 : 00000000ffffffd0 x8 : ffff8000106dca98
>>> [    0.000000] x7 : 000000000000005b x6 : 0000000000000000
>>> [    0.000000] x5 : 0000000000000000 x4 : ffff8000128c0000
>>> [    0.000000] x3 : ffff8000128a0000 x2 : ffff0003fc3c7000
>>> [    0.000000] x1 : 0000000000000001 x0 : 000000000000ffe8
>>> [    0.000000] Call trace:
>>> [    0.000000]  gic_iterate_rdists+0x58/0x130
>>> [    0.000000]  gic_init_bases+0x200/0x4b4
>>> [    0.000000]  gic_acpi_init+0x148/0x284
>>> [    0.000000]  acpi_match_madt+0x4c/0x84
>>> [    0.000000]  acpi_table_parse_entries_array+0x188/0x278
>>> [    0.000000]  acpi_table_parse_entries+0x70/0x98
>>> [    0.000000]  acpi_table_parse_madt+0x40/0x50
>>> [    0.000000]  __acpi_probe_device_table+0x88/0xe4
>>> [    0.000000]  irqchip_init+0x38/0x40
>>> [    0.000000]  init_IRQ+0x168/0x19c
>>> [    0.000000]  start_kernel+0x328/0x508
>>> [    0.000000] Code: f90017b6 9b3a7f16 f8766853 8b190260 (b9400000)
>>> [    0.000000] ---[ end trace ae5cf232d924bfc1 ]---
>>> [    0.000000] Kernel panic - not syncing: Fatal exception
>>> [    0.000000] Rebooting in 3 seconds..
>>>
>>> In this case, nr_redist_regions counts all GICC structures but only
>>> enabled ones have redistributor mapped. So add check to avoid NULL
>>> deference of redist_base.
>>>
>>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> ---
>>>  drivers/irqchip/irq-gic-v3.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3.c 
>>> b/drivers/irqchip/irq-gic-v3.c
>>> index d6218012097b..bd9d55cadef9 100644
>>> --- a/drivers/irqchip/irq-gic-v3.c
>>> +++ b/drivers/irqchip/irq-gic-v3.c
>>> @@ -781,6 +781,13 @@ static int gic_iterate_rdists(int (*fn)(struct
>>> redist_region *, void __iomem *))
>>>          u64 typer;
>>>          u32 reg;
>>>
>>> +        /*
>>> +         * redist_base may be NULL if we use single_redist and 
>>> some GICC
>>> +         * structure is disabled.
>>> +         */
>>> +        if (!ptr)
>>> +            continue;
>>> +
>>>          reg = readl_relaxed(ptr + GICR_PIDR2) & 
>>> GIC_PIDR2_ARCH_MASK;
>>>          if (reg != GIC_PIDR2_ARCH_GICv3 &&
>>>              reg != GIC_PIDR2_ARCH_GICv4) { /* We're in trouble... 
>>> */
>>
>> This feels like the wrong fix. The redistributor region array should
>> be completely populated, and there is an assumption all over this 
>> driver
>> that there is no junk in these structures.
>
>
> Oh, I thought the place holder for disabled GICR in nr_redist_regions
> were for some special reason, like CPU hotplug. Now I know I was 
> wrong
> :)

CPU hotplug would imply that the redistributors are available.
My interpretation of the ACPI MADT GICC subtable is that the
redistributors are simply inaccessible when disabled.

Otherwise, it'd be legitimate to just map them and live with
redistributors that do not have a corresponding CPU (which we
otherwise do). See ebe2f8718007 for details.

If we need to support redistributors becoming enabled under our
feet, then we'll have to handle this in a different way. We're
not there yet.

>> You're seeing this because we don't track the number of *enabled* 
>> rdists,
>> and allocate the number of regions based on the number of overall 
>> GICC
>> entries instead of the number of enabled redistributors.
>>
>> How about this instead?
>
> It looks good to me, and works fine in my case.

Can I take this as a Tested-by: ?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
