Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F234C12D88D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 13:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfLaMNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 07:13:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43534 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfLaMNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 07:13:42 -0500
Received: from zn.tnic (p4FED3FEE.dip0.t-ipconnect.de [79.237.63.238])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C266E1EC0216;
        Tue, 31 Dec 2019 13:13:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577794421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oR2xbj0U/pPGMoJ8gZOuKTnC6YknArbdAxhM7IvzOgI=;
        b=L1M0d2MfDvXwB06BInNWbNrRyxXJ4p8eDWXOOC1n/RXs6mpQ2saXsgVesChtYtCn60jG7+
        SBCfc9UtbWk0c6apV5LWzFHPhERhSr3VoPf1lCSNVyNciCmnC8tHSycqfsu4pL/EZgPGlQ
        28R/sA9gg+yXZLyaBXZGDBcyGdJlvSI=
Date:   Tue, 31 Dec 2019 13:11:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v7 3/4] x86/dumpstack: Introduce die_addr() for die()
 with #GP fault address
Message-ID: <20191231121121.GA13549@zn.tnic>
References: <20191218231150.12139-1-jannh@google.com>
 <20191218231150.12139-3-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218231150.12139-3-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:11:49AM +0100, Jann Horn wrote:
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index c8b4ae6aed5b..4c691bb9e0d9 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -621,7 +621,10 @@ do_general_protection(struct pt_regs *regs, long error_code)
>  				 "maybe for address",
>  				 gp_addr);

 
> -		die(desc, regs, error_code);

I've added here:

                /*
                 * KASAN is interested only in the non-canonical case, clear it
                 * otherwise.
                 */

> +		if (hint != GP_NON_CANONICAL)
> +			gp_addr = 0;


otherwise you have:

	if (hint != GP_NO_HINT)
		...

	if (hint != GP_NON_CANONICAL)
		...

which is kinda confusing at a first glance and one has to follow the
code into die_addr() to figure out the usage of the address argument.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
