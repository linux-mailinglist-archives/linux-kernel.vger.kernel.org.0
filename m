Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD319116C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgCXNnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgCXNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:19 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895B02076E;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=X/F1qWsmyNf72Fejws4IM6/sAtChB+ci2BuEUkaM1RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGWdR+xGLJOfwBIu9aI3NbT96lwp5GhJCAJyCZ9dp6aMWW+ksU8OC3SYwe1UUZja1
         NSF+ISQ+nFrgPWvqhRC7qCzGlxK1HdOxY5QJGtQnW85kCCFvfNOoLJNTQtpbVKv6ae
         mFCpCOOyBd8/xU9Zk57eWuOo1aH1A1wHOo5qnyRM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025qh-G4; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 01/20] media: dvb-usb: auto-select CYPRESS_FIRMWARE
Date:   Tue, 24 Mar 2020 14:42:54 +0100
Message-Id: <712ca59ba2e1185fc505b52eba9eb3575467f393.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least some of the supported boards by dvb-usb
driver need to load the cypress firmware, so select
it, as otherwise missing dependencies may popup.

Also, as the cypress firmware load routines are needed
only by the dvb-usb, dvb-usb-v2 and go7007 drivers, and
those all (now) select it, there's no need to ask the
user for manually select it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/common/Kconfig      | 2 +-
 drivers/media/usb/dvb-usb/Kconfig | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/Kconfig b/drivers/media/common/Kconfig
index 1990b7f09454..4ea03b7899a8 100644
--- a/drivers/media/common/Kconfig
+++ b/drivers/media/common/Kconfig
@@ -14,7 +14,7 @@ config VIDEO_TVEEPROM
 	depends on I2C
 
 config CYPRESS_FIRMWARE
-	tristate "Cypress firmware helper routines"
+	tristate
 	depends on USB
 
 source "drivers/media/common/videobuf2/Kconfig"
diff --git a/drivers/media/usb/dvb-usb/Kconfig b/drivers/media/usb/dvb-usb/Kconfig
index 1a3e5f965ae4..42334a02cdce 100644
--- a/drivers/media/usb/dvb-usb/Kconfig
+++ b/drivers/media/usb/dvb-usb/Kconfig
@@ -2,6 +2,7 @@
 config DVB_USB
 	tristate "Support for various USB DVB devices"
 	depends on DVB_CORE && USB && I2C && RC_CORE
+	select CYPRESS_FIRMWARE
 	help
 	  By enabling this you will be able to choose the various supported
 	  USB1.1 and USB2.0 DVB devices.
-- 
2.24.1

