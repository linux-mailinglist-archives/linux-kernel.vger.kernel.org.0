Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB63F7D535
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 08:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfHAGEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 02:04:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33682 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfHAGEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:04:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so2805068wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZX8DEZG5Ea4sWFl/9jg9pO3wxEnjlg0LPax30I/HuEI=;
        b=U3srDwm+9wseLkx5qtt3lUz/lvVsvqnqihuUwsbeXKkBgKpmgXujCZ4DbQH7AOaolj
         b/xl/C0xgW1JTEIyvb3KdYWOGmXBTT9QoIou15Q6uOIkDObjSIEHmxuFIim03SEHLMk4
         h984h9UQiyaxRtRWZ+J7g9vIBQLhFLDIdcescwEa4ySEzMXXC7ut/L2eFvD4t9UOlpPJ
         DDPTTzxt+pxQcNp3V6t1xROnwsnYiB/YJO9SpXNnL6olRO9ZJPsYYOzIOeVg1IbXlxix
         GOLbXj/l4mX0xpkrR7u2li4dyEz+eHUr/K5ByllfSMZZKMDEYLQSU4D4dCHlnz/RZsTi
         N9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZX8DEZG5Ea4sWFl/9jg9pO3wxEnjlg0LPax30I/HuEI=;
        b=bsfDBz7+rSjaiADgi2mfSbNdH8ZL+LHaUYdeeF4XpkOLh1eHh+MWpglD14ROdihkEP
         upb1goUT+7sWIucgAnJexVbsgNutXF7tndTegHSVjk74u+huGThq3L3NJ+0YA8xS4E75
         6BNvFqnI8SSoPTpvtA3tGeaVUAX5AHQNQWaJ/DLHUlj9jHSwtg/LLpzyI+DE0/USM8WN
         wrLm+gychxAInfc3KBGfI4WSyNuDgwdqvUF2TnJknGgLujPZJSdGFemW3XtEQpVeBdIq
         /wldQpLQ03mgg6u/einUkJDQqsiIqHCA9p4xqX/shhrcfDrtmMMT/o2+djNXH0p5+iMD
         0+0w==
X-Gm-Message-State: APjAAAVWHb+kFKSUNy3dRaa/zdNtRr25Q6sApdtXc/YJGiRG1tPuBFPq
        zSi5hfSXvL4t8nJ69jIC9xJgu4xTlrPkDfv1/YPgvw==
X-Google-Smtp-Source: APXvYqz7Hx5Vl5ToMrMxE/l4VfUQcmbVYx2Oqw/jQf6dLJG1mYM9y8hd9gXbwqDQtby/tqAgS7dZqRzp/ZuqN9aCduY=
X-Received: by 2002:a05:600c:20c1:: with SMTP id y1mr117636636wmm.10.1564639462519;
 Wed, 31 Jul 2019 23:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <13353.1564635114@turing-police> <CAKv+Gu8EF3R05hLWHh7mgbgkUyzBwELctdVvSFMq+6Crw6Tf4A@mail.gmail.com>
 <32521.1564638419@turing-police>
In-Reply-To: <32521.1564638419@turing-police>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 1 Aug 2019 09:04:11 +0300
Message-ID: <CAKv+Gu_zEO75s6o8bv4TXPxibSH-dCe-V46AYjL-dOEAvpQaqw@mail.gmail.com>
Subject: Re: [PATCH] linux-next 20190731 - aegis128-core.c fails to build
To:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2019 at 08:47, Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu=
> wrote:
>
> On Thu, 01 Aug 2019 08:01:54 +0300, Ard Biesheuvel said:
>
> > > ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] unde=
fined!
> > > ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
> > > ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] unde=
fined!
> > > make[1]: *** [scripts/Makefile.modpost:105: modules-modpost] Error 1
> > > make: *** [Makefile:1299: modules] Error 2
>
> > Which compiler version are you using? All references to the
> > crypt_aegis128_xx_simd() routines should disappear if
> > CONFIG_CRYPTO_AEGIS128_SIMD is not set (in which case have_simd will
> > always be false and so the compiler should optimize away those calls).
>
> gcc 9.1.1 obviously doesn't think it can be optimized away. Apparently, i=
t's
> not smart enough to realize that nothing sets have_simd in any of the fun=
ctions
> and therefor it's guaranteed to be zero, and  it can do dead code optimiz=
ation
> based on that.
>
> Now, if we had something like:
>
> #ifdef CONFIG_CRYPTO_AEGIS_128_SIMD
> static bool have_simd;
> #else
> #define have_simd (0)
> #endif
>
> then that should be enough to tell the compiler it can optimize it away, =
except
> that then runs into problems here:
>
>         if (IS_ENABLED(CONFIG_CRYPTO_AEGIS128_SIMD))
>                 have_simd =3D crypto_aegis128_have_simd();
>
> because it will whine about the lack of an lvalue before it optimizes the=
 assignment away...

The fact that crypto_aegis128_have_simd() does get optimized away, but
crypto_aegis128_update_simd() doesn't (which is only called directly
and not via a function pointer like the other two routines) makes me
suspicious that this is some pathology in the compiler. Is this a
distro build of gcc? Also, which architecture are you compiling for?
