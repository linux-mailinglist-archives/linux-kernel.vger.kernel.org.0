Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FEAB5429
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfIQR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:27:06 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51152 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731044AbfIQR1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sCrIBZVGo0peO+Uzee7kafLql6ON3IEIAQABS5oBoAs=; b=Jvo1RKwAS4WxLU0OxF6+jp0Nmd
        kIgssYdP4/7tmzx8r2ZRX7WFIc6FL6QciEsZOTg092mtujdJFcUQpTnXipWzsI+8QUZtF2y+GXTwa
        FenjWvKcKIVV41P6esSy4jxOWoeu8gUao2IuRmpQYAC5ghJzuFs0Ohd+TO/vNXkDdFSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1iAHFi-0002bt-H4; Tue, 17 Sep 2019 19:26:58 +0200
Date:   Tue, 17 Sep 2019 19:26:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     tinywrkb <tinywrkb@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190917172658.GB9591@lunn.ch>
References: <20190915135652.GC3427@lunn.ch>
 <20190917124101.GA1200564@arch-dsk-01>
 <20190917125434.GH20778@lunn.ch>
 <20190917133253.GA1210141@arch-dsk-01>
 <20190917133942.GR25745@shell.armlinux.org.uk>
 <20190917151707.GV25745@shell.armlinux.org.uk>
 <20190917153027.GW25745@shell.armlinux.org.uk>
 <20190917163427.GA1475935@arch-dsk-01>
 <20190917170419.GX25745@shell.armlinux.org.uk>
 <20190917171913.GY25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917171913.GY25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index b3893347804d..85cf4a4a5e81 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c

Hi Russell

This won't work. In the kernel logs, you see 

kernel: Generic PHY 2188000.ethernet-1:00: attached PHY driver [Generic PHY]

The generic PHY driver is being used, not the at803x driver.

But i do like your idea, it does fit the problem description.

    Andrew
