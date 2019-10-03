Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F48C99B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbfJCIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 04:23:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35492 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfJCIXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:23:12 -0400
Received: by mail-oi1-f193.google.com with SMTP id x3so1829182oig.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UrOVvtok0uymTGoBhO1tPdn3aCgpqxGA17M9N6XBPfA=;
        b=U/Jlme74zOUlrCR8ZhKj+vaPPMPWfOKQBc9zFQhJlUukL0kL1HFbBVd0OXD3wX+5E9
         MtfWQYuSv+TprRuG11V58kHZUkcF5q8MKOPBOtNlCMqp6s/bsZ32ONk7mLgPDfOx9Tte
         Fthh7HkbWZaSfU/kqVvaB1Ti4PFfY3bNnSElArV2bEHQuN5gQMz0d202zjTBsTDcpLuj
         vV3aoeSVXwN4xxHtCqCNKXQDI+TTfy40fQtKwJqtQpjfHbt19B0iAXipmxkN6FqkWxdU
         eZ4jAE48tGg3Y9dfgISSkQF7TE+t9vL6qPEyp93rtsOpT+6fXIdfVxsS2+cL4ohD1V4O
         29Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UrOVvtok0uymTGoBhO1tPdn3aCgpqxGA17M9N6XBPfA=;
        b=EJz1sL7wK6iuRi7wLi3o1qkj5TsQzXu29CHo1In3YxlHbAc7BXYno4pP1cNw3Lzpui
         Xkrjwh1tOZ0pbKGnDQ4nzEwtgj8WbcBEa/0OtyrDWiHaQc0F7vSv1GZIdbDIUW6RnYv3
         VjVBnC4KNxzmsWdYj47tJPL/sHw6c+5Q7s3pp3SL+DphkMpiDWQuWPoO0nRgG5d/Nb9f
         ZM0u6OP/xpX9gHpKzMM+rLUllb0MT6ZX6aKO27/ePKqUU1WsSQiDXAw/ERcPlJGy67/R
         2JJ/3U45Te/OLR4N6QZepWX2XOh2/ETmNxBPpu+51gloz5UOeoeyftNFZu24SBHBZLFQ
         prjg==
X-Gm-Message-State: APjAAAVCWZ48d3CnDRVRYjaIrPUNRAuPfY3pjzJg7wpBF7HYsaot8kG+
        f0/Ckmwoy843wh6HmkVj1h3v+YeK855t2dKPCkg+5gO4
X-Google-Smtp-Source: APXvYqyXucKIw3BGYj4GTqQI5auzDGDNuJyDj9w+notR7ZJAI7zH2iAfnJ/YYeT28C6YiaNwWk9eOZlB82+RfG5usgg=
X-Received: by 2002:a54:4f8a:: with SMTP id g10mr1905955oiy.147.1570090991558;
 Thu, 03 Oct 2019 01:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190927011641.4858-1-skhan@linuxfoundation.org>
In-Reply-To: <20190927011641.4858-1-skhan@linuxfoundation.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 3 Oct 2019 10:23:00 +0200
Message-ID: <CAMpxmJXJB=KjSqtqKNmm2N8UbgSrJXvpKwgDj9DtSwfR7owFfQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] tools: gpio: Use !building_out_of_srctree to
 determine srctree
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 27 wrz 2019 o 03:16 Shuah Khan <skhan@linuxfoundation.org> napisa=C5=
=82(a):
>
> make TARGETS=3Dgpio kselftest fails with:
>
> Makefile:23: tools/build/Makefile.include: No such file or directory
>
> When the gpio tool make is invoked from tools Makefile, srctree is
> cleared and the current logic check for srctree equals to empty
> string to determine srctree location from CURDIR.
>
> When the build in invoked from selftests/gpio Makefile, the srctree
> is set to "." and the same logic used for srctree equals to empty is
> needed to determine srctree.
>
> Check building_out_of_srctree undefined as the condition for both
> cases to fix "make TARGETS=3Dgpio kselftest" build failure.
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Rsending with corrected address for linux-kselftest@vger.kernel.org
>
>  tools/gpio/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
> index 6ecdd1067826..1178d302757e 100644
> --- a/tools/gpio/Makefile
> +++ b/tools/gpio/Makefile
> @@ -3,7 +3,11 @@ include ../scripts/Makefile.include
>
>  bindir ?=3D /usr/bin
>
> -ifeq ($(srctree),)
> +# This will work when gpio is built in tools env. where srctree
> +# isn't set and when invoked from selftests build, where srctree
> +# is set to ".". building_out_of_srctree is undefined for in srctree
> +# builds
> +ifndef building_out_of_srctree
>  srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
>  srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
>  endif
> --
> 2.20.1
>

Applied for fixes, thanks!

Bart
