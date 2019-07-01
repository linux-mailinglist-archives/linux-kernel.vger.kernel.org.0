Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E763A336
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 04:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfFIC3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 22:29:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfFIC1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LODV2xUoFNxknV26miUARY9/ZInmVpzomuSRyMjtHiw=; b=Liuk11zXQX5SETZbGsYGr9b5FM
        zQB0JlkjIJpedmd2f4Q3CVO7Wn3y0Aac0gpizeY+CDzaFTxXt0ivmFofDJc/cjIBPbVYYuI9G2llA
        x6ZoFYxKl647j0lk29shgtN5t6Q0CryPYiMgwd8B5T9B4QD4rRMu6B0R3az6TWvxtVrfxPo/B70kB
        KLlrosAMEg+a+cSqb9YYhGUj4xCLQfd0p+hOmTqZQj3DKCYtImeW5gZ7PKxtM6EqzPIr+cfYtrhUv
        5LbvU4tVtIUU7/loFLgPn1l4Nnnrl9Tnhe6T9RAEjwHMrQMcaWakJIcBDhXX/wPqH64pA/BnghO06
        fpgV7RWQ==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYS-0001nD-Oq; Sun, 09 Jun 2019 02:27:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYL-0000Kn-PN; Sat, 08 Jun 2019 23:27:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 33/33] docs: EDID/HOWTO.txt: convert it and rename to howto.rst
Date:   Sat,  8 Jun 2019 23:27:23 -0300
Message-Id: <74bec0b5b7c32c8d84adbaf9ff208803475198e5.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx need to know when a paragraph ends. So, do some adjustments
at the file for it to be properly parsed.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

that's said, I believe that this file should be moved to the
GPU/DRM documentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/EDID/{HOWTO.txt => howto.rst}   | 31 ++++++++++++-------
 .../admin-guide/kernel-parameters.txt         |  2 +-
 drivers/gpu/drm/Kconfig                       |  2 +-
 3 files changed, 22 insertions(+), 13 deletions(-)
 rename Documentation/EDID/{HOWTO.txt => howto.rst} (83%)

diff --git a/Documentation/EDID/HOWTO.txt b/Documentation/EDID/howto.rst
similarity index 83%
rename from Documentation/EDID/HOWTO.txt
rename to Documentation/EDID/howto.rst
index 539871c3b785..725fd49a88ca 100644
--- a/Documentation/EDID/HOWTO.txt
+++ b/Documentation/EDID/howto.rst
@@ -1,3 +1,9 @@
+:orphan:
+
+====
+EDID
+====
+
 In the good old days when graphics parameters were configured explicitly
 in a file called xorg.conf, even broken hardware could be managed.
 
@@ -34,16 +40,19 @@ Makefile. Please note that the EDID data structure expects the timing
 values in a different way as compared to the standard X11 format.
 
 X11:
-HTimings:  hdisp hsyncstart hsyncend htotal
-VTimings:  vdisp vsyncstart vsyncend vtotal
+  HTimings:
+    hdisp hsyncstart hsyncend htotal
+  VTimings:
+    vdisp vsyncstart vsyncend vtotal
 
-EDID:
-#define XPIX hdisp
-#define XBLANK htotal-hdisp
-#define XOFFSET hsyncstart-hdisp
-#define XPULSE hsyncend-hsyncstart
+EDID::
 
-#define YPIX vdisp
-#define YBLANK vtotal-vdisp
-#define YOFFSET vsyncstart-vdisp
-#define YPULSE vsyncend-vsyncstart
+  #define XPIX hdisp
+  #define XBLANK htotal-hdisp
+  #define XOFFSET hsyncstart-hdisp
+  #define XPULSE hsyncend-hsyncstart
+
+  #define YPIX vdisp
+  #define YBLANK vtotal-vdisp
+  #define YOFFSET vsyncstart-vdisp
+  #define YPULSE vsyncend-vsyncstart
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3d072ca532bb..3faf37b8b001 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -930,7 +930,7 @@
 			edid/1680x1050.bin, or edid/1920x1080.bin is given
 			and no file with the same name exists. Details and
 			instructions how to build your own EDID data are
-			available in Documentation/EDID/HOWTO.txt. An EDID
+			available in Documentation/EDID/howto.rst. An EDID
 			data set will only be used for a particular connector,
 			if its name and a colon are prepended to the EDID
 			name. Each connector may use a unique EDID data
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 6b34949416b1..c3a6dd284c91 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -141,7 +141,7 @@ config DRM_LOAD_EDID_FIRMWARE
 	  monitor are unable to provide appropriate EDID data. Since this
 	  feature is provided as a workaround for broken hardware, the
 	  default case is N. Details and instructions how to build your own
-	  EDID data are given in Documentation/EDID/HOWTO.txt.
+	  EDID data are given in Documentation/EDID/howto.rst.
 
 config DRM_DP_CEC
 	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
-- 
2.21.0

