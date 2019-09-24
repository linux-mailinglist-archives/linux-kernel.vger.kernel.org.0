Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D30BC5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 12:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440744AbfIXKt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 06:49:28 -0400
Received: from foss.arm.com ([217.140.110.172]:57384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405537AbfIXKt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:49:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76DF4142F;
        Tue, 24 Sep 2019 03:49:27 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 056113F67D;
        Tue, 24 Sep 2019 03:49:25 -0700 (PDT)
Subject: Re: [PATCH 04/35] irqchip/gic-v3: Detect GICv4.1 supporting RVPEID
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-5-maz@kernel.org>
 <20190924102413.GN9720@e119886-lin.cambridge.arm.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <a8107ed9-bb95-a648-ea41-597510f35ec8@kernel.org>
Date:   Tue, 24 Sep 2019 11:49:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924102413.GN9720@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2019 11:24, Andrew Murray wrote:
> On Mon, Sep 23, 2019 at 07:25:35PM +0100, Marc Zyngier wrote:
>> GICv4.1 supports the RVPEID ("Residency per vPE ID"), which allows for
>> a much efficient way of making virtual CPUs resident (to allow direct
>> injection of interrupts).
>>
>> The functionnality needs to be discovered on each and every redistributor
>> in the system, and disabled if the settings are inconsistent.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  drivers/irqchip/irq-gic-v3.c       | 21 ++++++++++++++++++---
>>  include/linux/irqchip/arm-gic-v3.h |  2 ++
>>  2 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 422664ac5f53..0b545e2c3498 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -849,8 +849,21 @@ static int __gic_update_rdist_properties(struct redist_region *region,
>>  					 void __iomem *ptr)
>>  {
>>  	u64 typer = gic_read_typer(ptr + GICR_TYPER);
>> +
>>  	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
>> -	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
>> +
>> +	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
> 
> I think the doc says, RVPEID is *always* 1 for GICv4.1 (and presumably beyond)
> and when RVPEID==1 then DirectLPI is *always* 0 - but that's OK because for
> GICv4.1 support for direct LPIs is mandatory.

Well, v4.1 support for DirectLPI is pretty patchy. It has just enough
features to make it useful.

> 
>> +	gic_data.rdists.has_rvpeid &= !!(typer & GICR_TYPER_RVPEID);
>> +	gic_data.rdists.has_direct_lpi &= (!!(typer & GICR_TYPER_DirectLPIS) |
>> +					   gic_data.rdists.has_rvpeid);
>> +
>> +	/* Detect non-sensical configurations */
>> +	if (WARN_ON_ONCE(gic_data.rdists.has_rvpeid && !gic_data.rdists.has_vlpis)) {
> 
> How feasible is the following suitation? All the redistributors in the system has
> vlpis=0, and only the first redistributor has rvpeid=1 (with the remaining ones
> rvpeid=0).If we evaluate this WARN_ON_ONCE on each call to
> __gic_update_rdist_properties we end up without direct LPI support, however if we
> evaluated this after iterating through all the redistributors then we'd end up
> with direct LPI support and a non-essential WARN.
> 
> Should we do the WARN after iterating through all the redistributors once we
> know what the final values of these flags will be, perhaps in
> gic_update_rdist_properties?

What does it gains us? The moment we've detected any inconsistency, any
use of DirectLPI or VLPIs is a big nono, because the redistributors care
not designed to communicate with each other, and we might as well do
that early. Frankly, the HW should have stayed in someone's lab. The
only reason I have that code in is to detect the FVP model being
misconfigured, which is pretty easy to do.

	M.
-- 
Jazz is not dead, it just smells funny...
