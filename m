Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738AE32982
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 09:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfFCH1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 03:27:41 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39654 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfFCH1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:27:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id m202so948093oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 00:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91l+n5sLsO8XrUlcVUfMfSBih2YfyMwvOg3hnHFMMJw=;
        b=f+Hea9Ic4qblr/BayCu5g7vZjTJFbfuAxYAvZlp3YQ2cFIV3PaBA8fnXKEFYEnNrFP
         1YUEzWSSNZzWU3eDF2b549hyeJmdMZmRsBQ2ve5FMhfe7KWcbN3IwGU3WXM5PW+peBWx
         C19pThxHlWdMyLCY6DLg8ELKrm0AhnfraP9V2xPLwr+pA063xq9t5llv1xN/XQ0Etk7t
         RhEVWyuaY09bn6K/aAIzmyFZBeDu0STvfmRBWijmjYhYDX31qgMNlwVMKI2vmAMKiu9E
         3VvvJcztPIVmSJEQd+t1NDHvcSG9wPPJV7/VcGEGmjRePHAHRBMcDTMF2ERoWwYs7078
         Lz1w==
X-Gm-Message-State: APjAAAVxW4NAkS6iq/q1dpcp5Ut7dWX+Xr1oFRXsq0x1u4d4F6Oo9w0Z
        nAJooAIMtBUVDMJsGO3RZdO1u35SjxUcBjOr3zXteA==
X-Google-Smtp-Source: APXvYqy4T57mDjaHFCyHTKOwj1BaQRtES/e739DaslgYKUUjlVAXZOV5trKZ1YmsPbDI5+1eyBiTHu+dO12TFQJ5Z+Y=
X-Received: by 2002:aca:300d:: with SMTP id w13mr12937oiw.26.1559546859860;
 Mon, 03 Jun 2019 00:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190601021526.GA8264@zhanggen-UX430UQ>
In-Reply-To: <20190601021526.GA8264@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 Jun 2019 09:27:29 +0200
Message-ID: <CAFqZXNuPMxOQeq-5evh4dSuGC-Q5sQPjbhRgCBh4Q=u6OrEi9Q@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 1, 2019 at 4:15 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> should be freed when error.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..f329fc0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2616,6 +2616,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>         char *from = options;
>         char *to = options;
>         bool first = true;
> +       int ret;

I'd suggest just moving the declaration of 'rc' here and simply reuse
that variable. Otherwise the patch looks good to me.

>
>         while (1) {
>                 int len = opt_len(from);
> @@ -2635,15 +2636,16 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg) {
> +                                       ret = -ENOMEM;
> +                                       goto free_opt;
> +                               }
>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {
> +                               ret = rc;
>                                 kfree(arg);
> -                               if (*mnt_opts) {
> -                                       selinux_free_mnt_opts(*mnt_opts);
> -                                       *mnt_opts = NULL;
> -                               }
> -                               return rc;
> +                               goto free_opt;
>                         }
>                 } else {
>                         if (!first) {   // copy with preceding comma
> @@ -2661,6 +2663,12 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>         }
>         *to = '\0';
>         return 0;
> +free_opt:
> +       if (*mnt_opts) {
> +               selinux_free_mnt_opts(*mnt_opts);
> +               *mnt_opts = NULL;
> +       }
> +       return ret;
>  }
>
>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
