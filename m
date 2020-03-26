Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63F194227
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 15:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgCZO5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 10:57:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58556 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgCZO5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:57:19 -0400
Received: from zn.tnic (p200300EC2F0A4900341618FA2426449A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4900:3416:18fa:2426:449a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1CFD91EC0469;
        Thu, 26 Mar 2020 15:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585234637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I5bzym9yUMWO0jgjlADgMWnILk9HKqW39Q1cend1Znw=;
        b=hamAasPB1uuxLYTMK2DmIuXoiIH0eaaT7MmvTTfPeL7YCT7znmmD3Of4d+f1fopvTpU5CO
        77nhM0XgmB7QeKrE6nBKC7HoxE3mn92XDzLQAOr30wAOcYh9jxsVpw7V8LnueGBSe4BQr8
        bxprFNFKyWN3iOZL9APdhJcyooAeul0=
Date:   Thu, 26 Mar 2020 15:57:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 09/17] x86/static_call: Add out-of-line static
 call implementation
Message-ID: <20200326145709.GB11398@zn.tnic>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.819003994@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324142245.819003994@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:56:12PM +0100, Peter Zijlstra wrote:
> +static void __static_call_transform(void *insn, u8 opcode, void *func)
> +{
> +	const void *code = text_gen_insn(opcode, (long)insn, (long)func);
> +
> +	if (WARN_ONCE(*(u8 *)insn != opcode,
> +		      "unexpected static call insn opcode 0x%x at %pS\n",
> +		      opcode, insn))
> +		return;
> +
> +	if (memcmp(insn, code, CALL_INSN_SIZE) == 0)
> +		return;
> +
> +	text_poke_bp(insn, code, CALL_INSN_SIZE, NULL);

Right, this is working with CALL_INSN_SIZE but ...

> +}
> +
> +void arch_static_call_transform(void *site, void *tramp, void *func)
> +{
> +	mutex_lock(&text_mutex);
> +
> +	if (tramp)
> +		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);

... it gets called with JMP32_INSN_OPCODE too. I mean, both lengths are
equal and all - it is just a bit confusing at a first glance. Maybe slap
a small comment that it is ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
