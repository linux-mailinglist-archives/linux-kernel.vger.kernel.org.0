Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED812340F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfFDH7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfFDH7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:59:02 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB3D24D3D;
        Tue,  4 Jun 2019 07:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559635142;
        bh=BGPVBwJeHoElaUtEavKKbm0/aDM8XNbhtrBPJNIJn9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=DyY2TTvBHAhL+dlseHCh809aq7njNbpYYJOhcA3Nv8vFJeYLItkwqo1/IfSN6RQxE
         zSVx3hroxmFFPFRhwYj+l8jLFykJ73rWLBWiUfb29+9/XIU0dzuKQEhOI5SHktYlTY
         gU5BtQjZaITuRbo353CZK4RZG78hZRFZqFHajGWQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] s390: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 09:58:57 +0200
Message-Id: <1559635137-20900-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
   CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
   made default to 'n',
2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,
3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/s390/configs/defconfig          | 1 -
 arch/s390/configs/zfcpdump_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index c59b922cb6c5..18cff2e4607d 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -94,7 +94,6 @@ CONFIG_NET_CLS_RSVP6=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
 CONFIG_BPF_JIT=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 7dc7f58c4287..d92bab844b73 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -24,7 +24,6 @@ CONFIG_CRASH_DUMP=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
 # CONFIG_IUCV is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_RAM=y
 # CONFIG_BLK_DEV_XPRAM is not set
-- 
2.7.4

