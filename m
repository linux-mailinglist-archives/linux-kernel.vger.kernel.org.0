Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303E28D14F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfHNKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 06:48:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54986 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfHNKs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:48:59 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 189B01A0384;
        Wed, 14 Aug 2019 12:48:56 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0BE661A037B;
        Wed, 14 Aug 2019 12:48:56 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FDB02060E;
        Wed, 14 Aug 2019 12:48:55 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/15] Improvements and fixes for mxsfb DRM driver
Date:   Wed, 14 Aug 2019 13:48:36 +0300
Message-Id: <1565779731-1300-1-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set improves the use of eLCDIF block on iMX 8 SoCs (like 8MQ, 8MM
and 8QXP). Following, are the new features added and fixes from this
patch-set:

1. Add support for drm_bridge
On 8MQ and 8MM, the LCDIF block is not directly connected to a parallel
display connector, where an LCD panel can be attached, but instead it is
connected to DSI controller. Since this DSI stands between the display
controller (eLCDIF) and the physical connector, the DSI can be implemented
as a DRM bridge. So, in order to be able to connect the mxsfb driver to
the DSI driver, the support for a drm_bridge was needed in mxsfb DRM
driver (the actual driver for the eLCDIF block).

2. Add support for additional pixel formats
Some of the pixel formats needed by Android were not implemented in this
driver, but they were actually supported. So, add support for them.

3. Add support for horizontal stride
Having support for horizontal stride allows the use of eLCDIF with a GPU
(for example) that can only output resolution sizes multiple of a power of
8. For example, 1080 is not a power of 16, so in order to support 1920x1080
output from GPUs that can produce linear buffers only in sizes multiple to 16,
this feature is needed.

3. Few minor features and bug-fixing
The addition of max-res DT property was actually needed in order to limit
the bandwidth usage of the eLCDIF block. This is need on systems where
multiple display controllers are presend and the memory bandwidth is not
enough to handle all of them at maximum capacity (like it is the case on
8MQ, where there are two display controllers: DCSS and eLCDIF).
The rest of the patches are bug-fixes.

v2:
- Collected Tested-by from Guido
- Split the first patch, which added more than one feature into relevant
  patches, explaining each feature added
- Also split the second patch into more patches, to differentiate between
  the feature itself (additional pixel formats support) and the cleanup
  of the register definitions for a better representation (guido)
- Included a patch submitted by Guido, while he was testing my patch-set

Guido Günther (1):
  drm/mxsfb: Read bus flags from bridge if present

Mirela Rabulea (1):
  drm/mxsfb: Signal mode changed when bpp changed

Robert Chiras (13):
  drm/mxsfb: Update mxsfb to support a bridge
  drm/mxsfb: Add defines for the rest of registers
  drm/mxsfb: Reset vital register for a proper initialization
  drm/mxsfb: Update register definitions using bit manipulation defines
  drm/mxsfb: Update mxsfb with additional pixel formats
  drm/mxsfb: Fix the vblank events
  dt-bindings: display: Add max-res property for mxsfb
  drm/mxsfb: Add max-res property for MXSFB
  drm/mxsfb: Update mxsfb to support LCD reset
  drm/mxsfb: Improve the axi clock usage
  drm/mxsfb: Clear OUTSTANDING_REQS bits
  drm/mxsfb: Add support for horizontal stride
  drm/mxsfb: Add support for live pixel format change

 .../devicetree/bindings/display/mxsfb.txt          |   6 +
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c                 | 287 ++++++++++++++++++---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  | 190 +++++++++++---
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                  |  10 +-
 drivers/gpu/drm/mxsfb/mxsfb_out.c                  |  26 +-
 drivers/gpu/drm/mxsfb/mxsfb_regs.h                 | 193 +++++++++-----
 6 files changed, 573 insertions(+), 139 deletions(-)

-- 
2.7.4

