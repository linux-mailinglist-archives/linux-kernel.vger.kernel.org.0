Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A7189CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgCRNWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 09:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbgCRNWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:22:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00DA32076F;
        Wed, 18 Mar 2020 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584537763;
        bh=CKEreA8CUxYmEbiSZgNzqX5KgmCpM63Ng+o18LXBl38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JorCG4C+ZGySiVuSu/z2+zdsj8FFbdzJ/Mp1MEZsbo/dyOHhwA/+Mw/1buc1hJZkx
         lOo2bzLYuiL6RFah4WngRMZW5fEq0OyfOlc8GblgkDZG5603FFUj+eWm4DEUKSAsZi
         joOSh8U3p8fA7Jx9In9dBPuZhzY5YPFNM1LDPeWI=
Date:   Wed, 18 Mar 2020 14:22:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] coresight: cti: Initial CoreSight CTI Driver
Message-ID: <20200318132241.GB2789508@kroah.com>
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
 <20200309161748.31975-2-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309161748.31975-2-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:17:36AM -0600, Mathieu Poirier wrote:
> From: Mike Leach <mike.leach@linaro.org>
> 
> This introduces a baseline CTI driver and associated configuration files.
> 
> Uses the platform agnostic naming standard for CoreSight devices, along
> with a generic platform probing method that currently supports device
> tree descriptions, but allows for the ACPI bindings to be added once these
> have been defined for the CTI devices.
> 
> Driver will probe for the device on the AMBA bus, and load the CTI driver
> on CoreSight ID match to CTI IDs in tables.
> 
> Initial sysfs support for enable / disable provided.
> 
> Default CTI interconnection data is generated based on hardware
> register signal counts, with no additional connection information.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

You didn't cc: all of them to get review comments?  I've added it
above...

And signed-off-by implies reviewed-by.

> +/* basic attributes */
> +static ssize_t enable_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	int enable_req;
> +	bool enabled, powered;
> +	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	ssize_t size = 0;
> +
> +	enable_req = atomic_read(&drvdata->config.enable_req_count);
> +	spin_lock(&drvdata->spinlock);
> +	powered = drvdata->config.hw_powered;
> +	enabled = drvdata->config.hw_enabled;
> +	spin_unlock(&drvdata->spinlock);
> +
> +	if (powered) {
> +		size = scnprintf(buf, PAGE_SIZE, "cti %s; powered;\n",
> +				 enabled ? "enabled" : "disabled");
> +	} else {
> +		size = scnprintf(buf, PAGE_SIZE, "cti %s; unpowered;\n",
> +				 enable_req ? "enable req" : "disabled");

sysfs files should never need scnprintf() as you "know" a single value
will fit into a PAGE_SIZE.

And shouldn't this just be a single value, this looks like it is 2
values in one line, that then needs to be parsed, is that to be
expected?

Where is the documentation for this new sysfs file?

> +const struct attribute_group *coresight_cti_groups[] = {
> +	&coresight_cti_group,
> +	NULL,
> +};

ATTRIBUTE_GROUPS()?

> +static struct amba_driver cti_driver = {
> +	.drv = {
> +		.name	= "coresight-cti",
> +		.owner = THIS_MODULE,

Aren't amba drivers smart enough to set this properly on their own?
{sigh}

greg k-h
