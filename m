Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4114D969
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 12:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgA3LAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 06:00:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54364 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgA3LAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:00:11 -0500
Received: from zn.tnic (p200300EC2F0A2D00117AE2DCE574A1D4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2d00:117a:e2dc:e574:a1d4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B70641EC0C35;
        Thu, 30 Jan 2020 12:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580382009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kjg9mgnBvBc86IaMdqx5/BlOEYwrYBiouFb70aee4Bw=;
        b=RuQQD8jxDugTZkrDAiGhGpFFKkj3DVT4XTQs4EsVWVgj3BQHHNIWVcAUN4AYGEQiezd7H1
        gxvASm37g6+xD8ZouImjVP9KNVn2mnXqg+i2HEZJu0D7CqJMAViTOkRFnQck1xp9eAnB+a
        IJPvFz1wudNNdbsOjLfV1m1TiindZkg=
Date:   Thu, 30 Jan 2020 12:00:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: fix kaslr-enabled build
Message-ID: <20200130110008.GD6656@zn.tnic>
References: <20200129162926.1006-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200129162926.1006-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 01:29:26AM +0900, Sergey Senozhatsky wrote:
> Both pgtable_64 and kaslr_64 define `__force_order', which breaks
> the build:
> 
> ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order';
> arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
> 
> Make KASLR use extern pgtable_64's definition.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  arch/x86/boot/compressed/kaslr_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
> index 748456c365f4..274df8f9e659 100644
> --- a/arch/x86/boot/compressed/kaslr_64.c
> +++ b/arch/x86/boot/compressed/kaslr_64.c
> @@ -30,7 +30,7 @@
>  #include "../../mm/ident_map.c"
>  
>  /* Used by pgtable.h asm code to force instruction serialization. */
> -unsigned long __force_order;
> +extern unsigned long __force_order;
>  
>  /* Used to track our page table allocation area. */
>  struct alloc_pgt_data {
> -- 

Hmm, I can't trigger that. gcc version and .config pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
