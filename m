Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB8DAB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 13:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439675AbfJQLSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 07:18:03 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52998 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439661AbfJQLSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:18:03 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iL3n3-0002yw-Kr; Thu, 17 Oct 2019 12:17:57 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iL3n2-0003MI-WD; Thu, 17 Oct 2019 12:17:57 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, malidp@foss.arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/arm: make undeclared items static
Date:   Thu, 17 Oct 2019 12:17:55 +0100
Message-Id: <20191017111756.12861-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the following items static to avoid clashes with
other parts of the kernel (dev_attr_core_id) or just
silence the following sparse warning:

drivers/gpu/drm/arm/malidp_drv.c:371:24: warning: symbol 'malidp_fb_create' was not declared. Should it be static?
drivers/gpu/drm/arm/malidp_drv.c:494:6: warning: symbol 'malidp_error_stats_dump' was not declared. Should it be static?
drivers/gpu/drm/arm/malidp_drv.c:668:1: warning: symbol 'dev_attr_core_id' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Brian Starkey <brian.starkey@arm.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: malidp@foss.arm.com
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
.. (open list)
---
 drivers/gpu/drm/arm/malidp_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 333b88a5efb0..18ca43c9cef4 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -368,7 +368,7 @@ malidp_verify_afbc_framebuffer(struct drm_device *dev, struct drm_file *file,
 	return false;
 }
 
-struct drm_framebuffer *
+static struct drm_framebuffer *
 malidp_fb_create(struct drm_device *dev, struct drm_file *file,
 		 const struct drm_mode_fb_cmd2 *mode_cmd)
 {
@@ -491,9 +491,9 @@ void malidp_error(struct malidp_drm *malidp,
 	spin_unlock_irqrestore(&malidp->errors_lock, irqflags);
 }
 
-void malidp_error_stats_dump(const char *prefix,
-			     struct malidp_error_stats error_stats,
-			     struct seq_file *m)
+static void malidp_error_stats_dump(const char *prefix,
+				    struct malidp_error_stats error_stats,
+				    struct seq_file *m)
 {
 	seq_printf(m, "[%s] num_errors : %d\n", prefix,
 		   error_stats.num_errors);
@@ -665,7 +665,7 @@ static ssize_t core_id_show(struct device *dev, struct device_attribute *attr,
 	return snprintf(buf, PAGE_SIZE, "%08x\n", malidp->core_id);
 }
 
-DEVICE_ATTR_RO(core_id);
+static DEVICE_ATTR_RO(core_id);
 
 static int malidp_init_sysfs(struct device *dev)
 {
-- 
2.23.0

