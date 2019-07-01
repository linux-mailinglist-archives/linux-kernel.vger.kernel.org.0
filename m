Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241ED216A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfEQKEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 06:04:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728112AbfEQKEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:04:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A0876D550BCA3411A7D9;
        Fri, 17 May 2019 18:03:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 17 May 2019 18:03:49 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] ipmi_si: use bool type for initialized variable
Date:   Fri, 17 May 2019 18:12:45 +0800
Message-ID: <20190517101245.4341-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517101245.4341-1-wangkefeng.wang@huawei.com>
References: <20190517101245.4341-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cover 'int' to 'bool' type for initialized variable.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/char/ipmi/ipmi_si_intf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index f124a2d2bb9f..da5b6723329a 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -71,7 +71,7 @@ enum si_intf_state {
 
 static const char * const si_to_str[] = { "invalid", "kcs", "smic", "bt" };
 
-static int initialized;
+static bool initialized;
 
 /*
  * Indexes into stats[] in smi_info below.
@@ -2124,7 +2124,7 @@ static int __init init_ipmi_si(void)
 	}
 
 skip_fallback_noirq:
-	initialized = 1;
+	initialized = true;
 	mutex_unlock(&smi_infos_lock);
 
 	if (type)
-- 
2.20.1

