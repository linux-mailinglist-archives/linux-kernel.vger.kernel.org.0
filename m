Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A2D191196
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgCXNo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgCXNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:19 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9958C208E4;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=Wn32YEXlsFeyH0U1lHQAPIpXDBsqxsEtcqAGcnsGtIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntWumbabi97efzjFBGH7vSlAS3scQlHx+zCUE/k09XijwBxNYu2qnq3YszHayN8Ch
         JMOWvZNHGlJBJP0BvFz1l1TvKJxWxN9/7FPi98WDTSY76rdxfcZVqk2AG9OIr0VkC7
         xq8p/SvTmvIOPwV4Jya7sxsn6VHreHGzx1gsz1wg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025rB-Mh; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 07/20] media: Kconfig: add an option to filter in/out the embedded drivers
Date:   Tue, 24 Mar 2020 14:43:00 +0100
Message-Id: <23242586947faec259eabc545415592a5ea9ac92.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most systems don't need support for those, while others only
need those, instead of the others.

So, add an option to filter in/out the SoC specific drivers.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index e266d1afa912..a57e2198b2db 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -88,6 +88,14 @@ config MEDIA_CEC_SUPPORT
 	  Say Y when you have an HDMI receiver, transmitter or a USB CEC
 	  adapter that supports HDMI CEC.
 
+config MEDIA_EMBEDDED_SUPPORT
+	bool "Embedded devices (SoC)"
+	help
+	  Enable support for complex cameras, codecs, and other hardware
+	  found on Embedded hardware (SoC).
+
+	  Say Y when you have a software defined radio device.
+
 endmenu # media support types
 
 if MEDIA_SUPPORT
@@ -177,9 +185,13 @@ source "drivers/media/radio/Kconfig"
 
 # Common driver options
 source "drivers/media/common/Kconfig"
+
+if MEDIA_EMBEDDED_SUPPORT
+
 source "drivers/media/platform/Kconfig"
 source "drivers/media/mmc/Kconfig"
 
+endif # MEDIA_EMBEDDED_SUPPORT
 
 comment "FireWire (IEEE 1394) Adapters"
 	depends on DVB_CORE && FIREWIRE
-- 
2.24.1

