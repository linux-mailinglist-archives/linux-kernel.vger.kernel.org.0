Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF1BD0E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407285AbfIXRrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 13:47:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48782 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732249AbfIXRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:47:14 -0400
Received: from zn.tnic (p200300EC2F0DB700CDA5DCD899733FA6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:b700:cda5:dcd8:9973:3fa6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E42471EC0626;
        Tue, 24 Sep 2019 19:47:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569347233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=adKE8SbI1kBCgg9keQtSq6HfopCJHVUTQz4k4IbvxMg=;
        b=Pv0ekFq9y+W1xwrwKddprLzPxYLDdTsRo4HS3mQs8L7bYTctG9uOUkkQUzDtdQn9vR7pwU
        Kxrli31pKtPx1wiBz2yCvLkjfE7ixX42dAthoMjcT3cqCpqZD70IVJVg47UXqoRRi0/n/j
        kqOeGb2uX2fv4ADTsGyhPBOiWjMV0sM=
Date:   Tue, 24 Sep 2019 19:47:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Philipp K <philipp97kl@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] x86: Refactor __cmpxchg to cmpxchg in lock_cmos
Message-ID: <20190924174713.GK19317@zn.tnic>
References: <CAGZ+4_+TMdbmy6_x4sondGFgcOc=9XXSMTaixcyKasd3LMDMbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ+4_+TMdbmy6_x4sondGFgcOc=9XXSMTaixcyKasd3LMDMbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 04:29:13PM +0100, Philipp K wrote:
> It is unusual to reference __cmpxchg() from other files than cmpxchg.h and
> similar.
> Instead, cmpxchg() is used, which expands to __cmpxchg() and derives the
> 'size' parameter automatically with sizeof(*(ptr)).
> 
> So clean up the lock_cmos() function by using cmpxchg(), without changing
> the generated code.
> 
> Signed-off-by: Philipp Klocke <philipp97kl@gmail.com>
> ---
> 
> This patch was acked by Ingo, so I would expect it to be added to pit.

You mean tip. :)

>  arch/x86/include/asm/mc146818rtc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/mc146818rtc.h
> b/arch/x86/include/asm/mc146818rtc.h
> index 97198001e567..b72e3bbba0a2 100644
> --- a/arch/x86/include/asm/mc146818rtc.h
> +++ b/arch/x86/include/asm/mc146818rtc.h
> @@ -47,7 +47,7 @@ static inline void lock_cmos(unsigned char reg)
>   cpu_relax();
>   continue;
>   }
> - if (__cmpxchg(&cmos_lock, 0, new, sizeof(cmos_lock)) == 0)
> + if (cmpxchg(&cmos_lock, 0, new) == 0)
>   return;
>   }
>  }
> -- 

I don't know how you created this diff but yours breaks the indentation.
It should look like this:

--
diff --git a/arch/x86/include/asm/mc146818rtc.h b/arch/x86/include/asm/mc146818rtc.h
index 97198001e567..b72e3bbba0a2 100644
--- a/arch/x86/include/asm/mc146818rtc.h
+++ b/arch/x86/include/asm/mc146818rtc.h
@@ -47,7 +47,7 @@ static inline void lock_cmos(unsigned char reg)
 			cpu_relax();
 			continue;
 		}
-		if (__cmpxchg(&cmos_lock, 0, new, sizeof(cmos_lock)) == 0)
+		if (cmpxchg(&cmos_lock, 0, new) == 0)
 			return;
 	}
 }
--

Also, you can simplify it even more by changing it to:

		if (!cmpxchg(&cmos_lock, 0, new))
			return;

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
