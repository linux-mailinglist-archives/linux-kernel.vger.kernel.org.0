Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B0C8C3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 23:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfHMVbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 17:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfHMVbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:31:05 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5CE216F4;
        Tue, 13 Aug 2019 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565731864;
        bh=XkpRbJVll+516C+jJvJAyZYjkbPpLw3esxFYVJy/wTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BhKlEJ07K2sEEE5X4BQU8lEPMxeIpf0FdTFhXiajh0LjFw8bDbY3WzB2dNJ4vcMn3
         UGtMwQUP93jw9omyNyPFpXjzVk9Hl234h1a8jhcbZevW85Qxd1ii4y5Fu06AyWI7Am
         GHJYOHU67WvA4jTB6oS6YDAOleQ99BlwEqc6fckY=
Received: by mail-qt1-f179.google.com with SMTP id e8so7422060qtp.7;
        Tue, 13 Aug 2019 14:31:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVG9AITvDoE80FqxULHL+418M1t7jd0+2o5rB0rLoxzQGeIzM+u
        7U6lL53Iov0isyDFvyhWWuIQfm1pzYs/it8yQA==
X-Google-Smtp-Source: APXvYqxokdujfBE8cDSjy43/2Jcz08YFXVAXNp4Cx5lVzoxujubkxGKCo14iNFpW20deuL9aWMxvPVwsHCwUEklSXXc=
X-Received: by 2002:ac8:7593:: with SMTP id s19mr27868839qtq.136.1565731863171;
 Tue, 13 Aug 2019 14:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190813124744.32614-1-mripard@kernel.org> <20190813124744.32614-2-mripard@kernel.org>
In-Reply-To: <20190813124744.32614-2-mripard@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 15:30:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJa-_x+QKkuQ2ZTt+tOtJWJ0NhywZMKomQhtShYr7WbTA@mail.gmail.com>
Message-ID: <CAL_JsqJa-_x+QKkuQ2ZTt+tOtJWJ0NhywZMKomQhtShYr7WbTA@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: watchdog: Convert Allwinner watchdog to
 a schema
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 6:47 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The Allwinner SoCs have a watchdog supported in Linux, with a matching
> Device Tree binding.
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../watchdog/allwinner,sun4i-a10-wdt.yaml     | 50 +++++++++++++++++++
>  .../bindings/watchdog/sunxi-wdt.txt           | 22 --------
>  2 files changed, 50 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> new file mode 100644
> index 000000000000..93df27ec1664
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/allwinner,sun4i-a10-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A10 Watchdog Device Tree Bindings
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <maxime.ripard@bootlin.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: allwinner,sun4i-a10-wdt
> +      - const: allwinner,sun6i-a31-wdt
> +      - items:
> +          - const: allwinner,sun50i-a64-wdt
> +          - const: allwinner,sun6i-a31-wdt
> +      - items:
> +          - const: allwinner,sun50i-h6-wdt
> +          - const: allwinner,sun6i-a31-wdt
> +      - items:
> +          - const: allwinner,suniv-f1c100s-wdt
> +          - const: allwinner,sun4i-a10-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  timeout-sec:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Contains the watchdog timeout in seconds.

Can you do a common watchdog schema to include with this and the node
name at least.

Rob
