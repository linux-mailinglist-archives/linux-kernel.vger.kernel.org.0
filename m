Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA0EFC2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNJpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:45:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39478 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:45:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so5656521wrp.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 01:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhvzp5b+Q4a3/0oVBXiXpioibMrQjz/TpooATE3bWZA=;
        b=FRq3dG1d6Uc9go+BHE9dRYlgxm27TAnBxLKzGjuZ3yaZVQcY47huQPCgrKiEA+vQyZ
         gnkCiCD6RsSG+sOD5K7C88cYC7VTN5SNn/gFYioXG1S7mBIoK55zINU57SmF133BB5SB
         T5IIjsBXNZJwZwmzfSDyKgCR9i9MPBxkZ5EHRkof1ydCBQ3WzaY1ZWS26GU218U7RbZe
         V47xLggJ3QJ7sEzKDBFHTsKxVV9yagwoN4oWqADLFcsYLQQT/sVXb2hXdzOkRPvgCLa/
         Fk9rN4bVSNvqxTpqPpXu4A6yfnxnW1/ywsO5+FW/Payabj6CngpZg/41xWpl0hZeAN6a
         QvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhvzp5b+Q4a3/0oVBXiXpioibMrQjz/TpooATE3bWZA=;
        b=eLsmT848h0gDZgg7VHaA0GQM9W7fiX7cEuejKajfcJ2LjAzER+VZytPCYUeAhc8960
         qc5UKJmQEkIUHectLeiGkNc06Vk40Q/hX7u3qBMIoHwQYff8ra4+8fZPKywoiRQhRHrt
         eAqQnscdKWRHOMgS9AMXoNta2YeKI/ACD6N1VhFRna2cMgKpQOPPeJmINZmmRfn49MGv
         862laEGXRazgqToAlro0hwiORiLiTr/+EBTyn1+SRJUO+wHFS+KCfnNS+q8gmCX9nCVc
         BzvtZZy/SEGZyGhxmocjg9VRuwW/4e5O94EQqrPYtSvJM0VUrcZRuG0eFcWa5JZievlX
         3RPg==
X-Gm-Message-State: APjAAAVvmEBC67SMzWKeNBo/NfOyX711DxRNYJrd8h5iPgvmoHuw8B0F
        6wyVT3JcLSYkO8cfQbBzLXmCU0iLGz9D7R+Q04tC2g==
X-Google-Smtp-Source: APXvYqxyGDZLLSdO7iFFPhCbyuFwYfQ2O45xwAZvkApwZrLzKIl7bERQR2BXJZAlRkzAJg02ZY/qIbP0G6b7FHE6kC0=
X-Received: by 2002:adf:f743:: with SMTP id z3mr6981129wrp.200.1573724714881;
 Thu, 14 Nov 2019 01:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20191112223046.176097-1-samitolvanen@google.com>
 <20191113200419.GE221701@gmail.com> <CABCJKudoBHo6rZoGMFproXjmexu16gonVKDPdnq9XDCmO2J2cw@mail.gmail.com>
In-Reply-To: <CABCJKudoBHo6rZoGMFproXjmexu16gonVKDPdnq9XDCmO2J2cw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 14 Nov 2019 09:45:05 +0000
Message-ID: <CAKv+Gu85PY+A_XxB9DcmcoV8+nAJZGfAc59sj6XnOGyhDedNQA@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm64/sha: fix function types
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 at 22:28, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Wed, Nov 13, 2019 at 12:04 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > On Tue, Nov 12, 2019 at 02:30:46PM -0800, Sami Tolvanen wrote:
> > > Declare assembly functions with the expected function type
> > > instead of casting pointers in C to avoid type mismatch failures
> > > with Control-Flow Integrity (CFI) checking.
> > >
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > ---
> > >  arch/arm64/crypto/sha1-ce-glue.c   | 12 +++++-------
> > >  arch/arm64/crypto/sha2-ce-glue.c   | 26 +++++++++++---------------
> > >  arch/arm64/crypto/sha256-glue.c    | 30 ++++++++++++------------------
> > >  arch/arm64/crypto/sha512-ce-glue.c | 23 ++++++++++-------------
> > >  arch/arm64/crypto/sha512-glue.c    | 13 +++++--------
> > >  5 files changed, 43 insertions(+), 61 deletions(-)
> > >
> > > diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> > > index bdc1b6d7aff7..3153a9bbb683 100644
> > > --- a/arch/arm64/crypto/sha1-ce-glue.c
> > > +++ b/arch/arm64/crypto/sha1-ce-glue.c
> > > @@ -25,7 +25,7 @@ struct sha1_ce_state {
> > >       u32                     finalize;
> > >  };
> > >
> > > -asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
> > > +asmlinkage void sha1_ce_transform(struct sha1_state *sst, u8 const *src,
> > >                                 int blocks);
> >
> > Please update the comments in the corresponding assembly files too.
> >
> > Also, this change doesn't really make sense because the assembly functions still
> > expect struct sha1_ce_state, and they access sha1_ce_state::finalize which is
> > not present in struct sha1_state.  There should either be wrapper functions that
> > explicitly do the cast from sha1_state to sha1_ce_state, or there should be
> > comments in the assembly files that very clearly explain that although the
> > function prototype takes sha1_state, it's really assumed to be a sha1_ce_state.
>
> Agreed, this needs a comment explaining the type mismatch. I'm also
> fine with using wrapper functions and explicitly casting the
> parameters instead of changing function declarations. Herbert, Ard,
> any preferences?
>

I guess the former would be cleaner, using container_of() rather than
a blind cast to make the code more self-documenting. The extra branch
shouldn't really matter.
