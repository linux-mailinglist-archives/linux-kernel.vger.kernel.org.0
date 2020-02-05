Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8F153B03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 23:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBEWaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 17:30:55 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57354 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgBEWaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:30:55 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3df5::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2D3E25C4363;
        Wed,  5 Feb 2020 23:30:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1580941853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=8j/wLPVNelocFC7g7KIME69AY5HWX79CB2Mc0G7rnng=;
        b=AWS1XuQcm4wvY/QLxoLWaINZ0MDRA75jAX35f8zRoS6r4tFVmWTqPmL0I7WYIrC4kvVvhd
        hcjShldOactnbRSkfznuWKTcF1ZH9Acnx2rkPeOkl+VbQ5KqHI/v5P5cGUk2egYt/K6q7J
        nfieAP0L3J1FAE6CVr18oXS2vU964mA=
From:   Stefan Agner <stefan@agner.ch>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel.vetter@ffwll.ch
Cc:     airlied@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] drm: Add missing newline after comment
Date:   Wed,  5 Feb 2020 23:26:00 +0100
Message-Id: <586aab08af596120f48858005bb6784c83035d59.1580941448.git.stefan@agner.ch>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang prints a warning:
drivers/gpu/drm/drm_lock.c:363:6: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
         */     mutex_lock(&dev->struct_mutex);
                ^
drivers/gpu/drm/drm_lock.c:357:2: note: previous statement is here
        if (!drm_core_check_feature(dev, DRIVER_LEGACY))
        ^

Fix this by adding a newline after the multi-line comment.

Fixes: 058ca50ce3f1 ("drm/legacy: move lock cleanup for master into lock file (v2)")
Link: https://github.com/ClangBuiltLinux/linux/issues/855
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/drm_lock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_lock.c b/drivers/gpu/drm/drm_lock.c
index 2e8ce99d0baa..2c79e8199e3c 100644
--- a/drivers/gpu/drm/drm_lock.c
+++ b/drivers/gpu/drm/drm_lock.c
@@ -360,7 +360,8 @@ void drm_legacy_lock_master_cleanup(struct drm_device *dev, struct drm_master *m
 	/*
 	 * Since the master is disappearing, so is the
 	 * possibility to lock.
-	 */	mutex_lock(&dev->struct_mutex);
+	 */
+	mutex_lock(&dev->struct_mutex);
 	if (master->lock.hw_lock) {
 		if (dev->sigdata.lock == master->lock.hw_lock)
 			dev->sigdata.lock = NULL;
-- 
2.25.0

