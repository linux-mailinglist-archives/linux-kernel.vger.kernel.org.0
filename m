Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC810CA02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 15:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfK1OAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 09:00:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbfK1OAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:00:49 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 34BB265186D19FA1D158;
        Thu, 28 Nov 2019 22:00:46 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 28 Nov 2019
 22:00:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <cezary.rojewski@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <liam.r.girdwood@linux.intel.com>, <yang.jie@linux.intel.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <gregkh@linuxfoundation.org>, <allison@lohutok.net>,
        <yuehaibing@huawei.com>, <tglx@linutronix.de>,
        <alexios.zavras@intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: Intel: sst: Add missing include <linux/io.h>
Date:   Thu, 28 Nov 2019 21:58:53 +0800
Message-ID: <20191128135853.8360-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error:

sound/soc/intel/atom/sst/sst.c: In function intel_sst_interrupt_mrfld:
sound/soc/intel/atom/sst/sst.c:93:5: error: implicit declaration of function memcpy_fromio;
 did you mean memcpy32_fromio? [-Werror=implicit-function-declaration]
     memcpy_fromio(msg->mailbox_data,
     ^~~~~~~~~~~~~
     memcpy32_fromio

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/intel/atom/sst/sst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index fbecbb7..68bcec5 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
-- 
2.7.4


