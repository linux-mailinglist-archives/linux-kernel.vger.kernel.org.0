Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157DF10530D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 14:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKUN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 08:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfKUN3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:29:30 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78A5A2070B;
        Thu, 21 Nov 2019 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574342969;
        bh=yyXJzn+XyQztYsAFDd+jIydz3QhsmNmW5iErSayP8O0=;
        h=From:To:Cc:Subject:Date:From;
        b=vtPUseQuJskD7wyazERwtvJ8t1Sms7TRZTBm5ohv8JJ8fsTsXV88KKk53IZf0rgBe
         9pqHaek7jcNnWod6esgscEZ5OPINcLL6NgBnXRaDYZtO/ghn6gpIi/3YmF7LvqSOLs
         Du1HBnToU+wvA3Ho4ToPB/3auWhW1t7vz0InSOXE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] drm/sun4i: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 21:29:24 +0800
Message-Id: <20191121132924.29485-1-krzk@kernel.org>
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
 drivers/gpu/drm/sun4i/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 37e90e42943f..5755f0432e77 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -17,18 +17,18 @@ config DRM_SUN4I
 if DRM_SUN4I
 
 config DRM_SUN4I_HDMI
-       tristate "Allwinner A10 HDMI Controller Support"
-       default DRM_SUN4I
-       help
+	tristate "Allwinner A10 HDMI Controller Support"
+	default DRM_SUN4I
+	help
 	  Choose this option if you have an Allwinner SoC with an HDMI
 	  controller.
 
 config DRM_SUN4I_HDMI_CEC
-       bool "Allwinner A10 HDMI CEC Support"
-       depends on DRM_SUN4I_HDMI
-       select CEC_CORE
-       select CEC_PIN
-       help
+	bool "Allwinner A10 HDMI CEC Support"
+	depends on DRM_SUN4I_HDMI
+	select CEC_CORE
+	select CEC_PIN
+	help
 	  Choose this option if you have an Allwinner SoC with an HDMI
 	  controller and want to use CEC.
 
-- 
2.17.1

