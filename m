Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF184197AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 13:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgC3Leu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 07:34:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58998 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbgC3Let (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:34:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 0545E292556
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@collabora.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v5 0/5] Genericize DW MIPI DSI bridge and add i.MX 6 driver
Date:   Mon, 30 Mar 2020 14:35:37 +0300
Message-Id: <20200330113542.181752-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

The v5 series is a significantly cleaned up version from v4,
started by Ezequiel Garcia's suggestion of splitting out the
regmap infrastructure from the drivers (thank you!).

Turns out no changes are required to the existing drivers and
the bridge can transparently take care of the layout logic,
so there's no need to expose the regmap via plat_data anymore.

Starting from this version I also opted to add per-patch
changelogs. All review comments up to now have been addressed.

Tested on IMX6DL.

Adrian Ratiu (5):
  drm: bridge: dw_mipi_dsi: add initial regmap infrastructure
  drm: bridge: dw_mipi_dsi: abstract register access using reg_fields
  drm: bridge: synopsis: add dsi v1.01 support
  drm: imx: Add i.MX 6 MIPI DSI host platform driver
  dt-bindings: display: add i.MX6 MIPI DSI host controller doc

 .../display/imx/fsl,mipi-dsi-imx6.yaml        | 134 ++++
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 683 +++++++++++++-----
 drivers/gpu/drm/imx/Kconfig                   |   7 +
 drivers/gpu/drm/imx/Makefile                  |   1 +
 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c        | 399 ++++++++++
 5 files changed, 1049 insertions(+), 175 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
 create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c

-- 
2.26.0

