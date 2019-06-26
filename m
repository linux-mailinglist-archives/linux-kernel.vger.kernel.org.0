Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCC756811
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 13:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfFZLz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 07:55:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39757 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZLz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:55:57 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so4351121iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4SPPlml4y9TrtWAQCUjsdfHfQIRX6Xl2SugOU3jklTk=;
        b=YIuixC0fgcOTmNzhQ0tG8LlDNyCIharFpnNWQfgSkOPOQvT7VdXv6dl56xlVouu8yB
         ixeqNz2NVdvdkdyLm2pAO3zbdZkTqp+VfRuC9Te7ap1lHgacEF6zwDG3uZDgaSnnUqqA
         487NLC2XN7KA9+8q9md/J2bfIjmzcxth2AWjhLN7XFiPQ4IKYOw8qBX3M96Nhss5JPNv
         y4/0Yd+VKsRQ6YmKjbC8+ypnQhA4R4yRbiAXsQkQRgXREOpLtvhDfnIkPKgYpmrO/uJn
         uxp3ZSnNKblEsDhUDe4qul4JRYPT4fS6tb6HkwbEeRYyIfsTLRfNuBT101uW9njyKcOi
         AXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4SPPlml4y9TrtWAQCUjsdfHfQIRX6Xl2SugOU3jklTk=;
        b=X9GuQ6ME47aTt3j41trKEDK4veNP1+LpuuWSfvQRMJ3GDIm631urEt3rNXSpw91Cy7
         C3bG/KpuHtgo0v6c4mZVPsqgb9Q1EvguiQa/RrGwg8oR/Xkcxj3hm+pVCjxMk5e+z/MU
         IXyjRKE8ktmYQwkWfHi4JOgVa+BnZ5nXTnrE2tR/SkYz+IdIqRDHHTs2e7ko//nT79Ke
         xKNW37Rnme96yeNKjR3eHz77SVUBdLUMfOZAEX6VZ2B3ojmLIhJ5c0pd1EA/7ib8IQ2s
         GoswQXOKVEw/z1uEuFCEm0wjsDX9yjpvcwnh4PY9HfYCYuvapDH2E4sXvifcZuOiuHku
         T9Og==
X-Gm-Message-State: APjAAAUUn4qrSbakRj8oyDD/2bvqTbPQNkEax+lpgkDz1hNTgSj8kI32
        IfhqSD7wFUi3z3dSIijzw5/HDkITTuJHJh/vPDqAGg==
X-Google-Smtp-Source: APXvYqwpdcuRVyNm6p7HASJTMkXe0GXnJa2EAUcoFgp21Y11biCuzhb0eiFPtro7366T4+3bMlStGVjSfd60h4iHnB4=
X-Received: by 2002:a5d:80c3:: with SMTP id h3mr4673851ior.167.1561550157015;
 Wed, 26 Jun 2019 04:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190626084557.11847-1-brgl@bgdev.pl> <CACRpkdZXtFUimMATgKA6Qdo4-mTLW5xV3XvdcBShpO9c32_gbQ@mail.gmail.com>
In-Reply-To: <CACRpkdZXtFUimMATgKA6Qdo4-mTLW5xV3XvdcBShpO9c32_gbQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 26 Jun 2019 13:55:46 +0200
Message-ID: <CAMRc=MfgvzKbUmttkHj1tWwFU_fZX93hnD6SDmaJV8ZYiRCU2g@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: mockup: no need to check return value of
 debugfs_create functions
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 26 cze 2019 o 13:54 Linus Walleij <linus.walleij@linaro.org> napi=
sa=C5=82(a):
>
> On Wed, Jun 26, 2019 at 10:46 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
>
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> >
> > Cc: Bamvor Jian Zhang <bamv2005@gmail.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Cc: linux-gpio@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > [Bartosz: removed one more check for debugfs return value]
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> > v1 -> v2:
> > - fix build warning found by kbuild
> > - fix build error found by kbuild
> >
> > v2 -> v3:
> > - remove one more unnecessary ifdef
>
> Looks good
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Will you send me this in a pull request with the rest of
> the stuff you have queued?
>
> Yours,
> Linus Walleij

Yes, I'll do it shortly.

Bart
