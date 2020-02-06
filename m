Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F3154872
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 16:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgBFPsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 10:48:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41466 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBFPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:48:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 83E5E2956C0
Subject: Re: [PATCH v2] dt-bindings: convert extcon-usbc-cros-ec.txt
 extcon-usbc-cros-ec.yaml
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        devicetree@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, bleung@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
References: <20200205110029.3395-1-dafna.hirschfeld@collabora.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <59ec876a-a77a-9b6d-34dd-272292102ed9@collabora.com>
Date:   Thu, 6 Feb 2020 16:47:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200205110029.3395-1-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On 5/2/20 12:00, Dafna Hirschfeld wrote:
> convert the binding file extcon-usbc-cros-ec.txt to yaml format
> This was tested and verified on ARM with:
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
> Changes since v1:
> 1 - changing the license to (GPL-2.0-only OR BSD-2-Clause)
> 2 - changing the maintainers
> 3 - changing the google,usb-port-id property to have minimum 0 and maximum 255
> 
>  .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 ----------
>  .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> deleted file mode 100644
> index 8e8625c00dfa..000000000000
> --- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -ChromeOS EC USB Type-C cable and accessories detection
> -
> -On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> -able to detect the state of external accessories such as display adapters
> -or USB devices when said accessories are attached or detached.
> -
> -The node for this device must be under a cros-ec node like google,cros-ec-spi
> -or google,cros-ec-i2c.
> -
> -Required properties:
> -- compatible:		Should be "google,extcon-usbc-cros-ec".
> -- google,usb-port-id:	Specifies the USB port ID to use.
> -
> -Example:
> -	cros-ec@0 {
> -		compatible = "google,cros-ec-i2c";
> -
> -		...
> -
> -		extcon {
> -			compatible = "google,extcon-usbc-cros-ec";
> -			google,usb-port-id = <0>;
> -		};
> -	}
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> new file mode 100644
> index 000000000000..fd95e413d46f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ChromeOS EC USB Type-C cable and accessories detection
> +
> +maintainers:
> +  - Benson Leung <bleung@chromium.org>
> +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +
> +description: |
> +  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
> +  able to detect the state of external accessories such as display adapters
> +  or USB devices when said accessories are attached or detached.
> +  The node for this device must be under a cros-ec node like google,cros-ec-spi
> +  or google,cros-ec-i2c.
> +
> +properties:
> +  compatible:
> +    const: google,extcon-usbc-cros-ec
> +
> +  google,usb-port-id:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    description: the port id
> +    minimum: 0
> +    maximum: 255
> +
> +required:
> +  - compatible
> +  - google,usb-port-id
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cros-ec@0 {
> +        compatible = "google,cros-ec-i2c";

Now that you are here ... could you use compatible = "google,cros-ec-spi" here?

The reason is that the label above, cros-ec@0 is not really correct for an i2c
device because after the @ you should put the address, cros-ec@1e will have more
sense here. But cros-ec-i2c is rarely used, so I'd change the compatible to use
"google,cros-ec-spi" and the entry "cros-ec@0" is fine.

> +        extcon {
> +            compatible = "google,extcon-usbc-cros-ec";
> +            google,usb-port-id = <0>;
> +        };

And maybe would be useful have a more complete example like this?

    cros-ec@0 {
        compatible = "google,cros-ec-spi";

	usbc_extcon0: extcon@0 {
		compatible = "google,extcon-usbc-cros-ec";
		google,usb-port-id = <0>;
	};


	usbc_extcon1: extcon@1 {
		compatible = "google,extcon-usbc-cros-ec";
		google,usb-port-id = <1>;
	};
    };
