Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D596918FE09
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 20:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgCWTsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 15:48:19 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40596 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCWTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:48:19 -0400
Received: by mail-il1-f196.google.com with SMTP id j9so1461121ilr.7;
        Mon, 23 Mar 2020 12:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kipXCQa4i+umHTrcz0qmgyn0yywsyA7UdjziiiIu1Sw=;
        b=iNvFLOCQsREWGYVEhQ/HZ9ReUxvFC0fbJM9nXvIfFbqr9uTVfB5FRaZa7JzmnQoby4
         tzyAfvGGKR/Wu1Z3zJf8YxqKDZF4pQj4AbeZGubmSVrYUHoA+rIUfbgCiv9FGGgk2spC
         rtsc8imw6rZOGZcmVnnUqX+F1Aa8h2nKijEB4Da+CosV+ilEe2+K0FnTM15Afl+3Bh5h
         Yg8FKo+mz+vLkm0l993BuPRbETtw0Yjl10C679ArTThIV6XY5naPhApjvBWw5M17f6QC
         kvpgXvK7Q/hivTjg49/4FY961snHqBhJsDgwc2oZxcNEVOzSyiQmx1DDcI6u5RlBfLXY
         YeVQ==
X-Gm-Message-State: ANhLgQ3Wbc4JZGjmJyLCWSZRSpPHgeb8c2e/sKs6ZhQgSQIUYlW04CRu
        UAZNOb9VDOQObdQzDZ4B7A==
X-Google-Smtp-Source: ADFU+vsP/KgXVNr/Uu6jpUr15rWf4XDIQ6bcITTjbhYpcoip6I8JN0DSb20PaQRJAEfQrw28uasKAQ==
X-Received: by 2002:a92:9f13:: with SMTP id u19mr23299246ili.111.1584992897749;
        Mon, 23 Mar 2020 12:48:17 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u19sm1807524iow.21.2020.03.23.12.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:48:16 -0700 (PDT)
Received: (nullmailer pid 26533 invoked by uid 1000);
        Mon, 23 Mar 2020 19:48:15 -0000
Date:   Mon, 23 Mar 2020 13:48:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC 04/11] dt-bindings: interrupt-controller: Add Sunplus
 SP7021 mux
Message-ID: <20200323194815.GA21590@bogus>
References: <20200308163230.4002-1-afaerber@suse.de>
 <20200308163230.4002-5-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200308163230.4002-5-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 05:32:22PM +0100, Andreas Färber wrote:
> The Sunplus SP7021 SoC has an interrupt mux.
> 
> Cc: Wells Lu 呂芳騰 <wells.lu@sunplus.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  .../sunplus,pentagram-intc.yaml                    | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,pentagram-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunplus,pentagram-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sunplus,pentagram-intc.yaml
> new file mode 100644
> index 000000000000..baaf7bcd4a71
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sunplus,pentagram-intc.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/sunplus,pentagram-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus Pentagram SoC Interrupt Controller
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#

No need for this. It's applied based on the node name.

> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-intc
> +
> +  reg:
> +    maxItems: 2

Need to define what each one is.

> +
> +  interrupts:
> +    maxItems: 2

Same here.

> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    interrupt-controller@9c000780 {
> +        compatible = "sunplus,sp7021-intc";
> +        reg = <0x9c000780 0x80>,
> +              <0x9c000a80 0x80>;
> +        interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +    };
> +...
> -- 
> 2.16.4
> 
