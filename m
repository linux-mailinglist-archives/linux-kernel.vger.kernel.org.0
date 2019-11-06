Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41810F0DE6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 05:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfKFEly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 23:41:54 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37210 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFEly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:41:54 -0500
Received: by mail-oi1-f194.google.com with SMTP id y194so19834448oie.4;
        Tue, 05 Nov 2019 20:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kExrcIwewO5meaE9ViSZ9PEk4wNZBD0E9gb/qgrKUcI=;
        b=UBnJ4uW3WSCL1JKJwTNtm6Unh17NGGKRvx8qOezW9l6ODbppjaiBiW9ykhTArSY0Sv
         ygpQ2vqVXVpusJzz7ayhKf7Hmyk2PhCR7jWwG4E3tfjEl4jcBcIGmqLWBKhlVSd9DCXU
         3XDX82mhEyfbLliKcg6qTY0eny0JvO1NiK7HZ/bhneP7luuXscdhLNj8bNxGg8eHVR2Q
         KX6763hna5llZZGJwHz83nV68tW6enqLbCkOBLuSm46D8aNcarNQnQmsiJrABIo8cGfz
         Q2Pm0RMSfggytAp/A0Ng6qxAGwu9qPstmq65jiy3DYve63W+GRaFpHQqBo8wCNxJtV9D
         5dKw==
X-Gm-Message-State: APjAAAVyHqrFeunKfNIuOGLYsO2rlkoBS/B0V564A5kZFGexLWJL1LbC
        4C54nVUZhHn/lfE1VehkFw==
X-Google-Smtp-Source: APXvYqxmk7nxkZvyzvyIdu53qhvNJePeZ1ZjaB/WVSemAb5HsQboL1nEWJcM17/eP/f5e7eko5Xxgw==
X-Received: by 2002:aca:f543:: with SMTP id t64mr498893oih.89.1573015313469;
        Tue, 05 Nov 2019 20:41:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 21sm6216231oin.26.2019.11.05.20.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:41:52 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:41:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [RFC 01/11] dt-bindings: soc: Add Realtek RTD1195 chip info
 binding
Message-ID: <20191106044152.GA23224@bogus>
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191103013645.9856-2-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 02:36:35AM +0100, Andreas F�rber wrote:
> Define a binding for RTD1195 and later SoCs' chip info registers.
> Add the new directory to MAINTAINERS.
> 
> Signed-off-by: Andreas F�rber <afaerber@suse.de>
> ---
>  Note: The binding gets extended compatibly later for up to three reg entries.
>  
>  .../bindings/soc/realtek/realtek,rtd1195-chip.yaml | 32 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
> new file mode 100644
> index 000000000000..565ad2419553
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/realtek/realtek,rtd1195-chip.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Realtek RTD1195 chip identification
> +
> +maintainers:
> +  - Andreas F�rber <afaerber@suse.de>
> +
> +description: |
> +  The Realtek SoCs have some registers to identify the chip and revision.
> +
> +properties:
> +  compatible:
> +    const: "realtek,rtd1195-chip"

Don't need quotes.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Add here:

additionalProperties: false

> +
> +examples:
> +  - |
> +    chip-info@1801a200 {
> +        compatible = "realtek,rtd1195-chip";
> +        reg = <0x1801a200 0x8>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f33adc430230..5c61cf5a44cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2188,6 +2188,7 @@ L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm64/boot/dts/realtek/
>  F:	Documentation/devicetree/bindings/arm/realtek.yaml
> +F:	Documentation/devicetree/bindings/soc/realtek/
>  
>  ARM/RENESAS ARM64 ARCHITECTURE
>  M:	Geert Uytterhoeven <geert+renesas@glider.be>
> -- 
> 2.16.4
> 
