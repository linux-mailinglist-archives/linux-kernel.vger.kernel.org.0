Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5B2862F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfEWS46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 14:56:58 -0400
Received: from foss.arm.com ([217.140.101.70]:52854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbfEWS46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:56:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4AA1A78;
        Thu, 23 May 2019 11:56:57 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07D6E3F5AF;
        Thu, 23 May 2019 11:56:55 -0700 (PDT)
Subject: Re: [PATCH 3/4] iommu: Introduce device fault report API
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        joro@8bytes.org, alex.williamson@redhat.com
Cc:     yi.l.liu@linux.intel.com, ashok.raj@intel.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20190523180613.55049-1-jean-philippe.brucker@arm.com>
 <20190523180613.55049-4-jean-philippe.brucker@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e56244fd-86fd-1fc9-17f7-d00179d586ac@arm.com>
Date:   Thu, 23 May 2019 19:56:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523180613.55049-4-jean-philippe.brucker@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2019 19:06, Jean-Philippe Brucker wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> Traditionally, device specific faults are detected and handled within
> their own device drivers. When IOMMU is enabled, faults such as DMA
> related transactions are detected by IOMMU. There is no generic
> reporting mechanism to report faults back to the in-kernel device
> driver or the guest OS in case of assigned devices.
> 
> This patch introduces a registration API for device specific fault
> handlers. This differs from the existing iommu_set_fault_handler/
> report_iommu_fault infrastructures in several ways:
> - it allows to report more sophisticated fault events (both
>    unrecoverable faults and page request faults) due to the nature
>    of the iommu_fault struct
> - it is device specific and not domain specific.
> 
> The current iommu_report_device_fault() implementation only handles
> the "shoot and forget" unrecoverable fault case. Handling of page
> request faults or stalled faults will come later.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   drivers/iommu/iommu.c | 127 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/iommu.h |  29 ++++++++++
>   2 files changed, 156 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 67ee6623f9b2..d546f7baa0d4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -644,6 +644,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   		goto err_free_name;
>   	}
>   
> +	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param), GFP_KERNEL);
> +	if (!dev->iommu_param) {
> +		ret = -ENOMEM;
> +		goto err_free_name;
> +	}
> +	mutex_init(&dev->iommu_param->lock);
> +

Note that this gets a bit tricky when we come to move to move the 
fwspec/ops/etc. into iommu_param, since that data can have a longer 
lifespan than the group association. I'd suggest moving this management 
out to the iommu_{probe,release}_device() level from the start, but 
maybe we're happy to come back and change things later as necessary.

Robin.

>   	kobject_get(group->devices_kobj);
>   
>   	dev->iommu_group = group;
> @@ -674,6 +681,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   	mutex_unlock(&group->mutex);
>   	dev->iommu_group = NULL;
>   	kobject_put(group->devices_kobj);
> +	kfree(dev->iommu_param);
> +	dev->iommu_param = NULL;
>   err_free_name:
>   	kfree(device->name);
>   err_remove_link:
> @@ -721,6 +730,8 @@ void iommu_group_remove_device(struct device *dev)
>   
>   	trace_remove_device_from_group(group->id, dev);
>   
> +	kfree(dev->iommu_param);
> +	dev->iommu_param = NULL;
>   	kfree(device->name);
>   	kfree(device);
>   	dev->iommu_group = NULL;
> @@ -854,6 +865,122 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>   
> +/**
> + * iommu_register_device_fault_handler() - Register a device fault handler
> + * @dev: the device
> + * @handler: the fault handler
> + * @data: private data passed as argument to the handler
> + *
> + * When an IOMMU fault event is received, this handler gets called with the
> + * fault event and data as argument. The handler should return 0 on success.
> + *
> + * Return 0 if the fault handler was installed successfully, or an error.
> + */
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	int ret = 0;
> +
> +	/*
> +	 * Device iommu_param should have been allocated when device is
> +	 * added to its iommu_group.
> +	 */
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);
> +	/* Only allow one fault handler registered for each device */
> +	if (param->fault_param) {
> +		ret = -EBUSY;
> +		goto done_unlock;
> +	}
> +
> +	get_device(dev);
> +	param->fault_param =
> +		kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
> +	if (!param->fault_param) {
> +		put_device(dev);
> +		ret = -ENOMEM;
> +		goto done_unlock;
> +	}
> +	param->fault_param->handler = handler;
> +	param->fault_param->data = data;
> +
> +done_unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
> +
> +/**
> + * iommu_unregister_device_fault_handler() - Unregister the device fault handler
> + * @dev: the device
> + *
> + * Remove the device fault handler installed with
> + * iommu_register_device_fault_handler().
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	int ret = 0;
> +
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);
> +
> +	if (!param->fault_param)
> +		goto unlock;
> +
> +	kfree(param->fault_param);
> +	param->fault_param = NULL;
> +	put_device(dev);
> +unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
> +
> +/**
> + * iommu_report_device_fault() - Report fault event to device driver
> + * @dev: the device
> + * @evt: fault event data
> + *
> + * Called by IOMMU drivers when a fault is detected, typically in a threaded IRQ
> + * handler.
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	struct iommu_fault_param *fparam;
> +	int ret = 0;
> +
> +	/* iommu_param is allocated when device is added to group */
> +	if (!param || !evt)
> +		return -EINVAL;
> +
> +	/* we only report device fault if there is a handler registered */
> +	mutex_lock(&param->lock);
> +	fparam = param->fault_param;
> +	if (!fparam || !fparam->handler) {
> +		ret = -EINVAL;
> +		goto done_unlock;
> +	}
> +	ret = fparam->handler(evt, fparam->data);
> +done_unlock:
> +	mutex_unlock(&param->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_report_device_fault);
> +
>   /**
>    * iommu_group_id - Return ID for a group
>    * @group: the group to ID
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d442f5f3fa93..f95e376a7ed3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -340,6 +340,7 @@ struct iommu_fault_param {
>    *	struct iommu_fwspec	*iommu_fwspec;
>    */
>   struct iommu_param {
> +	struct mutex lock;
>   	struct iommu_fault_param *fault_param;
>   };
>   
> @@ -432,6 +433,15 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
>   					 struct notifier_block *nb);
>   extern int iommu_group_unregister_notifier(struct iommu_group *group,
>   					   struct notifier_block *nb);
> +extern int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data);
> +
> +extern int iommu_unregister_device_fault_handler(struct device *dev);
> +
> +extern int iommu_report_device_fault(struct device *dev,
> +				     struct iommu_fault_event *evt);
> +
>   extern int iommu_group_id(struct iommu_group *group);
>   extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>   extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
> @@ -740,6 +750,25 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
>   	return 0;
>   }
>   
> +static inline
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static inline
> +int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
> +{
> +	return -ENODEV;
> +}
> +
>   static inline int iommu_group_id(struct iommu_group *group)
>   {
>   	return -ENODEV;
> 
