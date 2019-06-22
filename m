Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E553F4F794
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfFVRzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 13:55:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49228 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfFVRzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mFFGkaI0iidPz6D6ZS4fu8dpqoCBpKXPSU6kWYWGKoA=; b=T/Ak48u3jVqwCPZX7scFXH1Lko
        zV6l5OAc4BpmDF9HEJ9ZhX3XIoiSrCgnfv5hgmeB1F7USdvhsYqQvh9w7X5KHovLTRHPyzLzbEH7x
        GY1iJGAcIiWeIoI501iO3vNwRWqdKgjoNlAEXQOm4lPTO1D9SsnR0HQzWqqomEi/q7fw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hekEG-0003Ea-Vr; Sat, 22 Jun 2019 19:55:08 +0200
Date:   Sat, 22 Jun 2019 19:55:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: add ethernet phy node for tinker
 board
Message-ID: <20190622175508.GE8497@lunn.ch>
References: <20190621180017.29646-1-katsuhiro@katsuster.net>
 <1871177.hjLhdHVgcu@phil>
 <ccf5ad2c-bd56-2d77-4728-d7906045e302@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccf5ad2c-bd56-2d77-4728-d7906045e302@katsuster.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 11:50:10PM +0900, Katsuhiro Suzuki wrote:
> Hello,

Hi Katsuhiro

Please also report this to netdev, and the stmmac maintainers.

./scripts/get_maintainer.pl -f drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
Giuseppe Cavallaro <peppe.cavallaro@st.com> (supporter:STMMAC ETHERNET DRIVER)
Alexandre Torgue <alexandre.torgue@st.com> (supporter:STMMAC ETHERNET DRIVER)
Jose Abreu <joabreu@synopsys.com> (supporter:STMMAC ETHERNET DRIVER)
"David S. Miller" <davem@davemloft.net> (odd fixer:NETWORKING DRIVERS)
Maxime Coquelin <mcoquelin.stm32@gmail.com> (maintainer:ARM/STM32 ARCHITECTURE)
netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER)
linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE)
linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE)
linux-kernel@vger.kernel.org (open list)

> I have not bisect commit of root cause yet... Is it better to bisect
> and find problem instead of sending this patch?

My guess is that it is one of these three which broken it:

74371272f97f net: stmmac: Convert to phylink and remove phylib logic
eeef2f6b9f6e net: stmmac: Start adding phylink support
9ad372fc5aaf net: stmmac: Prepare to convert to phylink

	     Andrew
