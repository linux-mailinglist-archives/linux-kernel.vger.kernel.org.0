Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81FAF3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 02:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfIKA1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 20:27:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40573 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfIKA1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 20:27:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id w18so3035960lfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WajEOxLInLugBAoDBpA/UZhycoI/rEzq/XTRSPCwG6E=;
        b=EzMngyN8/VFtydsD0WIWfF50NQaPkM2eq8VQZ1+mbgQSlXsfBVGI+7MkTEJzrMepjE
         N5dzp3wn51b/B2O+rrJbqNGUKq5JuOmTT6211sd23WXSiR3zd2dGAm9f8pa0q1IGg2IK
         7UUdZYscZWrzG/He/DIZfQEpeLTSwcEo3eedfyMyU6cEaPIfRhxowWNF6pc2dPeVa5X5
         v3AHcOmN5viENhp+J71IZD/ZGQXMj0xOiHP+s7iSQW7MdcXBb3q+PaJlOw5FzNIHbjK7
         mYXUmu9PfI0jRJ5VcJqvushgAmgG0XP8z+66xHsDuZzkpejBCpjVGlQGBPgYhkvRR1n8
         BBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WajEOxLInLugBAoDBpA/UZhycoI/rEzq/XTRSPCwG6E=;
        b=kNkhd4Yix95aHdtQ9TN8OZrHpKlsfsVOacQkGmDyALQHwyuEkj0/JOkYJ4bRtmq6bI
         d7wBVO+tnPSomm9vG5gxTyNVhIuNo3UmeFA8djlM3yOmLd8qDcemTSsgi3g7qldvstzD
         V7/Y2P97bvhnuHt3n32eJAOewU8jDzuna9iiE339nNxmuc35VYk41V2ZSjj4HgqrAbkf
         42DWeXmzszeKybfJE9QciBt6lQl+Auu0z9ys97u13GxNi2t56qjFTbsSCM55Z5YScX7Q
         J9OJvKtVx+QXhi5GcV2fkxfXi72r+PrjV/AlvBX/73IdabLQmEl3dOoED3rF/a/8b3R8
         VBcA==
X-Gm-Message-State: APjAAAVt72P4ppljpKdHI7CqqTwouPPQu85BerccBZQeIsHSfWHETwMS
        1AkM8dYf949aNJmzcSkd6dUdJ/3SUR8g0IRxHkkWQA==
X-Google-Smtp-Source: APXvYqzTq8nRKqDrSo4UwdKaMsjIls0OQxxqbEF2KXMZYG4h+hjc3wihhhumQbhxZ9JIU9zTtyDhgWLKDvdddWxQFZc=
X-Received: by 2002:a19:14f:: with SMTP id 76mr21572482lfb.92.1568161641802;
 Tue, 10 Sep 2019 17:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190905141304.22005-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190905141304.22005-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 01:27:10 +0100
Message-ID: <CACRpkdbVC6DLHWftpL1wfkx_kWyfE=LpCQWZw=cv=RMVxDBm_g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91-pio4: implement .get_multiple and .set_multiple
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 3:13 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Implement .get_multiple and .set_multiple to allow reading or setting
> multiple pins simultaneously. Pins in the same bank will all be switched at
> the same time, improving synchronization and performances.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Good initiative!

> +       for (bank = 0; bank < atmel_pioctrl->nbanks; bank++) {> +               unsigned int word = bank;
> +               unsigned int offset = 0;
> +               unsigned int reg;
> +
> +#if ATMEL_PIO_NPINS_PER_BANK != BITS_PER_LONG

Should it not be > rather than != ?

> +               word = BIT_WORD(bank * ATMEL_PIO_NPINS_PER_BANK);
> +               offset = bank * ATMEL_PIO_NPINS_PER_BANK % BITS_PER_LONG;
> +#endif

This doesn't look good for multiplatform kernels.

We need to get rid of any compiletime constants like this.

Not your fault I suppose it is already there, but this really need
to be fixed. Any ideas?

Yours,
Linus Walleij
