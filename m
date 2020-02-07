Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8EC155B46
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBGP7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 10:59:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35829 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726974AbgBGP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:59:23 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 017FwTbL031620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 10:58:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EF42F420324; Fri,  7 Feb 2020 10:58:28 -0500 (EST)
Date:   Fri, 7 Feb 2020 10:58:28 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] random: add rng-seed= command line option
Message-ID: <20200207155828.GB122530@mit.edu>
References: <20200207150809.19329-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207150809.19329-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What was the base of your patch?  It's not applying on my kernel tree.

On Fri, Feb 07, 2020 at 07:07:59AM -0800, Mark Salyzyn wrote:
> A followup to commit 428826f5358c922dc378830a1717b682c0823160
> ("fdt: add support for rng-seed") to extend what was started
> with Open Firmware (OF or Device Tree) parsing, but also add
> it to the command line.
> 
> If CONFIG_RANDOM_TRUST_BOOTLOADER is set, then feed the rng-seed
> command line option length as added trusted entropy.
> 
> Always rrase all views of the rng-seed option, except early command
> line parsing, to prevent leakage to applications or modules, to
> eliminate any attack vector.

s/rrase/erase/

> 
> It is preferred to add rng-seed to the Device Tree, but some
> platforms do not have this option, so this adds the ability to
> provide some command-line-limited data to the entropy through this
> alternate mechanism.  Expect all 8 bits to be used, but must exclude
> space to be accounted in the command line.

"all 8 bits"?

> @@ -875,6 +909,21 @@ asmlinkage __visible void __init start_kernel(void)
>  	rand_initialize();
>  	add_latent_entropy();
>  	add_device_randomness(command_line, strlen(command_line));
> +	if (IS_BUILTIN(CONFIG_RANDOM_TRUST_BOOTLOADER)) {
> +		size_t l = strlen(command_line);
> +		char *rng_seed = strnstr(command_line, rng_seed_str, l);
> +
> +		if (rng_seed) {
> +			char *end;
> +
> +			rng_seed += strlen(rng_seed_str);
> +			l -= rng_seed - command_line;
> +			end = strnchr(rng_seed, l, ' ');
> +			if (end)
> +				l = end - rng_seed;
> +			credit_trusted_entropy(l);
> +		}
> +	}

This doesn't look right at all.  It calls credit_trusted_entropy(),
but it doesn't actually feed the contents of rng_seed where.  Why not
just call add_hwgeneterator_randomness() and drop adding this
credit_trusted_entropy(l)?

						- Ted
