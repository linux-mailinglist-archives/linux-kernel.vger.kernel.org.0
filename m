Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 398A5122AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 12:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLQLxd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Dec 2019 06:53:33 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2107 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfLQLxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:53:32 -0500
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 5AAA6FC76425F2D8B827;
        Tue, 17 Dec 2019 19:53:28 +0800 (CST)
Received: from DGGEML505-MBX.china.huawei.com ([169.254.12.46]) by
 DGGEML402-HUB.china.huawei.com ([fe80::fca6:7568:4ee3:c776%31]) with mapi id
 14.03.0439.000; Tue, 17 Dec 2019 19:53:22 +0800
From:   "wubo (T)" <wubo40@huawei.com>
To:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
Subject: [PATCH] scsi:remove unreachable code on scsi_decide_disposition func
Thread-Topic: [PATCH] scsi:remove unreachable code on
 scsi_decide_disposition func
Thread-Index: AdW0zylDYYuhZep7QPWk1qrXegsGRA==
Date:   Tue, 17 Dec 2019 11:53:21 +0000
Message-ID: <EDBAAA0BBBA2AC4E9C8B6B81DEEE1D6915E9A7FD@dggeml505-mbx.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.252]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Bo <wubo40@huawei.com>

Remove unreachable code on scsi_decide_disposition func.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/scsi_error.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index ae2fa17..c5e05c4 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1934,7 +1934,6 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
        default:
                return FAILED;
        }
-       return FAILED;

 maybe_retry:

--
1.8.3.1
