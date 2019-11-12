Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D506CF8BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 10:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfKLJea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 04:34:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727405AbfKLJe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:34:26 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6256F2A94F9A3167077;
        Tue, 12 Nov 2019 17:34:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 17:34:17 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/4] hisi_sas: Some misc minor patches
Date:   Tue, 12 Nov 2019 17:30:55 +0800
Message-ID: <1573551059-107873-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes some misc patches which were sitting on our internal
dev branch.

Nothing extra special to note, just really some tidying and very minor
fixes.

John Garry (1):
  scsi: hisi_sas: Stop converting a bool into a bool

Xiang Chen (3):
  scsi: hisi_sas: Check sas_port before using it
  scsi: hisi_sas: Return directly if init hardware failed
  scsi: hisi_sas: Relocate call to hisi_sas_debugfs_exit()

 drivers/scsi/hisi_sas/hisi_sas_main.c  | 5 +++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.17.1

