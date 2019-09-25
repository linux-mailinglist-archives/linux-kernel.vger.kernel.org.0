Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DC6BD779
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 06:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfIYEnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 00:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbfIYEnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:43:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2FD820665;
        Wed, 25 Sep 2019 04:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569386591;
        bh=FPVmGPrYYDxTgtdfOX0PBlOpovVgOyA6Wv0QHZ2LQCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AToNlkIjelKwVWSqOH35u56iky0Z6S9mEKdcJHHdVRQAjFKaO2NGd8xNXCAWhm+0u
         /dO/iFbMspl59BL4EAOF5DCEjnC6gNVRQapjOhRPgjsXRhxbP5v8dPqAwqFfv8v3d4
         8/6t1Waa6H29cEMVtN4k1i/U6ijDqHL2SYAMK4PY=
Date:   Wed, 25 Sep 2019 06:43:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Roman Kiryanov <rkir@google.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform: goldfish: Allow goldfish virtual platform
 drivers for RISCV
Message-ID: <20190925044308.GA1245729@kroah.com>
References: <20190925042912.119553-1-anup.patel@wdc.com>
 <20190925042912.119553-2-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925042912.119553-2-anup.patel@wdc.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:30:03AM +0000, Anup Patel wrote:
> We will be using some of the Goldfish virtual platform devices (such
> as RTC) on QEMU RISC-V virt machine so this patch enables goldfish
> kconfig option for RISC-V architecture.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/platform/goldfish/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
> index 77b35df3a801..0ba825030ffe 100644
> --- a/drivers/platform/goldfish/Kconfig
> +++ b/drivers/platform/goldfish/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig GOLDFISH
>  	bool "Platform support for Goldfish virtual devices"
> -	depends on X86_32 || X86_64 || ARM || ARM64 || MIPS
> +	depends on X86_32 || X86_64 || ARM || ARM64 || MIPS || RISCV

Why does this depend on any of these?  Can't we just have:

>  	depends on HAS_IOMEM

And that's it?

thanks,

greg k-h
