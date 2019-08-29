Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372C8A2A33
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 00:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfH2WsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 18:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbfH2WsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:48:02 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC0992173E;
        Thu, 29 Aug 2019 22:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567118881;
        bh=AF7KaaN0SPHZVCzMo4I0QlziT4Dc084NALpVNTE66xw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=iThSoqqrWY1rBHxgi2xpVYpYO5u/qkuBWYnStULaaLWA7uxqFPq1k2ifNvRpQjCsx
         oSUbcFoQVW+Q2dWM8uumjkvHntXywq9XuABVd8lVFeKIULhiYmtzH1Oa21ErYKv5Q2
         UmYWrhepeTu37larup9+65efIBZ3rbyjcLiAAXV4=
Date:   Thu, 29 Aug 2019 15:48:00 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@lst.de>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] swiotlb-xen: remove page-coherent.h
In-Reply-To: <20190826121944.515-10-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281526280.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-10-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> The only thing left of page-coherent.h is two functions implemented by
> the architecture for non-coherent DMA support that are never called for
> fully coherent architectures.  Just move the prototypes for those to
> swiotlb-xen.h instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm/include/asm/xen/page-coherent.h   |  2 --
>  arch/arm64/include/asm/xen/page-coherent.h |  2 --
>  arch/x86/include/asm/xen/page-coherent.h   | 11 -----------
>  drivers/xen/swiotlb-xen.c                  |  3 ---
>  include/Kbuild                             |  1 -
>  include/xen/arm/page-coherent.h            | 10 ----------
>  include/xen/swiotlb-xen.h                  |  6 ++++++
>  7 files changed, 6 insertions(+), 29 deletions(-)
>  delete mode 100644 arch/arm/include/asm/xen/page-coherent.h
>  delete mode 100644 arch/arm64/include/asm/xen/page-coherent.h
>  delete mode 100644 arch/x86/include/asm/xen/page-coherent.h
>  delete mode 100644 include/xen/arm/page-coherent.h
> 
> diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
> deleted file mode 100644
> index 27e984977402..000000000000
> --- a/arch/arm/include/asm/xen/page-coherent.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <xen/arm/page-coherent.h>
> diff --git a/arch/arm64/include/asm/xen/page-coherent.h b/arch/arm64/include/asm/xen/page-coherent.h
> deleted file mode 100644
> index 27e984977402..000000000000
> --- a/arch/arm64/include/asm/xen/page-coherent.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <xen/arm/page-coherent.h>
> diff --git a/arch/x86/include/asm/xen/page-coherent.h b/arch/x86/include/asm/xen/page-coherent.h
> deleted file mode 100644
> index c9c8398a31ff..000000000000
> --- a/arch/x86/include/asm/xen/page-coherent.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_X86_XEN_PAGE_COHERENT_H
> -#define _ASM_X86_XEN_PAGE_COHERENT_H
> -
> -static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
> -
> -static inline void xen_dma_sync_single_for_device(struct device *hwdev,
> -		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
> -
> -#endif /* _ASM_X86_XEN_PAGE_COHERENT_H */
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index a642e284f1e2..95911ff9c11c 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -35,9 +35,6 @@
>  #include <xen/xen-ops.h>
>  #include <xen/hvc-console.h>
>  
> -#include <asm/dma-mapping.h>
> -#include <asm/xen/page-coherent.h>
> -
>  #include <trace/events/swiotlb.h>
>  /*
>   * Used to do a quick range check in swiotlb_tbl_unmap_single and
> diff --git a/include/Kbuild b/include/Kbuild
> index c38f0d46b267..cce5cf6abf89 100644
> --- a/include/Kbuild
> +++ b/include/Kbuild
> @@ -1189,7 +1189,6 @@ header-test-			+= video/vga.h
>  header-test-			+= video/w100fb.h
>  header-test-			+= xen/acpi.h
>  header-test-			+= xen/arm/hypercall.h
> -header-test-			+= xen/arm/page-coherent.h
>  header-test-			+= xen/arm/page.h
>  header-test-			+= xen/balloon.h
>  header-test-			+= xen/events.h
> diff --git a/include/xen/arm/page-coherent.h b/include/xen/arm/page-coherent.h
> deleted file mode 100644
> index 635492d41ebe..000000000000
> --- a/include/xen/arm/page-coherent.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _XEN_ARM_PAGE_COHERENT_H
> -#define _XEN_ARM_PAGE_COHERENT_H
> -
> -void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
> -		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
> -void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
> -		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
> -
> -#endif /* _XEN_ARM_PAGE_COHERENT_H */
> diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
> index 5e4b83f83dbc..a7c642872568 100644
> --- a/include/xen/swiotlb-xen.h
> +++ b/include/xen/swiotlb-xen.h
> @@ -2,8 +2,14 @@
>  #ifndef __LINUX_SWIOTLB_XEN_H
>  #define __LINUX_SWIOTLB_XEN_H
>  
> +#include <linux/dma-mapping.h>
>  #include <linux/swiotlb.h>
>  
> +void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
> +		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
> +void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
> +		phys_addr_t paddr, size_t size, enum dma_data_direction dir);
> +
>  extern int xen_swiotlb_init(int verbose, bool early);
>  extern const struct dma_map_ops xen_swiotlb_dma_ops;
>  
> -- 
> 2.20.1
> 
