Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 605F7C8AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfJBOTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 10:19:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43669 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfJBOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:19:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so26509081qtv.10;
        Wed, 02 Oct 2019 07:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/4BkNlRVIojwkaNlJiwgslAKNSOU+8zzG4UZka4qDBU=;
        b=QdiKq9FI8LIqZDQt0b0cxmBM1BmxXdXQ9sZMwZTZuaeWiJUxHzK71Wh8b48pwTP4BZ
         +uURXCfnFjBCE8QMVWEUZagzYcF8f692XAa4sfcjPVp+Y1u+xa1/sa/05xYXOOMRzy6P
         3ENbwHVOydCJhc6//1T6yPU9XQzFVrlhKzCcmctGYqnO0DFH6uYCf02hJegj88XqZggc
         wvcIVivdyQg+HR5+FtLLiA3VqWlzfnM8y6LvlqzDsOuv6sGZxxr5FhvqFtkTFoW1F/a4
         OJqxqobggjewfUmfyVUFoU1pGLAlLcY/iOBC9P7LpjQ9e7CCldQMKHqeJV+fkbmq6nij
         xhdw==
X-Gm-Message-State: APjAAAW296l9VuKafbZjfWmY6ATXEVlh84RyaIJUdWgy6ScC9JpyCC8N
        pjr8UphfaGIoCOmH428BIQ==
X-Google-Smtp-Source: APXvYqyiCJ1kbtSTzcBUjuOuqu8ar7W4uCqJ/bf5oUMfYFYLi0a4ONnP7ChHGR3HF15IPGyvftP9iw==
X-Received: by 2002:ac8:2c86:: with SMTP id 6mr4217724qtw.113.1570025954662;
        Wed, 02 Oct 2019 07:19:14 -0700 (PDT)
Received: from localhost ([132.205.230.8])
        by smtp.gmail.com with ESMTPSA id e7sm13698395qtb.94.2019.10.02.07.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:19:14 -0700 (PDT)
Date:   Wed, 02 Oct 2019 09:19:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: clock: add the Amlogic Meson8 DDR clock
 controller binding
Message-ID: <20191001235650.GA11980@bogus>
References: <20190921151835.770263-1-martin.blumenstingl@googlemail.com>
 <20190921151835.770263-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190921151835.770263-2-martin.blumenstingl@googlemail.com>
X-Mutt-References: <20190921151835.770263-2-martin.blumenstingl@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 05:18:30PM +0200, Martin Blumenstingl wrote:
> Amlogic Meson8, Meson8b and Meson8m2 SoCs have a DDR clock controller in
> the MMCBUS registers. There is no public documentation on this, but the
> GPL u-boot sources from the Amlogic BSP show that:
> - it uses the same XTAL input as the main clock controller
> - it contains a PLL which seems to be implemented just like the other
>   PLLs in this SoC
> - there is a power-of-two PLL post-divider
> 
> Add the documentation and header file for this DDR clock controller.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../clock/amlogic,meson8-ddr-clkc.yaml        | 50 +++++++++++++++++++
>  include/dt-bindings/clock/meson8-ddr-clkc.h   |  4 ++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/meson8-ddr-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
> new file mode 100644
> index 000000000000..bf3ca5888485
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,meson8-ddr-clkc.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0-only OR BSD-2-Clause) for new bindings please.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,meson8-ddr-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic DDR Clock Controller Device Tree Bindings
> +
> +maintainers:
> +  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson8-ddr-clkc
> +      - amlogic,meson8b-ddr-clkc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: xtal
> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ddr_clkc: clock-controller@400 {
> +      compatible = "amlogic,meson8-ddr-clkc";
> +      reg = <0x400 0x20>;
> +      clocks = <&xtal>;
> +      clock-names = "xtal";
> +      #clock-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/meson8-ddr-clkc.h b/include/dt-bindings/clock/meson8-ddr-clkc.h
> new file mode 100644
> index 000000000000..a8e0fa2987ab
> --- /dev/null
> +++ b/include/dt-bindings/clock/meson8-ddr-clkc.h
> @@ -0,0 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#define DDR_CLKID_DDR_PLL_DCO			0
> +#define DDR_CLKID_DDR_PLL			1
> -- 
> 2.23.0
> 

