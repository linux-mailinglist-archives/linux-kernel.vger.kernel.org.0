Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524B7B3F97
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 19:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfIPRZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 13:25:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41920 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfIPRZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:25:45 -0400
Received: by mail-lj1-f194.google.com with SMTP id f5so698293ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDoPRf3O5U70HZ4jcVgvx0Z1NYw99N1yO48Z3M4xYr8=;
        b=Mph/reUqez7LCvFpck2PPhm1EQlu6gNTHDoYSg1zfXh5tIWII/iGnvnCN2Kr/SsOmb
         BTcMOWfAEWc+e2sFNBHejlEuj7QAoF4asCAxEL8Fvv88R8zylLuJ43c7T7XjCsS1cO/v
         xFmFIzvWpIxdD3+f2ybCyZQQbhgA6gNNLVqR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDoPRf3O5U70HZ4jcVgvx0Z1NYw99N1yO48Z3M4xYr8=;
        b=lZLfN5wTgbPeCLoGMoayAIkHr28Qu2qtQJmNmB0ZLmv3p1YEV2vQXrOKfXgyhInjyp
         5A6rD+ygtVXH8qedGSHM4RZFLY+8aqcd2O97pdHVNa+x++EE87yy5cemFAkchoL/z+1X
         CLoq8MO844jD/JZ8V8BvrbuHNGDK8vYsB/FKOLP69wZZxntNtBEGgFXxkpQ6qDGS4B6q
         EbgWp9VcdCwjehykUHSSecwZOvWrB9jKz/f43XOphj9wm7gaXj8fsAzoIvsJQPkO70Gt
         CIIaW7acIZzicGTs5wGpzmgYnqmmi/Y224FMuvuNmeHwsXQx7I9Fh/fU4IV0rfVViUFp
         pEmA==
X-Gm-Message-State: APjAAAVRwigd7sN+ErYELOpX8RhkdXhtJ9FR7plGDB9M2H+UHe/7BizL
        wPbr35U6yA1K4CZJKYNKtnBjrUh30MA=
X-Google-Smtp-Source: APXvYqzMUDulwZ8JukNEZ/wGXqyWWbcMX+JcS3QaFaRHpF3fjFcZhc5JRXnFqMtxMxHSU66NF5wLQA==
X-Received: by 2002:a2e:6d12:: with SMTP id i18mr375458ljc.223.1568654743443;
        Mon, 16 Sep 2019 10:25:43 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t16sm9169317lfp.38.2019.09.16.10.25.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 10:25:42 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 72so601345lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:25:42 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr294789lfm.170.1568654741860;
 Mon, 16 Sep 2019 10:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190913072237.GA12381@zn.tnic> <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk> <20190913104232.GA4190@zn.tnic>
 <20190913163645.GC4190@zn.tnic> <3fc31917-9452-3a10-d11d-056bf2d8b97d@rasmusvillemoes.dk>
In-Reply-To: <3fc31917-9452-3a10-d11d-056bf2d8b97d@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 10:25:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
Message-ID: <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
Subject: Re: [RFC] Improve memset
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <mail@rasmusvillemoes.dk>,
        x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 2:18 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Eh, this benchmark doesn't seem to provide any hints on where to set the
> cut-off for a compile-time constant n, i.e. the 32 in

Yes, you'd need to use proper fixed-size memset's with
__builtin_memset() to test that case. Probably easy enough with some
preprocessor macros to expand to a lot of cases.

But even then it will not show some of the advantages of inlining the
memset (quite often you have a "memset structure to zero, then
initialize a couple of fields" pattern, and gcc does much better for
that when it just inlines the memset to stores - to the point of just
removing all the memset entirely and just storing a couple of zeroes
between the fields you initialized).

So the "inline constant sizes" case has advantages over and beyond the
obvious ones. I suspect that a reasonable cut-off point is somethinig
like "8*sizeof(long)". But look at things like "struct kstat" uses
etc, the limit might actually be even higher than that.

Also note that while "rep stosb" is _reasonably_ good with current
CPU's (ie roughly gen 8+), it's not so great a few generations ago
(gen 6ish), and it can be absolutely horrid on older cores and/or
atom. The limit for when it is a win ends up depending on whether I$
footprint is an issue too, of course, but some of the bigger wins tend
to happen when you have sizes >= 128.

You can basically always beat "rep movs/stos" with hand-tuned AVX2/512
code for specific cases if you don't look at I$ footprint and the cost
of the AVX setup (and the cost of frequency changes, which often go
hand-in-hand with the AVX use). So "rep movs/stos" is seldom
_optimal_, but it tends to be "quite good" for modern CPU's with
variable sizes that are in the 100+ byte range.

             Linus
