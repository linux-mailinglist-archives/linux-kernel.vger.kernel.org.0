Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA3E195516
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 11:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC0KXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 06:23:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35665 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgC0KXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:23:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id k21so9632634ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 03:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6+qsGlY5ufaYGYSvfi6R/XdWdgiZnQOUmk027h++wY=;
        b=txdKACCdM7XXYtTJw1Cpjkvm6oyL7atR/RjEVZa4sh+MYp1TgRoMuB4B04Q0FgZjsv
         y0KzVBiDt3Z1FhO2p8E+MU3YRMufVrRxCYmY7YjzjKWlGskcN+zZ06vyYjx+OiQr0UZ3
         gpNercDKBycZnaS5EtnhmJ38FNp+YDDfQgGRFHKExKCyZWsHI9amhTlaUmujm60c5TI2
         Ge3c0sBOTmyfm1JbVHfFedn9QZukp8yXjcH/fCQ5IpDzWxKthGjvXw00GQVULuC2mKz0
         n2kpIEvWqRvtHSRWdfOvd0+a8KJf2vlqa1o2A7Quk9XZ2UFXj2EBVl8YdPspHfIuzTXf
         v91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6+qsGlY5ufaYGYSvfi6R/XdWdgiZnQOUmk027h++wY=;
        b=jh60e2I3dE/f33qm7C2j/tj9+PS33wuwvNAls/Hzjr0cDMIgDctFruH7UmldwHeXKe
         T/U5IoZlgnbXevm2pFegNfZni/y3he8YIdfVcY81DtX90AmKdlybc0n3dcI0c+VrY6U4
         l8VF6+fViqKE8PjDl2sqHmSE64s8Q0cQwrJ6p6FpPuEg8wc7KdGXgWUvtFJ9SfnT6/Mz
         DGkxj69HGS1EU3VPtrLzVVB/+N+gxYgXVdFdhlyarG3GviuR6D044Re1ELNO1ft8GFKy
         U8i1O8BGBM1AQPrsw/BNtS0xz6N52jFQGphcEjBZkOAI6dpA8kqVpTaekWe4ovrZZ4zE
         15kw==
X-Gm-Message-State: AGi0PubgZD1r3wBif3Gb613DkCZAwHVtXKfyqtqdOdGAk8PHAl+64hg9
        4Kh+WLy0M05/QDj4QexQiOgxxF0uiBHuM/1weeK1tg==
X-Google-Smtp-Source: APiQypLAxlxUn/h9pbLaNqfw8TLuPxvnQJeZXEcak++olZSdCahmwgdRjDUQzOitW2xd7O4LOLGl+Jaw0WeumCFSA7U=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr7429532ljd.99.1585304583741;
 Fri, 27 Mar 2020 03:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584456635.git.mchehab+huawei@kernel.org> <51197e3568f073e22c280f0584bfa20b44436708.1584456635.git.mchehab+huawei@kernel.org>
In-Reply-To: <51197e3568f073e22c280f0584bfa20b44436708.1584456635.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 11:22:52 +0100
Message-ID: <CACRpkdYrL02YHn5dPnh_Oz0Ysm5BxHrwQgwNMtsD55XGid_hCQ@mail.gmail.com>
Subject: Re: [PATCH 12/17] gpio: gpiolib.c: fix a doc warning
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 3:54 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> Use a different markup for the ERR_PTR, as %FOO doesn't work
> if there are parenthesis. So, use, instead:
>
>         ``ERR_PTR(-EINVAL)``
>
> This fixes the following warning:
>
>         ./drivers/gpio/gpiolib.c:139: WARNING: Inline literal start-string without end-string.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Mauro are you merging this or do you want me to merge it?

Yours,
Linus Walleij
