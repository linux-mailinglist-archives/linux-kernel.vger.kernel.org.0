Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D8191190
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgCXNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgCXNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:19 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9004A2078A;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=ck4OjCQbq8LRXFZxql73LnIMALqdecyTNuiDYT5obuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0Rn0XDWNxjS+YfjwYhNO2lqPu4lCgnejXIwIq4mA+TVu227ltcGxc2fz1ul9YCbB
         DiKaTWHvNDYpodAeJZOOdWbs61MTdIZZic+3q0vAndDCkWfRqpN9Vgt5oPnUrnpTLV
         2562DUnpR/Wte/KOipOCqgso1wNPYoIgPsL0ZKss=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025rQ-RV; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 10/20] media: Kconfig: move CEC-specific options to cec/Kconfig
Date:   Tue, 24 Mar 2020 14:43:03 +0100
Message-Id: <1a8216c3ab6a58cd22b71a55b7ee4221ba4eba91.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to have the CEC definitions inside the
media Kconfig, as the Kconfig parser doesn't require
symbols to be declared before their usages.

With that, the main Kconfig menu becomes cleaner.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig     |  9 ---------
 drivers/media/cec/Kconfig | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index e372029ac41f..2f4360faed03 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -3,15 +3,6 @@
 # Multimedia device configuration
 #
 
-config CEC_CORE
-	tristate
-
-config CEC_NOTIFIER
-	bool
-
-config CEC_PIN
-	bool
-
 source "drivers/media/rc/Kconfig"
 
 menuconfig MEDIA_SUPPORT
diff --git a/drivers/media/cec/Kconfig b/drivers/media/cec/Kconfig
index c01919713ab9..31417feaa213 100644
--- a/drivers/media/cec/Kconfig
+++ b/drivers/media/cec/Kconfig
@@ -1,4 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config CEC_CORE
+	tristate
+
+config CEC_NOTIFIER
+	bool
+
+config CEC_PIN
+	bool
+
 config MEDIA_CEC_RC
 	bool "HDMI CEC RC integration"
 	depends on CEC_CORE && RC_CORE
-- 
2.24.1

