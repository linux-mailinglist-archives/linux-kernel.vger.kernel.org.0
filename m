Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F0185866
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 03:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCOCGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 22:06:23 -0400
Received: from v6.sk ([167.172.42.174]:49692 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgCOCGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:06:22 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 159A160EED;
        Sat, 14 Mar 2020 16:38:42 +0000 (UTC)
Date:   Sat, 14 Mar 2020 17:38:39 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: Add USB HSIC PHY driver for Marvell MMP3 SoC
Message-ID: <20200314163839.GA356953@furthur.local>
References: <20200309125848.547664-1-lkundrak@v3.sk>
 <0d141fd7-274f-e9da-7cd0-68eb026d5c3c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d141fd7-274f-e9da-7cd0-68eb026d5c3c@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 04:52:00PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 09/03/20 6:28 pm, Lubomir Rintel wrote:
> > Add PHY driver for the HSICs found on Marvell MMP3 SoC. The driver is
> > rather straightforward -- the PHY essentially just needs to be enabled.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/phy/marvell/Kconfig         | 12 +++++
> >  drivers/phy/marvell/Makefile        |  1 +
> >  drivers/phy/marvell/phy-mmp3-hsic.c | 82 +++++++++++++++++++++++++++++
> >  3 files changed, 95 insertions(+)
> >  create mode 100644 drivers/phy/marvell/phy-mmp3-hsic.c
> > 
...
> > diff --git a/drivers/phy/marvell/phy-mmp3-hsic.c b/drivers/phy/marvell/phy-mmp3-hsic.c
> > new file mode 100644
> > index 0000000000000..f7b430f6f6f05
> > --- /dev/null
> > +++ b/drivers/phy/marvell/phy-mmp3-hsic.c
...
> > +static const struct of_device_id mmp3_hsic_phy_of_match[] = {
> > +	{ .compatible = "marvell,mmp3-hsic-phy", },
> 
> Where is the binding documentation for this?

There's one in mainline:
Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml

It got added just to document the compatible string at the time I thought 
usb-nop-xceiv would be sufficient to support the hardware.

It needs some fixing -- the "reset-gpios" shouldn't be there. I'll
follow up with a patch that removes it; please let me know if anything
else needs to be fixed there.

> Thanks
> Kishon

Thank you,
Lubo
