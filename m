Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4CF536
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 13:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfD3LOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 07:14:35 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34254 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfD3LOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:14:35 -0400
Received: by mail-vs1-f65.google.com with SMTP id b23so89449vso.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 04:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+apvPOK9hOKuyGFcfXqjcVJRX/KMiOheouDto7GSYrU=;
        b=OlG3x6DSEKoTSrHDdX3ybp6fgR+JxEYnOW6sgWdoouyfjOMZfIZE834Z0i1m4d147e
         yh01OWpa7Edvr5/DLSw4qqB8LMCNiX6xfb3u9ldeB5liaei3o+eamVJpoz15S4Di9YII
         N6OoTOfeYCULR2C/P3lYgfImFJYDCIrkgWUkZczpN1A48fy5NIuyoJS3kmm+qXRQDaW7
         fQTR+sko1QYp8Y9xuuWEQmS/WEufRgOb11yfjRtsiozp+zLSS624cIH40INcfhqvWQzF
         5/ZF1BLNue1OMHom1HohEH3No7Eg1JyIyx+xodFErGChH//VZmOfMLRkNZCuTkzjv/Ks
         d+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+apvPOK9hOKuyGFcfXqjcVJRX/KMiOheouDto7GSYrU=;
        b=I6v6F4reGxSTKsYzuWqYjxnqyH34SlcCFCkxIfxMJ8bIu2kDDsUv47crJKYsxfVTKE
         ZFQqtqbkv0N+gOsvwBtRisetAFHXl3x1v3fnbMeroYS85gqrFOjNJbbYHpRWt8k2JIhy
         9pFZERI/SrOutK2bjjEzgQQ0QGRxCQS76DUE7paZzSNPpTP5npUBa+gV5Wg9x0qh380H
         QU8KIlh5vYO1UmlWA0Dr1uXH15NuLMKtzsID0JocH1yPjVocHV1/Z+/bd1ZSREHBtysn
         f0wBfhQmcmaaackDaMfuBvwkeISGK76W63uQwaI4XNU5+eLzDn77X15yq134ccfAHurN
         GUZA==
X-Gm-Message-State: APjAAAU4C3JE+dFeIGR/m+GbJOwHIfXxbjIB4u6O/USheoWi+3D1rHLE
        bJ5o0kpIy3XBZr6+Qox7kcbKqw+OuBU5vSmu6D2Ymg==
X-Google-Smtp-Source: APXvYqyAUnACtUpQ/7yb1Sl1GxiGdH/gfNEqoAuzPz1Lm3B7D3UA4Nrusr1PmU9LKsLBG5dbHrkeoO4MOXsyUmN5ypY=
X-Received: by 2002:a67:c987:: with SMTP id y7mr310439vsk.35.1556622874058;
 Tue, 30 Apr 2019 04:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Apr 2019 13:13:57 +0200
Message-ID: <CAPDyKFqbn=UcbwoH_z+yjrjvHQZaMtmsD=n0yrBV7DAK5VRJEQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/5] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch series adds busy detect for stm32 sdmmc variant.
> Some adaptations are required:
> -Avoid to check and poll busy status when is not expected.
> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>  different.
> -Add hardware busy timeout with MMCIDATATIMER register.
>
> V2:
> -mmci_cmd_irq cleanup in separate patch.
> -simplify the busy_detect_flag exclude
> -replace sdmmc specific comment in
> "mmc: mmci: avoid fake busy polling in mmci_irq"
> to focus on common behavior
>
> Ludovic Barre (5):
>   mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
>   mmc: mmci: avoid fake busy polling in mmci_irq
>   mmc: mmci: fix clear of busy detect status
>   mmc: mmci: add hardware busy timeout feature
>   mmc: mmci: add busy detect for stm32 sdmmc variant
>
>  drivers/mmc/host/mmci.c | 61 ++++++++++++++++++++++++++++++++++++++-----------
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 51 insertions(+), 13 deletions(-)
>
> --
> 2.7.4
>

Ludovic, just wanted to let you know that I am reviewing and testing
this series.

However, while running some tests on Ux500 for validating the busy
detection code, even without your series applied, I encounter some odd
behaviors. I am looking into the problem to understand better and will
let you know as soon as I have some more data to share.

Kind regards
Uffe
