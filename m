Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37910530C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 14:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfKUN3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 08:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfKUN3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:29:23 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C822070B;
        Thu, 21 Nov 2019 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342963;
        bh=dIc++Icth9GruF6aBBYRNcCyQoKImA4/t49XcatR4Ig=;
        h=From:To:Cc:Subject:Date:From;
        b=neYUUfstg+Bc8trip8Y8omRdynVEAse6l+mu4mDVSzhSdq1Gj+GwQcdA/W4BenhJ1
         gKt7iCJho+qJV5ONRq86CDAw4lfrr0PjwmtLSFcFgcBpHFpDOyoiLK7MuduwyZLKRS
         lt0Az+ZzQWwbwDlagCCrfDYM+SXFP9++Wdr0BwQ4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vc4: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 21:29:19 +0800
Message-Id: <20191121132919.29430-1-krzk@kernel.org>
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
 drivers/gpu/drm/vc4/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
index 7c2317efd5b7..118e8a426b1a 100644
--- a/drivers/gpu/drm/vc4/Kconfig
+++ b/drivers/gpu/drm/vc4/Kconfig
@@ -22,9 +22,9 @@ config DRM_VC4
 	  our display setup.
 
 config DRM_VC4_HDMI_CEC
-       bool "Broadcom VC4 HDMI CEC Support"
-       depends on DRM_VC4
-       select CEC_CORE
-       help
+	bool "Broadcom VC4 HDMI CEC Support"
+	depends on DRM_VC4
+	select CEC_CORE
+	help
 	  Choose this option if you have a Broadcom VC4 GPU
 	  and want to use CEC.
-- 
2.17.1

