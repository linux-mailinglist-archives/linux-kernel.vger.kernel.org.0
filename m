Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B1340D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfFDH4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:56:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45604 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfFDHz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:55:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so448313lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xvjs+U7cpHXvVtpfAyZDYD6TtycrFDEwniXbUsYUvo=;
        b=LWHKn+jdGTZ1B3aX92wNdcLeWeget7Nla2xk1Yug2L70eK75rPzG7CrKjS5/lEIpz9
         hHCQW5TjBzh46G4IIS2pTdsEVs8DKWeZ+J/8UiGLK9fWvgHKlOrzrIDYTorifgcPuZna
         wEoI4Mag+TlUoHj66v8othMHW0lyqJHEYtYjQKgNBLjbVTIZ8MWznsjI8BMcCj/TCCwb
         GWjRQrs2rhcPh5Kshgmrk5W1zynkO8Jvgd/rVuRlKaAZ9lSuGWJC0Rff0olGYFgZn74K
         qElk4Rs5/7+2SNn1koiEBEwIwESN4Hnu9/KVQS9LN2q81Zei34lXP8SvnrHUsvFmcW6I
         PGVA==
X-Gm-Message-State: APjAAAXSWHxtNaiKAuCgy6B22DE9CFN6GsBa6Urw6Ffzn9uLc+tY1sAY
        LAzykeiUFzQeZgFI8KaMu/AUbAC1JboCFkXCLDr/6Q==
X-Google-Smtp-Source: APXvYqyxsQgy3LYD4yJOMTnAw432x6DOOdEil+9+TRmuB5xIWpmLOpJqhGsjgMcDM4EG+5kFGdexvJTsrAHoB2UF4oc=
X-Received: by 2002:a2e:8555:: with SMTP id u21mr15732385ljj.133.1559634957595;
 Tue, 04 Jun 2019 00:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <1559634748-19546-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559634748-19546-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 09:55:45 +0200
Message-ID: <CAMuHMdXzLGtUOagfEeTS0XjN7T0HkoM5XMjnFYaCPDO9VSmCRg@mail.gmail.com>
Subject: Re: [PATCH] arm64: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:52 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
