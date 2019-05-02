Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62643120ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 19:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEBRUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 13:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfEBRUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:20:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A27620652;
        Thu,  2 May 2019 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556817612;
        bh=DNZEf28z285Xq5SbA4zrCjNHhVWVAuEwgjHxbQTOb+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iian5KzlS2pBwfqDAikYfYBebvSvWKxBKu8BJubTVMZLohGeorJoJD9VUpwCSrZ9D
         Nx0Mf5EhWuNsAAal7Rauj7ASlRTzo/vNxYB0OS2eSFsUePaTK6HcItGZ8pcduauqAj
         fViH4iah220qpQmoh5q8iWy7/5cVYk37cnVz4CLk=
Date:   Thu, 2 May 2019 19:20:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V3 02/12] misc: xilinx-sdfec: add core driver
Message-ID: <20190502172007.GA1874@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-3-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556402706-176271-3-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 11:04:56PM +0100, Dragan Cvetic wrote:
> +#define DRIVER_NAME "xilinx_sdfec"
> +#define DRIVER_VERSION "0.3"

Version means nothing with the driver in the kernel tree, please remove
it.

> +#define DRIVER_MAX_DEV BIT(MINORBITS)

Why this number?  Why limit yourself to any number?

> +
> +static struct class *xsdfec_class;

Do you really need your own class?

> +static atomic_t xsdfec_ndevs = ATOMIC_INIT(0);

Why?

> +static dev_t xsdfec_devt;

Why?

Why not use misc_device for this?  Why do you need your own major with a
bunch of minor devices reserved ahead of time?  Why not just create a
new misc device for every individual device that happens to be found in
the system?  That will make the code a lot simpler and smaller and
easier.



> +
> +/**
> + * struct xsdfec_dev - Driver data for SDFEC
> + * @regs: device physical base address
> + * @dev: pointer to device struct
> + * @config: Configuration of the SDFEC device
> + * @open_count: Count of char device being opened
> + * @xsdfec_cdev: Character device handle
> + * @irq_lock: Driver spinlock
> + *
> + * This structure contains necessary state for SDFEC driver to operate
> + */
> +struct xsdfec_dev {
> +	void __iomem *regs;
> +	struct device *dev;
> +	struct xsdfec_config config;
> +	atomic_t open_count;
> +	struct cdev xsdfec_cdev;
> +	/* Spinlock to protect state_updated and stats_updated */
> +	spinlock_t irq_lock;
> +};
> +
> +static const struct file_operations xsdfec_fops = {
> +	.owner = THIS_MODULE,
> +};

No operations at all?  That's an easy driver :)

thanks,

greg k-h
