Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01BBF5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 17:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfIZPeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 11:34:17 -0400
Received: from foss.arm.com ([217.140.110.172]:53102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfIZPeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:34:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7860E28;
        Thu, 26 Sep 2019 08:34:16 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 702483F534;
        Thu, 26 Sep 2019 08:34:15 -0700 (PDT)
Subject: Re: [PATCH 03/35] irqchip/gic-v3-its: Allow LPI invalidation via the
 DirectLPI interface
To:     Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190923182606.32100-1-maz@kernel.org>
 <20190923182606.32100-4-maz@kernel.org>
 <92ff82ca-ebcb-8f5f-5063-313f65bbc5e3@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <fe2a5258-4a48-28d9-9cd5-793358ceb4eb@kernel.org>
Date:   Thu, 26 Sep 2019 16:34:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <92ff82ca-ebcb-8f5f-5063-313f65bbc5e3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 26/09/2019 15:57, Zenghui Yu wrote:
> Hi Marc,
> 
> I get one kernel panic with this patch on D05.

Ah, surprise! I haven't had time to test this on a D05 yet, such in a
hurry to push the damn thing out of the building...

> 
> (I don't have the GICv4.1 board at the moment. I have to wait for the
>   appropriate HW to do more tests.)
> 
> On 2019/9/24 2:25, Marc Zyngier wrote:
>> We currently don't make much use of the DirectLPI feature, and it would
>> be beneficial to do this more, if only because it becomes a mandatory
>> feature for GICv4.1.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 51 +++++++++++++++++++++++---------
>>   1 file changed, 37 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 58cb233cf138..c94eb287393b 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -175,6 +175,12 @@ static DEFINE_IDA(its_vpeid_ida);
>>   #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>>   #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
>>   
>> +static inline u32 its_get_event_id(struct irq_data *d)
>> +{
>> +	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> +	return d->hwirq - its_dev->event_map.lpi_base;
>> +}
>> +
>>   static struct its_collection *dev_event_to_col(struct its_device *its_dev,
>>   					       u32 event)
>>   {
>> @@ -183,6 +189,13 @@ static struct its_collection *dev_event_to_col(struct its_device *its_dev,
>>   	return its->collections + its_dev->event_map.col_map[event];
>>   }
>>   
>> +static struct its_collection *irq_to_col(struct irq_data *d)
>> +{
>> +	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> +
>> +	return dev_event_to_col(its_dev, its_get_event_id(d));
>> +}
>> +
> 
> irq_to_col uses device's event_map and col_map to get the target
> collection, yes it works well with device's LPI.
> But direct_lpi_inv also pass doorbells to it...
> 
> We don't allocate doorbells for any devices, instead for each vPE.

Hmm. Yes, you're right. It looks like I've been carried away on this
one. I'll have a look.

> 
> And see below,
> 
>>   static struct its_collection *valid_col(struct its_collection *col)
>>   {
>>   	if (WARN_ON_ONCE(col->target_address & GENMASK_ULL(15, 0)))
>> @@ -1031,12 +1044,6 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
>>    * irqchip functions - assumes MSI, mostly.
>>    */
>>   
>> -static inline u32 its_get_event_id(struct irq_data *d)
>> -{
>> -	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>> -	return d->hwirq - its_dev->event_map.lpi_base;
>> -}
>> -
>>   static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
>>   {
>>   	irq_hw_number_t hwirq;
>> @@ -1081,12 +1088,28 @@ static void wait_for_syncr(void __iomem *rdbase)
>>   		cpu_relax();
>>   }
>>   
>> +static void direct_lpi_inv(struct irq_data *d)
>> +{
>> +	struct its_collection *col;
>> +	void __iomem *rdbase;
>> +
>> +	/* Target the redistributor this LPI is currently routed to */
>> +	col = irq_to_col(d);
>> +	rdbase = per_cpu_ptr(gic_rdists->rdist, col->col_id)->rd_base;
>> +	gic_write_lpir(d->hwirq, rdbase + GICR_INVLPIR);
>> +
>> +	wait_for_syncr(rdbase);
>> +}
>> +
>>   static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
>>   {
>>   	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>>   
>>   	lpi_write_config(d, clr, set);
>> -	its_send_inv(its_dev, its_get_event_id(d));
>> +	if (gic_rdists->has_direct_lpi && !irqd_is_forwarded_to_vcpu(d))
>> +		direct_lpi_inv(d);
>> +	else
>> +		its_send_inv(its_dev, its_get_event_id(d));
>>   }
>>   
>>   static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
>> @@ -2912,15 +2935,15 @@ static void its_vpe_send_cmd(struct its_vpe *vpe,
>>   
>>   static void its_vpe_send_inv(struct irq_data *d)
>>   {
>> -	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>> -
>>   	if (gic_rdists->has_direct_lpi) {
>> -		void __iomem *rdbase;
>> -
>> -		rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
>> -		gic_write_lpir(vpe->vpe_db_lpi, rdbase + GICR_INVLPIR);
>> -		wait_for_syncr(rdbase);
>> +		/*
>> +		 * Don't mess about. Generating the invalidation is easily
>> +		 * done by using the parent irq_data, just like below.
>> +		 */
>> +		direct_lpi_inv(d->parent_data);
> 
> "GICv4-vpe"'s parent is "GICv3", not "ITS".  What do we expect with
> irq_data_get_irq_chip_data(parent's irq_data)?

Yup, terrible mix up. d->parent_data comes from the fact that we want to
invalidate the LPI and not d->hwirq (which is the VPEID). But doing so,
we also confuse direct_lpi_inv(), which expects to find meaningful data
(the its_dev) as chip data (and the irq_to_col doesn't help either).

To sum it up, the whole thing is busted, I'll have a brown paper bag,
thank you very much... :-(. Let me work on a fix.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
