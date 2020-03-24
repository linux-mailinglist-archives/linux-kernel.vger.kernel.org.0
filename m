Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5D191195
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 14:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgCXNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 09:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgCXNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:19 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979BB208E0;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=kXBgL77aKBseXgTmvFFT2dzAuc5r0P2z+w2gjYWQYQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvDerwhRR4Ll4atuijGCMkd+eCL3inE5VMZhWcf8GbSkD4mBfT5nF5MAo+8IAqvwo
         PUgSCfbwHaM+g942abpcbcFhNaPRjsRMQhWYpnbxvFvFs9Lah3d0pZjoPVZi0jLerv
         WBZMUJftJWA9y0ZjqntVUGxIiHtujC5lFN/LILBQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025rV-Sa; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 11/20] media: Kconfig: move comment to siano include
Date:   Tue, 24 Mar 2020 14:43:04 +0100
Message-Id: <df1ece11a2d64883ba87ed492f18ca52b613c837.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Showing this comment without showing the Siano mmc option
is very weird! Place the option together, and make it
visible only when showing Siano configuration.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/mmc/Kconfig       | 1 -
 drivers/media/mmc/siano/Kconfig | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/mmc/Kconfig b/drivers/media/mmc/Kconfig
index 5217f5bd205e..75aa6de08d53 100644
--- a/drivers/media/mmc/Kconfig
+++ b/drivers/media/mmc/Kconfig
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-comment "MMC/SDIO adapters"
 source "drivers/media/mmc/siano/Kconfig"
diff --git a/drivers/media/mmc/siano/Kconfig b/drivers/media/mmc/siano/Kconfig
index 1919f6fea8b1..570696019a9e 100644
--- a/drivers/media/mmc/siano/Kconfig
+++ b/drivers/media/mmc/siano/Kconfig
@@ -2,6 +2,8 @@
 #
 # Siano Mobile Silicon Digital TV device configuration
 #
+comment "MMC/SDIO DVB adapters"
+	depends on DVB_CORE && HAS_DMA && MMC
 
 config SMS_SDIO_DRV
 	tristate "Siano SMS1xxx based MDTV via SDIO interface"
-- 
2.24.1

