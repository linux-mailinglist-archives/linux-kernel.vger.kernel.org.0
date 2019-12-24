Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C43C129FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 10:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLXJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 04:30:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbfLXJa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 04:30:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D4CA3DA33EF8F02BCDC5;
        Tue, 24 Dec 2019 17:30:55 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 17:30:46 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 2/4] tty/serial: kgdb_nmi: use true,false for bool variable
Date:   Tue, 24 Dec 2019 17:38:03 +0800
Message-ID: <1577180285-24904-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577180285-24904-1-git-send-email-zhengbin13@huawei.com>
References: <1577180285-24904-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/tty/serial/kgdb_nmi.c:121:6-13: WARNING: Assignment of 0/1 to bool variable
drivers/tty/serial/kgdb_nmi.c:133:2-9: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/tty/serial/kgdb_nmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 4029272..5022447 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -118,7 +118,7 @@ static int kgdb_nmi_poll_one_knock(void)
 	int c = -1;
 	const char *magic = kgdb_nmi_magic;
 	size_t m = strlen(magic);
-	bool printch = 0;
+	bool printch = false;

 	c = dbg_io_ops->read_char();
 	if (c == NO_POLL_CHAR)
@@ -130,7 +130,7 @@ static int kgdb_nmi_poll_one_knock(void)
 		n = (n + 1) % m;
 		if (!n)
 			return 1;
-		printch = 1;
+		printch = true;
 	} else {
 		n = 0;
 	}
--
2.7.4

