Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 324C54CD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbfFTL46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 07:56:58 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:51835 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfFTL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:56:58 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x5KBul1Q011553;
        Thu, 20 Jun 2019 20:56:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x5KBul1Q011553
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561031808;
        bh=/BAafWzA383+nnyZrdJw/BM2bhFflyPhOUVwypUThHM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LeqVTnDe4d2r0+uqfP//lmL9L2EjtR45DywdQowWQXN0AhRrTOaKoZ6rD2nc3YlRD
         JaqyMqGLgl2gi4Ax7y5jUqus6f1y2oufgMvw18Gf4wazTzmt6BDx6EST+gwHtN7hmC
         rW0AYEJVOY/zaQpafHN97seOvS2ir3tv703Hr67MNXV94SruXeT/iss9mDPprZvPes
         6ffHUlxCzOhE7ugrxMFHbnEh58qV86Nq0cRZcplGlZ4lkQ0P8uKrQKXrjjA8OQu6A3
         V7TWknv8ReiHCp7ipOaWD2CyqQH0fI9EyGZvwTIki5/zP856BDL8km5YCQNBNsLuJR
         74CRos0X5bKJw==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id a97so1506604uaa.9;
        Thu, 20 Jun 2019 04:56:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWN7PWZlEy9vDSK9xE89/WVbaBfUSdh3fTVIxUok1JOx35C3hqV
        KFWLKMGxzD6zNDGKvDY/PV0OVcLcbSoPzglZLg0=
X-Google-Smtp-Source: APXvYqzFkXkuPwWKvjNYsfDgjIps7UBQ7O0hc5whwGz64kb9K7YPhi3vRWwH/ZaeZ7YoQkBARIPfxZtpgqPY6CQyo6s=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr41998536uag.40.1561031806895;
 Thu, 20 Jun 2019 04:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190620064023.cwvcj5g4rgnmkmmn@gondor.apana.org.au>
 <9c994536a297449d843947ba9be05998@SOC-EX01V.e01.socionext.com> <20190620075838.sthw4kjpp2gt6t6j@gondor.apana.org.au>
In-Reply-To: <20190620075838.sthw4kjpp2gt6t6j@gondor.apana.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 20 Jun 2019 20:56:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATbMou4DHN9=POay4RGT6upj1RoUZPwfvaB7oZwqm5rfA@mail.gmail.com>
Message-ID: <CAK7LNATbMou4DHN9=POay4RGT6upj1RoUZPwfvaB7oZwqm5rfA@mail.gmail.com>
Subject: Re: cifs: Fix tracing build error with O=
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     stfrench@microsoft.com, linux-cifs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:58 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Jun 20, 2019 at 06:54:42AM +0000, yamada.masahiro@socionext.com wrote:
> >
> > I cannot reproduce the build error on the latest Linus tree.
> >
> >
> > $ make O=build allmodconfig fs/cifs/
> >
> > perfectly works for me.
>
> I was trying to build just the fs/cifs directory with
>
>         make O=build M=fs/cifs
>
> But I see now that this can't possibly work as M= only supports
> absolute paths.  As M= is supposed to replace SUBDIRS=, what are
> we supposed to do to build just a directory?


Documentation/kbuild/kbuild.txt says
M= and KBUILD_EXTMOD (and older form SUBDIRS= too)
are for building external modules.

Yet, many people still wrongly use them to build
in-kernel directories just because they seem to work
(but do not really).

The similar question, and the answer is here:
https://lkml.org/lkml/2019/1/17/584


-- 
Best Regards
Masahiro Yamada
