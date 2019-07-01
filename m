Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6872E556AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfFYSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 14:02:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfFYSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:02:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 776DF2606DF
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v3 0/4] handle vblank when disabling ctc with interrupt disabled (was [PATCH v2] drm/imx: correct order of crtc disable)
Date:   Tue, 25 Jun 2019 18:59:11 +0100
Message-Id: <cover.1561483965.git.bob.beckett@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle vblank event sent to signal crtc disable while the backend vblank
interrupt has already been disabled by vblank_disable_fn.

Fixes: a474478642d5 ("drm/imx: fix crtc vblank state regression")
Fixes: 68036b08b91bc ("drm/vblank: Do not update vblank count if interrupts are already disabled.")
Fixes: 5f2f911578fb ("drm/imx: atomic phase 3 step 1: Use atomic configuration")


Changes since v2:
Split up the patch in to smaller pieces.
Add warning when about to send bogus vblank event.
Update vblank to best guess info during drm_vblank_disable_and_save.

Robert Beckett (4):
  drm/vblank: warn on sending stale event
  drm/imx: notify drm core before sending event during crtc disable
  drm/vblank: estimate vblank while disabling vblank if interrupt
    disabled
  drm/imx: only send event on crtc disable if kept disabled

 drivers/gpu/drm/drm_vblank.c     | 33 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/imx/ipuv3-crtc.c |  6 +++---
 2 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.18.0

