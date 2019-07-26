Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9377086
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 19:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfGZRp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 13:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387623AbfGZRp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:45:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEBE421994;
        Fri, 26 Jul 2019 17:45:25 +0000 (UTC)
Date:   Fri, 26 Jul 2019 13:45:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 04/13] recordmcount: Rewrite error/success handling
Message-ID: <20190726134523.4e7afd55@gandalf.local.home>
In-Reply-To: <316706a0e2727af0a2639b8e90366746d7a3a84a.1563992889.git.mhelsley@vmware.com>
References: <cover.1563992889.git.mhelsley@vmware.com>
        <316706a0e2727af0a2639b8e90366746d7a3a84a.1563992889.git.mhelsley@vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 14:04:58 -0700
Matt Helsley <mhelsley@vmware.com> wrote:


Hi Matt,

As I'm applying these for real, I'm taking a deeper look at the
patches. This one I have some questions about.

> Recordmcount uses setjmp/longjmp to manage control flow as
> it reads and then writes the ELF file. This unusual control
> flow is hard to follow and check in addition to being unlike
> kernel coding style.
> 
> So we rewrite these paths to use regular return values to
> indicate error/success. When an error or previously-completed object
> file is found we return an error code following kernel
> coding conventions -- negative error values and 0 for success when
> we're not returning a pointer. We return NULL for those that fail
> and return non-NULL pointers otherwise.
> 
> One oddity is already_has_rel_mcount -- there we use pointer comparison
> rather than string comparison to differentiate between
> previously-processed object files and returning the name of a text
> section.

This is fine, but it's got a strange implementation.



> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index c1e1b04b4871..909a3e4775c2 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -24,7 +24,9 @@
>  #undef mcount_adjust
>  #undef sift_rel_mcount
>  #undef nop_mcount
> +#undef missing_sym
>  #undef find_secsym_ndx
> +#undef already_has_rel_mcount

Why do we need these as defines? Can't you just have a single:

const char *already_has_mcount = "success";

in recordmcount.c before recordmcount.h is included?

And same for missing_sym.

Another, probably more robust way of doing this, is change
find_secsym_ndx() to return 0 on success and -1 on missing symbol, and
just pass a pointer by reference to fill the recsym (which doesn't have
to be a constant).

I've applied the first 3 patches of this series, but stopped here. I'll
continue to take a deeper look at your other patches.

Thanks!

-- Steve



>  #undef __has_rel_mcount
>  #undef has_rel_mcount
>  #undef tot_relsize
> @@ -54,7 +56,9 @@
>  # define append_func		append64
>  # define sift_rel_mcount	sift64_rel_mcount
>  # define nop_mcount		nop_mcount_64
> +# define missing_sym		missing_sym_64
>  # define find_secsym_ndx	find64_secsym_ndx
> +# define already_has_rel_mcount	already_has_rel_mcount_64
>  # define __has_rel_mcount	__has64_rel_mcount
>  # define has_rel_mcount		has64_rel_mcount
>  # define tot_relsize		tot64_relsize
> @@ -87,7 +91,9 @@
>  # define append_func		append32
>  # define sift_rel_mcount	sift32_rel_mcount
>  # define nop_mcount		nop_mcount_32
> +# define missing_sym		missing_sym_32
>  # define find_secsym_ndx	find32_secsym_ndx
> +# define already_has_rel_mcount	already_has_rel_mcount_32
>  # define __has_rel_mcount	__has32_rel_mcount
>  # define has_rel_mcount		has32_rel_mcount
>  # define tot_relsize		tot32_relsize

> +static const unsigned int missing_sym = (unsigned int)-1;
>  
>  /*
>   * Find a symbol in the given section, to be used as the base for relocating
> @@ -443,9 +469,11 @@ static unsigned find_secsym_ndx(unsigned const txtndx,
>  	}
>  	fprintf(stderr, "Cannot find symbol for section %u: %s.\n",
>  		txtndx, txtname);
> -	fail_file();
> +	cleanup();
> +	return missing_sym;
>  }
>  
> +char const *already_has_rel_mcount = "success"; /* our work here is done! */
>  
>  /* Evade ISO C restriction: no declaration after statement in has_rel_mcount. */
>  static char const *
> @@ -461,7 +489,8 @@ __has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
>  	if (strcmp("__mcount_loc", txtname) == 0) {
>  		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
>  			fname);
> -		succeed_file();
> +		cleanup();
> +		return already_has_rel_mcount;
>  	}
>  	if (w(txthdr->sh_type) != SHT_PROGBITS ||
>  	    !(_w(txthdr->sh_flags) & SHF_EXECINSTR))
