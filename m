Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415A8D6542
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfJNOdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 10:33:46 -0400
Received: from foss.arm.com ([217.140.110.172]:45792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731121AbfJNOdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:33:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078EC337;
        Mon, 14 Oct 2019 07:33:45 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0E113F68E;
        Mon, 14 Oct 2019 07:33:43 -0700 (PDT)
Subject: Re: [PATCH] kernel: dma: Make CMA boot parameters __ro_after_init
To:     Shyam Saini <mayhs11saini@gmail.com>,
        kernel-hardening@lists.openwall.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Christopher Lameter <cl@linux.com>,
        Christoph Hellwig <hch@lst.de>
References: <20191012122918.8066-1-mayhs11saini@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <95842b81-c751-abed-dd3f-258b9fd70393@arm.com>
Date:   Mon, 14 Oct 2019 15:33:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191012122918.8066-1-mayhs11saini@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2019 13:29, Shyam Saini wrote:
> This parameters are not changed after early boot.
> By making them __ro_after_init will reduce any attack surface in the
> kernel.

At a glance, it looks like these are only referenced by a couple of 
__init functions, so couldn't they just be __initdata/__initconst?

Robin.

> Link: https://lwn.net/Articles/676145/
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
> ---
>   kernel/dma/contiguous.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 69cfb4345388..1b689b1303cd 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -42,10 +42,10 @@ struct cma *dma_contiguous_default_area;
>    * Users, who want to set the size of global CMA area for their system
>    * should use cma= kernel parameter.
>    */
> -static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> -static phys_addr_t size_cmdline = -1;
> -static phys_addr_t base_cmdline;
> -static phys_addr_t limit_cmdline;
> +static const phys_addr_t __ro_after_init size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> +static phys_addr_t __ro_after_init size_cmdline = -1;
> +static phys_addr_t __ro_after_init base_cmdline;
> +static phys_addr_t __ro_after_init limit_cmdline;
>   
>   static int __init early_cma(char *p)
>   {
> 
