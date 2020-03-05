Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E88B17A31C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 11:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCEK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 05:28:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCEK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:28:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0CD41296593
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] platform/chrome: Kconfig: Remove CONFIG_ prefix from MFD_CROS_EC section
Date:   Thu,  5 Mar 2020 11:28:38 +0100
Message-Id: <20200305102838.108967-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_ prefix from the select statement for MFD_CROS_EC.

Fixes: 2fa2b980e3fe1 ("mfd / platform: cros_ec: Rename config to a better name")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 15fc8b8a2db8..5ae6c49f553d 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -7,7 +7,7 @@ config MFD_CROS_EC
 	tristate "Platform support for Chrome hardware (transitional)"
 	select CHROME_PLATFORMS
 	select CROS_EC
-	select CONFIG_MFD_CROS_EC_DEV
+	select MFD_CROS_EC_DEV
 	depends on X86 || ARM || ARM64 || COMPILE_TEST
 	help
 	  This is a transitional Kconfig option and will be removed after
-- 
2.25.1

