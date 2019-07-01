Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A112559B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfF1Mck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 08:32:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfF1Mak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CO9hXctq/ZOSyldt4xxMM8uAqt3nLCI2Mj5L48QrNiA=; b=G24BOgrNeg+XoxgblfomyGovQ3
        zcoKSDggvpJiEsMuTf8jqFh6ppqhx+xbRLHwdojbNx6N258LdXTBU4Hyuzn4tO3Lvp3NrHbhRBzJp
        KiOH1CBXRQoQ1EccK4pfT2zuGLSHw/kQayUvrdCtx5MbTwzQXo5N7LDlA/H5FKeYGIZOckO0FSkky
        946oACOW1TazI4dnFw/GR4IuSrguC26WcxnlqZikWM1TVhzoKFCU3H7qdfaZ81BIj8hhzxxcQceLi
        qj07axHEFTIsM5b6zJjlHsXnevCW96cq6CYlqrSolRj05uNzw9/vF6eWMC+mzDR61794goqvGqdSg
        DC2XqxKA==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055W-Gz; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Sl-Hh; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Milo Kim <milo.kim@ti.com>
Subject: [PATCH 23/39] docs: lp855x-driver.rst: add it to the driver-api book
Date:   Fri, 28 Jun 2019 09:30:16 -0300
Message-Id: <91977c04fb55ebbb7e31bb4fb59de82ca1dd3109.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The content of this file is intended for backlight Kernel
developers.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/{ => driver-api}/backlight/lp855x-driver.rst | 2 --
 Documentation/driver-api/index.rst                         | 1 +
 MAINTAINERS                                                | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename Documentation/{ => driver-api}/backlight/lp855x-driver.rst (99%)

diff --git a/Documentation/backlight/lp855x-driver.rst b/Documentation/driver-api/backlight/lp855x-driver.rst
similarity index 99%
rename from Documentation/backlight/lp855x-driver.rst
rename to Documentation/driver-api/backlight/lp855x-driver.rst
index 62b7ed847a77..1e0b224fc397 100644
--- a/Documentation/backlight/lp855x-driver.rst
+++ b/Documentation/driver-api/backlight/lp855x-driver.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ====================
 Kernel driver lp855x
 ====================
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index d41d1c561f01..fea0034afa56 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -66,6 +66,7 @@ available subsections can be seen below.
    thermal/index
    fpga/index
    acpi/index
+   backlight/lp855x-driver.rst
    generic-counter
 
 .. only::  subproject and html
diff --git a/MAINTAINERS b/MAINTAINERS
index f723371dccd0..664e2a827544 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15906,7 +15906,7 @@ F:	sound/soc/codecs/isabelle*
 TI LP855x BACKLIGHT DRIVER
 M:	Milo Kim <milo.kim@ti.com>
 S:	Maintained
-F:	Documentation/backlight/lp855x-driver.rst
+F:	Documentation/driver-api/backlight/lp855x-driver.rst
 F:	drivers/video/backlight/lp855x_bl.c
 F:	include/linux/platform_data/lp855x.h
 
-- 
2.21.0

