Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7610CF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 22:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfK1VM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 16:12:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42033 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfK1VMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 16:12:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so32647563wrf.9;
        Thu, 28 Nov 2019 13:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Lg7L77IP4bx5QKviUaKZB+T2xlEmOdr7ElK44pBo7WA=;
        b=X8vfNFSy73lLY1V6LiT2zN+ER6oI601XUGtHVkH1zsQ/ca6cHz+Ma9znwE+QeDm6eJ
         XeQyKxNr4YYJIf632sihj6wyRB7LcgIMtBRCoBpO88NzSx8h+zSTJ3J1B0N6QLdkGozw
         7y3ux5z4sflj2Xjo7XSREL2Illbc1C7bX8b0KmoZsaYogQ1ECD7ttBjWT3/9bHCMFjnX
         sbTVySr29u+1Pbb/k93zTan11Sbpr2J2vZ1eoq33ZRZBPBEL47jvN+sMcLstRNdF2d16
         7zX9+1FKUNocz/APdluQxW0nsVEw6c6N8p/5SaXf4KHNarEDnCADy92tfCMHUuE6lki3
         9MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lg7L77IP4bx5QKviUaKZB+T2xlEmOdr7ElK44pBo7WA=;
        b=FqcfrBRCZ4K5U68qkwaWP00Qfi8pG+4EFmxsSTIXBADjLZfNlO7hhdvfaFjJc1u83E
         GCBi3inz54yXrGUxqnB3rMAEBQgqWeivTf8dZmgBllYPQ6Vn6SvNC9fMf7YQYIb+gx/o
         xC+Of8DjvNJKH/9AVw2kBQZkXPL7VGpAi0jnJMGaNLxvGGqts7P9xZCdzYwYiEOyEi5R
         zVC255HFQGrUAdO5B/9f4PVg1fP43OI1yNI7l4vQBo+KRb7d5VXxND7sm3yIk7/8g93c
         ScaohYMLPiQGZ6FhJPzcore2+xcRY8u7dGSbBMDuw9kY/T1xJyo6Z/um9e/lkDSd1pPC
         cM9g==
X-Gm-Message-State: APjAAAWYRM7pq7ZvautQcDQAhJmbmrwsQ6aVgB9jdH1bFjaSfJ5BnG9E
        iPrdhreFLlyqufnjno1JjoFui5gI
X-Google-Smtp-Source: APXvYqy2mXbXFjqiXd4Q8h9H7IaLhmGXNdXzQ3Lb1se3s9RqLQDiXKrlRaGJ1HeXBn32u87XMHow9Q==
X-Received: by 2002:a5d:6887:: with SMTP id h7mr19806568wru.397.1574975541563;
        Thu, 28 Nov 2019 13:12:21 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id l26sm11620809wmj.48.2019.11.28.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 13:12:21 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] list: introduce list_for_each_continue()
Date:   Fri, 29 Nov 2019 00:11:54 +0300
Message-Id: <2b54707c0640114d24a3e08f57fce2576e05bd27.1574974577.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574974577.git.asml.silence@gmail.com>
References: <cover.1574974577.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As other *continue() helpers, this continues iteration from a given
position.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/list.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 85c92555e31f..3c391bbd03c3 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -538,6 +538,16 @@ static inline void list_splice_tail_init(struct list_head *list,
 #define list_for_each(pos, head) \
 	for (pos = (head)->next; pos != (head); pos = pos->next)
 
+/**
+ * list_for_each_continue - continue iteration over a list
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ *
+ * Continue to iterate over a list, continuing after the current position.
+ */
+#define list_for_each_continue(pos, head) \
+	for (pos = pos->next; pos != (head); pos = pos->next)
+
 /**
  * list_for_each_prev	-	iterate over a list backwards
  * @pos:	the &struct list_head to use as a loop cursor.
-- 
2.24.0

