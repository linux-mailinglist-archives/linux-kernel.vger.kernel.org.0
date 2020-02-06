Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233E0154D4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 21:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBFUqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 15:46:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46774 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgBFUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:46:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so22942pll.13;
        Thu, 06 Feb 2020 12:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t7+ZXb374SG+32aNab2QK6gIc/sbbSVu/ejEJ9J5R0o=;
        b=iru5h4s0U0vBJVKbXNKU4LUSLD7h6kzzYTSz54uaJtECHWIuK7meF5ZRvNKE/tczJF
         AQX1HuH1yiHIKi+SR2te2DU7EhTzz6FLy2cTCUjAxPhYNhVp0EVu2lr6a4oDbS/LQA8p
         R6GMUHWcp7KtqtoF5nn+UOvI7Gp3MFuMjdlUH3SNEauP9Lm8+frBxosqCb0hGOT8rsIm
         CC0iElRAUT7hJHvtdQZnYy8uv/A0q5oCHm9a/bRuoCHjUGEn5/YwM0ElLmuW66wzwnFf
         qewMH5EJv2fOdsUoFmCQzyKJ1W6tbeT0zRUq4otS0KhZA7t2V/mNt8CgQKjFA2kReKDk
         SHiQ==
X-Gm-Message-State: APjAAAXa74uH+qR+AcQwlsTcuouqTIibEkyKnle5H306/5eZ9BHeZfDp
        XnkZLCq4SbdH00S7pByc5i9aZT+H4g==
X-Google-Smtp-Source: APXvYqyFvEEIkfC7yPNsqX45LR6kQ8NZVIQRMQRf2zMe2y9dA9KwI/+6lD3tz0xOPw3xszid6QubfA==
X-Received: by 2002:a17:902:694c:: with SMTP id k12mr5736906plt.329.1581021976639;
        Thu, 06 Feb 2020 12:46:16 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id r14sm288920pfh.10.2020.02.06.12.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:46:16 -0800 (PST)
Received: (nullmailer pid 11394 invoked by uid 1000);
        Thu, 06 Feb 2020 19:23:34 -0000
Date:   Thu, 6 Feb 2020 19:23:34 +0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 12/12] dt-bindings: arm: bcm: Convert BCM2835 firmware
 binding to YAML
Message-ID: <20200206192333.GA30325@bogus>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
 <20200204235552.7466-13-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204235552.7466-13-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:55:52PM -0800, Florian Fainelli wrote:
> Convert the Raspberry Pi BCM2835 firmware binding document to YAML.
> Verified with dt_binding_check and dtbs_check.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 --------
>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 33 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> deleted file mode 100644
> index 6824b3180ffb..000000000000
> --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -Raspberry Pi VideoCore firmware driver
> -
> -Required properties:
> -
> -- compatible:		Should be "raspberrypi,bcm2835-firmware"
> -- mboxes:		Phandle to the firmware device's Mailbox.
> -			  (See: ../mailbox/mailbox.txt for more information)
> -
> -Example:
> -
> -firmware {
> -	compatible = "raspberrypi,bcm2835-firmware";
> -	mboxes = <&mailbox>;
> -};
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> new file mode 100644
> index 000000000000..db355d970f2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/bcm/raspberrypi,bcm2835-firmware.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi VideoCore firmware driver
> +
> +maintainers:
> +  - Eric Anholt <eric@anholt.net>
> +  - Stefan Wahren <wahrenst@gmx.net>
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,bcm2835-firmware simple-bus
                                          ^

I need to check for spaces with the meta-schema...

> +
> +  mboxes:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'

Already has a type, just need to define how many items and what they are 
if more than one.

> +    description: |
> +      Phandle to the firmware device's Mailbox.
> +      (See: ../mailbox/mailbox.txt for more information)

Drop this. That's every 'mboxes'.

> +
> +required:
> +  - compatible
> +  - mboxes
> +
> +examples:
> +  - |
> +    firmware {
> +        compatible = "raspberrypi,bcm2835-firmware";
> +        mboxes = <&mailbox>;
> +    };
> +...
> -- 
> 2.19.1
> 
