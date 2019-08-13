Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0688B51B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfHMKLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 06:11:01 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:52062 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbfHMKLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:11:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 030BEFB03;
        Tue, 13 Aug 2019 12:10:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j52cSuWGG3AI; Tue, 13 Aug 2019 12:10:57 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B21FD416CC; Tue, 13 Aug 2019 12:10:57 +0200 (CEST)
Date:   Tue, 13 Aug 2019 12:10:57 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 1/3] arm64: imx8mq: add imx8mq iomux-gpr field defines
Message-ID: <20190813101057.GB10751@bogon.m.sigxcpu.org>
References: <cover.1565367567.git.agx@sigxcpu.org>
 <e0562d8bb4098dc4cdb4023b41fb75b312be22a5.1565367567.git.agx@sigxcpu.org>
 <CAK8P3a3Vrd+sttJrQwD-jA9p_egG4x-hc41eGK8H-_aVm-uoYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3Vrd+sttJrQwD-jA9p_egG4x-hc41eGK8H-_aVm-uoYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
On Tue, Aug 13, 2019 at 10:08:44AM +0200, Arnd Bergmann wrote:
> On Fri, Aug 9, 2019 at 6:24 PM Guido G�nther <agx@sigxcpu.org> wrote:
> >
> > This adds all the gpr registers and the define needed for selecting
> > the input source in the imx-nwl drm bridge.
> >
> > Signed-off-by: Guido G�nther <agx@sigxcpu.org>
> > +
> > +#define IOMUXC_GPR0    0x00
> > +#define IOMUXC_GPR1    0x04
> > +#define IOMUXC_GPR2    0x08
> > +#define IOMUXC_GPR3    0x0c
> > +#define IOMUXC_GPR4    0x10
> > +#define IOMUXC_GPR5    0x14
> > +#define IOMUXC_GPR6    0x18
> > +#define IOMUXC_GPR7    0x1c
> (more of the same)
> 
> huh?

These are the names from the imx8MQ reference manual (general purpose
registers, they lump together all sorts of things), it's the same on
imx6/imx7):

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mfd/syscon/imx7-iomuxc-gpr.h     

> > +/* i.MX8Mq iomux gpr register field defines */
> > +#define IMX8MQ_GPR13_MIPI_MUX_SEL              BIT(2)
> 
> I think this define should probably be local to the pinctrl driver, to
> ensure that no other drivers fiddle with the registers manually.

The purpose of these bits is for a driver to fiddle with them to select
the input source. Similar on imx7 it's already used for e.g. the phy
refclk in the pci controller:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-imx6.c#n638

The GPRs are not about pad configuration but gather all sorts of things
(section 8.2.4 of the imx8mq reference manual): pcie setup, dsi related
bits so I don't think this should be done via a pinctrl
driver. Should we handle that differently than on imx6/7?

Cheers,
 -- Guido
