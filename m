Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B59A1CF06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfENSZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 14:25:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37761 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfENSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:25:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id f4so5548619oib.4;
        Tue, 14 May 2019 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kw3IOsl4tz1Kex8D0hbfYf2WNfpKc0o/lXZ+cVw7qjc=;
        b=lJr0Zzq/wwnxu0m2KeQgieErswd5Yc517neOCGeh1PtLvrXwf/bAxE4Lb1MJS5E2iU
         Q1JQhCcj6az7Bn1+cEetwZ3KUCQYjPa1r5R9lWU+KscBgqT4bNBBfR/jO3OWnG8Xf2Rb
         mclBcWeZF2rY7uG8NkF6YY3WksmciEdWC1KnQOc03AvywuyPRgkWsk/0FbAyuGETryaS
         fxp7e3UNkBLueJWWkKWj5oiAks30wFhQexvpgGbPeUHHnSoPUFliBwVVMYFhai5DBTCi
         g4Cjo6ccfLQkmSMk7pkq3Btuq7ZH9zROPV/CRPoIQnJdoUaloOZc8z6PHvZA0xVnT/m5
         qoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kw3IOsl4tz1Kex8D0hbfYf2WNfpKc0o/lXZ+cVw7qjc=;
        b=tGCyWhtkcNJqLxeQiqQw8LSwnrM5UWfq0cTvc0AzdxraGKx9aUtM9Iu+0cPdxwUfoM
         T/F3qQYiUhgyoAiS/QfBKMl0sClfNYu/L546JjfMC63ZNkoDUDD5BmYryk0pUGfkTn9L
         Ki1cXb2UM1dIP88TWFrwOdlxrYjJdwU8soOTv7lojLMhWKQybvqSYYsMM+fPD/kfhnpQ
         uvo5gROp5a6PN9kYX7+/2srOotH1RD/Xh+9HXC5U7X77kkk+mi3iZ7OcdHoCZiBsMgJe
         lhIH96k2ysClg87ttPWsL2DioR01PRd8/+lNJgdvDs90728ON7cw9Vpmf/ZkndreNCl/
         +PGQ==
X-Gm-Message-State: APjAAAUl41j1FIg2TU1kTHLI29b6H9hYOMZxoUz5ysCdqJBNWS4US2Qc
        FEduFLBv2eqlPPaJlaaNKXZi5qZtlmvdHKF4vl4=
X-Google-Smtp-Source: APXvYqyJrHbY/exB6YGUUMsPrCvn/3mcKsx1q0CU06ZeAfCGMaEVzFez/hJkMHPJ0+gpcEtC6YgIIDJWKB6/cggmMh0=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr3828880oif.47.1557858304300;
 Tue, 14 May 2019 11:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190514091611.15278-1-jbrunet@baylibre.com> <20190514091611.15278-3-jbrunet@baylibre.com>
In-Reply-To: <20190514091611.15278-3-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 20:24:53 +0200
Message-ID: <CAFBinCDdyctRu04PrnsrvLMbe+Ty7xo1jxaRzomjwq9VVu215w@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: meson: u200: add sd and emmc
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 11:16 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Enable eMMC and SDCard on the g12a u200 board
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
I compared the GPIOs with the Odroid-N2 schematics because I'm
assuming that they will be the same on all G12A/G12B boards:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
