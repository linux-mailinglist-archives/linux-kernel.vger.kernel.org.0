Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8D5FEC7A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 14:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfKPNkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 08:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfKPNkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 08:40:04 -0500
Received: from localhost (unknown [84.241.192.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 864CE206D4;
        Sat, 16 Nov 2019 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573911604;
        bh=qEu1+/Og3OBtKVbdJFE+PQGreGDYeq5DFHD43HsDEn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJ+dSToqiKaeu8Dz3e383PGP1WmAXi10JYYiR+GO2obTqyw4VFaGcu1R61I1E2VF6
         lzFQfb3o+VPhUQzZwFuoAoBbz7Ey0A4QDQ4GoWqWZKWHZ8nSF+ggTWkZ0G4HZMwugK
         yDNZFkp3Bg/W2lXVY9s8YYpZk0Ymm9RoM5NsV440=
Date:   Sat, 16 Nov 2019 14:40:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     patrick.rudolph@9elements.com
Cc:     linux-kernel@vger.kernel.org, coreboot@coreboot.org,
        Arthur Heymans <arthur@aheymans.xyz>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>
Subject: Re: [PATCH 2/3] firmware: google: Unregister driver_info on failure
 and exit in gsmi
Message-ID: <20191116134001.GE454551@kroah.com>
References: <20191115134842.17013-1-patrick.rudolph@9elements.com>
 <20191115134842.17013-3-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115134842.17013-3-patrick.rudolph@9elements.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 02:48:38PM +0100, patrick.rudolph@9elements.com wrote:
> From: Arthur Heymans <arthur@aheymans.xyz>
> 
> Fix a bug where the kernel module couldn't be loaded after unloading,
> as the platform driver wasn't released on exit.
> 
> Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
> ---
>  drivers/firmware/google/gsmi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> index edaa4e5d84ad..974c769b75cf 100644
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -1016,6 +1016,9 @@ static __init int gsmi_init(void)
>  	dma_pool_destroy(gsmi_dev.dma_pool);
>  	platform_device_unregister(gsmi_dev.pdev);
>  	pr_info("gsmi: failed to load: %d\n", ret);
> +#ifdef CONFIG_PM
> +	platform_driver_unregister(&gsmi_driver_info);
> +#endif
>  	return ret;
>  }
>  
> @@ -1037,6 +1040,9 @@ static void __exit gsmi_exit(void)
>  	gsmi_buf_free(gsmi_dev.name_buf);
>  	dma_pool_destroy(gsmi_dev.dma_pool);
>  	platform_device_unregister(gsmi_dev.pdev);
> +#ifdef CONFIG_PM
> +	platform_driver_unregister(&gsmi_driver_info);

Why the #ifdef here?  Why does PM change things?

#ifdefs in .c code is really frowned on.

thanks,

greg k-h
