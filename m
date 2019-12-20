Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B3E127930
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfLTKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 05:19:29 -0500
Received: from ns.iliad.fr ([212.27.33.1]:48074 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfLTKT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:19:29 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1F5352061F;
        Fri, 20 Dec 2019 11:19:28 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id EEA5F20348;
        Fri, 20 Dec 2019 11:19:27 +0100 (CET)
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
Message-ID: <bf020a68-00fd-2bb7-c3b6-00f5befa293a@free.fr>
Date:   Fri, 20 Dec 2019 11:19:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Fri Dec 20 11:19:28 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2019 16:30, Marc Gonzalez wrote:

> Commit a66d972465d15 ("devres: Align data[] to ARCH_KMALLOC_MINALIGN")
> increased the alignment of devres.data unconditionally.
> 
> Some platforms have very strict alignment requirements for DMA-safe
> addresses, e.g. 128 bytes on arm64. There, struct devres amounts to:
> 	3 pointers + pad_to_128 + data + pad_to_256
> i.e. ~220 bytes of padding.
> 
> Let's enforce the alignment only for devm_kmalloc().
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> I had not been aware that dynamic allocation granularity on arm64 was
> 128 bytes. This means there's a lot of waste on small allocations.
> I suppose there's no easy solution, though.
> ---
>  drivers/base/devres.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index 0bbb328bd17f..bf39188613d9 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -26,14 +26,7 @@ struct devres_node {
>  
>  struct devres {
>  	struct devres_node		node;
> -	/*
> -	 * Some archs want to perform DMA into kmalloc caches
> -	 * and need a guaranteed alignment larger than
> -	 * the alignment of a 64-bit integer.
> -	 * Thus we use ARCH_KMALLOC_MINALIGN here and get exactly the same
> -	 * buffer alignment as if it was allocated by plain kmalloc().
> -	 */
> -	u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
> +	u8				data[];
>  };
>  
>  struct devres_group {
> @@ -789,9 +782,16 @@ static void devm_kmalloc_release(struct device *dev, void *res)
>  	/* noop */
>  }
>  
> +#define DEVM_KMALLOC_PADDING_SIZE \
> +	(ARCH_KMALLOC_MINALIGN - sizeof(struct devres) % ARCH_KMALLOC_MINALIGN)
> +
>  static int devm_kmalloc_match(struct device *dev, void *res, void *data)
>  {
> -	return res == data;
> +	/*
> +	 * 'res' is dr->data (not DMA-safe)
> +	 * 'data' is the hand-aligned address from devm_kmalloc
> +	 */
> +	return res + DEVM_KMALLOC_PADDING_SIZE == data;
>  }
>  
>  /**
> @@ -811,6 +811,9 @@ void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
>  {
>  	struct devres *dr;
>  
> +	/* Add enough padding to provide a DMA-safe address */
> +	size += DEVM_KMALLOC_PADDING_SIZE;
> +
>  	/* use raw alloc_dr for kmalloc caller tracing */
>  	dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
>  	if (unlikely(!dr))
> @@ -822,7 +825,7 @@ void * devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
>  	 */
>  	set_node_dbginfo(&dr->node, "devm_kzalloc_release", size);
>  	devres_add(dev, dr->data);
> -	return dr->data;
> +	return dr->data + DEVM_KMALLOC_PADDING_SIZE;
>  }
>  EXPORT_SYMBOL_GPL(devm_kmalloc);

Would anyone else have any suggestions, comments, insights, recommendations,
improvements, guidance, or wisdom? :-)

I keep thinking about the memory waste caused by the strict alignment requirement
on arm64. Is there a way to inspect how much memory has been requested vs how much
has been allocated? (Turning on SLAB DEBUG perhaps?)

Couldn't there be a kmalloc flag saying "this alloc will not require strict
alignment, so just give me something 8-byte aligned" ?

Regards.
