Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B33A8CF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732862AbfIDQTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 12:19:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41036 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731911AbfIDQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:19:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so11500168pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j7WtStrOTgU0xftTvPfxcHzCbqawhqwZjsrZuTB+u2Y=;
        b=Gje1tajkGWiwHXd7AHg/WwNIdxQCo8PO5msGaUToV6qtEV9vohtEnnrkNNc2I/S2U6
         Q6dMLeF9wnosGYbyDjrT3fMInmDGzB2cG8Yeyr67uIRSLW+WjG3QPPSldtFUgpAP8xX8
         YZ8/i6rOEZnVS/awdmHGc9XYNglXKyyfNqDww89ZQvyGAwwCXRIZsICLhWIV/xnk4hEC
         QVmrgCdbgql01/L4Mru67EhZj/Iw2WXa8WE5ngoTzpqbrUfX9aCd5qgdbYfYqyMXi6RD
         8yRB8w85oUpE9RgfNiu+GachbBxmQN/pDQPodJGWbzzYH5MOkmbx4Z3SK9jQMeV1yXfK
         zWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j7WtStrOTgU0xftTvPfxcHzCbqawhqwZjsrZuTB+u2Y=;
        b=NywlhuZk2SReScwkF1/sL45qGunnuFL2SAtiW86dBjlQkvs3pl8PQY0Ol/2EJwn502
         9Vj0cR3iXWzKYQMjEcTB/po0rRE9voW7Tx1Td9H/Wy2mWZE8kLG00G3qnXo4wsZvEjl2
         WqVV9w/rhbR7zTg2eV08NQj/gEInrW5mxedqtl5e7cG+X9ighOWqNHViP7jT4IMHrmze
         DHOJPBmGoUMrSr6vfbQJKJRsZSIAF0K+7P4ocbW9Y1r7ZN+Hwc3YXYqTaNJPoYqZtOOl
         0wrbb+SaJIxJr63+agK3myeVl3KvUl1x6MzdiJiZHK1d7/z84hrz0Cum2miUaUvRO35g
         1sTA==
X-Gm-Message-State: APjAAAXX1IDNiGq1kg8hkjZLz9lMdqSKCrDt3D3qmHBeNLHN6ToT4SUY
        073gIVhe/thR8l01xelQuDRtxwsNUhoYThlkKOg=
X-Google-Smtp-Source: APXvYqxLmbhlmj7Zuajw/f+XtdINPtRiSK3rJkO1riUPyyhohbjRiMOGtDw4xKfLeIBsVJmhy114jN+gyotcCVdsu0E=
X-Received: by 2002:a62:c141:: with SMTP id i62mr25465785pfg.64.1567613976891;
 Wed, 04 Sep 2019 09:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Sep 2019 19:19:25 +0300
Message-ID: <CAHp75VcAEK0KioX-mvHeRqpX+c8Y7_A5X8RqmtHUT-MU-dXy6A@mail.gmail.com>
Subject: Re: [PATCH] printf: add support for printing symbolic error codes
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>, Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 12:48 AM Rasmus Villemoes
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

> +/*
> + * Ensure these tables to not accidentally become gigantic if some
> + * huge errno makes it in. On most architectures, the first table will
> + * only have about 140 entries, but mips and parisc have more sparsely
> + * allocated errnos (with EHWPOISON = 257 on parisc, and EDQUOT = 1133
> + * on mips), so this wastes a bit of space on those - though we
> + * special case the EDQUOT case.
> + */
> +#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err

Hmm... Perhaps better to define the upper boundary with something like

#define __E_POSIX_UPPER_BOUNDARY 300 // name sucks, I know

> +#define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = #err

Similar to 550?

> +const char *errcode(int err)
> +{
> +       /* Might as well accept both -EIO and EIO. */
> +       if (err < 0)
> +               err = -err;
> +       if (err <= 0) /* INT_MIN or 0 */
> +               return NULL;
> +       if (err < ARRAY_SIZE(codes_0))
> +               return codes_0[err];
> +       if (err >= 512 && err - 512 < ARRAY_SIZE(codes_512))
> +               return codes_512[err - 512];
> +       /* But why? */
> +       if (IS_ENABLED(CONFIG_MIPS) && err == EDQUOT) /* 1133 */
> +               return "EDQUOT";

Another possibility is to initialize the errors at run time with radix tree.

> +       return NULL;
> +}

> @@ -2111,6 +2112,31 @@ static noinline_for_stack
>  char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>               struct printf_spec spec)
>  {
> +       /* %px means the user explicitly wanted the pointer formatted as a hex value. */
> +       if (*fmt == 'x')
> +               return pointer_string(buf, end, ptr, spec);

But instead of breaking switch case apart can we use...

> +
> +       /* If it's an ERR_PTR, try to print its symbolic representation. */
> +       if (IS_ERR(ptr)) {

...  if (IS_ERR() && *fmt != 'x') {
here?

> +               long err = PTR_ERR(ptr);
> +               const char *sym = errcode(-err);
> +               if (sym)
> +                       return string_nocheck(buf, end, sym, spec);
> +               /*
> +                * Funky, somebody passed ERR_PTR(-1234) or some other
> +                * non-existing Efoo - or more likely
> +                * CONFIG_SYMBOLIC_ERRCODE=n. None of the
> +                * %p<something> extensions can make any sense of an
> +                * ERR_PTR(), and if this was just a plain %p, the
> +                * user is still better off getting the decimal
> +                * representation rather than the hash value that
> +                * ptr_to_id() would generate.
> +                */
> +               spec.flags |= SIGN;
> +               spec.base = 10;
> +               return number(buf, end, err, spec);
> +       }


-- 
With Best Regards,
Andy Shevchenko
