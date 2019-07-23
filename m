Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3D071583
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfGWJt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 05:49:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44351 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGWJt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:49:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so4940769otl.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sh8Gc/dDBQF/6zDo3pKFTalGj99cpIcGxIJ53WfTdj0=;
        b=nke0MrUX3OvwZpA1bB9noPZ3vMbhXdQw+Cz3LO/mmo/787/8QWtACjGrTkwx8pggC0
         x0MzMTWbECWPn/YZ1n4y+tzbUdlwpZFUXDBGX2Nqlcd8APDfD/jilQGorn3ax9AtXNlv
         ex6ECuI1kIPDkry1PxIyIIWG4V3buANHA6NGp41bQaq1sT5vHdzq+6rsB4qQH5wkpowi
         dQhYNRDEiJQvkD7dvdr/F1wHeXIFbdB0R4ybMnh/D2som7n+C5pN2wEdn4AvlgDlmnmI
         IvD082Y3295uyUC5JuH8yCaFpVWpHnhuljaRwWGGUoj75LBwhqRbiqk5fliVQaCSXk1Q
         sY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sh8Gc/dDBQF/6zDo3pKFTalGj99cpIcGxIJ53WfTdj0=;
        b=gYOFLqm+6X4/LfUrKoCWK1AZPPz2aAMqRmB+xudYf6XmppM6KO3JTZLeCo0IMEggMg
         uRZdHDR0icS77UnAkDlPCDhWBNx599aYmixBoD6tfsaqm6+hwjchIsKIdMkZu56iYJof
         VWrbxQ/yQ3vIxfIkMo1zCJTq1RN3nMC4MkvLV8zF7k3R7nhBx+TUWToQhLhiiiPM41u5
         FSXE895mfYvTkKdYc+zvedQRBxGnwbD6FjM/Fvzp2ytw3/xbemNGRLZzHq6SPupW4OPL
         5v1iy5fd3Q607HT+kNGAITMVuPCoi46W+yT8rX2+UxM7XL3j4sZb+7nIIqXBFjOYzRLo
         JWBQ==
X-Gm-Message-State: APjAAAUg9RlbuHfaMN6wZr1BSwewU3z7oP+c/tEnmXJQR30LyOmU4s+t
        vCiFXOUSsWIh/ktaXrXl5MLDqFSu5PMP/uPkQzXCMQ==
X-Google-Smtp-Source: APXvYqxoGqbzcMIgzth28GEyHqRvFwSXNNCEIipw0pQipVSlS7MWKe0DATd4V4qHqhQUT8PK/ZL2FxatleMtVIqj/5M=
X-Received: by 2002:a9d:7352:: with SMTP id l18mr51709290otk.292.1563875397393;
 Tue, 23 Jul 2019 02:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190723083923.21392-1-hslester96@gmail.com>
In-Reply-To: <20190723083923.21392-1-hslester96@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 23 Jul 2019 11:49:46 +0200
Message-ID: <CAMpxmJXkg8wiLOj9rQs+aNx+_oqb_tUWeELmrWQd7GXi-qAueA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: pch: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 lip 2019 o 10:39 Chuhong Yuan <hslester96@gmail.com> napisa=C5=82(a=
):
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Change the subject line to gpio: pch: ...
>
>  drivers/gpio/gpio-pch.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
> index 1d99293096f2..3f3d9a94b709 100644
> --- a/drivers/gpio/gpio-pch.c
> +++ b/drivers/gpio/gpio-pch.c
> @@ -409,8 +409,7 @@ static int pch_gpio_probe(struct pci_dev *pdev,
>
>  static int __maybe_unused pch_gpio_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev =3D to_pci_dev(dev);
> -       struct pch_gpio *chip =3D pci_get_drvdata(pdev);
> +       struct pch_gpio *chip =3D dev_get_drvdata(dev);
>         unsigned long flags;
>
>         spin_lock_irqsave(&chip->spinlock, flags);
> @@ -422,8 +421,7 @@ static int __maybe_unused pch_gpio_suspend(struct dev=
ice *dev)
>
>  static int __maybe_unused pch_gpio_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev =3D to_pci_dev(dev);
> -       struct pch_gpio *chip =3D pci_get_drvdata(pdev);
> +       struct pch_gpio *chip =3D dev_get_drvdata(dev);
>         unsigned long flags;
>
>         spin_lock_irqsave(&chip->spinlock, flags);
> --
> 2.20.1
>

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
