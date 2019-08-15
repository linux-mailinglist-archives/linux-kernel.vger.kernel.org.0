Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF68EE12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732924AbfHOOU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 10:20:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39893 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732816AbfHOOU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:20:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyGcW-0006aU-Oy; Thu, 15 Aug 2019 16:20:52 +0200
Date:   Thu, 15 Aug 2019 16:20:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ben Luo <luoben@linux.alibaba.com>
cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: Re: [PATCH v3 1/3] genirq: enhance error recovery code in free irq
In-Reply-To: <ac85d5f69649cb2b2c9e9254207fd751274bf3ad.1565857737.git.luoben@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1908151617150.1908@nanos.tec.linutronix.de>
References: <cover.1565857737.git.luoben@linux.alibaba.com> <ac85d5f69649cb2b2c9e9254207fd751274bf3ad.1565857737.git.luoben@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019, Ben Luo wrote:

> Per Thomas Gleixner's comments:
> 1) free_irq/free_percpu_irq returns if called from IRQ context
> 2) move WARN out of the locked region and print out dev_id

Please do not describe WHAT the patch is doing, please describe WHY.
 
> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> ---
>  kernel/irq/manage.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index e8f7f17..6f9b20f 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1690,7 +1690,11 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
>  	struct irqaction *action, **action_ptr;
>  	unsigned long flags;
>  
> -	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
> +	if (in_interrupt()) {
> +		WARN(1, "Trying to free IRQ %d (dev_id %p) from IRQ context!\n",
> +		     irq, dev_id);
> +		return NULL;
> +	}

	if (WARN(in_interrupt(), ."Tr...."))
		return NULL;

Thanks,

	tglx
