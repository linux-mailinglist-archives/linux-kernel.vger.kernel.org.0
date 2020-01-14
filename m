Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82EE13B436
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 22:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgANVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 16:22:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34391 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgANVW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:22:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so16089344ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sA09QfXfHalAafAysRZFEbl/WyLTN07MU6TFhyXENpY=;
        b=ZuB9kWPAPxoZGiuuomw2iudECT1rt4Q/HncS4ElvHzHC6yUT2oQ0HUnEnUGkTmGfs5
         jSF+DX0BEvuJ4HATwr4M5/u+JM7dyP0AtYM8/eZRZWfxVC069BAzSr0Gdwlw9jjgh6al
         CCB0j1K9REL8bGh8CtUBoa4q17ax6w7GJvMoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sA09QfXfHalAafAysRZFEbl/WyLTN07MU6TFhyXENpY=;
        b=eDyHQgSclguGfaOiR4Bp20NzrafVENF9sIdhc/dZwo6JcRjPRozdB3Z215QmoaIqiP
         LCmYG5/XoOAbaZWmON9F3FOMMGZHiO/LjEHKWeGhnui1bmyGHdQnWk3iU+K3M21APAgi
         eUuyeZFwra9nNSyykMGJi5CcY3AW569fWyscssYj979Hn4pmJEd5ECsPX3Yh+dTMha2+
         /l74EWyhR8UzrCOLqADqEM8RpLzFXjG4w4GOqnyDvisb7Eq6qhQdB2+ZP0nHGwBKQyaI
         XnWOOAr76QAIjfFwm/kHIPorH3l7cA89SExAzNgr3nY13w1+c9uqR3CDat9/sldwXq8V
         RmRw==
X-Gm-Message-State: APjAAAV1SKFL3U/70m2d2vcUdo0neSMmvvITKkUkihQbT9dSJsCC0VeL
        D/iZWamRl/AucaGvae/6yPI5LZlSj2E=
X-Google-Smtp-Source: APXvYqyTFIbyAuX1d+60dXZRYRZJhbdb6pjGY7TypI0cIhoQOV2Ua1KwwW0r3VfOi/F6F2StSk1UcQ==
X-Received: by 2002:a05:651c:1214:: with SMTP id i20mr15985224lja.107.1579036945706;
        Tue, 14 Jan 2020 13:22:25 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l5sm8199136lje.1.2020.01.14.13.22.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:22:24 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id h23so16053121ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:22:24 -0800 (PST)
X-Received: by 2002:a2e:800b:: with SMTP id j11mr15632652ljg.126.1579036943823;
 Tue, 14 Jan 2020 13:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-3-vgupta@synopsys.com>
In-Reply-To: <20200114200846.29434-3-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jan 2020 13:22:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgoc5DaF6=WxsAcft_Lp4XUYTiRhhCJGcmM5PwEDXY6Gw@mail.gmail.com>
Message-ID: <CAHk-=wgoc5DaF6=WxsAcft_Lp4XUYTiRhhCJGcmM5PwEDXY6Gw@mail.gmail.com>
Subject: Re: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space
 pointer range check
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:09 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This came up when switching ARC to word-at-a-time interface and using
> generic/optimized strncpy_from_user
>
> It seems the existing code checks for user buffer/string range multiple
> times and one of tem cn be avoided.

NO!

DO NOT DO THIS.

This is seriously buggy.

>  long strncpy_from_user(char *dst, const char __user *src, long count)
>  {
> -       unsigned long max_addr, src_addr;
> -
>         if (unlikely(count <= 0))
>                 return 0;
>
> -       max_addr = user_addr_max();
> -       src_addr = (unsigned long)untagged_addr(src);
> -       if (likely(src_addr < max_addr)) {
> -               unsigned long max = max_addr - src_addr;
> +       kasan_check_write(dst, count);
> +       check_object_size(dst, count, false);
> +       if (user_access_begin(src, count)) {

You can't do that "user_access_begin(src, count)", because "count" is
the maximum _possible_ length, but it is *NOT* necessarily the actual
length of the string we really get from user space!

Think of this situation:

 - user has a 5-byte string at the end of the address space

 - kernel does a

     n = strncpy_from_user(uaddr, page, PAGE_SIZE)

now your "user_access_begin(src, count)" will _fail_, because "uaddr"
is close to the end of the user address space, and there's not room
for PAGE_SIZE bytes any more.

But "count" isn't actually how many bytes we will access from user
space, it's only the maximum limit on the *target*. IOW, it's about a
kernel buffer size, not about the user access size.

Because we'll only access that 5-byte string, which fits just fine in
the user space, and doing that "user_access_begin(src, count)" gives
the wrong answer.

The fact is, copying a string from user space is *very* different from
copying a fixed number of bytes, and that whole dance with

        max_addr = user_addr_max();

is absolutely required and necessary.

You completely broke string copying.

It is very possible that string copying was horribly broken on ARC
before too - almost nobody ever gets this right, but the generic
routine does.

So the generic routine is not only faster, it is *correct*, and your
change broke it.

Don't touch generic code. If you want to use the generic code, please
do so. But DO NOT TOUCH IT. It is correct, your patch is wrong.

The exact same issue is true in strnlen_user(). Don't break it.

              Linus
