Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE13178B7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 08:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgCDHkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 02:40:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39570 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgCDHkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:40:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so1070312wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 23:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RNmsQpiHqfF/YSgO9NIM7W8CLgp3pdAVo9ykmJZlRo=;
        b=oVfcmTnpm3IisBAZOZhFMkm7jHzBWZKMQy3+fNwZiE84ISTMMwdHR1M2MI70C7JE79
         h+dlEJg1WqUTz5KeXNoPplBU/9fJtSyIUHStuFpxS15Kv20WMab3XUFasOOQTFzcflko
         d5yg1p4aGWRTggfr9RGgCuaDX0ya9cMQaVvGSd83TYZjcWbJ9NoKGu1qOEZ78t7A9O0b
         8sVO4QYD0K2fCCfY7gLSC/VzgwIiJfcurQT078dwwtQ5uLRDwCbbnyLI0pwwZ8TDSbpP
         ++jH3VqahXiptnqdTexN3p5HK9iOprfA8vR3Z3lBfMp6dKQSfryU9aCkBBE+0ZNYu/YA
         lDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RNmsQpiHqfF/YSgO9NIM7W8CLgp3pdAVo9ykmJZlRo=;
        b=S9O04IebPGonf9zwxq85b6FFbDi+wXbPUpKrTC5plPdwZD/J3bUhIP1I9WckDEr2Ok
         r8p3rHBV8JGEmzalc08lvMAJqu2NL8kMzhT8kAqgOA5JZgnLCQ5f7xdbIpqSozy39tso
         2iXu28ozTHGrW4qSo2NmLbZXW60FPD7Ite/AbtKQDtLsdZEywsIwRTQLuxaPIoAgkRYr
         QBnjhWhdnOBY/F+5/FTEDu+nDYqxkkQw8nK9I29Oz7rAhuy7DyeNRZiIHbrgE1Br6Eav
         Se2lx6jx1EyK4wjCi2r9hJgmDINjtRoIkZJI9bOpBj3XUbf/3rmg9BuH3wCWd45Iubcw
         PQfw==
X-Gm-Message-State: ANhLgQ0LBVvDmezS8y90j0a+8loaI6jz49X+zP93b2LwdJhxlwG4hVsE
        aPtSg0aytxz2hw2JmPSWGkdzSWgtc/oWSmawmkeWKQ==
X-Google-Smtp-Source: ADFU+vskboW/92fGHw8yfZSMDhTfUOgsQTJ3wM7mHxf3B6ugHu5h8UWfmWEUpFJKno4fiCYNiO2lp5cnJ56nibBCSbQ=
X-Received: by 2002:adf:a411:: with SMTP id d17mr2624915wra.126.1583307605723;
 Tue, 03 Mar 2020 23:40:05 -0800 (PST)
MIME-Version: 1.0
References: <c41cc67321d0b366e356440e6dbc9eceb1babfe4.1583105749.git.stefan@agner.ch>
In-Reply-To: <c41cc67321d0b366e356440e6dbc9eceb1babfe4.1583105749.git.stefan@agner.ch>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 4 Mar 2020 08:39:54 +0100
Message-ID: <CAKv+Gu-myRS5FWEVucdpS5zUXM+UjBdMGCiFbgu0=3=T8-9LFQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm/ghash-ce - define fpu before fpu registers
 are referenced
To:     Stefan Agner <stefan@agner.ch>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Manoj Gupta <manojgupta@google.com>,
        Jian Cai <jiancai@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 at 00:37, Stefan Agner <stefan@agner.ch> wrote:
>
> Building ARMv7 with Clang's integrated assembler leads to errors such
> as:
> arch/arm/crypto/ghash-ce-core.S:34:11: error: register name expected
>  t3l .req d16
>           ^
>
> Since no FPU has selected yet Clang considers d16 not a valid register.
> Moving the FPU directive on-top allows Clang to parse the registers and
> allows to successfully build this file with Clang's integrated assembler.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/crypto/ghash-ce-core.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/crypto/ghash-ce-core.S b/arch/arm/crypto/ghash-ce-core.S
> index 534c9647726d..9f51e3fa4526 100644
> --- a/arch/arm/crypto/ghash-ce-core.S
> +++ b/arch/arm/crypto/ghash-ce-core.S
> @@ -8,6 +8,9 @@
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
>
> +       .arch           armv8-a
> +       .fpu            crypto-neon-fp-armv8
> +
>         SHASH           .req    q0
>         T1              .req    q1
>         XL              .req    q2
> @@ -88,8 +91,6 @@
>         T3_H            .req    d17
>
>         .text
> -       .arch           armv8-a
> -       .fpu            crypto-neon-fp-armv8
>
>         .macro          __pmull_p64, rd, rn, rm, b1, b2, b3, b4
>         vmull.p64       \rd, \rn, \rm
> --
> 2.25.1
>
