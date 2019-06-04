Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C367235156
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 22:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFDUvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 16:51:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41285 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFDUvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:51:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id 107so15080481otj.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 13:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzJhGKhzrzdwswjZmo+oYPOFFA3OkVX4vMWQxKITSco=;
        b=W7HGaO0fnOLgvhIhRQmZUjbJlgWqFwiwmKiTlO+QB6b39yXf0HkBXsf/UcG6S6y+ns
         aAr7Z0Mqo1fxgPqirNnW622bbqJeICs4+1k4Bi0q/zbiXyfeiAuEAgekgWhXQ5djgKV5
         QP3tfiLClm7n0GiV9LYiczuKgRn9ewIqtPiVkOiTplcuOqZVG+fH0CVzw1xnz/gVVogd
         IaMTb4wjP1REbBJ6JH5WW1q/AYL06+2yCLKC4SLOdr77kF/BtAlQkhmexoejoF3OBIvn
         b2QKHK4kqHA2ibW84a4c21tdwhoU2OU7D/aVi2YOTXPHWitAbDGBjfSd9v5CytufxzZ7
         +UXw==
X-Gm-Message-State: APjAAAUfl0SB0Kzg+HAtwbQJaRlbxXPKMyV8GdTCrUeX00jmtMXA0FLA
        pMtOXnKMsnaj0A5yTb2cPpMUS65TSxvz3OwiS6vs9A==
X-Google-Smtp-Source: APXvYqw6aV66KCDU4wYhdXF/YwYlfF8jogyhDJ2Tb5qeXvYAYMxi5dQVzM1epv/bsdX0FEIRXWIJOOfFlUDKyaAzOqI=
X-Received: by 2002:a9d:7393:: with SMTP id j19mr6354384otk.118.1559681468447;
 Tue, 04 Jun 2019 13:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190604174412.13324-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190604174412.13324-1-yamada.masahiro@socionext.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jun 2019 22:50:54 +0200
Message-ID: <CAJZ5v0jXKNr3_W9B_raetj42UOdphA3GEE_Qh7nBSwDzwXfA1Q@mail.gmail.com>
Subject: Re: [PATCH] kobject: return -ENOSPC when add_uevent_var() fails
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 8:00 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This function never attempts to allocate memory, so returning -ENOMEM
> looks weird to me.

And why is the "looks weird to me" a good enough reason for making
changes like this?

The existing behavior is known and documented AFAICS and is it really
so confusing?

> The reason of the failure is there is no more space
> in the given kobj_uevent_env structure.
>
> No caller of this function relies on this functing returning a specific
> error code, so just change it to return -ENOSPC. The intended change,
> if any, is the error number displayed in log messages.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  lib/kobject_uevent.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 7998affa45d4..5ffd44bf4aad 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -647,7 +647,7 @@ EXPORT_SYMBOL_GPL(kobject_uevent);
>   * @env: environment buffer structure
>   * @format: printf format for the key=value pair
>   *
> - * Returns 0 if environment variable was added successfully or -ENOMEM
> + * Returns 0 if environment variable was added successfully or -ENOSPC
>   * if no space was available.
>   */
>  int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
> @@ -657,7 +657,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
>
>         if (env->envp_idx >= ARRAY_SIZE(env->envp)) {
>                 WARN(1, KERN_ERR "add_uevent_var: too many keys\n");
> -               return -ENOMEM;
> +               return -ENOSPC;
>         }
>
>         va_start(args, format);
> @@ -668,7 +668,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
>
>         if (len >= (sizeof(env->buf) - env->buflen)) {
>                 WARN(1, KERN_ERR "add_uevent_var: buffer size too small\n");
> -               return -ENOMEM;
> +               return -ENOSPC;
>         }
>
>         env->envp[env->envp_idx++] = &env->buf[env->buflen];
> --
> 2.17.1
>
