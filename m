Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE47345BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfFNLvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 07:51:07 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49656 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfFNLvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:51:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BD4B1200EA1;
        Fri, 14 Jun 2019 13:51:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF900200E9E;
        Fri, 14 Jun 2019 13:51:04 +0200 (CEST)
Received: from fsr-ub1664-046.ea.freescale.net (fsr-ub1664-046.ea.freescale.net [10.171.96.34])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9A27720606;
        Fri, 14 Jun 2019 13:51:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id 67DA155AD;
        Fri, 14 Jun 2019 14:51:04 +0300 (EEST)
Received: from fsr-ub1664-046.ea.freescale.net ([127.0.0.1])
        by localhost (fsr-ub1664-046.ea.freescale.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NgXw2_MzS-3i; Fri, 14 Jun 2019 14:51:04 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id 050A055AF;
        Fri, 14 Jun 2019 14:51:04 +0300 (EEST)
X-Virus-Scanned: amavisd-new at ea.freescale.net
Received: from fsr-ub1664-046.ea.freescale.net ([127.0.0.1])
        by localhost (fsr-ub1664-046.ea.freescale.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yF_fcMKFJFci; Fri, 14 Jun 2019 14:51:03 +0300 (EEST)
Received: from fsr-ub1664-120.ea.freescale.net (fsr-ub1664-120.ea.freescale.net [10.171.82.81])
        by fsr-ub1664-046.ea.freescale.net (Postfix) with ESMTP id C0B924D1D;
        Fri, 14 Jun 2019 14:51:03 +0300 (EEST)
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
Subject: [PATCH 0/2] Add DSI panel driver for Raydium RM67191
Date:   Fri, 14 Jun 2019 14:51:01 +0300
Message-Id: <1560513063-24995-1-git-send-email-robert.chiras@nxp.com>
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

Robert Chiras (2):
  dt-bindings: display: panel: Add support for Raydium RM67191 panel
  drm/panel: Add support for Raydium RM67191 panel driver

 .../bindings/display/panel/raydium,rm67191.txt     |  42 ++
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      | 730 +++++++++++++++++++++
 4 files changed, 782 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67191.txt
 create mode 100644 drivers/gpu/drm/panel/panel-raydium-rm67191.c

-- 
2.7.4

