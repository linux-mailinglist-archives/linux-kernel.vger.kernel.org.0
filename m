Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0339103BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 14:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfKTNga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 08:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKTNg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:36:29 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72CB221939;
        Wed, 20 Nov 2019 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256989;
        bh=tdDe4FJ44sifbvlkacqGnDR4fXNE5uA2pA1WmEudtB8=;
        h=From:To:Cc:Subject:Date:From;
        b=vo6IomQVGpPauYHWJ90F0M/5NY3rABfWNIK8ejuC3lGCyiwHNPYSYwJpQq2JQwPfM
         7d3SHjlrqYO70+1BUoXDYvO6c6KIO1S6vbaPoGzPjX56YQ7Zgn6KTSPuLcTxiINh23
         b2TmUtb92BKSHbXEfOoWU0ZYmYsm1m2xWBrINrV0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/mgag200: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:36:24 +0800
Message-Id: <20191120133625.11478-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/mgag200/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/Kconfig b/drivers/gpu/drm/mgag200/Kconfig
index aed11f4f4c55..d60aa4b9ccd4 100644
--- a/drivers/gpu/drm/mgag200/Kconfig
+++ b/drivers/gpu/drm/mgag200/Kconfig
@@ -8,8 +8,8 @@ config DRM_MGAG200
 	select DRM_TTM_HELPER
 	help
 	 This is a KMS driver for the MGA G200 server chips, it
-         does not support the original MGA G200 or any of the desktop
-         chips. It requires 0.3.0 of the modesetting userspace driver,
-         and a version of mga driver that will fail on KMS enabled
-         devices.
+	 does not support the original MGA G200 or any of the desktop
+	 chips. It requires 0.3.0 of the modesetting userspace driver,
+	 and a version of mga driver that will fail on KMS enabled
+	 devices.
 
-- 
2.17.1

