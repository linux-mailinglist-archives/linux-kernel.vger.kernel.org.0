Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8E71BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbfGWPeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:34:20 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:23719 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfGWPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:34:19 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x6NFYAOG026161
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 00:34:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x6NFYAOG026161
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563896051;
        bh=N8wYBRYX7KskQnF/bGZfXUpOo7enlO8gdq9+R2SRBS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1WYDi0ZUAmCzPDt1DW/czbgydroJyojsm/2ybzOB8u79n5y+Kg/fqZP8RGDWaQVxs
         KQMqKjebnNkzwuLooRYKx5YXj4mTJm045P8VidFmKTJqcq08/GihQ9Epz8mvCUsv+2
         F2rrNqOQ9btqBM1fQyvB1kru00G2AV4MTRlDYALmFBryIJQmO+QAXP0JSSeYy5FpK+
         LZC7oxzLZP2hFSwgpUC1HG4ee/T08Za+Dwx0smil2bBgHkkiFQX23MxzBULhY7x3ty
         uOdkc+aoqurrg39XvLUGrJ1Q5x67gvWOPl4IdmEClJxZdEpVW7K5Wry/KuaKrYJOf9
         bDg9+yuzVumPQ==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id o19so17063787uap.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 08:34:10 -0700 (PDT)
X-Gm-Message-State: APjAAAWir0rm+fRjwrS/23P6pMBFQEU5WM6KfYzd7LAw9i3OHEBkhchw
        HQQArVHDPeCX0HS2wTfI/q6rkeWilSLGRAO78zw=
X-Google-Smtp-Source: APXvYqyzCFZuuzPqWoMEpscGbZXPJ2gmIklxTeW/1RiOrdWaYgeR+vj58iK3IN7ilAXVG+lVq7v8Kemlz2BC5hd2hcQ=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr48030587uag.40.1563896049791;
 Tue, 23 Jul 2019 08:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190721085409.24499-1-k0ma@utam0k.jp>
In-Reply-To: <20190721085409.24499-1-k0ma@utam0k.jp>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Jul 2019 00:33:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBjkYHkmv1michYYMd-2_70d+-Gvg1Kv4FyPeeBShvdw@mail.gmail.com>
Message-ID: <CAK7LNARBjkYHkmv1michYYMd-2_70d+-Gvg1Kv4FyPeeBShvdw@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: Add compilation database files
To:     Toru Komatsu <k0ma@utam0k.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a nit.

The patch title is:
.gitignore: Add compilation database "files"

Maybe, should it be singular?


On Sun, Jul 21, 2019 at 5:55 PM Toru Komatsu <k0ma@utam0k.jp> wrote:
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
>
> diff --git a/.gitignore b/.gitignore
> index 8f5422cba6e2..025d887f64f1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -142,3 +142,6 @@ x509.genkey
>
>  # Kdevelop4
>  *.kdev4
> +
> +# Clang's compilation database files
> +/compile_commands.json
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
