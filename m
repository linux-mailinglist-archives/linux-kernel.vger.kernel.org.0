Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B6D318E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 21:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfJJToI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 15:44:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54378 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJToH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 15:44:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id DB451286280
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-rockchip@lists.infradead.org,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v5 0/3] RK3288 Gamma LUT
Date:   Thu, 10 Oct 2019 16:43:48 -0300
Message-Id: <20191010194351.17940-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New iteration, seems that we are finally converging.

For this v5, we are only doing some changes on
the gamma_set implementation. As a result, the code
is more readable. See the changelog in patch 2 for more
information.

Thanks!

Ezequiel Garcia (3):
  dt-bindings: display: rockchip: document VOP gamma LUT address
  drm/rockchip: Add optional support for CRTC gamma LUT
  ARM: dts: rockchip: Add RK3288 VOP gamma LUT address

 .../display/rockchip/rockchip-vop.txt         |   6 +-
 arch/arm/boot/dts/rk3288.dtsi                 |   4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c   | 120 ++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h   |   2 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |   2 +
 5 files changed, 131 insertions(+), 3 deletions(-)

-- 
2.22.0

