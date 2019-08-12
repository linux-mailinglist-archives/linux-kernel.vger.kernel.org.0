Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4781896F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 07:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfHLFpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 01:45:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbfHLFpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:45:01 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8ED0FBDC1E026B7FB095;
        Mon, 12 Aug 2019 13:44:58 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 12 Aug 2019
 13:44:54 +0800
Subject: Re: [PATCH 2/2] vfio_pci: make use of update_irq_devid and optimize
 irq ops
To:     Ben Luo <luoben@linux.alibaba.com>, <tglx@linutronix.de>,
        <alex.williamson@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     <tao.ma@linux.alibaba.com>, <gerry@linux.alibaba.com>
References: <cover.1565263723.git.luoben@linux.alibaba.com>
 <461a0d843c8ac4c31de61d08f4940884742f77b5.1565263723.git.luoben@linux.alibaba.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6b11b0fa-06a9-fd92-084c-faaca116dc74@huawei.com>
Date:   Mon, 12 Aug 2019 13:44:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <461a0d843c8ac4c31de61d08f4940884742f77b5.1565263723.git.luoben@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/8 20:07, Ben Luo wrote:
> When userspace (e.g. qemu) triggers a switch between KVM
> irqfd and userspace eventfd, only dev_id of irq action
> (i.e. the "trigger" in this patch's context) will be
> changed, but a free-then-request-irq action is taken in
> current code. And, irq affinity setting in VM will also
> trigger a free-then-request-irq action, which actully
> changes nothing, but only fires a producer re-registration
> to update irte in case that posted-interrupt is in use.
> 
> This patch makes use of update_irq_devid() and optimize
> both cases above, which reduces the risk of losing interrupt
> and also cuts some overhead.
> 
> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
> ---
>  drivers/vfio/pci/vfio_pci_intrs.c | 100 +++++++++++++++++++++++---------------
>  1 file changed, 62 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 3fa3f72..1323dc8 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -285,69 +285,93 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
>  				      int vector, int fd, bool msix)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> -	struct eventfd_ctx *trigger;
> +	struct eventfd_ctx *trigger = NULL;

struct eventfd_ctx *trigger = NULL;
struct pci_dev *pdev = vdev->pdev;

to maintain reverse christmas tree?

>  	int irq, ret;
>  
>  	if (vector < 0 || vector >= vdev->num_ctx)
>  		return -EINVAL;
>  
> +	if (fd >= 0) {
> +		trigger = eventfd_ctx_fdget(fd);
> +		if (IS_ERR(trigger))
> +			return PTR_ERR(trigger);

It seems vdev->ctx[vector].trigger is freed even if  fd < 0 before
this patch. If it return here, vdev->ctx[vector].trigger is not free?

> +	}
> +
>  	irq = pci_irq_vector(pdev, vector);
>  
>  	if (vdev->ctx[vector].trigger) {
> -		free_irq(irq, vdev->ctx[vector].trigger);
> -		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> -		kfree(vdev->ctx[vector].name);
> -		eventfd_ctx_put(vdev->ctx[vector].trigger);
> -		vdev->ctx[vector].trigger = NULL;
> +		if (vdev->ctx[vector].trigger != trigger) {
> +			if (trigger) {
> +				ret = update_irq_devid(irq,
> +						vdev->ctx[vector].trigger, trigger);
> +				if (unlikely(ret)) {
> +					dev_info(&pdev->dev,
> +							"update_irq_devid %d (token %p) fails: %d\n",
> +							irq, vdev->ctx[vector].trigger, ret);
> +					eventfd_ctx_put(trigger);
> +					return ret;
> +				}
> +				irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> +				eventfd_ctx_put(vdev->ctx[vector].trigger);
> +				vdev->ctx[vector].producer.token = trigger;
> +				vdev->ctx[vector].trigger = trigger;
> +			} else {
> +				free_irq(irq, vdev->ctx[vector].trigger);
> +				irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> +				kfree(vdev->ctx[vector].name);
> +				eventfd_ctx_put(vdev->ctx[vector].trigger);
> +				vdev->ctx[vector].trigger = NULL;
> +			}
> +		} else
> +			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
>  	}

Maybe adjust it a litte to reduce indent and to improve readability?

	if (vdev->ctx[vector].trigger && vdev->ctx[vector].trigger == trigger) {
		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
	} else if (vdev->ctx[vector].trigger && !trigger) {
		free_irq(irq, vdev->ctx[vector].trigger);
		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
		kfree(vdev->ctx[vector].name);
		eventfd_ctx_put(vdev->ctx[vector].trigger);
		vdev->ctx[vector].trigger = NULL;
	} else if (vdev->ctx[vector].trigger) {
		ret = update_irq_devid(irq, vdev->ctx[vector].trigger, trigger);
		if (unlikely(ret)) {
			dev_info(&pdev->dev,
				 "update_irq_devid %d (token %p) fails: %d\n",
				 irq, vdev->ctx[vector].trigger, ret);
				 eventfd_ctx_put(trigger);
				 return ret;
		}
		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
		eventfd_ctx_put(vdev->ctx[vector].trigger);
		vdev->ctx[vector].producer.token = trigger;
		vdev->ctx[vector].trigger = trigger;
	}


>  
>  	if (fd < 0)
>  		return 0;
>  
> -	vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "vfio-msi%s[%d](%s)",
> -					   msix ? "x" : "", vector,
> -					   pci_name(pdev));
> -	if (!vdev->ctx[vector].name)
> -		return -ENOMEM;
> +	if (vdev->ctx[vector].trigger == NULL) {

It may be common to use the below check to do NULL checking:
If (!vdev->ctx[vector].trigger)


> +		vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "vfio-msi%s[%d](%s)",
> +						   msix ? "x" : "", vector,
> +						   pci_name(pdev));
> +		if (!vdev->ctx[vector].name) {
> +			eventfd_ctx_put(trigger);
> +			return -ENOMEM;
> +		}
>  
> -	trigger = eventfd_ctx_fdget(fd);
> -	if (IS_ERR(trigger)) {
> -		kfree(vdev->ctx[vector].name);
> -		return PTR_ERR(trigger);
> -	}
> +		/*
> +		 * The MSIx vector table resides in device memory which may be cleared
> +		 * via backdoor resets. We don't allow direct access to the vector
> +		 * table so even if a userspace driver attempts to save/restore around
> +		 * such a reset it would be unsuccessful. To avoid this, restore the
> +		 * cached value of the message prior to enabling.
> +		 */
> +		if (msix) {
> +			struct msi_msg msg;
>  
> -	/*
> -	 * The MSIx vector table resides in device memory which may be cleared
> -	 * via backdoor resets. We don't allow direct access to the vector
> -	 * table so even if a userspace driver attempts to save/restore around
> -	 * such a reset it would be unsuccessful. To avoid this, restore the
> -	 * cached value of the message prior to enabling.
> -	 */
> -	if (msix) {
> -		struct msi_msg msg;
> +			get_cached_msi_msg(irq, &msg);
> +			pci_write_msi_msg(irq, &msg);
> +		}
>  
> -		get_cached_msi_msg(irq, &msg);
> -		pci_write_msi_msg(irq, &msg);
> -	}
> +		ret = request_irq(irq, vfio_msihandler, 0,
> +				  vdev->ctx[vector].name, trigger);
> +		if (ret) {
> +			kfree(vdev->ctx[vector].name);
> +			eventfd_ctx_put(trigger);
> +			return ret;
> +		}
>  
> -	ret = request_irq(irq, vfio_msihandler, 0,
> -			  vdev->ctx[vector].name, trigger);
> -	if (ret) {
> -		kfree(vdev->ctx[vector].name);
> -		eventfd_ctx_put(trigger);
> -		return ret;
> +		vdev->ctx[vector].producer.token = trigger;
> +		vdev->ctx[vector].producer.irq = irq;
> +		vdev->ctx[vector].trigger = trigger;
>  	}
>  
> -	vdev->ctx[vector].producer.token = trigger;
> -	vdev->ctx[vector].producer.irq = irq;
> +	/* always update irte for posted mode */
>  	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
>  	if (unlikely(ret))
>  		dev_info(&pdev->dev,
>  		"irq bypass producer (token %p) registration fails: %d\n",
>  		vdev->ctx[vector].producer.token, ret);
>  
> -	vdev->ctx[vector].trigger = trigger;
> -
>  	return 0;
>  }
>  
> 

