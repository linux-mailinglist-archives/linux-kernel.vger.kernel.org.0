Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB749F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfFRL2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 07:28:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34955 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfFRL2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:28:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so8977245lfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8A+94DRBbgDTY/8o4HH+UKDZtOS5NTYGxRViSkeTwqw=;
        b=rKLR5yEu4c+xuJ88AnMsPU1kuthSMYPhhJk6XSjIwM7GPAlmInFexlo7wcQdXtCWzm
         SQ+nGgIzW76Qm21k6aAQ9CwSFsWdbYskJ0FtmqEiTtNpc7plMZsOV6NaAVDxVPBM2V1e
         2WAn6Etm4VfYUwQaSa8FOnAiNOsszo6OZ8KWakKWFYjGeT/Yj/MKdwnCkQuQWd5lYS5n
         Ax9a4YXJZSUS4Cz2NMopk2BI09DgqZCFGBAmTlJuG1ja/hNEquOSnGJhVYU8FKHy4+r3
         pNpUZpLn9DimdeKlL1rUCEQknL3thkSDtPJMLXXBaVwL83kT+RalChw3QlIxetY63YIf
         DVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8A+94DRBbgDTY/8o4HH+UKDZtOS5NTYGxRViSkeTwqw=;
        b=Lh9fUdBp6lFIB9hPkJ5snAwYZaIMTEClC2q1aWtKKm07rux9GNy4MPf28aXC+AhmGU
         Jr+UUnE/4P4WqgTZvLqDE//nssuvabmNy8YsSolcK4YXPMopoobY2W9gVngsCO8IeNqO
         QZouRdeX16Eqt09MesMMlOfvgsia+R1nX74XHatZ8C9BDssHbMx88rsH2UaMXCzhrhjE
         zbPj4gF9hS+O92eIHblstlEmapd2IjyJwkJFtRnNrULVPGd76+LfkryccvPjTICqtEVX
         uSJnDBCc+34OqElOdd5xJmVPYoCbBktcII2s7yIDGTjPg54MGESV0z0TBdLpVqeawgjt
         ACkQ==
X-Gm-Message-State: APjAAAUUWEgW4nkYuPNT7Qi+djPLERyNyixbgVag/QLQgAkYZkFf9EzJ
        4DPjRguN8gImRrUsSlYRkRAmb1ixTobq55SEZIzZXw==
X-Google-Smtp-Source: APXvYqzfH55pWpb+0QG4bqA57hHIGbGCe7c2Veh+QzoaOTlWpokHw0hiNLCigHMKGx/PGT8M/4FG3C65Vjdz5haT3Vo=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr3490968lfm.61.1560857309967;
 Tue, 18 Jun 2019 04:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
 <20190610171103.30903-21-grygorii.strashko@ti.com> <CACRpkda2FhYNYA2TkVANOF5GWd3hE9cqM7N_pFDFj9nh-fh=iA@mail.gmail.com>
 <0ab98094-f8b2-69a3-e73c-1dfdf812d627@ti.com>
In-Reply-To: <0ab98094-f8b2-69a3-e73c-1dfdf812d627@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Jun 2019 13:28:18 +0200
Message-ID: <CACRpkdarzvVAFz90xJQCoF2+8rDf4_-Dys490HaXV+wbQGGxGw@mail.gmail.com>
Subject: Re: [PATCH-next 20/20] gpio: gpio-omap: clean up register access in omap2_set_gpio_debounce()
To:     grygorii <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 8:57 PM grygorii <grygorii.strashko@ti.com> wrote:

> By the way, there seems no ABI for debounce cfg in gpio_dev interface.
> (or i'm missing smth?)

No that is correct.

I tend to be conservative with exposing stuff to userspace, but if somone
comes with a valid usecase for using debounce from userspace we will
add it I suppose. It's pretty much on need-to-have basis since we can
never change the userspace ABI.

Yours,
Linus Walleij
