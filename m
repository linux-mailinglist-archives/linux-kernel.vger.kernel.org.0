Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C3103CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfKTOCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:02:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfKTOCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:02:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADDEE2235D;
        Wed, 20 Nov 2019 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574258534;
        bh=jfz7QwK1/Lbu7Y8QvbmT43l6h208/pDDBUvroUJR59A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWxURQera4DoHBCY2JpT7xtu3u6iqH4TRSUGv8GlKCeRWIDmS+FtWsBylVOFNcuFC
         oN5pgVWzzI/bVLIu1bNkXccHEwA9Ihcj7JFk1z4tpOQ5cAh72DeM8kmRBiXZ36sEs9
         10rf73NPkX6sE+J9lVOMDSr3gOC6Gx3T5l+rujfA=
Date:   Wed, 20 Nov 2019 15:02:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/2] firmware: google: Expose CBMEM over sysfs
Message-ID: <20191120140211.GA2935300@kroah.com>
References: <20191120133958.13160-1-patrick.rudolph@9elements.com>
 <20191120133958.13160-2-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133958.13160-2-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 02:39:46PM +0100, patrick.rudolph@9elements.com wrote:
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

Ick, you just raced userspace and lost :(

Please set the default group for the driver (dev_groups), so that the
driver core will correctly create and remove this group without you
having to do anything.

thanks,

greg k-h
