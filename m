Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B593EDAB2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 09:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfKDIoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 03:44:02 -0500
Received: from 60-251-196-230.HINET-IP.hinet.net ([60.251.196.230]:61672 "EHLO
        ironport.ite.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDIoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:44:02 -0500
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 04 Nov 2019 16:43:58 +0800
Received: from csbcas.internal.ite.com.tw (csbcas1.internal.ite.com.tw [192.168.65.46])
        by mse.ite.com.tw with ESMTP id xA48hpip026781;
        Mon, 4 Nov 2019 16:43:51 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from allen-VirtualBox.internal.ite.com.tw (192.168.70.14) by
 csbcas1.internal.ite.com.tw (192.168.65.45) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Mon, 4 Nov 2019 16:43:52 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking timings logic
Date:   Mon, 4 Nov 2019 16:42:49 +0800
Message-ID: <1572856969-12115-1-git-send-email-allen.chen@ite.com.tw>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.70.14]
X-MAIL: mse.ite.com.tw xA48hpip026781
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to VESA ENHANCED EXTENDED DISPLAY IDENTIFICATION DATA STANDARD
(Defines EDID Structure Version 1, Revision 4) page: 39
How to determine whether the monitor support RB timing or not?
EDID 1.4
First:  read detailed timing descriptor and make sure byte0 = 0,
	byte1 = 0, byte2 = 0 and byte3 = 0xFD
Second: read detailed timing descriptor byte10 = 0x04 and
	EDID byte18h bit0 = 1
Third:  if EDID byte18h bit0 == 1 && byte10 == 0x04,
	then we can check byte15, if byte15 bit4 =1 is support RB
        if EDID byte18h bit0 != 1 || byte10 != 0x04,
	then byte15 can not be used

The linux code is_rb function not follow the VESA's rule

EDID 1.3
LCD flat panels do not require long blanking intervals as a retrace
period so default support reduced-blanking timings.

Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/gpu/drm/drm_edid.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e5e7e65..9b67b80 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -93,6 +93,11 @@ struct detailed_mode_closure {
 	int modes;
 };
 
+struct edid_support_rb_closure {
+	struct edid *edid;
+	s8 support_rb;
+};
+
 #define LEVEL_DMT	0
 #define LEVEL_GTF	1
 #define LEVEL_GTF2	2
@@ -2018,22 +2023,31 @@ struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,
 is_rb(struct detailed_timing *t, void *data)
 {
 	u8 *r = (u8 *)t;
-	if (r[3] == EDID_DETAIL_MONITOR_RANGE)
-		if (r[15] & 0x10)
-			*(bool *)data = true;
+	struct edid_support_rb_closure *closure = data;
+	struct edid *edid = closure->edid;
+
+	if (!r[0] && !r[1] && !r[2] && r[3] == EDID_DETAIL_MONITOR_RANGE) {
+		if (edid->features & BIT(0) && r[10] == BIT(2))
+			closure->support_rb = (r[15] & 0x10) ? 1 : 0;
+	}
 }
 
 /* EDID 1.4 defines this explicitly.  For EDID 1.3, we guess, badly. */
 static bool
 drm_monitor_supports_rb(struct edid *edid)
 {
+	struct edid_support_rb_closure closure = {
+		.edid = edid,
+		.support_rb = -1,
+	};
+
 	if (edid->revision >= 4) {
-		bool ret = false;
-		drm_for_each_detailed_block((u8 *)edid, is_rb, &ret);
-		return ret;
+		drm_for_each_detailed_block((u8 *)edid, is_rb, &closure);
+		if (closure.support_rb >= 0)
+			return closure.support_rb;
 	}
 
-	return ((edid->input & DRM_EDID_INPUT_DIGITAL) != 0);
+	return true;
 }
 
 static void
-- 
1.9.1

