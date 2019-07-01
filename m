Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB43D21438
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 09:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfEQH2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 03:28:06 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:35062 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbfEQH2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:28:06 -0400
X-QQ-mid: bizesmtp6t1558078014tvru3ndpu
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 17 May 2019 15:26:49 +0800 (CST)
X-QQ-SSF: 01400000000000H0HH32B00A0000000
X-QQ-FEAT: uPLuWhYJ8bgQ0KBKFD26TP9nD+iZGxfLS5lfh9f7aD4HRiMqZBPYNqzg8iaWJ
        1nB6QC8odokeMzekQ6BY5HBuhXVzpGTTfXzMT14VhPUEE6i/C88YPCGNQ6dTyO/GGa499mI
        OV8irotPyiSh6NNnLrst0WZAeYOWbQ1W0zjwVeuXNM0pU3sS07KIpKo1pu1GDSeDTT+Y0X1
        wnWOlrLgKl75pbUL0GWR7iiP3ZVUbHzAIgIFuASwetrelpCJmRoctTYoYe4ho/Ces90ReM6
        txkM9csxi87PorZqRUfyPNQiHDaVv8Zo4h0L0Lr8n1UEY84s1cn9Wh5uH99IKGp6N4CQ==
X-QQ-GoodBg: 2
From:   xiaolinkui <xiaolinkui@kylinos.cn>
To:     james.morris@microsoft.com, gustavo@embeddedor.com,
        dhowells@redhat.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn
Subject: [PATCH 1/3] lib: assoc_array: use struct_size() in kmalloc()
Date:   Fri, 17 May 2019 15:26:48 +0800
Message-Id: <1558078008-15737-1-git-send-email-xiaolinkui@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new struct_size() helper to keep code simple.

Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 lib/assoc_array.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index edc3c14..0e69b5b 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -1494,8 +1494,7 @@ int assoc_array_gc(struct assoc_array *array,
 		shortcut = assoc_array_ptr_to_shortcut(cursor);
 		keylen = round_up(shortcut->skip_to_level, ASSOC_ARRAY_KEY_CHUNK_SIZE);
 		keylen >>= ASSOC_ARRAY_KEY_CHUNK_SHIFT;
-		new_s = kmalloc(sizeof(struct assoc_array_shortcut) +
-				keylen * sizeof(unsigned long), GFP_KERNEL);
+		new_s = kmalloc(struct_size(new_s, index_key, keylen), GFP_KERNEL);
 		if (!new_s)
 			goto enomem;
 		pr_devel("dup shortcut %p -> %p\n", shortcut, new_s);
-- 
2.7.4



