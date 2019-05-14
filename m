Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A084D1CE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfENRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 13:50:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37730 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfENRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:50:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id f4so5464818oib.4;
        Tue, 14 May 2019 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4WyVzZzVHcVMzl7pj4c0Q2a84ppXydmsR3w60Qr3I8=;
        b=iiapefQc9OooYST8YzJL6mbpQTGtKAh6sru0GX0gKw/CgUvZzMYcOXvIVgLEq5VMk7
         2yLm+1UnISmqneLtOZW3csOL8ZphWTEJ5H/077pGiEeOxgxJeAxSnCwO3K4LyG26k5F2
         ZVbmFjiYyQe0wdz1t7VrLeSnELO1pEJobV1GT+nO3hVKOp0J/e8iqGHdQomhHaCitacZ
         9z58fyzCnhNiMdr2zz2Laoxlqua9yJ3nESsILGwjaUArmQXOHi7kmpPXcruGmkY/fEOj
         G2O81pvak9yCTlBzzKego1s+qdMOd8mHaITN7/SyoJ5kAT0OCyC7EKDiLa0txDkD6T9x
         P/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4WyVzZzVHcVMzl7pj4c0Q2a84ppXydmsR3w60Qr3I8=;
        b=Z2/gGpL+wXQfWGuKdA8FSDnBmeONYsXBGe8K7eOMfbhBdMl6G5Ldex+bKu9WVH3Xrx
         j+sboMde37ijpDYe3ydISweMyWps3voihi6vXgsoCmERqVevWmGKSJLMX7+Vwpcxz6mK
         64GFFeaYPA4B+SU4NZWIoRgLTWRC10rSUhdjunRZ+rS8WlVNxQna0FbL/QgINEHwjqvG
         dvL1SjY7Wv0EZ5bR9Z34nb2dNafys/XlZ7b5fAyFUYKe9hMig5x1zNi1+zWP7P+QBAh1
         1Pcv0CwaYX+ylc8RtutfTVzg8nG64kZ0s++/SxImLSj5JjPVtP6nsBcb5HAq5dur9BmZ
         sjog==
X-Gm-Message-State: APjAAAViSUCmfBefruLlZ57vnF0j9YM9H2lVlXePzVloIsqmo9qfP/wU
        c/MxvzqjIuEoznMKz0s0VB4Se7Xpfn58oc9xFeM=
X-Google-Smtp-Source: APXvYqxZNNXzp0nJyuWfpW6dAVMT8zS7BZ4LoDWAyg736J4uo4HWjE3WCUvSPCToTp4GsbFry/Zty3e+CBfiESJXKQM=
X-Received: by 2002:aca:b68a:: with SMTP id g132mr3726020oif.47.1557856245316;
 Tue, 14 May 2019 10:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190513091548.16674-1-narmstrong@baylibre.com> <20190513091548.16674-2-narmstrong@baylibre.com>
In-Reply-To: <20190513091548.16674-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 19:50:34 +0200
Message-ID: <CAFBinCAhTeywLZRBhcX_myktU9k4_YcjsjgCeTHEkP7SX8JCMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: meson-gx: add ddr-access-quirk property
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     ulf.hansson@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, baylibre-upstreaming@groups.io,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, May 13, 2019 at 11:16 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
> makes any DDR access from the MMC controller fail.
>
> Add the amlogic,ddr-access-quirk property so signal this particular
> controller has this bug and needs a quirk to work properly.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> index 13e70409e8ac..f8914dab06c6 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -22,6 +22,10 @@ Required properties:
>    clock rate requested by the MMC core.
>  - resets     : phandle of the internal reset line
>
> +Optional properties:
> +- amlogic,ddr-access-quirk: set when HW cannot access the DDR memory, like on
> +  the G12A SDIO controller.
(I believe we cannot use a standard property like "dma-ranges" to
disable DMA access)
personally I prefer "amlogic,no-direct-memory-access" or
"amlogic,no-ddr-access", but if Rob is happy with the current naming
then I'm happy as well


Regards
Martin
