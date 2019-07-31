Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887217C6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGaPit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 11:38:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:56811 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfGaPit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:38:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 08:38:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,330,1559545200"; 
   d="scan'208";a="256181994"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2019 08:38:47 -0700
Subject: Re: [PATCH v2 01/10] driver core: add dev_groups to all drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
 <20190731124349.4474-2-gregkh@linuxfoundation.org>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <59887497-9d86-5c4d-40e3-1e5ac7c0a77a@linux.intel.com>
Date:   Wed, 31 Jul 2019 10:51:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731124349.4474-2-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

On 7/31/19 7:43 AM, Greg Kroah-Hartman wrote:
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Add the ability for the driver core to create and remove a list of
> attribute groups automatically when the device is bound/unbound from a
> specific driver.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: Richard Gong <richard.gong@linux.intel.com>

> ---
>   drivers/base/dd.c      | 14 ++++++++++++++
>   include/linux/device.h |  3 +++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 994a90747420..d811e60610d3 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -554,9 +554,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>   			goto probe_failed;
>   	}
>   
> +	if (device_add_groups(dev, drv->dev_groups)) {
> +		dev_err(dev, "device_add_groups() failed\n");
> +		goto dev_groups_failed;
> +	}
> +
>   	if (test_remove) {
>   		test_remove = false;
>   
> +		device_remove_groups(dev, drv->dev_groups);
> +
>   		if (dev->bus->remove)
>   			dev->bus->remove(dev);
>   		else if (drv->remove)
> @@ -584,6 +591,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>   		 drv->bus->name, __func__, dev_name(dev), drv->name);
>   	goto done;
>   
> +dev_groups_failed:
> +	if (dev->bus->remove)
> +		dev->bus->remove(dev);
> +	else if (drv->remove)
> +		drv->remove(dev);
>   probe_failed:
>   	if (dev->bus)
>   		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> @@ -1114,6 +1126,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>   
>   		pm_runtime_put_sync(dev);
>   
> +		device_remove_groups(dev, drv->dev_groups);
> +
>   		if (dev->bus && dev->bus->remove)
>   			dev->bus->remove(dev);
>   		else if (drv->remove)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index c330b75c6c57..98c00b71b598 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -262,6 +262,8 @@ enum probe_type {
>    * @resume:	Called to bring a device from sleep mode.
>    * @groups:	Default attributes that get created by the driver core
>    *		automatically.
> + * @dev_groups:	Additional attributes attached to device instance once the
> + *		it is bound to the driver.
>    * @pm:		Power management operations of the device which matched
>    *		this driver.
>    * @coredump:	Called when sysfs entry is written to. The device driver
> @@ -296,6 +298,7 @@ struct device_driver {
>   	int (*suspend) (struct device *dev, pm_message_t state);
>   	int (*resume) (struct device *dev);
>   	const struct attribute_group **groups;
> +	const struct attribute_group **dev_groups;
>   
>   	const struct dev_pm_ops *pm;
>   	void (*coredump) (struct device *dev);
> 

Regards,
Richard
