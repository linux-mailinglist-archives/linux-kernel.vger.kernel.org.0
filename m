Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E471B4A229
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 15:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfFRNat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 09:30:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48696 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfFRNat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:30:49 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 49941200DD0;
        Tue, 18 Jun 2019 15:30:47 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3C5A62003D7;
        Tue, 18 Jun 2019 15:30:47 +0200 (CEST)
Received: from fsr-ub1664-046.ea.freescale.net (fsr-ub1664-046.ea.freescale.net [10.171.96.34])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 27FCB20631;
        Tue, 18 Jun 2019 15:30:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id E955255B1;
        Tue, 18 Jun 2019 16:30:46 +0300 (EEST)
Received: from fsr-ub1664-046.ea.freescale.net ([127.0.0.1])
        by localhost (fsr-ub1664-046.ea.freescale.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WyWO7bCRI6C1; Tue, 18 Jun 2019 16:30:46 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id 81B0C55B3;
        Tue, 18 Jun 2019 16:30:46 +0300 (EEST)
X-Virus-Scanned: amavisd-new at ea.freescale.net
Received: from fsr-ub1664-046.ea.freescale.net ([127.0.0.1])
        by localhost (fsr-ub1664-046.ea.freescale.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PfxNs3qU2e-H; Tue, 18 Jun 2019 16:30:46 +0300 (EEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id 3F8594D1D;
        Tue, 18 Jun 2019 16:30:46 +0300 (EEST)
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
Subject: [PATCH v2 0/2] Add DSI panel driver for Raydium RM67191
Date:   Tue, 18 Jun 2019 16:30:44 +0300
Message-Id: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set contains the DRM panel driver and dt-bindings documentation
for the DSI driven panel: Raydium RM67191.

Changes since v1:
- Fixed 'reset-gpio' to 'reset-gpios' property naming
- Changed the state of the reset gpio to active low and fixed how it is
  handled in driver
- Fixed copyright statement
- Reordered includes
- Added defines for panel specific color formats
- Removed unnecessary tests in enable and unprepare
- Removed the unnecessary backlight write in enable

Robert Chiras (2):
  dt-bindings: display: panel: Add support for Raydium RM67191 panel
  drm/panel: Add support for Raydium RM67191 panel driver

 .../bindings/display/panel/raydium,rm67191.txt     |  43 ++
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      | 709 +++++++++++++++++++++
 4 files changed, 762 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
 create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm67191.c

-- 
2.7.4

