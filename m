Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2363D086
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 17:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404552AbfFKPOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 11:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391755AbfFKPOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:14:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79062080A;
        Tue, 11 Jun 2019 15:14:11 +0000 (UTC)
Date:   Tue, 11 Jun 2019 11:14:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 08/15] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20190611111410.366f4ced@gandalf.local.home>
In-Reply-To: <20190605131945.005681046@infradead.org>
References: <20190605130753.327195108@infradead.org>
        <20190605131945.005681046@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019 15:08:01 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> -void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
> +void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
>  {
>  	unsigned char int3 = 0xcc;
>  
> -	bp_int3_handler = handler;
> +	bp_int3_opcode = emulate ?: opcode;
>  	bp_int3_addr = (u8 *)addr + sizeof(int3);
>  	bp_patching_in_progress = true;
>  
>  	lockdep_assert_held(&text_mutex);
>  
>  	/*
> +	 * poke_int3_handler() relies on @opcode being a 5 byte instruction;
> +	 * notably a JMP, CALL or NOP5_ATOMIC.
> +	 */
> +	BUG_ON(len != 5);

If we have a bug on here, why bother with passing in len at all? Just
force it to be 5.

We could make it a WARN_ON() and return without doing anything.

This also prevents us from ever changing two byte jmps.

-- Steve

> +
> +	/*
>  	 * Corresponding read barrier in int3 notifier for making sure the
> -	 * in_progress and handler are correctly ordered wrt. patching.
> +	 * in_progress and opcode are correctly ordered wrt. patching.
>  	 */
>  	smp_wmb();
>  
> -
