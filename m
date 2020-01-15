Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4442013C485
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAON7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 08:59:45 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729112AbgAON7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:59:41 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 749CE92B389FC3257301;
        Wed, 15 Jan 2020 21:59:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 21:59:32 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>,
        <rppt@linux.ibm.com>, <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <chenzhou10@huawei.com>
Subject: [PATCH next] init/main.c: make some symbols static
Date:   Wed, 15 Jan 2020 21:54:58 +0800
Message-ID: <20200115135458.71460-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make variable xbc_namebuf and function boot_config_checksum static to
fix build warnings, warnings are as follows:

init/main.c:254:6:
	warning: symbol 'xbc_namebuf' was not declared. Should it be static?
init/main.c:330:5:
	warning: symbol 'boot_config_checksum' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 init/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index a77114f..3a95591 100644
--- a/init/main.c
+++ b/init/main.c
@@ -251,7 +251,7 @@ early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BOOT_CONFIG
 
-char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
@@ -327,7 +327,7 @@ static char * __init xbc_make_cmdline(const char *key)
 	return new_cmdline;
 }
 
-u32 boot_config_checksum(unsigned char *p, u32 size)
+static u32 boot_config_checksum(unsigned char *p, u32 size)
 {
 	u32 ret = 0;
 
-- 
2.7.4

