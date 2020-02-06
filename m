Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3611543FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 13:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBFM01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 07:26:27 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38312 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgBFM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:26:27 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so5288978oth.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 04:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NOY8bS0asHpD+z721OXmKaafugnpGdhKSAQgjErq5zs=;
        b=D63fMXu7FJZcwQhCNxkpNOfFGC8DypWspcBegFsiI4VcZrFqIotWhCwDMPATuBJiaR
         0r3jy3H4r1OuKl9TP/+9jyIGTeAMZImp8EiuyJVDRquG6f8GWM5vL3Aj2ekMsgH52lKL
         DQ/0fYPfdM1hK/ifrIFdCc6Yi/9yUC+XTDLto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NOY8bS0asHpD+z721OXmKaafugnpGdhKSAQgjErq5zs=;
        b=FER23FHH1lrfuDi7SSS7QkpkesXk0KI36VO9a/yuijRkMu4mJirxPrPMmmVxTfUZS6
         1eLa+aDjcq5tXqanHLwpTRGkdk0taXf3/fFMDIvqPlRP0W0TQ7rpAIXTrFpK7H76XiqR
         OER0dGUZCCekQxs/HRd8SGYb1sZdKEuddR+dC2q29o/jmvxsv7Nfd30nRvZ9ZVw5ea1D
         J4XPRjhaab2om416eDXi+Znn1COy1tnfZuQqleXLZaG7Ine6BiJjkFWu+o6o7sg7WXV/
         1KWZcg/NsMfe+k2Tb7EMPF3rVaJW4WAPVsK/vXIlD7yDNSN2zMR4yV0yQ+PWShr7ehFz
         hffQ==
X-Gm-Message-State: APjAAAUtYFbfZ7zrYARPZtcvohQ6+49xTaNUYy6qewbJ+0Go8Ef/PY4J
        3gEVDE56QI/KbbkRNCKW7UJagw==
X-Google-Smtp-Source: APXvYqwEZlN/eh3Ye+I2c+zEIeVmfOEkt+iEawFFgaC+cF+h2RqeLLo4LxogwNsdAQFa4PrpwOMMiQ==
X-Received: by 2002:a9d:7357:: with SMTP id l23mr28943725otk.10.1580991985931;
        Thu, 06 Feb 2020 04:26:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5sm1040821otp.10.2020.02.06.04.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 04:26:24 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:26:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <202002060408.84005CEFFD@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-7-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223950.1212394-7-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:39:45PM -0800, Kristen Carlson Accardi wrote:
> We will be using -ffunction-sections to place each function in
> it's own text section so it can be randomized at load time. The
> linker considers these .text.* sections "orphaned sections", and
> will place them after the first similar section (.text). However,
> we need to move _etext so that it is after both .text and .text.*
> We also need to calculate text size to include .text AND .text.*

The dependency on the linker's orphan section handling is, I feel,
rather fragile (during work on CFI and generally building kernels with
Clang's LLD linker, we keep tripping over difference between how BFD and
LLD handle orphans). However, this is currently no way to perform a
section "pass through" where input sections retain their name as an
output section. (If anyone knows a way to do this, I'm all ears).

Right now, you can only collect sections like this:

        .text :  AT(ADDR(.text) - LOAD_OFFSET) {
		*(.text.*)
	}

or let them be orphans, which then the linker attempts to find a
"similar" (code, data, etc) section to put them near:
https://sourceware.org/binutils/docs-2.33.1/ld/Orphan-Sections.html

So, basically, yes, this works, but I'd like to see BFD and LLD grow
some kind of /PASSTHRU/ special section (like /DISCARD/), that would let
a linker script specify _where_ these sections should roughly live.

Related thoughts:

I know x86_64 stack alignment is 16 bytes. I cannot find evidence for
what function start alignment should be. It seems the linker is 16 byte
aligning these functions, when I think no alignment is needed for
function starts, so we're wasting some memory (average 8 bytes per
function, at say 50,000 functions, so approaching 512KB) between
functions. If we can specify a 1 byte alignment for these orphan
sections, that would be nice, as mentioned in the cover letter: we lose
a 4 bits of entropy to this alignment, since all randomized function
addresses will have their low bits set to zero.

And we can't adjust function section alignment, or there is some
benefit to a larger alignment, I would like to have a way for the linker
to specify the inter-section padding (or fill) bytes. Right now, the
FILL(0xnn) (or =0xnn) can be used to specify the padding bytes _within_
a section, but not between sections. Right now, BFD appears to 0-pad. I'd
like that to be 0xCC so "guessing" addresses incorrectly will trigger
a trap.

-Kees

> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  arch/x86/kernel/vmlinux.lds.S     | 18 +++++++++++++++++-
>  include/asm-generic/vmlinux.lds.h |  2 +-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 3a1a819da137..e54e9ac5b429 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -146,8 +146,24 @@ SECTIONS
>  #endif
>  	} :text =0xcccc
>  
> -	/* End of text section, which should occupy whole number of pages */
> +#ifdef CONFIG_FG_KASLR
> +	/*
> +	 * -ffunction-sections creates .text.* sections, which are considered
> +	 * "orphan sections" and added after the first similar section (.text).
> +	 * Adding this ALIGN statement causes the address of _etext
> +	 * to be below that of all the .text.* orphaned sections
> +	 */
> +	. = ALIGN(PAGE_SIZE);
> +#endif
>  	_etext = .;
> +
> +	/*
> +	 * the size of the .text section is used to calculate the address
> +	 * range for orc lookups. If we just use SIZEOF(.text), we will
> +	 * miss all the .text.* sections. Calculate the size using _etext
> +	 * and _stext and save the value for later.
> +	 */
> +	text_size = _etext - _stext;
>  	. = ALIGN(PAGE_SIZE);
>  
>  	X86_ALIGN_RODATA_BEGIN
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4..edf19f4296e2 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -798,7 +798,7 @@
>  	. = ALIGN(4);							\
>  	.orc_lookup : AT(ADDR(.orc_lookup) - LOAD_OFFSET) {		\
>  		orc_lookup = .;						\
> -		. += (((SIZEOF(.text) + LOOKUP_BLOCK_SIZE - 1) /	\
> +		. += (((text_size + LOOKUP_BLOCK_SIZE - 1) /	\
>  			LOOKUP_BLOCK_SIZE) + 1) * 4;			\
>  		orc_lookup_end = .;					\
>  	}
> -- 
> 2.24.1
> 

-- 
Kees Cook
