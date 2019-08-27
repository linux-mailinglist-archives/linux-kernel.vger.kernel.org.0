Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12629E81E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 14:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfH0Mjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 08:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfH0Mjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:39:45 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0943620828;
        Tue, 27 Aug 2019 12:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566909584;
        bh=gLIZt3QBqVQuf+84rdK8Q8Zyrw4B4ptYkFNh+jBJOz0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cAX/tMBD+1cACAn6PI7WwLcPzJ1/XPRN7gQfSmkuq/+5UCxPyREoUYArg/ioTVQfz
         FrcNULmzSyokQRU04kaPDGrn0ewEo/KNw8SEvmCA/4xzmnDa1WsrVbC1gqkA7GUaqt
         3/AuOZq/fSOi/m9mPWMuRL3lmxXdHLuSLbjFj/pM=
Received: by mail-qt1-f170.google.com with SMTP id 44so21042510qtg.11;
        Tue, 27 Aug 2019 05:39:43 -0700 (PDT)
X-Gm-Message-State: APjAAAURnSf8p0DL1SLJi4ORVq4wkosLJkJAeXxCxnYZPXG9lDDsFYO3
        pC+ipPlJLO/T3QZj2WRYm9mtLYrZpZXvPwyTyA==
X-Google-Smtp-Source: APXvYqyCfwW+vnY+upQob/ly6+wXcqdZa6JFfMjuRTb1mhMFINh9OBYo3iJifS5BK8GagbP7PjxJaz2stYoMBOy0HDU=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr22321665qto.224.1566909583245;
 Tue, 27 Aug 2019 05:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190827082652.43840-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190827082652.43840-2-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20190827082652.43840-2-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Aug 2019 07:39:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJsTDNR7FsdFouLetzhsRhmr3fVT_xzzhKbR7KuTwepuQ@mail.gmail.com>
Message-ID: <CAL_JsqJsTDNR7FsdFouLetzhsRhmr3fVT_xzzhKbR7KuTwepuQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema
 for LGM SDXC PHY
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 3:27 AM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Add a YAML schema to use the host controller driver with the
> SDXC PHY on Intel's Lightning Mountain SoC.
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> new file mode 100644
> index 000000000000..be05020880bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,lgm-sdxc-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightning Mountain(LGM) SDXC PHY Device Tree Bindings
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +description: Binding for SDXC PHY
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-sdxc-phy
> +
> +  intel,syscon:
> +    description: phandle to the sdxc through syscon
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - intel,syscon
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sdxc_phy: sdxc_phy {
> +        compatible = "intel,lgm-sdxc-phy";
> +        intel,syscon = <&sysconf>;

Rather than a phandle, can this be a child node of sysconf? You need a
binding for sysconf first anyways.

> +        clocks = <&sdxc>;
> +        clock-names = "sdxcclk";
> +        #phy-cells = <0>;
> +    };
> +
> +...
> --
> 2.11.0
>
