Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020AA18719F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbgCPRyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 13:54:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730437AbgCPRyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:54:45 -0400
Received: from zn.tnic (p200300EC2F06AB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39E1B1EC0C84;
        Mon, 16 Mar 2020 18:54:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584381284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F0GgaJ9ZIP0KWGKKbs8QEzJhijPGxcv5KG9dWOxvw6k=;
        b=BWAA37IBA9O9r7kNeskqZ2YRVdXgRX/vgM7Vqthb5fxNnDkNljKACVUrEBgDzcOGMjp5ts
        Re1bj0Q86u82431jgKzJK07fHU7W8l8QHmlCYw5HTa+aEJ9g85YcjlPX55smPeiwpVJ9Ck
        8jLJfpu3RFwF2DhY2Xgj9K0Oq0QSU7U=
Date:   Mon, 16 Mar 2020 18:54:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316175450.GO26126@zn.tnic>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316134234.GE12561@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:42:34PM +0100, Peter Zijlstra wrote:
> Right I know, I looked for it recently :/ But since this is new in 10
> and 10 isn't released yet, I figured someone can add the attribute
> before it does get released.

Yes, that would be a good solution.

I looked at what happens briefly after building gcc10 from git and IINM,
the function in question - start_secondary() - already gets the stack
canary asm glue added so it checks for a stack canary.

However, the stack canary value itself gets set later in that same
function:

        /* to prevent fake stack check failure in clock setup */
        boot_init_stack_canary();

so the asm glue which checks for it would need to reload the newly
computed canary value (it is 0 before we compute it and thus the
mismatch).

So having a way to state "do not add stack canary checking to this
particular function" would be optimal. And since you already have the
"stack_protect" function attribute I figure adding a "no_stack_protect"
one should be easy...

> > Or of course you could add noinline attribute to whatever got inlined
> > and contains some array or addressable variable that whatever
> > -fstack-protector* mode kernel uses triggers it.  With -fstack-protector-all
> > it would never work even in the past I believe.
> 
> I don't think the kernel supports -fstack-protector-all, but I could be
> mistaken.

The other thing I was thinking was to carve out only that function into
a separate compilation unit and disable stack protector only for it.

All IMHO of course.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
