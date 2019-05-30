Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC82B2F88E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 10:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfE3Ia0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 04:30:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41311 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfE3IaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:30:25 -0400
Received: by mail-oi1-f193.google.com with SMTP id b21so364432oic.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 01:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzcNV6SW+Xh9Ya8lDxl+0yI6Dw+WGyclNEKNTVCp8nU=;
        b=oNY0itUuOlexInXW+Gp+VDdmTcz/v8A3OJ/ZmYzNmbNRg0nJUT/RP8nL+CggEXh6uu
         ILmKI3mWvUZdAsd0y9V6L1Xx/W0olFIAWtddBgV4yOGVkllOUxuSjKJ5ybW+0QFFNgnX
         KzwcGvKoTb+EWTpZA+njw+zF/xCbhXb4xfq0s2GwL49UzbvQb3WvnPM238KGDwncf1o1
         Mr2yPy4Qu0nA4QMXNR9UAehZQFWWTrRTBcn7nEXdTU49ajov0AZgrB4c67uWQBTa/Q6i
         aJlWbafvPHV81ZKY4eSie5a+afJl9GF2BQyz24hdvv8mw+5WS9h7kKfp6ntyJtS+X19v
         zzMA==
X-Gm-Message-State: APjAAAW2/ZuJFPgYNCNZbO0tE9koXbEGs5LogbZGUp3wYNwDGkZA1vxt
        1NQeO8EhlPXkSQpEvexpnFZM3Ue6ULvnhUf+DkV7fA==
X-Google-Smtp-Source: APXvYqzTv07K7SADdE55dDI77M75/XjvtsqUSGRV/r+pWOj/1v586YQ0cf99vI+eQ/N2XWS6ZrVc5NOYVULd8c/HKfw=
X-Received: by 2002:aca:e887:: with SMTP id f129mr1752282oih.156.1559205024714;
 Thu, 30 May 2019 01:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190530080602.GA3600@zhanggen-UX430UQ>
In-Reply-To: <20190530080602.GA3600@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 May 2019 10:30:17 +0200
Message-ID: <CAFqZXNtX1R1VDFxm7Jco3BZ=pVnNiHU3-C=d8MhCVV1XSUQ8bw@mail.gmail.com>
Subject: Re: [PATCH] hooks: fix a missing-check bug in selinux_add_mnt_opt()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, ccross@android.com,
        selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:06 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_add_mnt_opt(), 'val' is allcoted by kmemdup_nul(). It returns
> NULL when fails. So 'val' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

Please add a Fixes tag here, too:

Fixes: 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()")

> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..4797c63 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1052,8 +1052,11 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
>         if (token == Opt_error)
>                 return -EINVAL;
>
> -       if (token != Opt_seclabel)
> -               val = kmemdup_nul(val, len, GFP_KERNEL);
> +       if (token != Opt_seclabel) {
> +                       val = kmemdup_nul(val, len, GFP_KERNEL);
> +                       if (!val)
> +                               return -ENOMEM;

There is one extra tab character in the above three lines ^^^

> +       }
>         rc = selinux_add_opt(token, val, mnt_opts);
>         if (unlikely(rc)) {
>                 kfree(val);

Thanks,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
