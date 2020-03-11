Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E4181D99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgCKQRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:17:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730052AbgCKQRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:17:49 -0400
Received: from zn.tnic (p200300EC2F12AA00E5C435974B72A9DE.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:aa00:e5c4:3597:4b72:a9de])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C05151EC0CE7;
        Wed, 11 Mar 2020 17:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583943467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cLO4YbyKgXCkxVnutlFvkoeFpFis0mCV7bvOffoDZ5k=;
        b=QdFSOObwSB15f5RiOB8UTj3dfRacRUPLMwuGdiKvbuaVGklnT4560hwTiPSf17QDwTIZzE
        YuHFO3oIWgE5Z4irCkejSNxSyi86LEPRG5dMuMmeNYVl35+uS6FJek8n8IFGK6pmS8M6oC
        IWvna8Lwyp/vtRArCBooNFKuubGZUos=
Date:   Wed, 11 Mar 2020 17:17:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, elver@google.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH -next] x86/mm/pat: mark an intentional data race
Message-ID: <20200311161756.GE3470@zn.tnic>
References: <1581343816-6490-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1581343816-6490-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Paul.

On Mon, Feb 10, 2020 at 09:10:16AM -0500, Qian Cai wrote:
> cpa_4k_install could be accessed concurrently as noticed by KCSAN,
> 
> read to 0xffffffffaa59a000 of 8 bytes by interrupt on cpu 7:
> cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> __change_page_attr+0x10cf/0x1840 arch/x86/mm/pat/set_memory.c:1514
> __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> __set_pages_np+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2148
> __kernel_map_pages+0xb0/0xc8 arch/x86/mm/pat/set_memory.c:2178
> kernel_map_pages include/linux/mm.h:2719 [inline] <snip>
> 
> write to 0xffffffffaa59a000 of 8 bytes by task 1 on cpu 6:
> cpa_inc_4k_install arch/x86/mm/pat/set_memory.c:131 [inline]
> __change_page_attr+0x10ea/0x1840 arch/x86/mm/pat/set_memory.c:1514
> __change_page_attr_set_clr+0xce/0x490 arch/x86/mm/pat/set_memory.c:1636
> __set_pages_p+0xc4/0xf0 arch/x86/mm/pat/set_memory.c:2129
> __kernel_map_pages+0x2e/0xc8 arch/x86/mm/pat/set_memory.c:2176
> kernel_map_pages include/linux/mm.h:2719 [inline] <snip>
> 
> Both accesses are due to the same "cpa_4k_install++" in
> cpa_inc_4k_install. A data race here could be potentially undesirable:
> depending on compiler optimizations or how x86 executes a non-LOCK'd
> increment, it may lose increments, corrupt the counter, etc. Since this
> counter only seems to be used for printing some stats, this data race
> itself is unlikely to cause harm to the system though. Thus, mark this
> intentional data race using the data_race() marco.
> 
> Suggested-by: Macro Elver <elver@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index c4aedd00c1ba..ea0b6df950ee 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -128,7 +128,7 @@ static inline void cpa_inc_2m_checked(void)
>  
>  static inline void cpa_inc_4k_install(void)
>  {
> -	cpa_4k_install++;
> +	data_race(cpa_4k_install++);
>  }
>  
>  static inline void cpa_inc_lp_sameprot(int level)
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
