Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6A8EC1A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 12:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbfKALXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 07:23:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfKALXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:23:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 736BD94B132DE4DFE19F;
        Fri,  1 Nov 2019 19:23:46 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 19:23:39 +0800
Subject: Re: [PATCH v2 16/36] irqchip/gic-v4.1: Add mask/unmask doorbell
 callbacks
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Jayachandran C <jnair@marvell.com>,
        "Robert Richter" <rrichter@marvell.com>
References: <20191027144234.8395-1-maz@kernel.org>
 <20191027144234.8395-17-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7c94be43-e1b0-625a-762c-ec8589f16b2d@huawei.com>
Date:   Fri, 1 Nov 2019 19:23:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191027144234.8395-17-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/10/27 22:42, Marc Zyngier wrote:
> masking/unmasking doorbells on GICv4.1 relies on a new INVDB command,
> which broadcasts the invalidation to all RDs.
> 
> Implement the new command as well as the masking callbacks, and plug
> the whole thing into the v4.1 VPE irqchip.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

> ---
>   drivers/irqchip/irq-gic-v3-its.c   | 60 ++++++++++++++++++++++++++++++
>   include/linux/irqchip/arm-gic-v3.h |  3 +-
>   2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index dcc7227af5f1..3c34bef70bdd 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -309,6 +309,10 @@ struct its_cmd_desc {
>   			u16 seq_num;
>   			u16 its_list;
>   		} its_vmovp_cmd;
> +
> +		struct {
> +			struct its_vpe *vpe;
> +		} its_invdb_cmd;
>   	};
>   };
>   
> @@ -750,6 +754,21 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
>   	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
>   }
>   
> +static struct its_vpe *its_build_invdb_cmd(struct its_node *its,
> +					   struct its_cmd_block *cmd,
> +					   struct its_cmd_desc *desc)
> +{
> +	if (WARN_ON(!is_v4_1(its)))
> +		return NULL;
> +
> +	its_encode_cmd(cmd, GITS_CMD_INVDB);
> +	its_encode_vpeid(cmd, desc->its_invdb_cmd.vpe->vpe_id);
> +
> +	its_fixup_cmd(cmd);
> +
> +	return valid_vpe(its, desc->its_invdb_cmd.vpe);
> +}
> +
>   static u64 its_cmd_ptr_to_offset(struct its_node *its,
>   				 struct its_cmd_block *ptr)
>   {
> @@ -1117,6 +1136,14 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
>   	its_send_single_vcommand(its, its_build_vinvall_cmd, &desc);
>   }
>   
> +static void its_send_invdb(struct its_node *its, struct its_vpe *vpe)
> +{
> +	struct its_cmd_desc desc;
> +
> +	desc.its_invdb_cmd.vpe = vpe;
> +	its_send_single_vcommand(its, its_build_invdb_cmd, &desc);
> +}
> +
>   /*
>    * irqchip functions - assumes MSI, mostly.
>    */
> @@ -3408,6 +3435,37 @@ static struct irq_chip its_vpe_irq_chip = {
>   	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
>   };
>   
> +static void its_vpe_4_1_send_inv(struct irq_data *d)
> +{
> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +	struct its_node *its;
> +
> +	/*
> +	 * GICv4.1 wants doorbells to be invalidated using the
> +	 * INVDB command in order to be broadcast to all RDs. Send
> +	 * it to the first valid ITS, and let the HW do its magic.
> +	 */
> +	list_for_each_entry(its, &its_nodes, entry) {
> +		if (!is_v4_1(its))
> +			continue;
> +
> +		its_send_invdb(its, vpe);
> +		break;
> +	}

Maybe use find_4_1_its() helper instead?


Thanks,
Zenghui

> +}
> +
> +static void its_vpe_4_1_mask_irq(struct irq_data *d)
> +{
> +	lpi_write_config(d->parent_data, LPI_PROP_ENABLED, 0);
> +	its_vpe_4_1_send_inv(d);
> +}
> +
> +static void its_vpe_4_1_unmask_irq(struct irq_data *d)
> +{
> +	lpi_write_config(d->parent_data, 0, LPI_PROP_ENABLED);
> +	its_vpe_4_1_send_inv(d);
> +}
> +
>   static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>   {
>   	struct its_cmd_info *info = vcpu_info;
> @@ -3429,6 +3487,8 @@ static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>   
>   static struct irq_chip its_vpe_4_1_irq_chip = {
>   	.name			= "GICv4.1-vpe",
> +	.irq_mask		= its_vpe_4_1_mask_irq,
> +	.irq_unmask		= its_vpe_4_1_unmask_irq,
>   	.irq_eoi		= irq_chip_eoi_parent,
>   	.irq_set_affinity	= its_vpe_set_affinity,
>   	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index f1d6de53e09b..8157737053e4 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -484,8 +484,9 @@
>   #define GITS_CMD_VMAPTI			GITS_CMD_GICv4(GITS_CMD_MAPTI)
>   #define GITS_CMD_VMOVI			GITS_CMD_GICv4(GITS_CMD_MOVI)
>   #define GITS_CMD_VSYNC			GITS_CMD_GICv4(GITS_CMD_SYNC)
> -/* VMOVP is the odd one, as it doesn't have a physical counterpart */
> +/* VMOVP and INVDB are the odd ones, as they dont have a physical counterpart */
>   #define GITS_CMD_VMOVP			GITS_CMD_GICv4(2)
> +#define GITS_CMD_INVDB			GITS_CMD_GICv4(0xe)
>   
>   /*
>    * ITS error numbers
> 

