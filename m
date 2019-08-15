Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68D0C8E629
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 10:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbfHOIXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 04:23:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43102 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfHOIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:23:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id h15so1522273ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 01:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0NopUkqBTLA90SLW4pHyzSS/xf0ZSXYWDKGwtJAIsY=;
        b=XfZzDLa/pb4I6O618ihMETOAk22ZCfhPAN12JvjQDq86genpOOd9UIrjs1jDPfXHKv
         C4XbzbKfduo6gxH7+9d535juc4lDa3KVomsptlT5IuBLZAjjZa9RDW+DaFQ5jw+Hd6qz
         mvNDo2UoQAGTnFAb/z0MOQcgu+YNlE2gKQ/YaLvbGyKa55lgeWkOqmclOig+Qaw/vlFe
         cNlUE6ev+m2Z4fhHUkF3Fc5Qp0FShH4ZtRp0bE3Vz4mlR/Xl4QSWA+RxNjkVmDlNnU3c
         M9PVoAFWM/0SAqsGo/gmz/i8D6JE8b5LUjHeOHZCBhzPxG4uQmcxIyE7hoOUmdnT/gLF
         SnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0NopUkqBTLA90SLW4pHyzSS/xf0ZSXYWDKGwtJAIsY=;
        b=aYjLRIftafn0xlmNS4sICEfwm3nw6buN3jlko7e+p2mc95YkJVacukMINLSHHkT9YV
         34cdkeqxO8KRTiEfnd+9UjgU9bm+2ydkK8FNuP1sMYENkLqeFU6d/v+ntZcdZaKM0W8A
         aBu6Ih/oDEm569Z+fW8Srlt19YnIYG4m9lYgnmqTpfdFrFkakcNlNdD8Jrh2SXapCr+b
         Lh3GXd1FjCvZYN6R8laUV9GuyauFN16xZowWo8lTGzAaAiI3LNN9/PdTA5OgCVidOQeC
         fZ7sCqnwn7jmks/6uOfU7Y1RAg901HOcIDVmxK4lP9DAprMBBYwsyhsvKhvzxrN0t+AF
         zLcA==
X-Gm-Message-State: APjAAAVnkRQ5+kx7zzy2FB0e4c3t9POsN+7q8XCmlDuxXoLUw3DmIZ1w
        eNM6IOHjCXb6wvN927Eh2bQpfiHKbNzUH1cz55iWeg==
X-Google-Smtp-Source: APXvYqzE4/aMh5whMI0MclqVZfrD6ndHr/RkELyc9WknR09MC3TLKaJoB0cexdnz/NmuFUXRKZuieK+MZxg1NivzFuo=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr200669ljg.62.1565857421866;
 Thu, 15 Aug 2019 01:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190815004854.19860-1-masneyb@onstation.org> <20190815004854.19860-8-masneyb@onstation.org>
In-Reply-To: <20190815004854.19860-8-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Aug 2019 10:23:30 +0200
Message-ID: <CACRpkda3uCk05FNfeesa6ZgL4MPcQPwjv506jMNmvMkvwCnLdg@mail.gmail.com>
Subject: Re: [PATCH 07/11] ARM: qcom_defconfig: add CONFIG_DRM_ANALOGIX_ANX78XX
To:     Brian Masney <masneyb@onstation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:49 AM Brian Masney <masneyb@onstation.org> wrote:

> Add CONFIG_DRM_ANALOGIX_ANX78XX as a module so that the external display
> can be used on the Nexus 5 phones.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
