Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F793172C42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 00:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgB0Xay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 18:30:54 -0500
Received: from kernel.crashing.org ([76.164.61.194]:37124 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbgB0Xay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:30:54 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01RNU3sQ030322
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Feb 2020 17:30:06 -0600
Message-ID: <3150424b9e9f5856c747a0fbf44647919f49209d.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 7/7] dt-bindings: usb: add documentation for aspeed
 usb-vhub
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     rentao.bupt@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Date:   Fri, 28 Feb 2020 10:30:02 +1100
In-Reply-To: <20200227230507.8682-8-rentao.bupt@gmail.com>
References: <20200227230507.8682-1-rentao.bupt@gmail.com>
         <20200227230507.8682-8-rentao.bupt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-27 at 15:05 -0800, rentao.bupt@gmail.com wrote:

 .../...

You haven't fixed the problem spotted by Rob which is that the example
is now out of sync, it's missing the required properties.

Also long run I think best is going to have a child node per downstream
port, so we create a matching linux struct device. This will make it
easier to deal with the other device-controller in the ast2600 which is
basically one of these without a vhub above it.

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - aspeed,vhub-downstream-ports
> +  - aspeed,vhub-generic-endpoints
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/aspeed-clock.h>
> +    vhub: usb-vhub@1e6a0000 {
> +            compatible = "aspeed,ast2500-usb-vhub";
> +            reg = <0x1e6a0000 0x300>;
> +            interrupts = <5>;
> +            clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&pinctrl_usb2ad_default>;
> +    };
> -- 

