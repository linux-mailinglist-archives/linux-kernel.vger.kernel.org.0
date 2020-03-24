Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A48AB19126C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 15:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgCXOHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 10:07:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35716 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgCXOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:07:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id a20so20847637edj.2;
        Tue, 24 Mar 2020 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcUgHF1GDuuSunaZUU4Ruocj0GZ4ddqSxRhaLtXqkcM=;
        b=dvJVWQ0O8hlSN/WBTtGXC50vG9ZJsG5B93vJTJkLUCehGXLNA7WiOPqhxSiXPhvxSQ
         tOj7bM0T5W9KTOferZhZUOyGqo0WT7kVcvYhb76IspBlhdKXyvZmq+EUoZfZwWazY1UW
         HbYAq1mKiuaFo5UjFpQvGh5IQ9HKyn0ZBjewWugORhupS/tsE3xXNBR5yGU6r03Ve3qg
         h82gUAI0taleDBc/RB3m/Q6cwpslgv65JWBeiWge9O2p7DlFJJ4W2u4LfLz3QJWoSdyH
         acqk0DLuJ/Dx8CbymfYh3loG/49JveFdfInVQkuMKAur2NH3+HUGXG+nlEtRaI8mCUJ6
         YOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcUgHF1GDuuSunaZUU4Ruocj0GZ4ddqSxRhaLtXqkcM=;
        b=j4Q/Bu3bIsgogtzVoDPJOvnYVTcZRpkxVq6/XQF+m7zYQFJ9tZerwPhJcZnXI2w63/
         qpcnbMT5w1QwEBspM5QrkN174dkhT+a0+U61yR0Hj+InmWuMX8JIs1Nhoy0jy2w+2R/f
         +Ae6EpkUxgsww17Lg5YLgRNH2Nun0nbd7g4bFHFiYRmHlK3sM3SVLYCzd8IPaDSXxUfj
         QRItAFjUuges1QUio1ykyk0fipGLx/oNlIiE7VllvCJ5p8ISixf1l0fsWVx8+g7aVomU
         xXA/KY7e9WxcmD7J/TA+/m2EsVdj6ufvVJtWU5NSei1cmDLb7bW29Vy1LVSIKdFpVtLQ
         VpFA==
X-Gm-Message-State: ANhLgQ2rC8jBsC3hXjuPSTxijwkbjEfZY2++wM15eRct0PO7ZI+yvTED
        Ca9TpCmDvPVjpcEm//73MWwJ6Zmytj+bJLChY2M=
X-Google-Smtp-Source: ADFU+vuGEjDeb/L8U1c1UJ2A93v1OboeO9Zew62wGydVRx2aXkWZiMP1AE1wliFtVf6Ap3fpngvz6Yw78DvnnxMnQcw=
X-Received: by 2002:a05:6402:17aa:: with SMTP id j10mr20114633edy.146.1585058828747;
 Tue, 24 Mar 2020 07:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200324102030.31000-1-narmstrong@baylibre.com> <20200324102030.31000-2-narmstrong@baylibre.com>
In-Reply-To: <20200324102030.31000-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 24 Mar 2020 15:06:57 +0100
Message-ID: <CAFBinCCaMopoza5CFCC7=mStH8Ocni4GjGr+etn=dMKOgr_5fg@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add
 the Amlogic GXL and GXM Families USB Glue Bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Mar 24, 2020 at 11:20 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> --- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> @@ -25,9 +25,13 @@ description: |
>    The Amlogic A1 embeds a DWC3 USB IP Core configured for USB2 in
>    host-only mode.
>
> +  The Amlogic GXL & GXM SoCs doesn't embed an USB3 PHY.
> +
>  properties:
>    compatible:
>      enum:
> +      - amlogic,meson-gxl-usb-ctrl
> +      - amlogic,meson-gxm-usb-ctrl
>        - amlogic,meson-g12a-usb-ctrl
>        - amlogic,meson-a1-usb-ctrl
the phy-names property is described below which you don't update
please add usb2-phy2 to the list of allowed phy-names so the dt
binding validation for the .dtsi patche (#9) won't complain

With that fixed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Martin
