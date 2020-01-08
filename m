Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156AE1339BD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 04:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgAHDqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 22:46:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43140 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgAHDqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:46:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so1462188oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 19:46:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r+pFes6TBL9qlt9DAArVbPYLSHaTdO8S1tCZhBCIPEc=;
        b=RoxKx1cnEK1O01wGg6KUu8yoVM0JImhi5Ap91GyJUAYZpUF2ef515SejM0LNVv6o88
         ZMqVWys7bF0H8okOJCQ083Bo0tHL+VYty6stjkaPMrQ31xw006eyPbNQLrUGGfTJaiAu
         zhdbPltUPg7OYXI8eCnrkFk5wUNt/FYVZjxY8E9vIVu43bR6VGMS5WPEOBHGOE2vZO/a
         tPNd7JGn24Zx205E3/32h7NXONajcYZA1WZQNn+b6i7tRxB7O2zF3L51B5VqkCDVxFFT
         iqOTmp9dWybBCmbleAxPMLuSrzgiH1zmuG7RZ5q8zX4WNQq3U272ndGvlg7TXboAfvoz
         VWcg==
X-Gm-Message-State: APjAAAUuCuZbBHszjPy3MOyr+N0/ffM/ltYS4wwqW9/AnfURUTRxQhgF
        2ObuTMcpuJlCQf/8egBomXU2G9s=
X-Google-Smtp-Source: APXvYqzb+7aP7JUmpnRE8h0keDMurCQ0S5JvDycE7t7ey7iNdGWFgiDDyDzbqg9sEFBkN8wJW/WDZA==
X-Received: by 2002:aca:53c6:: with SMTP id h189mr1519969oib.11.1578455161536;
        Tue, 07 Jan 2020 19:46:01 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p83sm687116oia.51.2020.01.07.19.46.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 19:46:00 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219e3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 07 Jan 2020 21:45:59 -0600
Date:   Tue, 7 Jan 2020 21:45:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, broonie@kernel.org,
        lee.jones@linaro.org, lars@metafoo.de, pascal.huerst@gmail.com
Subject: Re: [PATCH 02/10] dt-bindings: i2c: Add documentation for ad242x i2c
 controllers
Message-ID: <20200108034559.GA27808@bogus>
References: <20191209183511.3576038-1-daniel@zonque.org>
 <20191209183511.3576038-3-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191209183511.3576038-3-daniel@zonque.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 07:35:02PM +0100, Daniel Mack wrote:
> This device must be placed as a sub-device of an AD242x MFD node.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  .../bindings/i2c/adi,ad242x-i2c.yaml          | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/adi,ad242x-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/adi,ad242x-i2c.yaml b/Documentation/devicetree/bindings/i2c/adi,ad242x-i2c.yaml
> new file mode 100644
> index 000000000000..ded92f8a791b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/adi,ad242x-i2c.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/i2c/adi,ad242x-i2c.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Analog Devices AD242x I2C controller
> +
> +maintainers:
> +  - Daniel Mack <daniel@zonque.org>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +
> +description: |
> +  This module is part of the AD242x MFD device. For more details and an example
> +  refer to Documentation/devicetree/bindings/mfd/ad242x.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad2428w-i2c
> +
> +  clock-frequency:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'

Can drop as it already has a type.

> +    default: 100000
> +    enum: [100000, 400000]
> +    description: Specifies the I²C clock frequency in Hz.
> +
> +required:
> +  - compatible
> -- 
> 2.23.0
> 
