Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8879317F67A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 12:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgCJLlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 07:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgCJLlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:41:11 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE6E2468C;
        Tue, 10 Mar 2020 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583840471;
        bh=QLt7kZCEnxiePVqlsBlF0aubfvfE3Qs3WP4X0CM6NhE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zGfLGVzdPIfTnCccgNOVx5CW1R9dpXEQhO7A4pCF6ujMer/TI9GJ0w2KBRqmSGTw5
         FGZpHsXhUpPSur83ZvsuZqmAV3lBaKsVnb8fiLCmxRS5stu2EWx0FW5Xkr4BHYwfFp
         +CAZbAIJ98sTFpB1t7Surh8En5pUN7wvUG66OoLY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBdG1-00BY0v-AA; Tue, 10 Mar 2020 11:41:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Mar 2020 11:41:09 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 03/32] irqchip/gic-v3: Workaround Cavium TX1 erratum
 when reading GICD_TYPER2
In-Reply-To: <20200309221137.5pjh4vkc62ft3h2a@rric.localdomain>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-4-maz@kernel.org>
 <20200309221137.5pjh4vkc62ft3h2a@rric.localdomain>
Message-ID: <b1b7db1f0e1c47b7d9e2dfbbe3409b77@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rrichter@marvell.com, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 2020-03-09 22:11, Robert Richter wrote:
> On 24.12.19 11:10:26, Marc Zyngier wrote:
>> Despite the architecture spec being extremely clear about the fact
>> that reserved registers in the GIC distributor memory map are RES0
>> (and thus are not allowed to generate an exception), the Cavium
>> ThunderX (aka TX1) SoC explodes as such:
>> 
>> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
>> [    0.000000] GICv3: 128 SPIs implemented
>> [    0.000000] GICv3: 0 Extended SPIs implemented
>> [    0.000000] Internal error: synchronous external abort: 96000210 
>> [#1] SMP
>> [    0.000000] Modules linked in:
>> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
>> 5.4.0-rc4-00035-g3cf6a3d5725f #7956
>> [    0.000000] Hardware name: cavium,thunder-88xx (DT)
>> [    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
>> [    0.000000] pc : __raw_readl+0x0/0x8
>> [    0.000000] lr : gic_init_bases+0x110/0x560
>> [    0.000000] sp : ffff800011243d90
>> [    0.000000] x29: ffff800011243d90 x28: 0000000000000000
>> [    0.000000] x27: 0000000000000018 x26: 0000000000000002
>> [    0.000000] x25: ffff8000116f0000 x24: ffff000fbe6a2c80
>> [    0.000000] x23: 0000000000000000 x22: ffff010fdc322b68
>> [    0.000000] x21: ffff800010a7a208 x20: 00000000009b0404
>> [    0.000000] x19: ffff80001124dad0 x18: 0000000000000010
>> [    0.000000] x17: 000000004d8d492b x16: 00000000f67eb9af
>> [    0.000000] x15: ffffffffffffffff x14: ffff800011249908
>> [    0.000000] x13: ffff800091243ae7 x12: ffff800011243af4
>> [    0.000000] x11: ffff80001126e000 x10: ffff800011243a70
>> [    0.000000] x9 : 00000000ffffffd0 x8 : ffff80001069c828
>> [    0.000000] x7 : 0000000000000059 x6 : ffff8000113fb4d1
>> [    0.000000] x5 : 0000000000000001 x4 : 0000000000000000
>> [    0.000000] x3 : 0000000000000000 x2 : 0000000000000000
>> [    0.000000] x1 : 0000000000000000 x0 : ffff8000116f000c
>> [    0.000000] Call trace:
>> [    0.000000]  __raw_readl+0x0/0x8
>> [    0.000000]  gic_of_init+0x188/0x224
>> [    0.000000]  of_irq_init+0x200/0x3cc
>> [    0.000000]  irqchip_init+0x1c/0x40
>> [    0.000000]  init_IRQ+0x160/0x1d0
>> [    0.000000]  start_kernel+0x2ec/0x4b8
>> [    0.000000] Code: a8c47bfd d65f03c0 d538d080 d65f03c0 (b9400000)
>> 
>> when reading the GICv4.1 GICD_TYPER2 register, which is unexpected...
>> 
>> Work around it by adding a new quirk flagging all the A1 revisions
>> of the distributor, but it remains unknown whether this could affect
>> other revisions of this SoC (or even other SoCs from the same silicon
>> vendor).
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3.c 
>> b/drivers/irqchip/irq-gic-v3.c
>> index 286f98222878..640d4db65b78 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -34,6 +34,7 @@
>>  #define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
>> 
>>  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
>> +#define FLAGS_WORKAROUND_GICD_TYPER2_TX1	(1ULL << 1)
>> 
>>  struct redist_region {
>>  	void __iomem		*redist_base;
>> @@ -1464,6 +1465,15 @@ static bool gic_enable_quirk_msm8996(void 
>> *data)
>>  	return true;
>>  }
>> 
>> +static bool gic_enable_quirk_tx1(void *data)
>> +{
>> +	struct gic_chip_data *d = data;
>> +
>> +	d->flags |= FLAGS_WORKAROUND_GICD_TYPER2_TX1;
>> +
>> +	return true;
>> +}
>> +
>>  static bool gic_enable_quirk_hip06_07(void *data)
>>  {
>>  	struct gic_chip_data *d = data;
>> @@ -1502,6 +1512,12 @@ static const struct gic_quirk gic_quirks[] = {
>>  		.mask	= 0xffffffff,
>>  		.init	= gic_enable_quirk_hip06_07,
>>  	},
>> +	{
>> +		.desc	= "GICv3: Cavium TX1 GICD_TYPER2 erratum",
> 
> There is no errata number yet.

Please let me know when/if you obtain one.

> 
>> +		.iidr	= 0xa100034c,
>> +		.mask	= 0xfff00fff,
>> +		.init	= gic_enable_quirk_tx1,
> 
> All TX1 and OcteonTX parts are affected, which is a0-a7 and b0-b7. So
> the iidr/mask should be:
> 
> 		.iidr   = 0xa000034c,
> 		.mask   = 0xe8f00fff,

Thanks, that's pretty helpful. I'll update the patch with these values
and the corresponding description.

>> +	},
>>  	{
>>  	}
>>  };
>> @@ -1577,7 +1593,12 @@ static int __init gic_init_bases(void __iomem 
>> *dist_base,
>>  	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
>>  	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
>> 
>> -	gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base + 
>> GICD_TYPER2);
>> +	/*
>> +	 * ThunderX1 explodes on reading GICD_TYPER2, in total violation
>> +	 * of the spec (which says that reserved addresses are RES0).
>> +	 */
>> +	if (!(gic_data.flags & FLAGS_WORKAROUND_GICD_TYPER2_TX1))
>> +		gic_data.rdists.gicd_typer2 = readl_relaxed(gic_data.dist_base + 
>> GICD_TYPER2);
> 
> You already said that checking for ArchRev of GICD_PIDR2 isn't an
> option here. Though, it could...

Once GICv3.2 starts using this register as well (because GICD_TYPER is
already completely full), we'd have to fix it again. There is also the 
thing
you hinted at in the other thread: TX1 will generate a SEA on every 
reserved
GICD registers, so we may need to protect more than just this one over 
time,
and maybe more than just in the distributor.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
