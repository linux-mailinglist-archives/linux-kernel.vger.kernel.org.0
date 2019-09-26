Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A14BED6E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 10:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfIZIcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 04:32:52 -0400
Received: from foss.arm.com ([217.140.110.172]:42154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfIZIcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:32:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6310A1000;
        Thu, 26 Sep 2019 01:32:51 -0700 (PDT)
Received: from iMac.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D6933F836;
        Thu, 26 Sep 2019 01:32:50 -0700 (PDT)
Date:   Thu, 26 Sep 2019 09:32:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 3/4] arm64: vdso32: Fix compilation warning
Message-ID: <20190926083217.GD26802@iMac.local>
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926060353.54894-1-vincenzo.frascino@arm.com>
 <20190926060353.54894-4-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926060353.54894-4-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 07:03:52AM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b61b50bf68b1..b1c8c43234c5 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -228,11 +228,16 @@ static inline unsigned long kaslr_offset(void)
>  #define __tag_get(addr)		0
>  #endif /* CONFIG_KASAN_SW_TAGS */
>  
> +#ifdef __aarch64__
>  static inline const void *__tag_set(const void *addr, u8 tag)
>  {
>  	u64 __addr = (u64)addr & ~__tag_shifted(0xff);
>  	return (const void *)(__addr | __tag_shifted(tag));
>  }
> +#else
> +/* Unused in 32 bit mode */
> +#define __tag_set(addr, tag) 0
> +#endif

I'm fine with this as a temporary workaround (or hack). But please add a
better comment on what the 32-bit mode is about - the compat vDSO.

-- 
Catalin
