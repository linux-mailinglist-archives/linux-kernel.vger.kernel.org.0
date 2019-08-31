Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5F0A4487
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2019 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfHaNAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Aug 2019 09:00:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbfHaNAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 09:00:41 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CFE00A00FDAB9886FE67;
        Sat, 31 Aug 2019 21:00:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Sat, 31 Aug 2019 21:00:31 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Murthy Bhat <Murthy.Bhat@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <esc.storagedev@microsemi.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] scsi: smartpqi: remove set but not used variable 'ctrl_info'
Date:   Sat, 31 Aug 2019 13:03:48 +0000
Message-ID: <20190831130348.20552-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/smartpqi/smartpqi_init.c: In function 'pqi_driver_version_show':
drivers/scsi/smartpqi/smartpqi_init.c:6164:24: warning:
 variable 'ctrl_info' set but not used [-Wunused-but-set-variable]

commit 6d90615f1346 ("scsi: smartpqi: add sysfs entries") add it but never
use, so remove it also variable 'shost'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index ea5409bebf57..b9e7dabee1e5 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6160,12 +6160,6 @@ static ssize_t pqi_firmware_version_show(struct device *dev,
 static ssize_t pqi_driver_version_show(struct device *dev,
 	struct device_attribute *attr, char *buffer)
 {
-	struct Scsi_Host *shost;
-	struct pqi_ctrl_info *ctrl_info;
-
-	shost = class_to_shost(dev);
-	ctrl_info = shost_to_hba(shost);
-
 	return snprintf(buffer, PAGE_SIZE,
 		"%s\n", DRIVER_VERSION BUILD_TIMESTAMP);
 }



