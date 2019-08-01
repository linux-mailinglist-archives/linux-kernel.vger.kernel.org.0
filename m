Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF91C7E3F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 22:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbfHAURV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 16:17:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51937 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388953AbfHAURT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:17:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so65833044wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 13:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+2f47S9TyynfRuvT0EIxN+x9IBMjQklZO2mS15S/FPM=;
        b=a/tboTaTAA7U22KkiWKgcpqovbFR9fW6T4w9RnlkV/wOd6gST44QEqb4yVG5gUCf8T
         VKsiuLwjP12EZaBqZJgQVqIOxyqSUdGaesaxmdc0GJ/DwZyS9YnxwbvNcyKjFCLKvC+7
         5qwm5D9v32NxrJ7KD9ZiqZ94kwN98X2/ARO3KD9f/Ff8B6r0fZG/9CZBqCVfn78/bVRg
         kr0v59xk1JjQj+ubScHK5ATwO/AScFIAUSyd+qURaHSc4GMwa7hHqVPzAj9Q80XQ4oB0
         uJij8u+NeJk4Nqx268L6gEG+OCtAV4eNU/kuMqn4F1zw2YSkdxfOXdu+4VTEoXqTB9I3
         Syuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+2f47S9TyynfRuvT0EIxN+x9IBMjQklZO2mS15S/FPM=;
        b=AUIYfeyuCfbG0BcSBSxTmub3YFbe5PJ7r79FQ+KyLVb11DnYVBkut6jvwokx+DF8Ov
         XDACCp3VFyc+GAzXvtd3VvDRn6s3cBZuKeCNYwmJIs2J3L5FVJzTuCdHxQLot57bt/t9
         GEPeCspKTKDEDXlgas6GDN1fpNKgHPDlL/jbi3+opcWEYAAvg6MK25lLqIf5KufwYfQt
         o7I4I5PbQsMtMiyUz4BZZg9HqyS+GKm160amBQU9I3nC7IBPzEg41bfS0fCsqL8hOas7
         kOtD9LIACEToE4MFvXgFXoRDQNT4CWI9f7dkBg1e38z5FlqC2qv67WaKlGvW0hFERZcu
         U1DQ==
X-Gm-Message-State: APjAAAWTw/LLIaZb2OaHvuxIC27LVt18hBdB58/e3ykPZOWF0e0nWcQa
        yHx7rmjPBdXtu4MvBJMlaHTJ3rXXBouYMVvlqPasLQ==
X-Google-Smtp-Source: APXvYqzs3BOEDM3w9OuhJ4FQl4f2puNY9YafhpkAs2qld4bMQQtf2+HUV0DluaeoOIMugNCx0V3PFA4aCCtffsdiVE8=
X-Received: by 2002:a1c:720e:: with SMTP id n14mr339413wmc.53.1564690637336;
 Thu, 01 Aug 2019 13:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <13353.1564635114@turing-police> <CAKv+Gu8EF3R05hLWHh7mgbgkUyzBwELctdVvSFMq+6Crw6Tf4A@mail.gmail.com>
 <32521.1564638419@turing-police> <CAKv+Gu_zEO75s6o8bv4TXPxibSH-dCe-V46AYjL-dOEAvpQaqw@mail.gmail.com>
 <1166.1564639726@turing-police>
In-Reply-To: <1166.1564639726@turing-police>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 1 Aug 2019 23:17:05 +0300
Message-ID: <CAKv+Gu8oK22Su5mq=i3pnKrkPq85a3hX-kyog9xwAVYa705iYg@mail.gmail.com>
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

On Thu, 1 Aug 2019 at 09:08, Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu=
> wrote:
>
> On Thu, 01 Aug 2019 09:04:11 +0300, Ard Biesheuvel said:
>
> > The fact that crypto_aegis128_have_simd() does get optimized away, but
> > crypto_aegis128_update_simd() doesn't (which is only called directly
> > and not via a function pointer like the other two routines) makes me
> > suspicious that this is some pathology in the compiler. Is this a
> > distro build of gcc? Also, which architecture are you compiling for?
>
> It's the Fedora Rawhide build on x86_64.
>
>  [/usr/src/linux-next] gcc --version
> gcc (GCC) 9.1.1 20190605 (Red Hat 9.1.1-2)
> Copyright (C) 2019 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is N=
O
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>

Strange.

Does the following patch make any difference?

https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuvel@=
linaro.org/
