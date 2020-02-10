Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284E71582EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 19:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBJSps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 13:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgBJSps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:45:48 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE6B20715;
        Mon, 10 Feb 2020 18:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581360347;
        bh=1HEo325uKcJScMqA1TBMxTyz69hQ2kusxwb1WY+5d6w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NdKqBThhzMhuAHRe2+WtUZ1+wejRl1ueQ6kv59onPhamqyc+lX6JIkIxnZ96amPkw
         H+p42TwWdhwtBxbUDFDh0UW2ZwTa2JGVxwnV3vCVXju5Ku3/obTgujV8sDjDrI3IQo
         xeiGrx+9qOrOv/fccDCB8NpQMziZ4n8mEMAhYtrI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200207044425.32398-2-vigneshr@ti.com>
References: <20200207044425.32398-1-vigneshr@ti.com> <20200207044425.32398-2-vigneshr@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add binding documentation for TI syscon gate clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Date:   Mon, 10 Feb 2020 10:45:46 -0800
Message-ID: <158136034652.94449.4389789192412792346@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vignesh Raghavendra (2020-02-06 20:44:24)
> diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbcl=
k.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> new file mode 100644
> index 000000000000..98fcac2b41f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI syscon gate clock driver
> +
> +maintainers:
> +  - Vignesh Raghavendra <vigneshr@ti.com>
> +
> +description: |
> +
> +  This binding uses common clock bindings
> +  Documentation/devicetree/bindings/clock/clock-bindings.txt

Maybe have a real description instead of this line which is mostly
useless.

> +
> +properties:
> +  compatible:
> +    items:

I think you can drop items.

> +      - const: ti,am654-ehrpwm-tbclk
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  ti,tbclk-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the system controller node that has bits to
> +      control eHRPWM's TBCLK
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - ti,tbclk-syscon
> +
> +examples:
> +  - |
> +    tbclk_ctrl: tbclk_ctrl@4140 {
> +        compatible =3D "syscon";
> +        reg =3D <0x4140 0x18>;
> +    };
> +
> +    ehrpwm_tbclk: clk0 {
> +        compatible =3D "ti,am654-ehrpwm-tbclk";
> +        #clock-cells =3D <1>;
> +        ti,tbclk-syscon =3D <&tbclk_ctrl>;
> +    };

I don't understand the binding. Why can't the syscon node register clks
and have #clock-cells?
