Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20072190A74
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 11:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCXKPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 06:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbgCXKPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:15:24 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F13A20870;
        Tue, 24 Mar 2020 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585044924;
        bh=mvF+8DJswgww3SrqFXIL4DAo4Hpgzr3yTYJuJvmcW+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFIgvBRW/GgEzYk5YXzvZlSbRkHNzjlkbuLwyQQ/A5xXyHN9nhOjz7d2zYB6/xjZd
         0Go4mue5PUAT4NhhHMxxNL2SBr1MOTdTJJCa2zCIQkquizF21JbtEk0/yaGlbESU2z
         P42a8Hifrj8r5evBxIcULoMOxCBzpLG7K5377pKE=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGgag-001pjX-A0; Tue, 24 Mar 2020 11:15:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/8] media: reorganize the drivers menu options
Date:   Tue, 24 Mar 2020 11:15:17 +0100
Message-Id: <fa1eab8ee9addcb546fa6f88f72fa05c1e6b7dc6.1585044374.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585044374.git.mchehab+huawei@kernel.org>
References: <cover.1585044374.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments before some of the drivers support look
weird, because their Kconfig have their own "comment"
directive inside it. So, rearrange them to make it
look a little nicer for the ones with are not too
familiar with the media system.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 4af21fa73fcf..586d8931d9fc 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -87,6 +87,8 @@ config MEDIA_CEC_SUPPORT
 	  Say Y when you have an HDMI receiver, transmitter or a USB CEC
 	  adapter that supports HDMI CEC.
 
+comment "Media core options"
+
 source "drivers/media/cec/Kconfig"
 
 source "drivers/media/mc/Kconfig"
@@ -166,17 +168,17 @@ comment "Media drivers"
 
 source "drivers/media/usb/Kconfig"
 source "drivers/media/pci/Kconfig"
+source "drivers/media/radio/Kconfig"
+
+# Common driver options
+source "drivers/media/common/Kconfig"
 source "drivers/media/platform/Kconfig"
 source "drivers/media/mmc/Kconfig"
-source "drivers/media/radio/Kconfig"
 
 comment "Supported FireWire (IEEE 1394) Adapters"
 	depends on DVB_CORE && FIREWIRE
 source "drivers/media/firewire/Kconfig"
 
-# Common driver options
-source "drivers/media/common/Kconfig"
-
 comment "Media ancillary drivers (tuners, sensors, i2c, spi, frontends)"
 
 #
-- 
2.24.1

