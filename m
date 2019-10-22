Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F33E059E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 15:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbfJVN5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 09:57:15 -0400
Received: from [217.140.110.172] ([217.140.110.172]:53394 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJVN5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:57:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCC1E1763;
        Tue, 22 Oct 2019 06:56:53 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A01083F71A;
        Tue, 22 Oct 2019 06:56:52 -0700 (PDT)
Subject: Re: [PATCH V2] kernel: dma: contigous: Make CMA parameters
 __initdata/__initconst
To:     Shyam Saini <mayhs11saini@gmail.com>,
        kernel-hardening@lists.openwall.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>
References: <20191020050322.2634-1-mayhs11saini@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1a358862-0c0c-e4c6-9dd7-f626c0a904b0@arm.com>
Date:   Tue, 22 Oct 2019 14:56:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191020050322.2634-1-mayhs11saini@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2019 06:03, Shyam Saini wrote:
> These parameters are only referenced by __init routine calls during early
> boot so they should be marked as __initdata and __initconst accordingly.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>
> ---
> V1->V2:
> 	mark cma parameters as __initdata/__initconst
> 	instead of __ro_after_init. As these parameters
> 	are only used by __init calls and never used afterwards
> 	which contrast the __ro_after_init usage.
> ---
>   kernel/dma/contiguous.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 69cfb4345388..10bfc8c44c54 100644
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
> +static const phys_addr_t size_bytes __initconst = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> +static phys_addr_t  size_cmdline __initdata = -1;
> +static phys_addr_t base_cmdline __initdata;
> +static phys_addr_t limit_cmdline __initdata;
>   
>   static int __init early_cma(char *p)
>   {
> 
