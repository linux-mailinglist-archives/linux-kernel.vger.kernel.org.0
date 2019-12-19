Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96222126E17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 20:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLSTkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 14:40:04 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42791 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfLSTkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:40:04 -0500
Received: by mail-ot1-f53.google.com with SMTP id 66so8540457otd.9;
        Thu, 19 Dec 2019 11:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4FD4E6VPRHSJlg1OMSyY98hDnZZOWMuHy6UnkVUj/RM=;
        b=Ft/AdCzKPdyX3oHc5jvZBR4Kaqj4jpE7Q8XzPP0EYcT9xYnuC0/BZxUGrN8jhz8BIO
         DE98t7yJ+SogBLg95Hag1kDnoZddyigaNdDCBg9H+8JXJ1NmLbAyr217y/9EW2qAT2+T
         C/PGP32ENKQNE7zIEYfYF2Z3gkJLm8BJb1MFI3an9ZlgJ4XZWZ6MnsyZ+lk7q797Wn1a
         ML8MbTnqxl8pF8QJltuJVaeCJCHrLn5hzyA1QdN411K43iqS1wBJd5WmRoon8HDDCXeg
         HEMzuGB5YGI8ZfWMB+mGIvd0XvQjF9A2EnA2aoCYyMFYOUZ9euY4n0bii3QVIw94vISp
         kqZg==
X-Gm-Message-State: APjAAAV2kp/deZwL4eO5qNhs/fHla/MiadhUp5MHmhJLcesuzz/7Cr77
        b+ZaVLwdQfCrfonGmJXNuw==
X-Google-Smtp-Source: APXvYqxb3mN0ppbQoW8chdIbp9cEdwb9xhDSWxqJaXgyf3uzsInKjRVJLfT7puBtOC0JdkGYGP9ghg==
X-Received: by 2002:a05:6830:124b:: with SMTP id s11mr10297161otp.333.1576784402776;
        Thu, 19 Dec 2019 11:40:02 -0800 (PST)
Received: from localhost ([2607:fb90:20de:fb54:3549:d84c:9720:edb4])
        by smtp.gmail.com with ESMTPSA id s145sm2333734oie.44.2019.12.19.11.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 11:40:02 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:40:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     jassisinghbrar@gmail.com
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCHv1 1/2] dt-bindings: max3421-udc: add dt bindings for
 MAX3420 UDC
Message-ID: <20191219194000.GA23698@bogus>
References: <20191210003124.32376-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210003124.32376-1-jassisinghbrar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 06:31:24PM -0600, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Add YAML dt bindings for Maxim MAX3420 UDC controller.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  .../bindings/usb/maxim,max3420-udc.yaml       | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
> new file mode 100644
> index 000000000000..cf4eec8a618e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/maxim,max3420-udc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAXIM MAX3420/1 USB Peripheral Controller
> +
> +maintainers:
> +  - Jassi Brar <jaswinder.singh@linaro.org>
> +
> +description: |
> +  The controller provices USB2.0 compliant FullSpeed peripheral
> +  implementation over the  SPI interface.

space                        ^

> +
> +  Specifications about the part can be found at:
> +    http://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max3420-udc
> +      - maxim,max3421-udc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: udc
> +      - const: vbus

interrupts are integers, not strings. Should be interrupt-names?

> +
> +  spi-max-frequency:
> +    maximum: 26000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>
> +      #include <dt-bindings/interrupt-controller/irq.h>
> +      spi0 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            udc@0 {
> +                  compatible = "maxim,max3420-udc";
> +                  reg = <0>;
> +                  interrupt-parent = <&gpio>;
> +                  interrupts = <0 IRQ_TYPE_EDGE_FALLING>, <10 IRQ_TYPE_EDGE_BOTH>;
> +                  interrupt-names = "udc", "vbus";
> +                  spi-max-frequency = <12500000>;
> +            };
> +      };
> -- 
> 2.20.1
> 
