Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C76A5668C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 12:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfFZKUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 06:20:50 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42256 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZKUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:20:50 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B58C91A09DC;
        Wed, 26 Jun 2019 12:20:47 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A89161A0011;
        Wed, 26 Jun 2019 12:20:47 +0200 (CEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 31862205DB;
        Wed, 26 Jun 2019 12:20:47 +0200 (CEST)
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH v5 0/2] Add DSI panel driver for Raydium RM67191
Date:   Wed, 26 Jun 2019 13:20:18 +0300
Message-Id: <1561544420-15572-1-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set contains the DRM panel driver and dt-bindings documentation
for the DSI driven panel: Raydium RM67191.

v5:
- Removed unnecessary debug messages (fabio)
- Handled error case for gpio pin (fabio)

v4:
- Changed default_timing structure type from 'struct display_timing' to
  'struct drm_display_mode' (fabio)
- Replaced devm_gpiod_get with devm_gpiod_get_optional (fabio)
- Added power regulators (fabio)
- Removed pm_ops (fabio)

v3:
- Added myself to MAINTAINERS for this driver (sam)
- Removed display-timings property (fabio)
- Fixed dt description (sam)
- Re-arranged calls inside get_modes function (sam)
- Changed ifdefs with _maybe_unused for suspend/resume functions (sam)
- Collected Reviewed-by from Sam

v2:
- Fixed 'reset-gpio' to 'reset-gpios' property naming (fabio)
- Changed the state of the reset gpio to active low and fixed how it is
  handled in driver (fabio)
- Fixed copyright statement (daniel)
- Reordered includes (sam)
- Added defines for panel specific color formats (fabio)
- Removed unnecessary tests in enable and unprepare (sam)
- Removed the unnecessary backlight write in enable (sam)

Robert Chiras (2):
  dt-bindings: display: panel: Add support for Raydium RM67191 panel
  drm/panel: Add support for Raydium RM67191 panel driver

 .../bindings/display/panel/raydium,rm67191.txt     |  41 ++
 MAINTAINERS                                        |   6 +
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      | 670 +++++++++++++++++++++
 5 files changed, 727 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
 create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm67191.c

-- 
2.7.4

