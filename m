Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A16EF7B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2019 15:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfGTNZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jul 2019 09:25:05 -0400
Received: from mx1.cock.li ([185.10.68.5]:60777 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbfGTNZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 09:25:04 -0400
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on cock.li
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NO_RECEIVED,NO_RELAYS shortcircuit=_SCTYPE_
        autolearn=disabled version=3.4.2
From:   Robert Karszniewicz <avoidr@firemail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1563628615; bh=UJ4UPCQ6KTaOMKiUiOK1HLUSwhxZK+o1vVoca6TIZfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zt5IafkXqOJZXaTfBk63k+kEVLQTzb7Q0/HZaPtjzgMfqE4XwcLPhBVaCGF4veo18
         wZ8gP1hjTeCLUvpuRwqpWG3fyMNiAxGFh8xVVv5ElbiOIa9tCQx3s5qhBSoZcNG3ZM
         QXR9He7DRA9LrlPix8wIHA4rYTApF8rIgCa45ubVSqDCmk314g5yY14j9+usqDRjET
         U2PE5NCpXfyxbO2ofjztrrpqxxikwZAzIYu5jt/eVzkv19877T5DGrc9cNV31tZXtO
         DLxpz50DffS6G295j+09QoLs9Un6+cVIFyrlIvXP0e4Zmpn2q1T2FGBn/9VLSR+OVi
         cT178neJNSpcg==
To:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Robert Karszniewicz <avoidr@firemail.cc>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (k8temp) documentation: update URL of datasheet
Date:   Sat, 20 Jul 2019 15:16:52 +0200
Message-Id: <7139bc7707c24bd4dd7eb323e2da90105a3de9c1.1563522498.git.avoidr@firemail.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563522498.git.avoidr@firemail.cc>
References: <cover.1563522498.git.avoidr@firemail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old URL is dead.

Signed-off-by: Robert Karszniewicz <avoidr@firemail.cc>
---
 Documentation/hwmon/k8temp.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/k8temp.rst b/Documentation/hwmon/k8temp.rst
index 72da12aa17e5..fe9109521056 100644
--- a/Documentation/hwmon/k8temp.rst
+++ b/Documentation/hwmon/k8temp.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: PCI space
 
-    Datasheet: http://support.amd.com/us/Processor_TechDocs/32559.pdf
+    Datasheet: http://www.amd.com/system/files/TechDocs/32559.pdf
 
 Author: Rudolf Marek
 
-- 
2.22.0

