Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAD30352
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfE3UhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 16:37:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42630 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3UhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CzZNdS7LKVPhMQrMJpz7Y8+OpXbEAePhifOl33mCSkA=; b=wpGOi1iSqLulaxzZWywII1B+qn
        4EZSokjY+LbuOEdRHIuw+kiYGOjUslhLdD6IvizLXzwuI7rq2b8u3s0WlM7H8X6fYahnJqnPUztJ9
        a4K93qA0l8nJI0J8OvKIwfoohQsd5eNt5C1DAFet3ZVo05Rhh79zrYbz02TwcGMXSEq0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hWRnB-0001ZU-H8; Thu, 30 May 2019 22:36:53 +0200
Date:   Thu, 30 May 2019 22:36:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexander Filippov <a.filippov@yadro.com>
Cc:     linux-aspeed@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: aspeed: Add YADRO VESNIN BMC
Message-ID: <20190530203653.GD1561@lunn.ch>
References: <20190530143933.25414-1-a.filippov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530143933.25414-1-a.filippov@yadro.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 05:39:33PM +0300, Alexander Filippov wrote:
> VESNIN is an OpenPower machine with an Aspeed 2400 BMC SoC manufactured
> by YADRO.
> 
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 234 ++++++++++++++++++++
>  2 files changed, 235 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 834cce80d1b8..811e9312cf22 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1259,6 +1259,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-microsoft-olympus.dtb \
>  	aspeed-bmc-opp-lanyang.dtb \
>  	aspeed-bmc-opp-palmetto.dtb \
> +	aspeed-bmc-opp-vesnin.dtb \
>  	aspeed-bmc-opp-romulus.dtb \
>  	aspeed-bmc-opp-swift.dtb \
>  	aspeed-bmc-opp-witherspoon.dtb \

Hi Alexander

Still not correctly sorted.

      Andrew
