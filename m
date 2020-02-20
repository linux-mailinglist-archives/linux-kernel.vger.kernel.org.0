Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A5D1667E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 21:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgBTUBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 15:01:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgBTUBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:01:45 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9D9124650;
        Thu, 20 Feb 2020 20:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582228904;
        bh=E3wtXDlHqe9uG1b3FccAdsybeJfQVvMHZ1RK3GWM/sg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u9GdaiH1AxhdmxCLobZH59ld4VoU8bKkNCMkr+kUaThLTzlb7w+ao+wURI3rU/lek
         kkrMmCnfUd1uAHE0IXSzPpNjvapSXrhlWTqfH6XQ6LC86ycV0l4A54mw0s2vnKLNgv
         Q2N7uUTFijrtv0F9zAGaPeLCtnkS9xrY/PtegQSM=
Received: by mail-qt1-f171.google.com with SMTP id n17so3819030qtv.2;
        Thu, 20 Feb 2020 12:01:44 -0800 (PST)
X-Gm-Message-State: APjAAAVVsDDV1JloJ0p6wNPt5d2gjjBteVInGArU5TqOjMJeAkhffqfZ
        4eoOiqNEkY5sgy015gNQSwk8OLWIOGNc0PXzKA==
X-Google-Smtp-Source: APXvYqzjdY4RP8PXrUjP9DhJJfjP2nOH9wKbVDesN+YnyeYa7DustfCuvJPmOYppH7ViKAhlXHaPkzzxn/PcXp6k6M8=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr28217961qtp.224.1582228903752;
 Thu, 20 Feb 2020 12:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20200217234657.9413-1-chris.packham@alliedtelesis.co.nz> <20200217234657.9413-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200217234657.9413-3-chris.packham@alliedtelesis.co.nz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 20 Feb 2020 14:01:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-zD+_gBw-HqzSfz8_r8wY041DcewKJYm7BZj4ToHeZw@mail.gmail.com>
Message-ID: <CAL_JsqK-zD+_gBw-HqzSfz8_r8wY041DcewKJYm7BZj4ToHeZw@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: hwmon: Document adt7475
 bypass-attenuator property
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Shaw <logan.shaw@alliedtelesis.co.nz>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 5:47 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> From: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
>
> Add documentation for the bypass-attenuator-in[0-4] property.
>
> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/hwmon/adt7475.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> index 2252499ea201..61da90c82649 100644
> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -39,6 +39,17 @@ properties:
>    reg:
>      maxItems: 1
>
> +patternProperties:
> +  "^bypass-attenuator-in[0-4]$":
> +    maxItems: 1
> +    minimum: 0
> +    maximum: 1

The errors here are because you are mixing array and scalar constraints.

You also need a vendor prefix and a type $ref.

> +    description: |
> +      Configures bypassing the individual voltage input attenuator. If
> +      set to 1 the attenuator is bypassed if set to 0 the attenuator is
> +      not bypassed. If the property is absent then the attenuator
> +      retains it's configuration from the bios/bootloader.
> +
>  required:
>    - compatible
>    - reg
> @@ -52,6 +63,8 @@ examples:
>        hwmon@2e {
>          compatible = "adi,adt7476";
>          reg = <0x2e>;
> +        bypass-attenuator-in0 = <1>;
> +        bypass-attenuator-in1 = <0>;
>        };
>      };
>
> --
> 2.25.0
>
