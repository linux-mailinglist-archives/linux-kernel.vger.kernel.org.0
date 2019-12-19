Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404951267E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 18:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLSRRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 12:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfLSRRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:17:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 967E824679;
        Thu, 19 Dec 2019 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576775828;
        bh=MzC3dLLt7wxhUDAIJyt8yIc7gxTOe+1dNpFUlIRQ9H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lT5qCXuwnJRyIN8zWcqKwZVkFnhboCavPIHO9Q8VxksUoUp/m8n2LclOLDgtITJiE
         E2ysJY6QQRQUyfluVszquWH7at0CuP/Y9HAwqD70oz9WyyDO7OBE/8TSdmce15D8Eg
         KgDyfRtCIhwc0BgFQH3Md8P/IfD5sgZur1IgiKk4=
Date:   Thu, 19 Dec 2019 18:17:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
Message-ID: <20191219171705.GA2092676@kroah.com>
References: <20191128125100.14291-1-patrick.rudolph@9elements.com>
 <20191128125100.14291-2-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128125100.14291-2-patrick.rudolph@9elements.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 01:50:50PM +0100, patrick.rudolph@9elements.com wrote:
> +static int cbmem_probe(struct coreboot_device *cdev)
> +{
> +	struct device *dev = &cdev->dev;
> +	struct cb_priv *priv;
> +	int err;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));
> +
> +	priv->remap = memremap(priv->entry.address,
> +			       priv->entry.entry_size, MEMREMAP_WB);
> +	if (!priv->remap) {
> +		err = -ENOMEM;
> +		goto failure;
> +	}
> +
> +	err = sysfs_create_group(&dev->kobj, &cb_mem_attr_group);

You just raced with userspace and lost :(

Set the driver's default attribute group up to point at
cb_mem_attr_group and the driver core will handle creating and removing
the group automatically for you correctly.

thanks,

greg k-h
