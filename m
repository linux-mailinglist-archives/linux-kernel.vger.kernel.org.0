Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3147F3C68
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 01:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfKHADS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 19:03:18 -0500
Received: from gloria.sntech.de ([185.11.138.130]:49646 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfKHADR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:03:17 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko.stuebner@theobroma-systems.com>)
        id 1iSrjz-00065H-Jt; Fri, 08 Nov 2019 01:03:03 +0100
From:   Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
To:     dri-devel@lists.freedesktop.org, a.hajda@samsung.com
Cc:     hjc@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, philippe.cornu@st.com,
        yannick.fertre@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v2 0/5] dw-mipi-dsi support for Rockchip px30
Date:   Fri,  8 Nov 2019 01:02:48 +0100
Message-Id: <20191108000253.8560-1-heiko.stuebner@theobroma-systems.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the dsi controller on the px30.
The main difference to previous incarnations is the use of an
external dphy for the output.

changes in v2:
- drop handling the dphy-pll manually, instead use the regular
  phy configuration operations, thanks Laurent for the suggestion
- add missing px30 compatible to the binding and make
  binding changes separate patches


Heiko Stuebner (5):
  drm/bridge/synopsys: dsi: move phy_ops callbacks around panel
    enablement
  dt-bindings: display: rockchip-dsi: document external phys
  drm/rockchip: add ability to handle external dphys in mipi-dsi
  dt-bindings: display: rockchip-dsi: add px30 compatible
  drm/rockchip: dsi: add px30 support

 .../display/rockchip/dw_mipi_dsi_rockchip.txt | 13 ++-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 13 ++-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 95 ++++++++++++++++++-
 3 files changed, 106 insertions(+), 15 deletions(-)

-- 
2.23.0

