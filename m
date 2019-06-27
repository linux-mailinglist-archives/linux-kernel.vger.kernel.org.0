Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4D258E42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 01:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfF0XHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 19:07:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41596 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0XHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:07:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so2077654pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 16:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8aV1JatTnCG9rEfKFqUjdOyDtVtjZrcPrKiiada/KQ=;
        b=PI8yun9rIYrfvJePU9ieiN5O/3Qk2VslkzAZJXq2L0EBRtjuK6USjOKgOZ7Sc3b+kf
         LPjwHijZrg/3NHKZAYZHn8P3h7xwVWlHnKoc2/RrtZtZgli4ONeW98tcloEtmOsMxT5m
         QVM3ftbNcbQGm+emV1Lijfg3U4M9T1XcPT5f6kW8AfUQ44udK7p25ZgMy/I2rTzLM34G
         mWCxIs5XIjjiXQdMjtLFVEc3ANV0UzH068BKZGk1INqR1RU80HQd+ujezyya4rmZvA5b
         u6sdkn++METQypcjKKe5RUomOOj0r19dOFdHGeJotVDCVz1KLCVeRTLX6reoAbhQrHhm
         kLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8aV1JatTnCG9rEfKFqUjdOyDtVtjZrcPrKiiada/KQ=;
        b=ZmJw+cDmYW+XVdyrxgV5Nwx1nikuh6oHTIzlw1ltwLr8JWqlSY7D3p/SaMgVuJO7vD
         QGzZqfYOn/XzxQAyt2hzDRtxdx/Hkqbgl+bDGSV5/zJk4IoY6bWdvUQGggForStV59j5
         ExEmpEly/JaJeta0NtW+3Gg7G0oBht3+o6N1EIL6R2fHI6/CphzOzr81nxH1EUAbk9rp
         QKLacDRCgkvRawG1H+NmS2Afd/eSDiB89AijYP3BWCHW6O7gYvtLZDvo4He3HJM69boH
         5q2XoxUeg7Ae1cnmX/9i4FYlNY+mmXs7p+QOJtSueIIGHGrgXyddn+HP7YpBHa3m00xa
         l4/Q==
X-Gm-Message-State: APjAAAVm2Xg8FwTWGoAMWrO4BBDlUQKsj29IrZgCvN+SPGpPccXLTB5H
        YUUMTPMnNg4QOzKF6H5IIcAxEeLCAliUJZdLeHQb2A==
X-Google-Smtp-Source: APXvYqwWpZpvsnZI1MNBHv4VcBRtExkgggkF2GcyWY7FfmfWI8rEETy9DfUnxj5aU4wruEHdvjbqLbL5JkRgkd6QXzU=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr7450025plq.223.1561676836363;
 Thu, 27 Jun 2019 16:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190627221507.83942-1-nhuck@google.com>
In-Reply-To: <20190627221507.83942-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Jun 2019 16:07:05 -0700
Message-ID: <CAKwvOdkYvuYTq=kV9yBWmStQ4GhMtpnp9dV5UvASQKeMwfu0Vw@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: Fix -Wunused-const-variable
To:     fparent@baylibre.com, sboyd@kernel.org
Cc:     mturquette@baylibre.com, Nathan Huckleberry <nhuck@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 3:15 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Clang produces the following warning
>
> drivers/clk/mediatek/clk-mt8516.c:234:27: warning: unused variable
> 'ddrphycfg_parents' [-Wunused-const-variable] static const char * const
> ddrphycfg_parents[] __initconst = {
>
> This variable has never been used. Deleting it to cleanup the warning.

comparing this to `nfi1x_pad_parents`, it looks like this maybe should
be an entry in `top_muxes`, but there seem to be some magic constants
in those that I don't understand or know what we'd use for
`ddrphycfg_parents`.

Again, looking at `nfi1x_pad_parents` for reference, we see
`CLK_TOP_NFI1X_PAD_SEL` used with it and being defined in the device
tree bindings in include/dt-bindings/clock/mt8516-clk.h.  I would
guess that `CLK_TOP_DDRPHYCFG_SEL` should be used in `top_muxes` with
`ddrphycfg_parents`.

`CLK_TOP_DDRPHYCFG_SEL` appears in:
drivers/clk/mediatek/clk-mt8135.c
drivers/clk/mediatek/clk-mt8173.c
drivers/clk/mediatek/clk-mt2701.c
drivers/clk/mediatek/clk-mt7629.c
drivers/clk/mediatek/clk-mt7622.c
but not the translation unit in question:
drivers/clk/mediatek/clk-mt8516.c

in most of the above (except clk-mt2701.c which simply has 1
additional field but otherwise matching values, and clk-mt8135.c which
has 2 different values), it's added to a similarly named and typed
`top_muxes` as:

MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, "ddrphycfg_sel", ddrphycfg_parents,
  0x040, 16, 1, 23),

even then `ddrphycfg_parents` shows up in the other translation units
in the same statement as `CLK_TOP_DDRPHYCFG_SEL`.

So questions to the maintainers I have:
1. Is the above `MUX_GATE` what should be added to `top_muxes` in
drivers/clk/mediatek/clk-mt8516.c?
2. If so, where? Is order of the array elements important.

If the answer to 1 is no, then we should take Nathan's patch.

>
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/523
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  drivers/clk/mediatek/clk-mt8516.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
> index 26fe43cc9ea2..9d4261ecc760 100644
> --- a/drivers/clk/mediatek/clk-mt8516.c
> +++ b/drivers/clk/mediatek/clk-mt8516.c
> @@ -231,11 +231,6 @@ static const char * const nfi1x_pad_parents[] __initconst = {
>         "nfi1x_ck"
>  };
>
> -static const char * const ddrphycfg_parents[] __initconst = {
> -       "clk26m_ck",
> -       "mainpll_d16"
> -};
> -


-- 
Thanks,
~Nick Desaulniers
