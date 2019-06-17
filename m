Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A00548AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfFQRtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 13:49:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42415 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfFQRtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:49:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id l19so6203151pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7vdD9VPFK0+Xky8RLVoGN1gXzJuRD+60CWyOI7Wh4A=;
        b=LedKRuqOQ3UYxWZRgPkUVmbQ4KRO9oI0h/OfrWpqyJbhKuReDUkOD57gXsf+wE1Gfg
         bqnbC+Rr3DYGd9Wv3sXqe6ZhTP7XbDDHNZ9WCGO+v6FM2EHOqNfglqV9XAzdq/P/Nkf5
         N7ork70khfcfYUBTDJc314YGJYi8yHI+UCY3OUzIyQQxSJHYABm7XTwrKjejEntYpSKs
         UFh2R5bwKkvyoXsP6+OZYFS/OW1RmlsRV7ZDCXQz9Q7ufcyg4u+SoNEi3ueSfzjaaKA5
         IGc1OL0juhlJUK8kAmNu+I/Qeo0GefNCwXxyGhrBWTw876uuRJDlTzc8PqvZuv0oBmV3
         EBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7vdD9VPFK0+Xky8RLVoGN1gXzJuRD+60CWyOI7Wh4A=;
        b=EOdcLgEd1ImlqkNXWuq2ZOcmaORoO/5r8Tk6GIIGjD96jLaxJjHA4FqwZwlnonAMdj
         XJf4G4aET9/39hGrgxnkumD6HbccTdXAnsPod7M1vQuVtPSoaJAaZVdJwoeFWT6vOuSo
         zADkw0z5YFl2fT1YEF9A3dZM7VnI0nSzimlG/QmoJkOb76Yhq9x7TMiDwYlOrF4WDsoI
         pKG8hb0KcvR4Juk/QKVV3BG6C6h4hD722kheYWOkCllRgSlzK/72QTKQjeea757vwHvK
         EdmLn1tHQnsREkr+0x4qJi144VFvh9a3nflgcYJ8IyZiMzgE51l0oi8CgwBGqpqZOXhS
         wO7w==
X-Gm-Message-State: APjAAAUaaGYONsyZiwc3/+iu7KQ6QsJjj55O4tVHmbwpBn53Op8Ax0Qm
        TA5bdnS7Jzytl1pJm+797uB012SlvxdwdVIkEPqgVQ==
X-Google-Smtp-Source: APXvYqz/Rr1ZQZTHLSiw2nXmVo5B1aASs8f4Vn2eVbLLCQy+Ht8IfHVX0p83BpCYvBCFIbaqbWiUbNSu0pqPqnz6dsU=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr26781289pje.123.1560793742592;
 Mon, 17 Jun 2019 10:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190617172829.164520-1-nhuck@google.com>
In-Reply-To: <20190617172829.164520-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Jun 2019 10:48:51 -0700
Message-ID: <CAKwvOdk4yvWQynR4uPzDFPonfVTTDt7_ZaqR2MJGUm78PQ4Gfg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Remove unnecessary -Wno-unused-value
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:28 AM Nathan Huckleberry <nhuck@google.com> wrote:
>
> This flag turns off several other warnings that would
> be useful. Most notably -warn_unused_result is disabled.
> All of the following warnings are currently disabled:
>
> UnusedValue
> |-UnusedComparison
>   |-warn_unused_comparison
> |-UnusedResult
>   |-warn_unused_result
> |-UnevaluatedExpression
>   |-PotentiallyEvaluatedExpression
>     |-warn_side_effects_typeid
>   |-warn_side_effects_unevaluated_context
> |-warn_unused_expr
> |-warn_unused_voidptr
> |-warn_unused_container_subscript_expr
> |-warn_unused_call
>
> With this flag removed there are ~10 warnings.
> Patches have been submitted for each of these warnings.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/520
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Most importantly, it fixes __must_check, which has been silently not
working w/ Clang.  Nathan sent patches for the issues we could find w/
x86_65 and arm64 allyesconfig builds, and even fixed a bug in Clang.
https://reviews.llvm.org/D63369

Thanks for all of the work that went into this.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/Makefile.extrawarn | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 3ab8d1a303cd..b293246e48fe 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -68,7 +68,6 @@ else
>
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CFLAGS += -Wno-initializer-overrides
> -KBUILD_CFLAGS += -Wno-unused-value
>  KBUILD_CFLAGS += -Wno-format
>  KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-format-zero-length
> --
> 2.22.0.410.gd8fdbe21b5-goog
>


-- 
Thanks,
~Nick Desaulniers
