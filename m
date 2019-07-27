Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06677628
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 05:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfG0DEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 23:04:48 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:55340 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfG0DEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 23:04:48 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x6R34KWh026693
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:04:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x6R34KWh026693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564196660;
        bh=KyUt/4DdOLcXzf6+RCuqvGSbJ9eJh3Y/n22t3XzqEBE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OwjLjNvBlz2157t2XcXCUEif8pHS+Wojx0/d/EG8lZssnqM2jVShir/NYLheWMboV
         uMwwwl8OhTmz127IIrmYVyMC+FSpZcNwvvPtypteRV0xtbEJCBgnjWx1am4bWOEIdR
         yryRMCnEOsnCpjRzWg3BrzOmKyIBZmpgD6ODG0KWTmoJToF8Hv/nHwfRjkTNV6qnCZ
         OpZ4kmaO7NPratni0VUY/I+CV4Z4vv59x3zjwI8r7PXBZHH0q9GokdvAP/6h16qxZz
         0vV0JF7uOZKvLUONjE5S3Vd6RRKL0wqBVudk8tp9SscHjRzhETeNdLCAT4DX4LGoCI
         +qM7hf3/RZmVw==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id u124so37406697vsu.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 20:04:20 -0700 (PDT)
X-Gm-Message-State: APjAAAVRHdqr0KuOfN93UA0sBK/hBAxu1x3JrBjNRFRdptkKQQzFDKgb
        ZGDhwgIFrOaaTBFpS4A1kWSbW1IWrXynJN0w43w=
X-Google-Smtp-Source: APXvYqxizoG9vfjaU3egrU+USC158UjJ9QuWzz0liWRnjquiTLTrE+BNF0sMg2gfGuSqvtT/oT1/gdrQA8S9RWLnB0I=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr38762600vsd.215.1564196659404;
 Fri, 26 Jul 2019 20:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190724002233.9813-1-k0ma@utam0k.jp>
In-Reply-To: <20190724002233.9813-1-k0ma@utam0k.jp>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 27 Jul 2019 12:03:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQa528Qq4Sm4DSQQeGiyGtwVD1eYBDJ414mhM_FqaAffA@mail.gmail.com>
Message-ID: <CAK7LNAQa528Qq4Sm4DSQQeGiyGtwVD1eYBDJ414mhM_FqaAffA@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: Add compilation database file
To:     Toru Komatsu <k0ma@utam0k.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 9:22 AM Toru Komatsu <k0ma@utam0k.jp> wrote:
>
> This file is used by clangd to use language server protocol.
> It can be generated at each compile using scripts/gen_compile_commands.py.
> Therefore it is different depending on the environment and should be
> ignored.
>
> Signed-off-by: Toru Komatsu <k0ma@utam0k.jp>
> ---
>  .gitignore | 3 +++
>  1 file changed, 3 insertions(+)

Applied to linux-kbuild/fixes. Thanks.

-- 
Best Regards
Masahiro Yamada
