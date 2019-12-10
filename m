Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119B4118037
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 07:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfLJGL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 01:11:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:58028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfLJGL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 01:11:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56FF1B311;
        Tue, 10 Dec 2019 06:11:53 +0000 (UTC)
Subject: Re: [PATCH v4 1/2] xenbus/backend: Add memory pressure handler
 callback
To:     SeongJae Park <sjpark@amazon.com>
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, roger.pau@citrix.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, SeongJae Park <sjpark@amazon.de>
References: <20191209194305.20828-1-sjpark@amazon.com>
 <20191209194305.20828-2-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <2aca11d5-38ba-e924-c38e-e48c52c915c6@suse.com>
Date:   Tue, 10 Dec 2019 07:11:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209194305.20828-2-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.19 20:43, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Granting pages consumes backend system memory.  In systems configured
> with insufficient spare memory for those pages, it can cause a memory
> pressure situation.  However, finding the optimal amount of the spare
> memory is challenging for large systems having dynamic resource
> utilization patterns.  Also, such a static configuration might lacks a
> flexibility.
> 
> To mitigate such problems, this commit adds a memory reclaim callback to
> 'xenbus_driver'.  Using this facility, 'xenbus' would be able to monitor
> a memory pressure and request specific domains of specific backend
> drivers which causing the given pressure to voluntarily release its
> memory.
> 
> That said, this commit simply requests every callback registered driver
> to release its memory for every domain, rather than issueing the
> requests to the drivers and domain in charge.  Such things would be a
> future work.  Also, this commit focuses on memory only.  However, it
> would be ablt to be extended for general resources.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>   drivers/xen/xenbus/xenbus_probe_backend.c | 31 +++++++++++++++++++++++
>   include/xen/xenbus.h                      |  1 +
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> index b0bed4faf44c..cd5fd1cd8de3 100644
> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> @@ -248,6 +248,34 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
>   	return NOTIFY_DONE;
>   }
>   
> +static int xenbus_backend_reclaim(struct device *dev, void *data)
> +{
> +	struct xenbus_driver *drv;
> +	if (!dev->driver)
> +		return -ENOENT;
> +	drv = to_xenbus_driver(dev->driver);
> +	if (drv && drv->reclaim)
> +		drv->reclaim(to_xenbus_device(dev), DOMID_INVALID);
> +	return 0;
> +}
> +
> +/*
> + * Returns 0 always because we are using shrinker to only detect memory
> + * pressure.
> + */
> +static unsigned long xenbus_backend_shrink_count(struct shrinker *shrinker,
> +				struct shrink_control *sc)
> +{
> +	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL,
> +			xenbus_backend_reclaim);
> +	return 0;
> +}
> +
> +static struct shrinker xenbus_backend_shrinker = {
> +	.count_objects = xenbus_backend_shrink_count,
> +	.seeks = DEFAULT_SEEKS,
> +};
> +
>   static int __init xenbus_probe_backend_init(void)
>   {
>   	static struct notifier_block xenstore_notifier = {
> @@ -264,6 +292,9 @@ static int __init xenbus_probe_backend_init(void)
>   
>   	register_xenstore_notifier(&xenstore_notifier);
>   
> +	if (register_shrinker(&xenbus_backend_shrinker))
> +		pr_warn("shrinker registration failed\n");
> +
>   	return 0;
>   }
>   subsys_initcall(xenbus_probe_backend_init);
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index 869c816d5f8c..52aaf4f78400 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -104,6 +104,7 @@ struct xenbus_driver {
>   	struct device_driver driver;
>   	int (*read_otherend_details)(struct xenbus_device *dev);
>   	int (*is_ready)(struct xenbus_device *dev);
> +	unsigned (*reclaim)(struct xenbus_device *dev, domid_t domid);

Can you please add a comment here regarding semantics of specifying
DOMID_INVALID as domid?

Block maintainers, would you be fine with me carrying this series
through the Xen tree?


Juergen
