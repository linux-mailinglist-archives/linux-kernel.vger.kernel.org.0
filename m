Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0DF16EFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 21:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbgBYUCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 15:02:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45379 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731692AbgBYUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:02:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so100908pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 12:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aeBrpkuCL/cNn0iJh2rddagSts2JkNemNM1x7ifKADI=;
        b=K60ZZa7K1GcANSbCA8n8XkewtFw/PcYVEQ2jLmThWPTEZaTvW1Af9T5V7RcdIwnUC6
         mZZthrNBNJwQhRF/IbrTvzmsO9RHKRDMxK2VqoyM75yq+AetzbjxTB9ZsO5ENF/wbqXX
         +PH3IkWEu0aUIUAFepOnyLCcsPwc6l2zCEW8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aeBrpkuCL/cNn0iJh2rddagSts2JkNemNM1x7ifKADI=;
        b=OzF8AB5VRaTEst8rhMG8+kx8OzscSRT/k/nVx+wfJ4gPvz+grdg7Kse/ywulBTsCG5
         VIcNzxgTQbSXjpvRJmiTO7S+sbBBQIXOIn1k8poxgfQOA8eXIyIwfeJYEczAX4RYQmvP
         zl0F3omwCZWIgpZ61xhIRiqcldbsaSUBwTaVMFHYIrIKB32l8LxWc0HvWwFR2V91LBpb
         PRH18ZFCuKiej0W96vhAjNR5Ra79ZkDm3cCZ9dNyEwFApJbqiqSEUP2D6eTecIVtgec+
         AjxlnbbjpOpb2xoyJjxWwKZC0UlV+DqRXZsnQYs2rHPcFQfSEoZW59CWfUvZF/fQT4C+
         SBwQ==
X-Gm-Message-State: APjAAAVtBHDt670DqiKAyE15Ml/dcMU6YQD6ulgEmGyovcIGvCOhWwGy
        4/GuL2JZtHysbha7nok5R9qRjg==
X-Google-Smtp-Source: APXvYqyNms2P2aD6pJmBF4aKiw3f9i2LofLVp3p9FT47fAxwRvwqHGC9uxcYnsCUiFns2aSX1NwMqw==
X-Received: by 2002:a63:e509:: with SMTP id r9mr225600pgh.274.1582660967228;
        Tue, 25 Feb 2020 12:02:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21sm19057903pfp.0.2020.02.25.12.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:46 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:02:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com,
        Borislav Petkov <bp@suse.de>
Subject: Re: [RFC PATCH v9 02/27] x86/cpufeatures: Add CET CPU feature flags
 for Control-flow Enforcement Technology (CET)
Message-ID: <202002251202.9ED97B977@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-3-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:10AM -0800, Yu-cheng Yu wrote:
> Add CPU feature flags for Control-flow Enforcement Technology (CET).
> 
> CPUID.(EAX=7,ECX=0):ECX[bit 7] Shadow stack
> CPUID.(EAX=7,ECX=0):EDX[bit 20] Indirect Branch Tracking
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Reviewed-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/cpufeatures.h | 2 ++
>  arch/x86/kernel/cpu/cpuid-deps.c   | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index e9b62498fe75..a2c6b1b5c026 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -336,6 +336,7 @@
>  #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
>  #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
>  #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
> +#define X86_FEATURE_SHSTK		(16*32+ 7) /* Shadow Stack */
>  #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
>  #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
>  #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
> @@ -361,6 +362,7 @@
>  #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
>  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
>  #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
> +#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
>  #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
>  #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
>  #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
> index 3cbe24ca80ab..fec83cc74b9e 100644
> --- a/arch/x86/kernel/cpu/cpuid-deps.c
> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
> @@ -69,6 +69,8 @@ static const struct cpuid_dep cpuid_deps[] = {
>  	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
>  	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
>  	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
> +	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
> +	{ X86_FEATURE_IBT,			X86_FEATURE_XSAVES    },
>  	{}
>  };
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook
