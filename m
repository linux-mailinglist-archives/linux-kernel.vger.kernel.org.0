Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6E113E19
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 10:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfLEJgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 04:36:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44611 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfLEJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:36:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so2593806wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDhpzGph/Sl3F5yiAxtDx7OozplQyiOLtDQYn1Ymcc4=;
        b=cFs1DKxxrz3wBHesk8ew2n1s9xKJYKOoB799VoJIVv7vULGEjf8uPBSiTsC/uIEN0b
         rGnDFF9fgPyFOi/HhbgkzTxaYPn89KCBGiQrMptVXesZLRn6BXw//WBBFa0NqxTTCRQ+
         RYm7Bph9RQq5Vne74F/S8/agrOXEavnZbA/yzX/HKP0sZsASJ2kebR4VFGv4iVKJZaKY
         B2MiD7qkcJeYtcY1CbGtrCvRNRRDzU81NWP49VI9Bh2UraywJ8vdE3cRdRwcs4CSyo8g
         B7YRwjFxN/n21rzlbyVkyiiW1EQ1AHPhxHem+7IJD9doSzgLWCydSd1dVtnhKPTocYXg
         BzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDhpzGph/Sl3F5yiAxtDx7OozplQyiOLtDQYn1Ymcc4=;
        b=ZA8znjSxz9/jW2Ja25o/QMELgywZ6Wit/rIxk7r7f8nXi+oGZl6ONxhlv3BSY4EfLK
         t2U3UOgu8xOFq+6V8oW0R0Io3/lPBh4ON6/+nsaaBhmdGmbZtkksowGpYeAhQlo1ipqy
         xXwYUqvreaI8cJqQ+szV9soyN2DaYuLxu61RD5rvBY/eASrBKAGxVBY3G+GZPMPLrGu+
         NMAXRIdXX1Oe7R76+qeLP3ViQ1Ssbl4FJV1CPkIglRacvPJiyXRDlY3Fhx6So+uccU6Q
         jJBKc/aegSwSouhuDctOv/080GvlNt6x/ZDAYs5NGHd73t8Y+x7cx22jriOfVlb2e2gj
         md3w==
X-Gm-Message-State: APjAAAW3JDhhU+ryTTGrPYexQxTmqKiCXG3K5a/WWXo8Vec6NjS/PHEq
        mw7HbVETshLenLf6xrXHBXAdggp0Ej5S02vvFiwD055S6cBZbJpd
X-Google-Smtp-Source: APXvYqzV4yD5evgBaMe8lq6m+lD5/SimV/mRxPFn5FYoNCSYAHmao71QnHJ9x2c2DpakxxM1i1+QHz1VLBVG3mRVAi4=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr9267283wrw.246.1575538592021;
 Thu, 05 Dec 2019 01:36:32 -0800 (PST)
MIME-Version: 1.0
References: <5de7d155.1c69fb81.c06f8.3583@mx.google.com> <377fa169-7ae5-479f-023c-e282d8c19f3a@collabora.com>
In-Reply-To: <377fa169-7ae5-479f-023c-e282d8c19f3a@collabora.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 5 Dec 2019 09:36:28 +0000
Message-ID: <CAKv+Gu_LY29hJ9c+myomeappoOgJYHdNYoWOu=KyfH3zCcTkLw@mail.gmail.com>
Subject: Re: ardb/for-kernelci bisection: boot on rk3288-rock2-square
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>, mgalka@collabora.com,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        tomeu.vizoso@collabora.com, Kevin Hilman <khilman@baylibre.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Eric)

On Wed, 4 Dec 2019 at 17:17, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On 04/12/2019 15:31, kernelci.org bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > ardb/for-kernelci bisection: boot on rk3288-rock2-square
> >
> > Summary:
> >   Start:      16839329da69 enable extra tests by default
> >   Details:    https://kernelci.org/boot/id/5de79104990bc03e5a960f0b
> >   Plain log:  https://storage.kernelci.org//ardb/for-kernelci/v5.4-9340-g16839329da69/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-rock2-square.txt
> >   HTML log:   https://storage.kernelci.org//ardb/for-kernelci/v5.4-9340-g16839329da69/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/gcc-8/lab-collabora/boot-rk3288-rock2-square.html
> >   Result:     16839329da69 enable extra tests by default
> >
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> >
> > Parameters:
> >   Tree:       ardb
> >   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
> >   Branch:     for-kernelci
> >   Target:     rk3288-rock2-square
> >   CPU arch:   arm
> >   Lab:        lab-collabora
> >   Compiler:   gcc-8
> >   Config:     multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y
> >   Test suite: boot
> >
> > Breaking commit found:
> >
> > -------------------------------------------------------------------------------
> > commit 16839329da69263e7360f3819bae01bcf4b220ec
> > Author: Ard Biesheuvel <ardb@kernel.org>
> > Date:   Tue Dec 3 12:29:31 2019 +0000
> >
> >     enable extra tests by default
> >
> > diff --git a/crypto/Kconfig b/crypto/Kconfig
> > index 5575d48473bd..36af840aa820 100644
> > --- a/crypto/Kconfig
> > +++ b/crypto/Kconfig
> > @@ -140,7 +140,6 @@ if CRYPTO_MANAGER2
> >
> >  config CRYPTO_MANAGER_DISABLE_TESTS
> >       bool "Disable run-time self tests"
> > -     default y
> >       help
> >         Disable run-time self tests that normally take place at
> >         algorithm registration.
> > @@ -148,6 +147,7 @@ config CRYPTO_MANAGER_DISABLE_TESTS
> >  config CRYPTO_MANAGER_EXTRA_TESTS
> >       bool "Enable extra run-time crypto self tests"
> >       depends on DEBUG_KERNEL && !CRYPTO_MANAGER_DISABLE_TESTS
> > +     default y
> >       help
> >         Enable extra run-time self tests of registered crypto algorithms,
> >         including randomized fuzz tests.
> > diff --git a/crypto/testmgr.c b/crypto/testmgr.c
> > index 88f33c0efb23..5df87bcf6c4d 100644
> > --- a/crypto/testmgr.c
> > +++ b/crypto/testmgr.c
> > @@ -40,7 +40,7 @@ static bool notests;
> >  module_param(notests, bool, 0644);
> >  MODULE_PARM_DESC(notests, "disable crypto self-tests");
> >
> > -static bool panic_on_fail;
> > +static bool panic_on_fail = true;
> >  module_param(panic_on_fail, bool, 0444);
> >
> >  #ifdef CONFIG_CRYPTO_MANAGER_EXTRA_TESTS
> > -------------------------------------------------------------------------------
>
>
> Seems legit, from the log:
>
> <3>[   18.186181] rk3288-crypto ff8a0000.cypto-controller: [rk_load_data:123] pcopy err
> <3>[   18.199432] alg: skcipher: ecb-aes-rk encryption failed on test vector \"random: len=0 klen=32\"; expected_error=0, actual_error=-22, cfg=\"random: inplace use_finup nosimd src_divs=[100.0%@+2054] key_offset=16\"
> <0>[   18.220458] Kernel panic - not syncing: alg: self-tests for ecb-aes-rk (ecb(aes)) failed in panic_on_fail mode!
>
> Let me know if you need any help with testing a fix on this
> platform or anything.
>

This is an expected failure. I pushed this to my branch to check if
Eric's new AEAD testing code identifies any new problems on the
hardware we have in kernelCI, but it only found stuff we already knew
about.

> Also, as you probably only want this to be enabled in KernelCI
> and not merged upstream, we could have a config fragment to
> enable the config with your branch and maybe even others.
>

It would be *very* helpful if we could add Herbert's cryptodev branch
[0] to kernelCI with a kconfig fragment that turns off
CRYPTO_MANAGER_DISABLE_TESTS and turns on CRYPTO_MANAGER_EXTRA_TESTS,
and passes cryptomgr.panic_on_fail=1 on the kernel command line. That
way, we'll have rolling coverage of just the crypto changes queued up
in linux-next, but tested thoroughly on actual hardware, and without
the need to carry patches like the above to trigger the tests
explicitly.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/
