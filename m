Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0052D71617
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 12:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389039AbfGWK3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 06:29:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47271 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389028AbfGWK3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 06:29:38 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hps37-0005i0-8w; Tue, 23 Jul 2019 12:29:37 +0200
Message-ID: <1563877776.3731.3.camel@pengutronix.de>
Subject: Re: [EXT] Re: [v1] gpu: ipu-v3: allow to build with ARCH_LAYERSCAPE
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Wen He <wen.he_1@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     Leo Li <leoyang.li@nxp.com>
Date:   Tue, 23 Jul 2019 12:29:36 +0200
In-Reply-To: <DB7PR04MB5195F5731555285623955738E2F10@DB7PR04MB5195.eurprd04.prod.outlook.com>
References: <20190508105755.5881-1-wen.he_1@nxp.com>
         <1562322724.4291.5.camel@pengutronix.de>
         <DB7PR04MB5195F5731555285623955738E2F10@DB7PR04MB5195.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 03:11 +0000, Wen He wrote:
[...]
> > Thank you for the patch, but this does not seem right.
> > ipuv3-crtc.c is part of DRM_IMX, which already depends on IMX_IPUV3_CORE.
> > How did you manage to make it try to compile imxdrm?

I assume the answer to my question is that you have removed the
IMX_IPUV3_CORE dependency in the LS1028A BSP?

> Thanks for the review, Philipp,
> 
> NXP LS1028A platform use same Display IP with IMX8, so they have use same display
> transmit controller drivers, config 'DRM_IMX' is used to support drm common drivers
> on the NXP I.MX and LS1028A, display transmit controller is coming to plan upstream.  

Is it the i.MX8MQ DCSS or the i.MX8QM DPU that is shared with LS1028A?

> Actually, we have done compile of the imxdrm on LS1028A BSP release.

Can you point me changes that have been applied? It is still unclear to
me how you managed to build imx-drm, unless you have removed the
IMX_IPUV3_CORE dependency from DRM_IMX.

> > Since LS1028A does not have the IPUv3, keeping this under COMPILE_TEST
> > should be correct.
> 
> Although LS1028A does not have the IPVv3, but DRM_IMX depends on it, LS1028A display
> Transmit controller drivers also depends on DRM_IMX, so we need add this dependency to
> solve the compile issue.

The imx-drm driver is not suited to drive the i.MX8 display controllers.
They should get their own drm drivers, as they have nothing in common
with the i.MX5/6 IPU. There are no video capture capabilities, so they
don't need the subsystem spanning driver layout, and without muxable
shared encoders there is no need for the component design either.

regards
Philipp
