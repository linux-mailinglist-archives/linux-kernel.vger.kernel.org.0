Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB43717016B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 15:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgBZOm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 09:42:59 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35567 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBZOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:42:59 -0500
Received: by mail-ua1-f68.google.com with SMTP id y23so1059372ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 06:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2driM7PVKhUuwY8TYsAiPgtqDfJ1mYTYuG83+3NODao=;
        b=rZKYZyZe5pecUg6ri7spyGNlVIyke9HtZIFWZAO5W3oJk2MG4xqdy++MHeGXvyk2mA
         WRNiGwLHqe6E1FAGMonL03AJRUsQr1yuV0OKuCuqrm6Pni++rP2T+xfcmnOGwmKQ3R8m
         +bfV/GYHBchauekkGjlSIc7gDgqJsuFxAIwVxcrf5eKBlGTUfIsbqJhdtUAW2Iyy76Sg
         SbWghbJWh570IvRvtLULVWnrSGM7hygFOYVyfX7Q3DIHUezDALez8PMnpn8mdqGc4I4p
         skK0TBi9QlhXRb8869GtBswUI8uEQeWvmnjkpP4Qad5PHd7O4oF6tV+szldTCsV2hvRq
         PbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2driM7PVKhUuwY8TYsAiPgtqDfJ1mYTYuG83+3NODao=;
        b=Py9JNEpRWJiulINM1bykH3TMIT7JkB7etknKxkz72+Hgp1Zs62PhKIGC2dOU/B1rYT
         Zh45+/8TbSo9yrc2F5071g5CqlUmeLTuUxyYrefDinsL9STOcugy9qT/nfVBIx5/Oh68
         mJvxVcJswgumlgPSoKfWsQ/rbnyUZpOccN59fKXT3L1dod6c5S34NBxLz2pQcbbNEU8r
         0zE+XA4o8za6Xs44Bsy34NbdPhITY/eaBApYQ0ggJwQdBMjZR1nenMicvtCyLjc04fq8
         L823UbxtlUxJaix+0+K7L93Bysc8Tp2QA1iqup4moMR/tVwQRiKfwMMVcnt/LoipxKz2
         gW2g==
X-Gm-Message-State: APjAAAWswmZksu5qeK/ziKoxIbFveHVYTVr6pMRZ2mSSvRdnX3UHtE0q
        uhOqPm/yNvG6oq5S4BzhcCH91jvjB4/096Kk5xzzbKQQ
X-Google-Smtp-Source: APXvYqzkgKGcDiFlA58U+y0xkwzn4e25+jVwn5rMMEn8FbTSxS0DJ1hIBhPWzwyEFGqNfRJOZMch419/ZIU78qM1Vds=
X-Received: by 2002:a9f:226d:: with SMTP id 100mr3924729uad.107.1582728176625;
 Wed, 26 Feb 2020 06:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20200225154834.25108-1-gilad@benyossef.com> <20200225154834.25108-2-gilad@benyossef.com>
 <20200225194551.GA114977@gmail.com>
In-Reply-To: <20200225194551.GA114977@gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 26 Feb 2020 16:42:45 +0200
Message-ID: <CAOtvUMeWB=MiYfzkrPjOctOufKJ8Q81E3m6bq8GJY-enbG6Qjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] crypto: testmgr - use generic algs making test vecs
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 9:45 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Feb 25, 2020 at 05:48:33PM +0200, Gilad Ben-Yossef wrote:
> > Use generic algs to produce inauthentic AEAD messages,
> > otherwise we are running the risk of using an untested
> > code to produce the test messages.
> >
> > As this code is only used in developer only extended tests
> > any cycles/runtime costs are negligible.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > Cc: Eric Biggers <ebiggers@kernel.org>
>
> It's intentional to use the same implementation to generate the inauthent=
ic AEAD
> messages, because it allows the inauthentic AEAD input tests to run even =
if the
> generic implementation is unavailable.

That is a good.
We can simply revert to the same implementation if the generic one is
not available.

>
> > @@ -2337,8 +2338,42 @@ static int test_aead_inauthentic_inputs(struct a=
ead_extra_tests_ctx *ctx)
> >  {
> >       unsigned int i;
> >       int err;
> > +     struct crypto_aead *tfm =3D ctx->tfm;
> > +     const char *algname =3D crypto_aead_alg(tfm)->base.cra_name;
> > +     const char *driver =3D ctx->driver;
> > +     const char *generic_driver =3D ctx->test_desc->generic_driver;
> > +     char _generic_driver[CRYPTO_MAX_ALG_NAME];
> > +     struct crypto_aead *generic_tfm =3D NULL;
> > +     struct aead_request *generic_req =3D NULL;
> > +
> > +     if (!generic_driver) {
> > +             err =3D build_generic_driver_name(algname, _generic_drive=
r);
> > +             if (err)
> > +                     return err;
> > +             generic_driver =3D _generic_driver;
> > +     }
> > +
> > +     if (!strcmp(generic_driver, driver) =3D=3D 0) {
> > +             /* Already the generic impl? */
> > +
> > +             generic_tfm =3D crypto_alloc_aead(generic_driver, 0, 0);
>
> I think you meant the condition to be 'if (strcmp(generic_driver, driver)=
 !=3D 0)'
> and for the comment to be "Not already the generic impl?".

Yes, of course. Silly me,

>
> > +             if (IS_ERR(generic_tfm)) {
> > +                     err =3D PTR_ERR(generic_tfm);
> > +                     pr_err("alg: aead: error allocating %s (generic i=
mpl of %s): %d\n",
> > +                     generic_driver, algname, err);
> > +                     return err;
> > +             }
>
> This means the test won't run if the generic implementation is unavailabl=
e.
> Is there any particular reason to impose that requirement?
>
> You mentioned a concern about the implementation being "untested", but it
> actually already passed test_aead() before getting to test_aead_extra().
>

The impetus to write this patch came from my experience debugging a
test failure with the ccree driver.
At some point while tweaking around I got into a situation where the
test was succeeding (that is, declaring the message inauthentic) not
because the mutation was being detected but because the generation of
the origin was producing a bogus ICV.
At that point it seemed to me that it would be safer to "isolate" the
original AEAD messages generation from the code that was being teste.

> We could also just move test_aead_inauthentic_inputs() to below
> test_aead_vs_generic_impl() so that it runs last.

This would probably be better, although I think that this stage also
generates inauthentic messages from time to time, no?

At any rate, I don't have strong feelings about it either way. I defer
to your judgment whether it is worth it to add a fallback to use the
same implementation and fix what needs fixing or drop the patch
altogether if you think this isn't worth the trouble - just let me
know.

Thanks,
Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
