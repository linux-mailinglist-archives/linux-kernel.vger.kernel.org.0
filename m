Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6B49E2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 10:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfH0Igu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 04:36:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34951 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfH0Igu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:36:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id 100so7135156otn.2;
        Tue, 27 Aug 2019 01:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gy8QSlZb4lT6kTyFQW393XSRIZRR//dSxSXR0M5umDw=;
        b=rseanfH3ezo2KyfQXe+UxVzRFtUFb7MgWbYH4F2I3+n6RVT053q/cV97RevehWNGN9
         ftf+CE4XyxJgWsuEx56SE+T+NhTrixLBOiFn0c0ynd0LNDhTGHJt94cc7KYMVH/9XKtN
         5Kk01RGgF6RjXEyvI5lEMgVd3QeuRfL52qc+wh9Sc3z2Plg+wsz6nQJeVOuJQfSGjE8G
         /5EHcIIPBOd+xZF20tQV6+9VmENXgw38pr4h+uixJZv6zfJUceG7JoU78DUy5pVBKLBw
         5VyDeNUcYqQdLscaLC8/s3QihVNV6SPgQ9XHV9Eejfb+ENrD/ZgSDSr/L8GyFFQgwVoJ
         onbg==
X-Gm-Message-State: APjAAAURvYakp9bMeOtxnJfFeRo7hBsu55Fa49WYt4BykD/Rgn8xTRVN
        gO9ttOPjk9UF16CZt2FDF7f+B4y0XsDj4VrX/T8=
X-Google-Smtp-Source: APXvYqwqr+4C8z0AckmhxVmMT1WH0NiPgJPn7BzlKjPtLP4Os4b98pJGuuNkYsXNVKyLkpOOnfzy1tcfnDVwRgf1Xao=
X-Received: by 2002:a9d:2cc:: with SMTP id 70mr15907270otl.145.1566895009070;
 Tue, 27 Aug 2019 01:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190826195740.29415-1-peda@axentia.se> <20190826195740.29415-3-peda@axentia.se>
In-Reply-To: <20190826195740.29415-3-peda@axentia.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 10:36:38 +0200
Message-ID: <CAMuHMdVx77aOyUVhZ2_N76VAP+AJ3X8w-gdHLjnjUEeRKcZmOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fbdev: fbmem: allow overriding the number of
 bootup logos
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Aug 26, 2019 at 10:46 PM Peter Rosin <peda@axentia.se> wrote:
> Probably most useful if you only want one logo regardless of how many
> CPU cores you have.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Thanks for your patch!

> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@ -174,6 +174,11 @@ C. Boot options
>         displayed due to multiple CPUs, the collected line of logos is moved
>         as a whole.
>
> +9. fbcon=logo-count:<n>
> +
> +       The value 'n' overrides the number of bootup logos. Zero gives the
> +       default, which is the number of online cpus.

Isn't that a bit unexpected for the user?
What about making -1 the default (auto), and zero meaning no logos?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
