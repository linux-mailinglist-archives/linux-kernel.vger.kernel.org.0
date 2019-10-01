Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0012DC39FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 18:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389791AbfJAQHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 12:07:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733279AbfJAQHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:07:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 70DFC3FA71A0965C69C2;
        Wed,  2 Oct 2019 00:07:45 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Wed, 2 Oct 2019 00:07:15 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <bhelgaas@google.com>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] bus: hisi_lpc: Expand build test coverage
Date:   Wed, 2 Oct 2019 00:04:27 +0800
Message-ID: <1569945867-82243-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
References: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver will only ever be built for ARM64 because it selects
CONFIG_INDIRECT_PIO, which itself depends on ARM64.

Expand build test coverage for the driver to other architectures by only
selecting CONFIG_INDIRECT_PIO for ARM64, when we really want it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 6b331061d34b..44cb4b6bea18 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -41,8 +41,8 @@ config MOXTET
 
 config HISILICON_LPC
 	bool "Support for ISA I/O space on HiSilicon Hip06/7"
-	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
-	select INDIRECT_PIO
+	depends on (ARM64 && ARCH_HISI) || COMPILE_TEST
+	select INDIRECT_PIO if ARM64
 	help
 	  Driver to enable I/O access to devices attached to the Low Pin
 	  Count bus on the HiSilicon Hip06/7 SoC.
-- 
2.17.1

