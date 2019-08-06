Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A83DD83001
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbfHFKso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 06:48:44 -0400
Received: from foss.arm.com ([217.140.110.172]:60124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbfHFKso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:48:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C036337;
        Tue,  6 Aug 2019 03:48:43 -0700 (PDT)
Received: from DESKTOP-E1NTVVP.cambridge.arm.com (unknown [10.1.25.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 427DB3F694;
        Tue,  6 Aug 2019 03:48:42 -0700 (PDT)
From:   Brian Starkey <brian.starkey@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>, nd@arm.com,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/crc-debugfs: Add notes about CRC<->commit interactions
Date:   Tue,  6 Aug 2019 11:48:35 +0100
Message-Id: <20190806104835.26075-1-brian.starkey@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806091233.GX7444@phenom.ffwll.local>
References: <20190806091233.GX7444@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CRC generation can be impacted by commits coming from userspace, and
enabling CRC generation may itself trigger a commit. Add notes about
this to the kerneldoc.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
---
 drivers/gpu/drm/drm_debugfs_crc.c | 17 +++++++++++++----
 include/drm/drm_crtc.h            |  4 ++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index 7ca486d750e9..77159b6e77c3 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -65,10 +65,19 @@
  * it submits. In this general case, the maximum userspace can do is to compare
  * the reported CRCs of frames that should have the same contents.
  *
- * On the driver side the implementation effort is minimal, drivers only need to
- * implement &drm_crtc_funcs.set_crc_source. The debugfs files are automatically
- * set up if that vfunc is set. CRC samples need to be captured in the driver by
- * calling drm_crtc_add_crc_entry().
+ * On the driver side the implementation effort is minimal, drivers only need
+ * to implement &drm_crtc_funcs.set_crc_source. The debugfs files are
+ * automatically set up if that vfunc is set. CRC samples need to be captured
+ * in the driver by calling drm_crtc_add_crc_entry(). Depending on the driver
+ * and HW requirements, &drm_crtc_funcs.set_crc_source may result in a commit
+ * (even a full modeset).
+ *
+ * CRC results must be reliable across non-full-modeset atomic commits, so if a
+ * commit via DRM_IOCTL_MODE_ATOMIC would disable or otherwise interfere with
+ * CRC generation, then the driver must mark that commit as a full modeset
+ * (drm_atomic_crtc_needs_modeset() should return true). As a result, to ensure
+ * consistent results, generic userspace must re-setup CRC generation after a
+ * legacy SETCRTC or an atomic commit with DRM_MODE_ATOMIC_ALLOW_MODESET.
  */
 
 static int crc_control_show(struct seq_file *m, void *data)
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 128d8b210621..7d14c11bdc0a 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -756,6 +756,9 @@ struct drm_crtc_funcs {
 	 * provided from the configured source. Drivers must accept an "auto"
 	 * source name that will select a default source for this CRTC.
 	 *
+	 * This may trigger an atomic modeset commit if necessary, to enable CRC
+	 * generation.
+	 *
 	 * Note that "auto" can depend upon the current modeset configuration,
 	 * e.g. it could pick an encoder or output specific CRC sampling point.
 	 *
@@ -767,6 +770,7 @@ struct drm_crtc_funcs {
 	 * 0 on success or a negative error code on failure.
 	 */
 	int (*set_crc_source)(struct drm_crtc *crtc, const char *source);
+
 	/**
 	 * @verify_crc_source:
 	 *
-- 
2.17.1

