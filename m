Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F49BF4479
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 11:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfKHK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 05:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfKHK2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:28:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997DF206BA;
        Fri,  8 Nov 2019 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573208889;
        bh=AOSjNRac0P9NEqExaxB0xZTWmcyhkd13as5AIA1QlAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMCWRLIPqRMeWNaDQUiiTnuQ2uS0dICkTS3gRPk7P+iNA8cyh/JeygV57zPG+NxmY
         kYgXxnjTO11HViK4KzLlph40W+a6qDazZbXc9CnT8tRfliiAzNCMxJTKq4Fdbir8td
         0KJT3vLj5HkWsVy6nOJNtxnn8ZKJlJtgBFH2cHHg=
Date:   Fri, 8 Nov 2019 11:28:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH v2 08/11] dt-bindings: fsi: Add description of FSI master
Message-ID: <20191108102806.GA656785@kroah.com>
References: <20191108051945.7109-1-joel@jms.id.au>
 <20191108051945.7109-9-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108051945.7109-9-joel@jms.id.au>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 03:49:42PM +1030, Joel Stanley wrote:
> This describes the FSI master present in the AST2600.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Alistair Popple <alistair@popple.id.au>
> ---
>  .../bindings/fsi/fsi-master-aspeed.txt        | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> new file mode 100644
> index 000000000000..b758f91914f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> @@ -0,0 +1,24 @@
> +Device-tree bindings for AST2600 FSI master
> +-------------------------------------------
> +
> +The AST2600 contains two identical FSI masters. They share a clock and have a
> +separate interrupt line and output pins.
> +
> +Required properties:
> + - compatible: "aspeed,ast2600-fsi-master"
> + - reg: base address and length
> + - clocks: phandle and clock number
> + - interrupts: platform dependent interrupt description
> + - pinctrl-0: phandle to pinctrl node
> + - pinctrl-names: pinctrl state
> +
> +Examples:
> +
> +    fsi-master {
> +        compatible = "aspeed,ast2600-fsi-master", "fsi-master";
> +        reg = <0x1e79b000 0x94>;
> +	interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fsi1_default>;
> +	clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
> +    };
> -- 
> 2.24.0.rc1
> 

As these all seem like bog-standard properties, I'll take this now,
thanks.

greg k-h
