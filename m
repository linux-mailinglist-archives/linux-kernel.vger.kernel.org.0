Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58CF61942DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 16:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCZPR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 11:17:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33878 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgCZPRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:17:55 -0400
Received: from zn.tnic (p200300EC2F0A4900341618FA2426449A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4900:3416:18fa:2426:449a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97BA51EC0469;
        Thu, 26 Mar 2020 16:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585235874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PoN/7rYz9AoBh8GJI/bdaHsVDtWJ4mFyOEFbfYWnBeQ=;
        b=gswVKwMcy+eO7uaRwRU7TB7DSqgNABIC2my5gmEVw3JGtgB78N4IawmXs0OcpJwFgZNW6y
        XYbwynQJ4WaZXx216v/0SVwTDS5jlBg5M3UnWhfBTygQIhgEyj6NRzpnS+OhzanfvGJQ7t
        iqNQykMOWxj4VTnDdxK8W6/N2569auY=
Date:   Thu, 26 Mar 2020 16:17:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 10/17] x86/static_call: Add inline static call
 implementation for x86-64
Message-ID: <20200326151750.GC11398@zn.tnic>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.880990363@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324142245.880990363@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:56:13PM +0100, Peter Zijlstra wrote:
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -15,6 +15,7 @@
>  
>  #include <linux/hashtable.h>
>  #include <linux/kernel.h>
> +#include <linux/static_call_types.h>
>  
>  #define FAKE_JUMP_OFFSET -1
>  
> @@ -1345,6 +1346,21 @@ static int read_retpoline_hints(struct o
>  	return 0;
>  }
>  
> +static int read_static_call_tramps(struct objtool_file *file)
> +{
> +	struct section *sec, *sc_sec = find_section_by_name(file->elf, ".static_call.text");
> +	struct symbol *func;

	if (!sc_sec)
		return;

no?

I mean, it is enabled by default on X86_64 but not on 32-bit. Or will it
be?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
