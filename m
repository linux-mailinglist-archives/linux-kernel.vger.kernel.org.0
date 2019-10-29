Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB1E8A63
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 15:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389006AbfJ2OOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 10:14:04 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40565 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388274AbfJ2OOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:14:04 -0400
Received: by mail-ua1-f66.google.com with SMTP id i13so3844715uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WRiAkOhbI4dV58chbNSol3Yacs8NwxdmyZ2dChnRtrM=;
        b=xajKtnJrhLWyaOykhKGtlxEGtudWLdubnUwcx9nZIUmZ4B4YcwrOPiyj85JY+B6kxA
         uT2KUH+00Vf5ICMMKVHjppY+r/euFqo4OijPnQeKEp5lNbBSxpgT1jL68LVXsnvoNTA5
         s0f0EGVTrFfjcYf3jfJFCVHPjNHopZ/3FeHYPtMdAIRL0lJsT1x95wGkyZ5O3eTrynBR
         tJw5mEIpEpxkuCVlRhHU7wNjXhJH4apI5dDYiIwN+Bx2LjcyVYa3HphmngId8dOU8EQ7
         3dv0emRFlpZpV/ZQ24gLpSg/D/u4yH52OPvGqnZR6PfQn3c5lnm9ynCXkzLAY8NcZ2Zr
         2jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WRiAkOhbI4dV58chbNSol3Yacs8NwxdmyZ2dChnRtrM=;
        b=WBCQr3Pzu6P3WprgKP3L4QFImPUMzYxCJi0SFea+RIG2EIfNBaGu79WBpPb91rHhGz
         wSWwMY3XTZps/GoS8A/l2B35vb8KUNMu4X1Gd30/Ho/YFzLbeD94W8zzXn0ygPoq92yn
         3jZ1CgmaoxGLgLhD9B1CRTWKnGZdHL82Qoq5wpegLkE1saxl6TTPO6ORAViRq1SSJ6z0
         f84l8NEecQIgmYInUzoJjmscSTIk4h5Pl4/4rcEkjuUd1RUk1xfXALiIam5IdiUek0/M
         J+5pFqqitbhME1EpfFi1+eUVT56Jc0pCGt+hn8ojVqAseSfDcX50MDmu3XigGusgc0QK
         5r9Q==
X-Gm-Message-State: APjAAAXhwLKe05QI84VsUIEs9xSYut+y/Gt+O0c6kVMUUjBCfomJ+M4U
        XnRfQeiXlTG1gVvqoVNewMXRmRG0eCYgh7p6YEtgyQ==
X-Google-Smtp-Source: APXvYqwXDN2mRvdj+26BcZ/ILI0ofvlyph74hhkrx25WZ8XAd6RsJ1WmNMUZxWgcMl8KizcybIyWzpVf3nQ5cmC3Sso=
X-Received: by 2002:a9f:31a9:: with SMTP id v38mr4022990uad.33.1572358443061;
 Tue, 29 Oct 2019 07:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191021064413.19840-1-manivannan.sadhasivam@linaro.org> <20191021064413.19840-4-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20191021064413.19840-4-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Oct 2019 15:13:51 +0100
Message-ID: <CACRpkdbSF8C=fY8s-=e=zVjTHu30_mA+MP=Y_J=jkSp96APWhw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] gpio: Add RDA Micro GPIO controller support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 8:44 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add support for GPIO controller from RDA Micro. This GPIO controller
> is an in house IP, developed by RDA Micro (now Unisoc) for the use in
> RDA88* series of SoCs. There are multiple GPIO ports present in all SoCs,
> each capable of addressing 32 GPIOs. But only first 8 pins have the
> interrupt capability.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Not even 300 lines! Nice.

Patch applied!

Yours,
Linus Walleij
