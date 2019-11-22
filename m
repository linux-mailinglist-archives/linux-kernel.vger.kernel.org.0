Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67B4107573
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 17:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfKVQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 11:09:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKVQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E8fZNk5GMi/4XEmun1xOwx3M/04axr0mW//Zh4kLYAg=; b=QYUK0Gul8xiB+05zNOo77mhQZ
        n6q9HCqPxquRQEiCfDZEQPrssz0+G+ULz8X5ryj7WT1Myd0cHuFQmH0F89fso3+jfuo4SWaHUdbrx
        +1b6haCmJVyE+j0XJs8PcVmF5YHtNalh3+tpdsTFzH2qUsKn+qWpqb1Vob943XVebTR+vd22y4q8A
        QWMUIwjmy474gBD4zUbM2292iSONAdkwfILU4FkiFPkzbcSVKQ8CqdsdaMZ25V8oiF5vCykVEQXno
        QnUJRwB3YX4o5ViWiNSRFD7iZPBVG/M8FITABF8cFG8tJrd3gO1g8xx8zhIbtnpLMDysi6Fwf/uMu
        iC2EkvuPw==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYBUk-0000Hn-O1; Fri, 22 Nov 2019 16:09:18 +0000
Subject: Re: [PATCH -next] staging: hp100: Fix build error without ETHERNET
To:     YueHaibing <yuehaibing@huawei.com>, gregkh@linuxfoundation.org,
        perex@perex.cz, davem@davemloft.net, joe@perches.com,
        tglx@linutronix.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20191113021306.35464-1-yuehaibing@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0b78573-48d4-d33e-8684-5a3c4d5e81a9@infradead.org>
Date:   Fri, 22 Nov 2019 08:09:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191113021306.35464-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 6:13 PM, YueHaibing wrote:
> It should depends on ETHERNET, otherwise building fails:
> 
> drivers/staging/hp/hp100.o: In function `hp100_pci_remove':
> hp100.c:(.text+0x165): undefined reference to `unregister_netdev'
> hp100.c:(.text+0x214): undefined reference to `free_netdev'
> 
> Fixes: 52340b82cf1a ("hp100: Move 100BaseVG AnyLAN driver to staging")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/staging/hp/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/hp/Kconfig b/drivers/staging/hp/Kconfig
> index fb395cf..f20ab21 100644
> --- a/drivers/staging/hp/Kconfig
> +++ b/drivers/staging/hp/Kconfig
> @@ -6,6 +6,7 @@
>  config NET_VENDOR_HP
>  	bool "HP devices"
>  	default y
> +	depends on ETHERNET
>  	depends on ISA || EISA || PCI
>  	---help---
>  	  If you have a network (Ethernet) card belonging to this class, say Y.
> 


-- 
~Randy

