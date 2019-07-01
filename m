Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD039F8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 14:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfD3Mey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 08:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfD3Mex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:34:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38D9030917AA;
        Tue, 30 Apr 2019 12:34:53 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F4366D09A;
        Tue, 30 Apr 2019 12:34:49 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] irqchip/gicv2m: Don't map the MSI page in
 gicv2m_compose_msi_msg()
To:     Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jason@lakedaemon.net, douliyangs@gmail.com, marc.zyngier@arm.com,
        robin.murphy@arm.com, miquel.raynal@bootlin.com,
        tglx@linutronix.de, logang@deltatee.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-4-julien.grall@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c4013c08-3d32-769c-447b-38a0a0dcf152@redhat.com>
Date:   Tue, 30 Apr 2019 14:34:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190429144428.29254-4-julien.grall@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 30 Apr 2019 12:34:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 4/29/19 4:44 PM, Julien Grall wrote:
> gicv2m_compose_msi_msg() may be called from non-preemptible context.
> However, on RT, iommu_dma_map_msi_msg() requires to be called from a
> preemptible context.
> 
> A recent change split iommu_dma_map_msi_msg() in two new functions:
> one that should be called in preemptible context, the other does
> not have any requirement.
> 
> The GICv2m driver is reworked to avoid executing preemptible code in
> non-preemptible context. This can be achieved by preparing the MSI
> mapping when allocating the MSI interrupt.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> ---
>     Changes in v2:
>         - Rework the commit message to use imperative mood
> ---
>  drivers/irqchip/irq-gic-v2m.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
> index f5fe0100f9ff..4359f0583377 100644
> --- a/drivers/irqchip/irq-gic-v2m.c
> +++ b/drivers/irqchip/irq-gic-v2m.c
> @@ -110,7 +110,7 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
>  		msg->data -= v2m->spi_offset;
>  
> -	iommu_dma_map_msi_msg(data->irq, msg);
> +	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
>  }
>  
>  static struct irq_chip gicv2m_irq_chip = {
> @@ -167,6 +167,7 @@ static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq,
>  static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  				   unsigned int nr_irqs, void *args)
>  {
> +	msi_alloc_info_t *info = args;
>  	struct v2m_data *v2m = NULL, *tmp;
>  	int hwirq, offset, i, err = 0;
>  
> @@ -186,6 +187,11 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  
>  	hwirq = v2m->spi_start + offset;
>  
> +	err = iommu_dma_prepare_msi(info->desc,
> +				    v2m->res.start + V2M_MSI_SETSPI_NS);
> +	if (err)
> +		return err;
> +
>  	for (i = 0; i < nr_irqs; i++) {
>  		err = gicv2m_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
>  		if (err)
> 
