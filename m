Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79362790B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfG2QVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 12:21:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33112 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfG2QVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:21:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so27638440plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6c39aHCrPSADKgn1QA3sQ/OzJg2W7CUxLj9xwpXNwm8=;
        b=QNUdnwD+0BnljNKmpSMc4dq1BHiw94BWEcKU6fhvEQa03/4iKV41fAYISj+UN/3NAL
         4U3SKSKjVySDfUikKeS7kxUw15lpQOIY6MO0E7z+KYjC5MJLO6LXo0+jxLdjCRpKdisd
         9d5GqsNYlbc9jvHYMxRLbYC1fQPIgz7J9VZ1gGCGAzc+2MhgJW88fvuhsEJRZIKOKUSm
         wj/WB4k+6L+qzQLCI4Grpkmjj+3If7uPvcS7y1u6H1mDyYfeVqylpARfkL1K0KmJWas6
         C+NAm3hah4FzqYYgR7uaMLyyl7qdKYmPl2O3w4Y3EIwOGUb+aq/Ro29iUmqbaubuzhqO
         Fpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6c39aHCrPSADKgn1QA3sQ/OzJg2W7CUxLj9xwpXNwm8=;
        b=DFU7VBDRvjWvt4Gy8cCbvIsaVzbKIDrSwm44BYysRUGIGdTBhfvdRo3Sjx3m2jg845
         /8imH0PduZI4naYnG5Vnm/zDYiPR4U7pxO+tOC3BvN2q7aV3kUmNBRztqePZfjKn2/Gz
         HkblqrAYDt1rez+PWbDRHgb9f8+JVIVocPmDjJpcPATVOv6VN4wTNIIPESajut5IaVQX
         WtyMipOIsIEhDPqEcDl5qnj5DDLNFWitYVZPbX3y9VBlqc+2aOMMlWLDsYDz/DGfqq65
         +5LQF15/gMZoXVLuXtozH6WXa2+EXanCvgwL2ZGaF9YigzFXHadA3sqaBIHtLnMFUzGf
         EFmw==
X-Gm-Message-State: APjAAAVQT9+Jpzm3Ye2RQjDyTdROejLWRvw60Z2snpjSF7TjL3kqlUvF
        ijLulyZDpK/HU+vd6TpKDCGWbiVXXw+eZT0DzHg8EA==
X-Google-Smtp-Source: APXvYqxNskZ/KQ64ZtfmGcktH0OJHpIo2HF39Q8rmuazafjjU1buTQDpZhkJSEFFXEE2fvgDHJElTStCCkxLT6/DleE=
X-Received: by 2002:a17:902:e703:: with SMTP id co3mr13856835plb.119.1564417305124;
 Mon, 29 Jul 2019 09:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190729091517.5334-1-yamada.masahiro@socionext.com> <20190729160412.GA100132@archlinux-threadripper>
In-Reply-To: <20190729160412.GA100132@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Jul 2019 09:21:33 -0700
Message-ID: <CAKwvOdnU8tLQ=wYAKs9Fy+3c2e_NmKL6H4kRKsRxH=sv16+8cQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: initialize CLANG_FLAGS correctly in the top Makefile
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 9:04 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Jul 29, 2019 at 06:15:17PM +0900, Masahiro Yamada wrote:
> > CLANG_FLAGS is initialized by the following line:
> >
> >   CLANG_FLAGS     := --target=$(notdir $(CROSS_COMPILE:%-=%))
> >
> > ..., which is run only when CROSS_COMPILE is set.
> >
> > Some build targets (bindeb-pkg etc.) recurse to the top Makefile.
> >
> > When you build the kernel with Clang but without CROSS_COMPILE,
> > the same compiler flags such as -no-integrated-as are accumulated
> > into CLANG_FLAGS.
> >
> > If you run 'make CC=clang' and then 'make CC=clang bindeb-pkg',
> > Kbuild will recompile everything needlessly due to the build command
> > change.
> >
> > Fix this by correctly initializing CLANG_FLAGS.
> >
> > Fixes: 238bcbc4e07f ("kbuild: consolidate Clang compiler flags")
> > Cc: <stable@vger.kernel.org> # v4.20+
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
