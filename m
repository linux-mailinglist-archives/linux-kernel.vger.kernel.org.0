Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F908BF6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfIZQk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 12:40:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37936 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfIZQk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:40:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so2154316pfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esvGgHn/Fk8P7/1eukGo/3RvPgjyDzLIKExVZFQ9XgM=;
        b=totzfr7ujRiSU4GBennfp0gaTeOVKnDAcd6h1IsC1yLhGzWT/UgC+wXUblFxkx3N2e
         24scoPBq265Mb1BFAMQGDTrRS8IgPKDqAPwaqMuTOP1gQ5RfPox95hz3Rli7HgRxJaek
         2gYBeSov7tAmx7456XbDA+EZcExRu4w29jOoo2z65E575Qgr36VxfpdeWw8WylBdFsDD
         SavSpFEAof4Olb9gWkqpz3xJxkk+CjhZ06WAuCD4m+v4qYOHS4FIffDCP4G4uAB6hZ9M
         qXCTUx7gclVXF7Uf+m35XM5lx43wRtDTTICUXwiSD1t9uKj3lMiuaTmxF2MmS39xRxdz
         VsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esvGgHn/Fk8P7/1eukGo/3RvPgjyDzLIKExVZFQ9XgM=;
        b=Q+kegb07FS/gxEQu9k046cvmf6syotYDw6+l6cBJdQJF0/cslF8x92rjy9D8zkZbc8
         bja+34BCsa7Ezw4lgM13O8swltazClltTe2qShplGQ4F+V8LjjyZx9S2Q4etYeonP86k
         Eof7A3TPUfoJQL6sYHvRpuoLsKOrt1h7cF/hJJl84G/hNXjGc4PQOBJpmQ1N77TihlS/
         fgAJYUWp+saq+DGMd51psZP4mpawI05Qjp20NXQqgVV7jnvamB20jxLezc/LE2lM2Okk
         pdKoPdpeGguM2MRJnlrD5JPJyKZbQINJF9ds70hqdST3Oh6xTAxA8YuK76ShOUc+ZEtB
         jJpg==
X-Gm-Message-State: APjAAAV/F2aIs5V3Ddyv7Hv5TsghzOAc49ZE86AvyfEU4I5/NGiXyWvu
        nCEc+gHyNOjAD/uhXcmN4CWXXeRBF4248SmqsXQUaw==
X-Google-Smtp-Source: APXvYqwSTR6cAQDZeotV74lzttVw2dtqTt8GShXwmft9mDe5aQD2k5v7WPPJWUm/hUEUtA8dnesPi8ZeKc06wbZ8QlA=
X-Received: by 2002:a17:90a:ff18:: with SMTP id ce24mr4437144pjb.123.1569516054579;
 Thu, 26 Sep 2019 09:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190925130926.50674-1-catalin.marinas@arm.com>
 <CAKwvOdn2Sf7aAt0zqUUqGY6nXg-C3be7An9amy4tfiNr_8ERJw@mail.gmail.com>
 <20190925170838.GK7042@arrakis.emea.arm.com> <a7e06b86-facd-21de-c47c-246d0da8d80d@arm.com>
 <20190926074717.GA26802@iMac.local> <20190926155147.GL9689@arrakis.emea.arm.com>
In-Reply-To: <20190926155147.GL9689@arrakis.emea.arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Sep 2019 09:40:43 -0700
Message-ID: <CAKwvOdmtys4sgx_k3ikc3pYca4u9Es3hWJUJbckiDaDFBrn7Fg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Allow disabling of the compat vDSO
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 8:51 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Sep 26, 2019 at 08:47:18AM +0100, Catalin Marinas wrote:
> > On Thu, Sep 26, 2019 at 01:06:50AM +0100, Vincenzo Frascino wrote:
> > > On 9/25/19 6:08 PM, Catalin Marinas wrote:
> > > > On Wed, Sep 25, 2019 at 09:53:16AM -0700, Nick Desaulniers wrote:
> > > >> On Wed, Sep 25, 2019 at 6:09 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > >>> - clean up the headers includes; vDSO should not include kernel-only
> > > >>>   headers that may even contain code patched at run-time
> > > >>
> > > >> This is a big one; Clang validates the inline asm constraints for
> > > >> extended inline assembly, GCC does not for dead code.  So Clang chokes
> > > >> on the inclusion of arm64 headers using extended inline assembly when
> > > >> being compiled for arm-linux-gnueabi.

This case is very much real (not sure if Vincenzo was asking me or
Catalin), see report at the bottom of this comment:
https://github.com/ClangBuiltLinux/linux/issues/595#issuecomment-509874891

> > > >
> > > > Whether clang or gcc, I'd like this fixed anyway. At some point we may
> > > > inadvertently rely on some code which is patched at boot time for the
> > > > kernel code but not for the vDSO.
> > >
> > > Do we have any code of this kind in header files?
> > >
> > > The vDSO library uses only a subset of the headers (mainly Macros) hence all the
> > > unused symbols should be compiled out. Is your concern only theoretical or do
> > > you have an example on where this could be happening?
> >
> > At the moment it's rather theoretical.
>
> Actually, it's not. The moment the compat vdso Makefile needs the line
> below, we are doing it wrong:
>
> VDSO_CFLAGS += -D__uint128_t='void*'

*yikes*
-- 
Thanks,
~Nick Desaulniers
