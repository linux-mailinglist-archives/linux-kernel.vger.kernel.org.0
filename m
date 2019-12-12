Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E7811D1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 17:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbfLLQIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 11:08:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39062 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfLLQIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:08:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id i12so2704739qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 08:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6xL5oHx6JhfySW6vNlCWxSH0U7ZkAzHSyw1I4MBhOBU=;
        b=bX0qcXCfrctzXDS/zTTqs6TEaaJAU5p5CsU4r/5/bKGYfQYofP2Ae0gBQel5/wwdh0
         iJ2cx1hOBcJw2uT6qMHTzMHRo5U9ndec/mh1nW0E/oy3kDUHngJDaI5a6Mt6QDB7Zh3O
         dyjAz+ug5qnFQxQ4IZoRP5rMghfhGc8NldSweIlVJQmGdoxJpU7aUh0qRmlziBJnQ/fk
         u4pmrr77wEOXvqc2gbXJ3o/0AbdNr9l2Y6k4PNoxH0z8nDQuxY9GR6ta87xJ75rBJUzs
         umrKZYrpChkC2N72J/mQTVKQbOj0TPfkwPb9o2seXvtOtZkLELyaLh/6USr4/sHNARPF
         WpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6xL5oHx6JhfySW6vNlCWxSH0U7ZkAzHSyw1I4MBhOBU=;
        b=eQTVtdkpwvTsw9eJZQo2tDHFBU8x00iZ4+57FcjHr45mPs6cQ0xDSytHrI99bVWlaj
         8vNIJEaBGBNYjnIRhbmphY0jVLaMRblLJ0Pi23aufvfD6eo2hqLMuJ9wTmN/HhxiPXNf
         X+i3QgnmNLG6W9tgz+gAEkxRi6NwQRlGPRnzxLkne4mLtG1RfTskPfKTZRM0TyNbVkEt
         Nfz/zvy0z4TWOza+i+D4F/IT0D2L7VNpN8UsA0CYfPv9Ki8BtSVeZRuepMFllkV/ACk3
         SlGXGKhTb+Vgq+FiP6fcHrhx5mcJZxnyKzLIVruZd33HmmxTGKdYMP1oMw4N0es4CgrD
         eqiQ==
X-Gm-Message-State: APjAAAWQc6fYSpggZ1/OcS1bq6v0ZrZcqpGShIe0Jp+0Tipkq1ZEgEM8
        0kNzEkEIy0YtCHVtPBj0028l3gsfqaIkqB1jCij2pA==
X-Google-Smtp-Source: APXvYqyHX+4gkmFrb0PetZfIRJsKK01/Htm4j9k5//KWMeGY8spRtLpR1itsFlTDdkQHvk5JZswQdyreZWZAfH/iR44=
X-Received: by 2002:ac8:6784:: with SMTP id b4mr7837731qtp.27.1576166929494;
 Thu, 12 Dec 2019 08:08:49 -0800 (PST)
MIME-Version: 1.0
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com>
 <CACRpkdaTLVNXd+-j_gkOfKnTk02XaZiMA_XxUeM0_4zZ_F-=ug@mail.gmail.com> <CACRpkdYjCnx46kOuWXMZFme3emm1TugqjQPDctakOppAeCZvZg@mail.gmail.com>
In-Reply-To: <CACRpkdYjCnx46kOuWXMZFme3emm1TugqjQPDctakOppAeCZvZg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 12 Dec 2019 17:08:38 +0100
Message-ID: <CAMpxmJX73eufsaXzFjkb2S9Adztv7PqDEhBSDHfmbB_+VGrXEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mvebu: use platform_irq_count
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 12 gru 2019 o 16:31 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Thu, Dec 12, 2019 at 4:29 PM Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >
> > On Tue, Dec 3, 2019 at 7:04 AM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Use platform_irq_count to replace of_irq_count
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V1:
> > >  Code inspection, not tested
> >
> > Patch applied.
>
> Oops dropped again now that I see there are comments on
> 2/2 that warrants a v2 of this as well.
>
> Yours,
> Linus Walleij

Linus,

FYI I picked up v3 of this series into my tree.

Bart
