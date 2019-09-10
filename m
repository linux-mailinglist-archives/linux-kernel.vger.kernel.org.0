Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3819AEE77
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 17:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfIJP0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 11:26:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42056 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbfIJP0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:26:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so11719572pfi.9;
        Tue, 10 Sep 2019 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szCNIUW6BgbokX0FPeRCVgqZ5ZdcFTN5rqoeuNdt524=;
        b=caR2EHx2Qt5HEr4rR7I7x4dW2X6VHrZZOd5QrFiwQrJcRuuNMXoYgnzTkWyFAo2FLI
         hIuVDkZMSQqupEAwSEVivqHBmD+UeeHLzBycMfwnzYXxLpNvOQnQjmpVF0AeIhJiGaEX
         C9BiYSXNaiFNjeXt5ERdvlkklW0kUyxOdN1pPlxEKI2FxI0WyoAzMVcmgMehTclWwZUS
         k4iPIKC58a+zGDjb0brPpC9UNBfDxITrvoCS6El+GKqRPLIkgHjzbTpEe14u9Le+86l/
         nd+6LahlcilZwQyO+zDB6DQKre3yKJB4kqglYJK5ji3DbC72wx35fRtE2asafjN68Et/
         Tymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szCNIUW6BgbokX0FPeRCVgqZ5ZdcFTN5rqoeuNdt524=;
        b=ucU0zRb9cbCBe9CFHh6DW4s16NhNmHFdnPRuNoZoLxJty+ET/KHdLlFAV3HQxAs1pD
         SP02zumpsvW+Rsp7p3D0xeM/Nc1Q7Fkbsps0RMNDZEZN4n6Kdq9Ua0/E248r0OyEbUj1
         2jkzdHTQ6NqgUpFhglYZlRBow5OkGv1CVcT0v1F9rzmAyklEo1HcCjVpJCtbp7u2ejQl
         aHMtTuMXbFesBreca+GXqrix/hREVZ5POQjpYRjVrd1G0fMNSUZiZS3Tti14pTUW7V8K
         kd5a4pUFe99+oJoKqRG+Q/rkNLd9kpa+v/Ao50FguyGfWTtRO+MV2cOyaQ2a8op69sJB
         Xcjg==
X-Gm-Message-State: APjAAAVFppRVYqzJ5AuLiT2vRRd1Ici6sZnhXCLggsL2ML2FKWm3Smhn
        qH8IIGBrq/sFtyEvrJZLL3nZNEd9HnE6polHPkI=
X-Google-Smtp-Source: APXvYqzOINBFtfLvF0b9qbl9PEWwDqdKgy6gSXJJzwn3QWuI+u/Xg4GqfM8xomnm9stnWRBe4FRdbpMx7VLIvJ9L0cU=
X-Received: by 2002:a17:90a:b313:: with SMTP id d19mr56369pjr.132.1568129203532;
 Tue, 10 Sep 2019 08:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk> <20190909203826.22263-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190909203826.22263-1-linux@rasmusvillemoes.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Sep 2019 18:26:32 +0300
Message-ID: <CAHp75Vdpd5uMCM-n+4vAZLwUpN=-cHnHs1uxoV2MDd5fk+CQig@mail.gmail.com>
Subject: Re: [PATCH v2] printf: add support for printing symbolic error codes
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 11:39 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> It has been suggested several times to extend vsnprintf() to be able
> to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
> another attempt. Rather than adding another %p extension, simply teach
> plain %p to convert ERR_PTRs. While the primary use case is
>
>   if (IS_ERR(foo)) {
>     pr_err("Sorry, can't do that: %p\n", foo);
>     return PTR_ERR(foo);
>   }
>
> it is also more helpful to get a symbolic error code (or, worst case,
> a decimal number) in case an ERR_PTR is accidentally passed to some
> %p<something>, rather than the (efault) that check_pointer() would
> result in.
>
> With my embedded hat on, I've made it possible to remove this.
>
> I've tested that the #ifdeffery in errcode.c is sufficient to make
> this compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the
> 0day bot will tell me which ones I've missed.
>
> The symbols to include have been found by massaging the output of
>
>   find arch include -iname 'errno*.h' | xargs grep -E 'define\s*E'
>
> In the cases where some common aliasing exists
> (e.g. EAGAIN=EWOULDBLOCK on all platforms, EDEADLOCK=EDEADLK on most),
> I've moved the more popular one (in terms of 'git grep -w Efoo | wc)
> to the bottom so that one takes precedence.

> +#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err
> +#define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = #err

From long term prospective 300 and 550 hard coded here may be forgotten.

> +const char *errcode(int err)
We got long, why not to use long type for it?

> +{
> +       /* Might as well accept both -EIO and EIO. */
> +       if (err < 0)
> +               err = -err;

> +       if (err <= 0) /* INT_MIN or 0 */
> +               return NULL;
> +       if (err < ARRAY_SIZE(codes_0))

> +               return codes_0[err];

It won't work if one of the #ifdef:s in the array fails.
Would it?

> +       if (err >= 512 && err - 512 < ARRAY_SIZE(codes_512))
> +               return codes_512[err - 512];
> +       /* But why? */
> +       if (IS_ENABLED(CONFIG_MIPS) && err == EDQUOT) /* 1133 */
> +               return "EDQUOT";
> +       return NULL;
> +}

> +               long err = PTR_ERR(ptr);
> +               const char *sym = errcode(-err);

Do we need additional sign change if we already have such check inside
errcode()?

-- 
With Best Regards,
Andy Shevchenko
