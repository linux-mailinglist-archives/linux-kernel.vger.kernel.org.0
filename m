Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E89877CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 12:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406183AbfHIKvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 06:51:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43571 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIKvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:51:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so37819273pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fq3JjQiPRSr9h5rdyuZsyHe1NcG45aIFnLyLsEYW9MM=;
        b=fmz7CBprhcOyROOnhxAQLeMaTiFeYLCzctiCa/09jIWbFLdPDUzgq7S2n2tOgobfLt
         CfgvD3poJNs9c7R2m8zDmwyrvKFVVjkPl6OoYzKR9/LvmVzeBYsdfdcqgTmg2CkePj7+
         TrHG3u5TO/rB+5DP3CwDuZAfg4LQ4J2qJO83zrm90dDvX4BbVFBIPrkjDUi1SFAm5GjF
         WUCQplopPdm3Hv6De4vhOzh0H4+Nzs4nUi6TwaPWiRzFEgEOoTC8duMb218XgFdERX6T
         J7XtbHk9IRvE2iiqmxbGm7EILGQ6tfR/1PmCgIUm0c9vrQNrwGWhYco8ZUHTm12+QyYl
         F75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fq3JjQiPRSr9h5rdyuZsyHe1NcG45aIFnLyLsEYW9MM=;
        b=uYhAGwxbLdj0k4LE72k3Srd6g+M7CiGcmRkLHJP+k5baszYsRdbUAa8Zgu/yrqnviu
         xBWnLVDrrleKPd9g9i1RNBWIy0cTgE3LoGb0vgSZhuU4WAQ1LShbirXJZ0qXJ64A6x28
         FSknPmdT9h68AxfVmFXVYrIqP0IwYtmyeklIUhWGgxCx62SCcAd6KBNeNNQRrS3x0Uj+
         RoNDkySLhmle4b6nEyTO31NVVAmqGZuay/UNjHqjm/NAQTuPRtLITHAXMWUmmfgtBOWx
         p2+7suC21wtesUQZVJDq8+e3orO8ewtgTc9e1WpJC77G187KLLl9CZSpw+NflpD7EsVQ
         rjWg==
X-Gm-Message-State: APjAAAVwNxPvOyd5s6v/twQsRh06+Buof2wIsXuOW/FnobZtW1bt0bdy
        PFqDHYx7Vo1EpSCl53A9TRTuIMaUXdjQ4ihyV83mTN4AG/o=
X-Google-Smtp-Source: APXvYqyl/oWaFXkz86QgXMjklwFEFy4ERJznniRCq6jWm80+1iIZDj5QBUOEmuRRxdjnF1XqJi/hREMrctqnVpqt1uw=
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr18754588plp.18.1565347894910;
 Fri, 09 Aug 2019 03:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190809012457.56685-1-justin.he@arm.com> <20190809012457.56685-2-justin.he@arm.com>
In-Reply-To: <20190809012457.56685-2-justin.he@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 9 Aug 2019 13:51:23 +0300
Message-ID: <CAHp75VdH4=fnygn-a3acrbjMAVkGb9qkSSvDoTkMUYfUWV3XYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/test_printf: add test of null/invalid pointer
 dereference for dentry
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 4:28 AM Jia He <justin.he@arm.com> wrote:
>
> This add some additional test cases of null/invalid pointer dereference
> for dentry and file (%pd and %pD)
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  lib/test_printf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 944eb50f3862..befedffeb476 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -455,6 +455,13 @@ dentry(void)
>         test("foo", "%pd", &test_dentry[0]);
>         test("foo", "%pd2", &test_dentry[0]);
>
> +       /* test the null/invalid pointer case for dentry */
> +       test("(null)", "%pd", NULL);
> +       test("(efault)", "%pd", PTR_INVALID);
> +       /* test the null/invalid pointer case for file */
> +       test("(null)", "%pD", NULL);
> +       test("(efault)", "%pD", PTR_INVALID);
> +
>         test("romeo", "%pd", &test_dentry[3]);
>         test("alfa/romeo", "%pd2", &test_dentry[3]);
>         test("bravo/alfa/romeo", "%pd3", &test_dentry[3]);
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
