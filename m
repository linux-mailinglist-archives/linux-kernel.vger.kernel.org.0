Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA286AB19
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbfGPOy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 10:54:56 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:47456 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfGPOyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:54:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id AE3A1FB03;
        Tue, 16 Jul 2019 16:54:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Rc1dG7eD4j4M; Tue, 16 Jul 2019 16:54:51 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 08B5141140; Tue, 16 Jul 2019 16:54:50 +0200 (CEST)
Date:   Tue, 16 Jul 2019 16:54:50 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     "marex@denx.de" <marex@denx.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH 00/10] Improvements and fixes for mxsfb DRM
 driver
Message-ID: <20190716145450.GA609@bogon.m.sigxcpu.org>
References: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
 <20190711150403.GB23195@bogon.m.sigxcpu.org>
 <1562919331.3209.11.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562919331.3209.11.camel@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
On Fri, Jul 12, 2019 at 08:15:32AM +0000, Robert Chiras wrote:
> Hi Guido,
> 
> On Jo, 2019-07-11 at 17:04 +0200, Guido G�nther wrote:
> > Hi Robert,
> > On Wed, Jun 26, 2019 at 04:32:08PM +0300, Robert Chiras wrote:
> > > 
> > > This patch-set improves the use of eLCDIF block on iMX 8 SoCs (like
> > > 8MQ, 8MM
> > > and 8QXP). Following, are the new features added and fixes from
> > > this
> > > patch-set:
> > > 
> > > 1. Add support for drm_bridge
> > > On 8MQ and 8MM, the LCDIF block is not directly connected to a
> > > parallel
> > > display connector, where an LCD panel can be attached, but instead
> > > it is
> > > connected to DSI controller. Since this DSI stands between the
> > > display
> > > controller (eLCDIF) and the physical connector, the DSI can be
> > > implemented
> > > as a DRM bridge. So, in order to be able to connect the mxsfb
> > > driver to
> > > the DSI driver, the support for a drm_bridge was needed in mxsfb
> > > DRM
> > > driver (the actual driver for the eLCDIF block).
> > So I wanted to test this but with both my somewhat cleaned up nwl
> > driver� and the nwl driver forward ported from the nxp vendor tree
> > I'm
> > looking at a black screen with current mainline - while my dcss
> > forward
> > port gives me nice output on mipi dsi. Do you have a tree that uses
> > mipi
> > dsi on imx8mq where I could look at to check for differences?
> Somewhere on the pixel path (between the display controller and the
> DSI) there is a block that inverts the polarity. I can't remember
> exactly what was the role of this block, but the polarity is inverted
> when eLCDIF is used in combination with the DSI.
> If you take a look at my DSI driver from NXP releases (I guess you have
> them), you will see there is a hack in mode_fixup:
> 
> unsigned int *flags = &mode->flags;
> if (dsi->sync_pol {
> 	*flags |= DRM_MODE_FLAG_PHSYNC;
> 	*flags |= DRM_MODE_FLAG_PVSYNC;
> 	*flags &= ~DRM_MODE_FLAG_NHSYNC;
> 	*flags &= ~DRM_MODE_FLAG_NVSYNC;
> } else {
> 	*flags &= ~DRM_MODE_FLAG_PHSYNC;
> 	*flags &= ~DRM_MODE_FLAG_PVSYNC;
> 	*flags |= DRM_MODE_FLAG_NHSYNC;
> 	*flags |= DRM_MODE_FLAG_NVSYNC;
> }

Thanks for the suggestion! I'll try that.

> 
> I know it's not clean, but it works for now. You can try this in your
> driver and see if it helps.
> These days I will also take your nwl-dsi driver and test it, and also
> add support for bridge and eLCDIF to see if I can make it work.

I have hacky bridge support over here already. Give me some days to
clean it up and it might safe you some work.
Cheers,
 -- Guido
