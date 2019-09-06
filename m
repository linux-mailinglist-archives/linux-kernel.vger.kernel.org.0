Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA6ABAE1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405431AbfIFOaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 10:30:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46547 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390975AbfIFOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:30:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6FFc-0005RF-IG; Fri, 06 Sep 2019 14:30:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/shmem.c: make array 'values' static const, makes object smaller
Date:   Fri,  6 Sep 2019 15:30:12 +0100
Message-Id: <20190906143012.28698-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array 'values' on the stack but instead make it
static const. Makes the object code smaller by 111 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
 108612	  11169	    512	 120293	  1d5e5	mm/shmem.o

After:
   text	   data	    bss	    dec	    hex	filename
 108437	  11233	    512	 120182	  1d576	mm/shmem.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 77d2df011c0e..30e1de87bdca 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3934,7 +3934,7 @@ int __init shmem_init(void)
 static ssize_t shmem_enabled_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	int values[] = {
+	static const int values[] = {
 		SHMEM_HUGE_ALWAYS,
 		SHMEM_HUGE_WITHIN_SIZE,
 		SHMEM_HUGE_ADVISE,
-- 
2.20.1

