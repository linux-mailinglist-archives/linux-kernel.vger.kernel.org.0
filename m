Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427C28EECE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbfHOO6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 10:58:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39964 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbfHOO6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:58:33 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyHCu-0007SL-HD; Thu, 15 Aug 2019 16:58:28 +0200
Date:   Thu, 15 Aug 2019 16:58:27 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ben Luo <luoben@linux.alibaba.com>
cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: Re: [PATCH v3 2/3] genirq: introduce update_irq_devid()
In-Reply-To: <6343a7e34ffdd0ddcd730996fc5dad3024e42251.1565857737.git.luoben@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1908151622410.1908@nanos.tec.linutronix.de>
References: <cover.1565857737.git.luoben@linux.alibaba.com> <6343a7e34ffdd0ddcd730996fc5dad3024e42251.1565857737.git.luoben@linux.alibaba.com>
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

Ben,

On Thu, 15 Aug 2019, Ben Luo wrote:

> Sometimes, only the dev_id field of irqaction need to be changed.
> E.g. KVM VM with device passthru via VFIO may switch irq injection
> path between KVM irqfd and userspace eventfd. These two paths
> share the same irq num and handler for the same vector of a device,

s/irq num/interrupt number/

Changelogs are text and should not contain cryptic abbreviations.

> only with different dev_id referencing to different fds' contexts.
> 
> So, instead of free/request irq, only update dev_id of irqaction.

Please write functions like this: function_name() so they can be easily
identified in the text as such.

> This narrows the gap for setting up new irq (and irte, if has)

What does that mean: "narrows the gap"

What's the gap and why is it only made smaller and not closed?

> and also gains some performance benefit.
> 
> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>

I prefer to see the 'reviewed-by' as a reply on LKML rather than coming
from some internal process.

> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

While I reviewed the previous version, I surely did not give a
'Reviewed-by' tag. That tag means that the person did review the patch and
did not find an issue. I surely found issues, right?

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 6f9b20f..a76ef61 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2064,6 +2064,84 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
>  EXPORT_SYMBOL(request_threaded_irq);
>  
>  /**
> + *	update_irq_devid - update irq dev_id to a new one

Can you please name this: irq_update_devid(). We try to have a consistent
name space for new functions.

> + *	@irq: Interrupt line to update
> + *	@dev_id: A cookie to find the irqaction to update
> + *	@new_dev_id: New cookie passed to the handler function

Can you please arrange these in tabular fashion:

 *	@irq:		Interrupt line to update
 *	@dev_id:	A cookie to find the irqaction to update
 *	@new_dev_id:	New cookie passed to the handler function

> + *	Sometimes, only the cookie data need to be changed.
> + *	Instead of free/request irq, only update dev_id here
> + *	Not only to gain some performance benefit, but also
> + *	reduce the risk of losing interrupt.
> + *
> + *	E.g. irq affinity setting in a VM with VFIO passthru

Again. Please write it out 'interrupt' and everything else.

> + *	device is carried out in a free-then-request-irq way
> + *	since lack of this very function. The free_irq()

That does not make sense. The function is there for such a use case. So
immediately when the VFIO change is merged this comment is stale and bogus.

> + *	eventually triggers deactivation of IR domain, which
> + *	will cleanup IRTE. There is a gap before request_irq()
> + *	finally setup the IRTE again. In this gap, a in-flight
> + *	irq buffering in hardware layer may trigger DMAR fault
> + *	and be lost.

Exactly this information wants to be in the changelog.

> + *
> + *	On failure, it returns a negative value. On success,
> + *	it returns 0
> + */
> +int update_irq_devid(unsigned int irq, void *dev_id, void *new_dev_id)
> +{
> +	struct irq_desc *desc = irq_to_desc(irq);
> +	struct irqaction *action, **action_ptr;
> +	unsigned long flags;
> +
> +	if (in_interrupt()) {
> +		WARN(1, "Trying to update IRQ %d (dev_id %p to %p) from IRQ context!\n",
> +		     irq, dev_id, new_dev_id);
> +		return -EPERM;
> +	}

  	if (WARN(....)

> +
> +	if (!desc)
> +		return -EINVAL;
> +
> +	chip_bus_lock(desc);

This does not need to take bus lock. The action pointer is sufficiently
protected by desc->lock.

> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +
> +	/*
> +	 * There can be multiple actions per IRQ descriptor, find the right
> +	 * one based on the dev_id:
> +	 */
> +	action_ptr = &desc->action;
> +	for (;;) {
> +		action = *action_ptr;
> +
> +		if (!action) {
> +			raw_spin_unlock_irqrestore(&desc->lock, flags);
> +			chip_bus_sync_unlock(desc);
> +			WARN(1, "Trying to update already-free IRQ %d (dev_id %p to %p)\n",
> +			     irq, dev_id, new_dev_id);
> +			return -ENXIO;
> +		}
> +
> +		if (action->dev_id == dev_id) {
> +			action->dev_id = new_dev_id;
> +			break;
> +		}
> +		action_ptr = &action->next;
> +	}
> +
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +	chip_bus_sync_unlock(desc);
> +
> +	/*
> +	 * Make sure it's not being used on another CPU:
> +	 * There is a risk of UAF for old *dev_id, if it is
> +	 * freed in a short time after this func returns

function please. Also it does not matter whether the time is short or
not. The point is:

     	 Ensure that an interrupt in flight on another CPU which uses the
     	 old 'dev_id' has completed because the caller can free the memory
	 to which it points after this function returns.

But this has another twist:

    CPU0				CPU1

    interrupt
    	primary_handler(old_dev_id)
	   do_stuff_on(old_dev_id)
	   return WAKE_THREAD;		update_dev_id()
        wakeup_thread();
					  action->dev_id = new_dev_id;
    irq_thread()
        secondary_handler(new_dev_id)
	
That's broken and synchronize_irq() does not protect against it.

> +	 */
> +	synchronize_irq(irq);

Thanks,

	tglx
