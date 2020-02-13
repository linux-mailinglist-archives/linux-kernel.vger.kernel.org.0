Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286D515BE43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 13:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgBMMI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 07:08:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59760 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbgBMMI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:08:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id 551CE294F6A
Subject: Re: [PATCH v3] dt-bindings: extcon: usbc-cros-ec: convert
 extcon-usbc-cros-ec.txt to yaml format
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        robh+dt@kernel.org, mark.rutland@arm.com, bleung@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com
References: <20200212155155.14210-1-dafna.hirschfeld@collabora.com>
 <f01756ae-d66b-f7e1-2aaf-b554426dd6c1@collabora.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <98e304dd-16f9-445b-d3bc-436dfc154f46@collabora.com>
Date:   Thu, 13 Feb 2020 13:08:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f01756ae-d66b-f7e1-2aaf-b554426dd6c1@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.02.20 17:55, Enric Balletbo i Serra wrote:
> Hi Dafna,
> 
> On 12/2/20 16:51, Dafna Hirschfeld wrote:
>> convert the binding file extcon-usbc-cros-ec.txt to
>> yaml format extcon-usbc-cros-ec.yaml
>>
>> This was tested and verified on ARM with:
>> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>>
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>> ---
>> Changes since v1:
>> 1 - changing the license to (GPL-2.0-only OR BSD-2-Clause)
>> 2 - changing the maintainers
>> 3 - changing the google,usb-port-id property to have minimum 0 and maximum 255
>>
>> Changes since v2:
>> 1 - Changing the patch subject to start with "dt-bindings: extcon: usbc-cros-ec:"
>> 2 - In the example, adding a parent isp node, a reg field to cros-ec@0
>> and adding nodes 'extcon0/1' instead of one node 'extcon'.
>>
>>   .../bindings/extcon/extcon-usbc-cros-ec.txt   | 24 --------
>>   .../bindings/extcon/extcon-usbc-cros-ec.yaml  | 56 +++++++++++++++++++
>>   2 files changed, 56 insertions(+), 24 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>>   create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>> deleted file mode 100644
>> index 8e8625c00dfa..000000000000
>> --- a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
>> +++ /dev/null
>> @@ -1,24 +0,0 @@
>> -ChromeOS EC USB Type-C cable and accessories detection
>> -
>> -On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
>> -able to detect the state of external accessories such as display adapters
>> -or USB devices when said accessories are attached or detached.
>> -
>> -The node for this device must be under a cros-ec node like google,cros-ec-spi
>> -or google,cros-ec-i2c.
>> -
>> -Required properties:
>> -- compatible:		Should be "google,extcon-usbc-cros-ec".
>> -- google,usb-port-id:	Specifies the USB port ID to use.
>> -
>> -Example:
>> -	cros-ec@0 {
>> -		compatible = "google,cros-ec-i2c";
>> -
>> -		...
>> -
>> -		extcon {
>> -			compatible = "google,extcon-usbc-cros-ec";
>> -			google,usb-port-id = <0>;
>> -		};
>> -	}
>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>> new file mode 100644
>> index 000000000000..d7a2fc544c4d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/extcon/extcon-usbc-cros-ec.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ChromeOS EC USB Type-C cable and accessories detection
>> +
>> +maintainers:
>> +  - Benson Leung <bleung@chromium.org>
>> +  - Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> +
>> +description: |
>> +  On ChromeOS systems with USB Type C ports, the ChromeOS Embedded Controller is
>> +  able to detect the state of external accessories such as display adapters
>> +  or USB devices when said accessories are attached or detached.
>> +  The node for this device must be under a cros-ec node like google,cros-ec-spi
>> +  or google,cros-ec-i2c.
>> +
>> +properties:
>> +  compatible:
>> +    const: google,extcon-usbc-cros-ec
>> +
>> +  google,usb-port-id:
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: the port id
>> +    minimum: 0
>> +    maximum: 255
>> +
>> +required:
>> +  - compatible
>> +  - google,usb-port-id
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    isp1 {
> 
> I think you mean 'spi' here ( spi0 or spi1 )?
yes!

> 
> With that fixed,
> 
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        cros-ec@0 {
>> +            compatible = "google,cros-ec-spi";
>> +            reg = <0>;
>> +
>> +            usbc_extcon0: extcon0 {
>> +                compatible = "google,extcon-usbc-cros-ec";
>> +                google,usb-port-id = <0>;
>> +            };
>> +
>> +            usbc_extcon1: extcon1 {
>> +                compatible = "google,extcon-usbc-cros-ec";
>> +                google,usb-port-id = <1>;
>> +            };
>> +        };
>> +    };
>>
