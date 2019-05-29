Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 887272DAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 12:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfE2Kij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 06:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2Kij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:38:39 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EDD20B1F;
        Wed, 29 May 2019 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559126318;
        bh=E8S0Wx8LXthPWIflHl9Vf3EAlPewm28ZDi1OcJYzkKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odEt1PJiUL7viKAVwhRWwXP0MTOe0e5SnIliDQDgd9VFr32ioKFQQL3jZZ5JUSCjz
         nnxLQAgxLP+LzPzea28YqL6pGQ8cvQs2EmzyLR4Mej95fP325b8hr5631XHim0C0nb
         JbyCCZTI71TLUZM3Mc7mmmDsDYIW5q9uoQu5M3d8=
Date:   Wed, 29 May 2019 03:38:38 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     laurentiu.tudor@nxp.com
Cc:     hch@lst.de, stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 2/5] USB: use genalloc for USB HCs with local memory
Message-ID: <20190529103838.GC7383@kroah.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-3-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529102843.13174-3-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:28:40PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> For HCs that have local memory, replace the current DMA API usage
> with a genalloc generic allocator to manage the mappings for these
> devices. To help users, introduce a new HCD API,
> usb_hcd_setup_local_mem() that will setup up the genalloc backing
> up the device local memory. It will be used in subsequent patches.
> This is in preparation for dropping the existing "coherent" dma
> mem declaration APIs. Current implementation was relying on a short
> circuit in the DMA API that in the end, was acting as an allocator
> for these type of devices.
> For sh arch to compile GENERIC_ALLOCATOR needs to be selected in
> Kconfig.
> 
> For context, see thread here: https://lkml.org/lkml/2019/4/22/357
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> Tested-by: Fredrik Noring <noring@nocrew.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/usb/Kconfig         |  1 +
>  drivers/usb/core/buffer.c   |  9 +++++++++
>  drivers/usb/core/hcd.c      | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/ohci-hcd.c | 23 ++++++++++++++++++-----
>  drivers/usb/host/ohci-mem.c | 35 +++++++++++++++++++++++++++++++----
>  drivers/usb/host/ohci.h     |  2 ++
>  include/linux/usb/hcd.h     |  5 +++++
>  7 files changed, 102 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index e4b27413f528..389c57d8eba7 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -45,6 +45,7 @@ config USB_ARCH_HAS_HCD
>  config USB
>  	tristate "Support for Host-side USB"
>  	depends on USB_ARCH_HAS_HCD
> +	select GENERIC_ALLOCATOR

Are there any arches that does not have GENERIC_ALLOCATOR?  I don't want
to suddenly cut off a bunch of working systems from having USB support.

thanks,

greg k-h
