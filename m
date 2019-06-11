Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9373D6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 21:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406945AbfFKThs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 15:37:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46473 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404788AbfFKThr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:37:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so5534242pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPoxxDVnePPhHUER+oER3oucDE8cdYp68lXRy9Z4zNg=;
        b=k9WZh4iOpYWtOERFcVxwA7ZlNcmKiK5gV6X1KXLLIgNZn+REeO9MREV2X5pbW/pmOe
         UrTduLBgyue13Zaq9MrTZjQN5X2mgOjzFJY7Ib1tQV5Me96dAMOcwx54G0pB5SKo5mmY
         zlwf5lysaK6UXnniIaXfoEH6tiTaEiL46MdhYtNR0Ot22ml1yLwkttqOPyi5lMp10HbN
         XU/n4SePZ4jkJhUIRA6qaUjI0XlTz56USBikTEOZYYlcgVFtsTV5JhGBPqX0tytMuKPa
         lL7TX8wlhlrfrWE8FX7obHiWs55oLP5+0nIOnK/3ELP2MbCmcVYtCA1A6/K/zzHpSb1/
         MMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPoxxDVnePPhHUER+oER3oucDE8cdYp68lXRy9Z4zNg=;
        b=gYcCj293qrGat/f4ajhb2CIlQ8Ba7zV0DCAOJtKk6+OLrFWhumG2OjFTNQVOkv8d2u
         7LAmk5cp/z1yhzutXnAFotWzrPfnJLoZYfJLOA3SNXC7P+I96H/CDSZQqxjB8JO0/V2w
         B90oFqj9PDC11/tUf5YOG1Tph7WzYHs6/aoXgJxOh9AMLs1RCCetXzPRNhZQLJrRqfZk
         md32g4uCZPtrpNL2C4xU5qeR0ublzpaTKXohZg5aTBRC7R5wpq0nbY79rlL5Er1BO7Wr
         t3ssDlhyyICJzUpjy1nsIjdi4T+DH7OAXGDxSMMY5mql6eUPdCBLcjjgTqPLkaKVsaNM
         GA1A==
X-Gm-Message-State: APjAAAVPmXEwxJBE+ljxGs+exs1hLxVob3YVGP2gN//jpYoKw1SjzPJc
        W9M4mh58lSgjkY7exk5PamoCPoib6l5F1VCOwQ5Oww==
X-Google-Smtp-Source: APXvYqx/0My5JwesbKnFTk6TQKBZUVLR+S7nz6oUlQpnVsyPBzrdUapvqCfOf9Me69/XI6Gva9fSZxSOhyWbsVoU1Q8=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr75104375pls.179.1560281866598;
 Tue, 11 Jun 2019 12:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190611184331.44242-1-natechancellor@gmail.com>
In-Reply-To: <20190611184331.44242-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Jun 2019 12:37:35 -0700
Message-ID: <CAKwvOdkxjweo=s-9tBNGwyjDJfyDfHjT7+DS+-Q-Sx7Ms8uoPg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add -Werror=unknown-warning-option to CLANG_FLAGS
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Smith <peter.smith@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:43 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> Suggested-by: Peter Smith <peter.smith@linaro.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I verified this has no negative effect with -Qunused-arguments and the
relative position of the two flags.  The build failure is much more
explicit with this patch:
> error: unknown warning option '-Wno-psabi' [-Werror,-Wunknown-warning-option]

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index b81e17261250..5f9d09bd2252 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -528,6 +528,7 @@ ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  CLANG_FLAGS    += -no-integrated-as
> +CLANG_FLAGS    += -Werror=unknown-warning-option
>  KBUILD_CFLAGS  += $(CLANG_FLAGS)
>  KBUILD_AFLAGS  += $(CLANG_FLAGS)
>  export CLANG_FLAGS
> --
> 2.22.0
>


-- 
Thanks,
~Nick Desaulniers
