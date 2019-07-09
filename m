Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B789E6357C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 14:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGIMSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 08:18:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44097 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIMSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:18:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so19326918ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYUZq7v6hg9F7A7hhMPEbsURdusM+toQNt32J9GD77k=;
        b=f4xWJs1rkxhdZh6VKdTdoooCK03zPhYeu+utI5sLkxuMNNpq6JFZhCp6qlUvf2anbR
         bnD9Q16qqv4Dm6uP/sjy7HzUwVXVlXoVh5/xKv+25+7zR0BYqnxeW8uOzgshPKsIQvOF
         Mjtc5D/3WIRJy38LPeT9tu8iyOvc7OBDwEMukvnU3H2/czGHc8iId4gxHDRSwFZCU+2h
         KsDrxHQju99B34OL34vf21WFKzZ3D2AjR6FZXoyTwPxt4rFfTHvu3HA3oinCcy3Rvbhj
         vjfLPUH/gcYvmOpCnAmdNLX3i+9t7aI0sJJdllF/IqXMETEQhgSlmnvmWjKANEgCW2Xa
         r3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYUZq7v6hg9F7A7hhMPEbsURdusM+toQNt32J9GD77k=;
        b=lDWIaxIiVWl83C3PBb98DTP7l9oqdsQeil7pmqt48SfOmkbWbsISArWR0u2o9ftq07
         e96HWp2ZnODjhN8nNuDsmpPQY92ArqEEvpPB/GUNPRXCFwke7z99+d/Z5JktTa8vpsKr
         sr99Kz/m9NRd+vA3tlgNYdsFBNmZje0TBrTKPs658JL2G8wqjWOXv6qqOzeiiC8PxiJs
         9qJvmfB4LXoiy0mrsl9OVLscdLT+W00JauUtFBa0mVEq+ePyoQP6WKzP5JqZZc7E+e/+
         eTvbrofLkfHovcy9+3Cm8+6ArerNXCS7SrKc1NGdd/Wx4ntnWaiVZz5WsXfjwhmgLKX3
         U3HA==
X-Gm-Message-State: APjAAAVNS2ir6PBLk+3IkexmNqh208189Hq4tdf8mOa0H/hr3Gz6ELLc
        SQXqv56du2FPLTfOaMGAoUys03tN3AR2TBNK/1ondvupfRM=
X-Google-Smtp-Source: APXvYqy1qu2+l+YL5DOsxvjmzznPXi+BVdOsWmKyCR6/5tRMWSNFkxo+m/lnuvORd/QmhWM+XBF+DRoi2gMuPj5dv8E=
X-Received: by 2002:a2e:9593:: with SMTP id w19mr10559143ljh.69.1562674690149;
 Tue, 09 Jul 2019 05:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190708203049.3484750-1-arnd@arndb.de>
In-Reply-To: <20190708203049.3484750-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Jul 2019 14:17:58 +0200
Message-ID: <CACRpkdZO6to2UsJ64FCYi3aOC79PEb9pxOBABBkgcmR_d82dYg@mail.gmail.com>
Subject: Re: [PATCH] ARM: mtd-xip: work around clang/llvm bug
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 10:31 PM Arnd Bergmann <arnd@arndb.de> wrote:

> -#define xip_iprefetch()        do { asm volatile (".rep 8; nop; .endr"); } while (0)
> +#define xip_iprefetch()        do {                                            \
> +        asm volatile ("nop; nop; nop; nop; nop; nop; nop; nop;");      \
> +} while (0)                                                            \

This is certainly an OK fix since we use a row of inline nop at
other places.

However after Russell explained the other nops I didn't understand I located
these in boot/compressed/head.S as this in __start:

                .rept   7
                __nop
                .endr
#ifndef CONFIG_THUMB2_KERNEL
                mov     r0, r0
#else

And certainly this gets compiled, right?

So does .rept/.endr work better than .rep/.endr, is it simply mis-spelled?

I.e. s/.rep/.rept/g
?

In that case we should explain in the commit that .rep doesn't work
but .rept does.

Yours,
Linus Walleij
