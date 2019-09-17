Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E045B545F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbfIQRhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:37:40 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44576 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfIQRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=omsIg2rbbwmNo2zYjbESoX4pKX0DYuCZ/SV7w4KEtXM=; b=jmcYKNMnfrqw4snJOPuurmbry
        M5Ipeu3Ciu8WoGdLAHoA6AsF6je/AC1WpcMtMjFgFlJsMCxuMO03ros7qr0a/jscdqXmf2PsSufbt
        gAsOWFS/thqGPbNuCHK8y6lkI32pa6BRGFcpW/mxSppHmsOMQbADhJn7VdceECzxAxNr+8MW+135o
        udIDoiJfvTFMjmZuIeIGGDjoGWZdp4I5ViHLjjRFfb89jkRFMiXI02BarEPCSbIRMDX9ZF7XN/5nZ
        tZlJF7Ee0ktZ21l915NuQI2yfEAhCJDE2vIVtUMPxfBd1zAxWF0TmzDP1D9zDP5mLdF3SolqBCTRE
        gAjzRj6PQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:40720)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iAHPw-0003Fo-13; Tue, 17 Sep 2019 18:37:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iAHPs-0001To-Gj; Tue, 17 Sep 2019 18:37:28 +0100
Date:   Tue, 17 Sep 2019 18:37:28 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20190917173728.GZ25745@shell.armlinux.org.uk>
References: <20190917124101.GA1200564@arch-dsk-01>
 <20190917125434.GH20778@lunn.ch>
 <20190917133253.GA1210141@arch-dsk-01>
 <20190917133942.GR25745@shell.armlinux.org.uk>
 <20190917151707.GV25745@shell.armlinux.org.uk>
 <20190917153027.GW25745@shell.armlinux.org.uk>
 <20190917163427.GA1475935@arch-dsk-01>
 <20190917170419.GX25745@shell.armlinux.org.uk>
 <20190917171913.GY25745@shell.armlinux.org.uk>
 <20190917172658.GB9591@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917172658.GB9591@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 07:26:58PM +0200, Andrew Lunn wrote:
> > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> > index b3893347804d..85cf4a4a5e81 100644
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> 
> Hi Russell
> 
> This won't work. In the kernel logs, you see 
> 
> kernel: Generic PHY 2188000.ethernet-1:00: attached PHY driver [Generic PHY]
> 
> The generic PHY driver is being used, not the at803x driver.

Well, the _correct_ driver needs to be used for the PHY specific
features to be properly controlled.  Using the generic driver
in this situation will not be guaranteed to work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
