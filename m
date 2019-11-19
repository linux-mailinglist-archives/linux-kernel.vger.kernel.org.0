Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6C102768
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 15:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfKSOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 09:55:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40640 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKSOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:55:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2so23703061ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 06:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30HsnFXKOn2D4Ac/Y1QirFdNbvGbwWtgx1aMNEHaCAk=;
        b=ct5f1NDggcLQsLtQ+UoakvEeM5R/sTJTQWFTHA2W1uKiXI8ZuWOcM3k9iF30mF4YzS
         J+VaokKIS/qBkUhKymjArTRRYPXnEU4KBtGZVs/SJNkT3w3Fs7Vad3XifsM7NrtZ6F6U
         GFNmZtnpojBJKnSJqK/v1aOBZf7iFqqzbfMSY9dEWSih8hbfDxpxlSY4dIti3HIw8aXl
         xx1LDkOpg+Em8PWpklrLzBayVmyzg9RWJTT0NlKwrEY7jV7/vFL+qVJBbVexwavMiQI2
         WoCdj91tsUURfX11LPJdWm5Y/o1SzPHM0By0CswZpkQfBxXLasD7Rv5MCESnnIQj+ZQZ
         AZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30HsnFXKOn2D4Ac/Y1QirFdNbvGbwWtgx1aMNEHaCAk=;
        b=SaGiArbpvl9uYcgT9llmKo5GofJTorp6PawICZLtJUVT7komwyb8t6S4M+dzUTk0MT
         5ZhYvNwIlh4SRFokymZcZWOBOoZOYoktclc+Lkx7l7tzwD0p0BCYoo5bMR3iDRssweU3
         Ch0nmSlprVZ7w20ohTbOdfPc5SrEL5IFimSC0d3AV7WYWMmROgEBtccM7BESWuOEx18O
         2incmfrGRqUcmUXaqYSWZ74ZV8sdfY8C6A4bok/2Au0wBwWjIkmWEBzpl8fgsCSFzje/
         6jSWRbjqQOu9SUVs0MJ7aGxFCQJx7SWQL7U8Hf90F6fYWEGFUZYTlXyY4yK+ie0Vbq25
         3DXw==
X-Gm-Message-State: APjAAAUKoALhMcYYLaOL2id1EzhqAw4m/R0hKrARWwkpZU/90+Wr213V
        RO6Io765TnYgACrzgvXBkFif5CY6Jj3OGjrSjn6S5g==
X-Google-Smtp-Source: APXvYqw8q1ClY4DpKAB2UVHvvEiU+KZqkbNXEwB22Kyo/eJ4d51VbtZfIpv7a/9bbEnHVShukCfvJg59ec4RpUNX/qA=
X-Received: by 2002:a2e:90b:: with SMTP id 11mr4146912ljj.233.1574175300137;
 Tue, 19 Nov 2019 06:55:00 -0800 (PST)
MIME-Version: 1.0
References: <1573819429-6937-1-git-send-email-qianggui.song@amlogic.com> <1573819429-6937-2-git-send-email-qianggui.song@amlogic.com>
In-Reply-To: <1573819429-6937-2-git-send-email-qianggui.song@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Nov 2019 15:54:48 +0100
Message-ID: <CACRpkdbXcT9BSgBurHHhO7tOM67oHsX6s72qEAV7=MrPy-0uZQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] pinctrl: meson: add a new callback for SoCs fixup
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Rob Herring <robh+dt@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 1:03 PM Qianggui Song <qianggui.song@amlogic.com> wrote:

> In meson_pinctrl_parse_dt, it contains two parts: reg parsing and
> SoC relative fixup for AO. Several fixups in the same code make it hard
> to maintain, so move all fixups to each SoC's callback and make
> meson_pinctrl_parse_dt just do the reg parsing, separate these two
> parts.Overview of all current Meson SoCs fixup is as below:

Patch applied with Neil's Review tag.

Yours,
Linus Walleij
