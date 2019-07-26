Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC36761AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 11:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfGZJSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 05:18:49 -0400
Received: from foss.arm.com ([217.140.110.172]:40018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZJSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:18:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC2D6344;
        Fri, 26 Jul 2019 02:18:48 -0700 (PDT)
Received: from why (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCBA93F71A;
        Fri, 26 Jul 2019 02:18:47 -0700 (PDT)
Date:   Fri, 26 Jul 2019 10:18:44 +0100
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] irqchip/gic-v3-its: Free unused vpt_page when alloc vpe
 table fail
Message-ID: <20190726101844.79cb10b5@why>
In-Reply-To: <1564105905-15410-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1564105905-15410-1-git-send-email-zhangshaokun@hisilicon.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 09:51:45 +0800
Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> From: Nianyao Tang <tangnianyao@huawei.com>
> 
> In its_vpe_init, when its_alloc_vpe_table fails, we should free
> vpt_page allocated just before, instead of vpe->vpt_page.
> Let's fix it.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 730fbe0..1b5c367 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3010,7 +3010,7 @@ static int its_vpe_init(struct its_vpe *vpe)
>  
>  	if (!its_alloc_vpe_table(vpe_id)) {
>  		its_vpe_id_free(vpe_id);
> -		its_free_pending_table(vpe->vpt_page);
> +		its_free_pending_table(vpt_page);
>  		return -ENOMEM;
>  	}
>  

Oops, well caught. Please repost this patch with your own SoB added
though, as you're posting the patch on behalf of someone else.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
