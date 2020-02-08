Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70A1563C0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Feb 2020 11:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgBHKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Feb 2020 05:05:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35200 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgBHKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 05:05:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so800872plt.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 02:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHm9ScY1W7HbxvW6Q4kkAHk83yXu8ldB5vCdWx34dho=;
        b=JosfX2NhucfWy8tdHRjwCtP3qFTnjdpdENc56F16apcbSS4qDozXpdczm0NtHOKJQ+
         uI98SLwFXqqmeerrFLWR+Q0m2qONO1I5TGyzpIAs6Dup1NA6uKs2+yOpMIrKn77GuU24
         lZnjl4X0qDKfqAUAuR2wQIbFW8k2knOo7zU/ls4Pz/36+M/kgJk5M/BlXDM6mHiiKwI6
         C67MbnXHSSTxjLkmgwZ6II8Fw7B+7SayhxPm4HHf56NoBRL6sf4E4Vcm5Nsu+hUzog5D
         geD91XFDS6ctD6sT+DKJLg/90N2LaQEnh2tfAZ6jpsYnUlrX4dd+tTJ456fkp44DZPTm
         Mu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHm9ScY1W7HbxvW6Q4kkAHk83yXu8ldB5vCdWx34dho=;
        b=tWBVBKFxA7IJdtAE7NpHkRnJGT/ztEBj37lydzOdgPpiZL8hSM1r7n9HSKS20ozdCp
         5ncm5J6f/iYUwPpm6bCfNAzg1yDYMinhJw1YcJjXd7Mr9Yj9uDUhAUsv+YmPuOb9f+U1
         5RuINXTIAamRXfXr4kRU6svUVKTKao0948xarcr3xnCZTXRughIdrwnNP6KCGG6F6Sb7
         fgTjQYeawH/4jq92DvniaacfIOYZPsA8J1z+wmuzKh8+aCEjxFjRb+k75oIezpeqIhlR
         ROCstU5mWu7BbONocROTIV+6Qk5cEPinQeIZiyx+u32WK5ae4D903V99MDaP6ttQVuMQ
         ZCUQ==
X-Gm-Message-State: APjAAAVFUTvFZYGXW9AYfhxNX4Qs21nAyBDBUrMcC7w0HjngMMQe4Mlg
        o4C6BNnFqudmXC0GMlCSSSSz9CgCt2/NX8NH6DLYufkjDuw=
X-Google-Smtp-Source: APXvYqwpSV1P/sXecoyEQnCNmPDZ7xFUP2gfsxGiywdF3N45t/9B9IoeSS9XXyDAVpaN8bquhMmhdAYy4SesweE+eyE=
X-Received: by 2002:a17:90a:3745:: with SMTP id u63mr9116235pjb.123.1581156351972;
 Sat, 08 Feb 2020 02:05:51 -0800 (PST)
MIME-Version: 1.0
References: <202002080058.FD1DDB1@keescook>
In-Reply-To: <202002080058.FD1DDB1@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 8 Feb 2020 10:05:40 +0000
Message-ID: <CAKwvOdm=r8BK62QRqhpyek56rMv8fEKmT+=uJ--2pbo49RBg3w@mail.gmail.com>
Subject: Re: [PATCH] ARM: Remove unused .fixup section in boot stub
To:     Kees Cook <keescook@chromium.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Manoj Gupta <manojgupta@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 10:04 AM Kees Cook <keescook@chromium.org> wrote:
>
> The boot stub does not emit a .fixup section at all anymore, so remove
> it.
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://lore.kernel.org/lkml/CAKwvOdnRhx=SgtcUCyX2ZOGATM8OzG6hSOY9wGQZcwtp+P5WBQ@mail.gmail.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/boot/compressed/vmlinux.lds.S | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> index fc7ed03d8b93..b247f399de71 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -36,7 +36,6 @@ SECTIONS
>      *(.start)
>      *(.text)
>      *(.text.*)
> -    *(.fixup)
>      *(.gnu.warning)
>      *(.glue_7t)
>      *(.glue_7)
> --
> 2.20.1
>
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers
