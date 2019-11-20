Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8E6103D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 15:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbfKTOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 09:36:27 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:57114 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731669AbfKTOgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:36:25 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id UEcN2100j5USYZQ01EcNZf; Wed, 20 Nov 2019 15:36:23 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXR5i-00020w-M0; Wed, 20 Nov 2019 15:36:22 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXR5i-0000Hb-KY; Wed, 20 Nov 2019 15:36:22 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] driver core: Add dev_WARN_ON() helper
Date:   Wed, 20 Nov 2019 15:36:18 +0100
Message-Id: <20191120143619.1027-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120143619.1027-1-geert+renesas@glider.be>
References: <20191120143619.1027-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is quite useful to print the related device in a warning backtrace.
Hence add a "dev_*" variant of WARN_ON() to handle this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/device.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index f05c5b92e61f535a..05089c329620472a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1902,6 +1902,9 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
+#define dev_WARN_ON(dev, condition) \
+	WARN(condition, "%s %s", dev_driver_string(dev), dev_name(dev))
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.17.1

