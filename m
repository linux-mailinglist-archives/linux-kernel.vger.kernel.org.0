Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44738CB61D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfJDI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 04:27:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40070 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbfJDI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:27:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iGIva-0003uQ-Px; Fri, 04 Oct 2019 08:27:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: sti: fix spelling mistake: rejec -> rejection
Date:   Fri,  4 Oct 2019 09:27:06 +0100
Message-Id: <20191004082706.26478-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In other places of the driver the string hdmi_rejection_pll is
used instead of the truncated hdmi_rejec_pll, so use this string
instead to be consistent.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 814560ead4e1..e2018e4a3ec5 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -886,7 +886,7 @@ static void sti_hdmi_pre_enable(struct drm_bridge *bridge)
 	if (clk_prepare_enable(hdmi->clk_tmds))
 		DRM_ERROR("Failed to prepare/enable hdmi_tmds clk\n");
 	if (clk_prepare_enable(hdmi->clk_phy))
-		DRM_ERROR("Failed to prepare/enable hdmi_rejec_pll clk\n");
+		DRM_ERROR("Failed to prepare/enable hdmi_rejection_pll clk\n");
 
 	hdmi->enabled = true;
 
-- 
2.20.1

