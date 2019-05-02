Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF8C11101
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 03:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfEBByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 21:54:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34532 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBByL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 21:54:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id n15so687747ota.1;
        Wed, 01 May 2019 18:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vVw1C6lqqEObhIEkQJZC6varaqiUoICZFVm+SicOMFc=;
        b=Fy5825i5JqkJeGG4+leTy52sMOYlfW7Jqy5oWHA5KZLx6d4gSsyYVEwkiECwWDXPkQ
         6sx13ZMMAVhjcDxdJGXXuUBtm1Cenxa9Ko+B34AlVn1vzWMYYUEzvLxkbA6m0IwljgRc
         1IfXRq+QZH9C/D6hUXz7dDugcVWThKgF8SXGpqJ7KSO1Dru0Y4C+1GcOYkOFb0xmYQrT
         eopen7ltZv3+JjgBZF3ea1KQ8zX2r/4Psb50YysYznKk723SmrSgCFpnCO63HfcrxTR8
         4jPuZiQCeYgh2bZpk93dafh9LWTIjbK+TW48g4YEunG+OnRvd1ZyJ8l0/nkcPVXqyntR
         eUYw==
X-Gm-Message-State: APjAAAUiWDm6RdINnYJOXRwnhIWBUSB2L1o6RNTIPiitRyD5zBiH95Vj
        wdnef7Tx0wkAnWj81KpOXg==
X-Google-Smtp-Source: APXvYqyvSe6l1vLK4cJ5ZxTy/PVn9hSglfwCtCezdanzmXnY1wQ1v0aNKpAxBDRzN1UG/UMo5gmWdg==
X-Received: by 2002:a9d:6c07:: with SMTP id f7mr740077otq.339.1556762050377;
        Wed, 01 May 2019 18:54:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f17sm8630963oto.5.2019.05.01.18.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 18:54:09 -0700 (PDT)
Date:   Wed, 1 May 2019 20:54:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kyungmin.park@samsung.com, bbrezillon@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 4/5] dt-binding: mtd: onenand/samsung: Add device tree
 support
Message-ID: <20190502015408.GA11612@bogus>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
 <20190426164224.11327-5-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426164224.11327-5-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 06:42:23PM +0200, Paweł Chmiel wrote:
> From: Tomasz Figa <tomasz.figa@gmail.com>
> 
> This patch adds dt-bindings for Samsung OneNAND driver.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../bindings/mtd/samsung-onenand.txt          | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/samsung-onenand.txt b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> new file mode 100644
> index 000000000000..341d97cc1513
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> @@ -0,0 +1,46 @@
> +Device tree bindings for Samsung SoC OneNAND controller
> +
> +Required properties:
> + - compatible : value should be either of the following.
> +   (a) "samsung,s3c6400-onenand" - for onenand controller compatible with
> +       S3C6400 SoC,
> +   (b) "samsung,s3c6410-onenand" - for onenand controller compatible with
> +       S3C6410 SoC,
> +   (c) "samsung,s5pc100-onenand" - for onenand controller compatible with
> +       S5PC100 SoC,
> +   (d) "samsung,s5pv210-onenand" - for onenand controller compatible with
> +       S5PC110/S5PV210 SoCs.
> +
> + - reg : two memory mapped register regions:
> +   - first entry: control registers.
> +   - second and next entries: memory windows of particular OneNAND chips;
> +     for variants a), b) and c) only one is allowed, in case of d) up to
> +     two chips can be supported.
> +
> + - interrupt-parent : phandle of interrupt controller to which the OneNAND
> +   controller is wired,

This is implied and can be removed.

> + - interrupts : specifier of interrupt signal to which the OneNAND controller
> +   is wired; should contain just one entry.
> + - clock-names : should contain two entries:
> +   - "bus" - bus clock of the controller,
> +   - "onenand" - clock supplied to OneNAND memory.

If the clock just goes to the OneNAND device, then it should be in the 
nand device node rather than the controller node.

> + - clock: should contain list of phandles and specifiers for all clocks listed
> +   in clock-names property.
> + - #address-cells : must be 1,
> + - #size-cells : must be 1.

This implies some child nodes. What are the child nodes?

> +
> +For partition table parsing (optional) please refer to:
> + [1] Documentation/devicetree/bindings/mtd/partition.txt
> +
> +Example for an s5pv210 board:
> +
> +	onenand@b0600000 {
> +		compatible = "samsung,s5pv210-onenand";
> +		reg = <0xb0600000 0x2000>, <0xb0000000 0x20000>;
> +		interrupt-parent = <&vic1>;
> +		interrupts = <31>;
> +		clock-names = "bus", "onenand";
> +		clocks = <&clocks NANDXL>, <&clocks DOUT_FLASH>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> -- 
> 2.20.1
> 
