Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E757FBB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 23:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKMW2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 17:28:33 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40415 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfKMW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:28:33 -0500
Received: by mail-vs1-f67.google.com with SMTP id m9so2495157vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 14:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=df+DaKSym2F9N38LbwQBau3uyVIjwZlwEI4gpy1fPE4=;
        b=dZb5uR28WtYmsIGQUl7x9pIgxS9KCCtdlUs9VoItFY5+c1+CApd8HbmkRUyerPpjHO
         gv+ogesx6Ikklix2lZMfqiwnJqGFYKybH2NcArccBFnXRMyJtTBobVjX2j3X3AvJhFlN
         9AcGprpxGi6mMOsBsVvcl0XYhdP5V2Ruf+wPdwgRvEtHXksnGjqVuioxHg6oX0MAgyGS
         O6e9uN/vo4c/x2u7XiDMhCWfzS4QslstYQYB4fu76AkptLbmn2qqu57heYwEhbMgtPH9
         MQaDP5Jy6GFzLHQIK1QKUN8YLZvx/m59XTd6leHo14UcJ4n880Yi2KQwPbPEAmJFIJfs
         +i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=df+DaKSym2F9N38LbwQBau3uyVIjwZlwEI4gpy1fPE4=;
        b=qwFemxXo/p/apklvxkcXnkID2nANzvPke5pVNLbvOGQoqW5LzT+6RIt6i86wlLQGPO
         g5faKB3Stp3bzVDY5RVIbbB+Msk6YS/TeotibTSlI+MtpsnRqxR/AsJAewYCVMxM50ym
         RJIBw+PDH2cYWgE/nDXqI0sXykuSOmseLEbgSfiht/319uC+uKdXQrhKCa+1xHD3E7+s
         dRZ6qJ/YAzR4NoOifvm98l0kL5J2l+v/XT/hVYmv0cB2QMyGa4X+gefPO/p9KY62JwHN
         S4tFBPtsNrHLSVQTiekFNDRXF5ygsJ1ZiuZlLRdv1OFEUIwp2UBpC2VayGkRCC3mbPpj
         0vrg==
X-Gm-Message-State: APjAAAWZ/g2tub3bHM+c5fm1f2gDkAhgkASsQuG0rJ8L4c8Y/EFsSD7C
        HoIUqtg9w8MFgmdPGMQocugxsFkCgVHIB2HCKQ8XtA==
X-Google-Smtp-Source: APXvYqxfpgw1bAj534p0frCXIEt+l0yG7RkVd1Sj5Hvf+PUYmwQzQTLAWLYEMRDZVRNouwEoi67rVA5OIosex2sZLnI=
X-Received: by 2002:a67:c58e:: with SMTP id h14mr3590395vsk.104.1573684112019;
 Wed, 13 Nov 2019 14:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20191112223046.176097-1-samitolvanen@google.com> <20191113200419.GE221701@gmail.com>
In-Reply-To: <20191113200419.GE221701@gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 13 Nov 2019 14:28:20 -0800
Message-ID: <CABCJKudoBHo6rZoGMFproXjmexu16gonVKDPdnq9XDCmO2J2cw@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm64/sha: fix function types
To:     Sami Tolvanen <samitolvanen@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:04 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Nov 12, 2019 at 02:30:46PM -0800, Sami Tolvanen wrote:
> > Declare assembly functions with the expected function type
> > instead of casting pointers in C to avoid type mismatch failures
> > with Control-Flow Integrity (CFI) checking.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/arm64/crypto/sha1-ce-glue.c   | 12 +++++-------
> >  arch/arm64/crypto/sha2-ce-glue.c   | 26 +++++++++++---------------
> >  arch/arm64/crypto/sha256-glue.c    | 30 ++++++++++++------------------
> >  arch/arm64/crypto/sha512-ce-glue.c | 23 ++++++++++-------------
> >  arch/arm64/crypto/sha512-glue.c    | 13 +++++--------
> >  5 files changed, 43 insertions(+), 61 deletions(-)
> >
> > diff --git a/arch/arm64/crypto/sha1-ce-glue.c b/arch/arm64/crypto/sha1-ce-glue.c
> > index bdc1b6d7aff7..3153a9bbb683 100644
> > --- a/arch/arm64/crypto/sha1-ce-glue.c
> > +++ b/arch/arm64/crypto/sha1-ce-glue.c
> > @@ -25,7 +25,7 @@ struct sha1_ce_state {
> >       u32                     finalize;
> >  };
> >
> > -asmlinkage void sha1_ce_transform(struct sha1_ce_state *sst, u8 const *src,
> > +asmlinkage void sha1_ce_transform(struct sha1_state *sst, u8 const *src,
> >                                 int blocks);
>
> Please update the comments in the corresponding assembly files too.
>
> Also, this change doesn't really make sense because the assembly functions still
> expect struct sha1_ce_state, and they access sha1_ce_state::finalize which is
> not present in struct sha1_state.  There should either be wrapper functions that
> explicitly do the cast from sha1_state to sha1_ce_state, or there should be
> comments in the assembly files that very clearly explain that although the
> function prototype takes sha1_state, it's really assumed to be a sha1_ce_state.

Agreed, this needs a comment explaining the type mismatch. I'm also
fine with using wrapper functions and explicitly casting the
parameters instead of changing function declarations. Herbert, Ard,
any preferences?

Sami
