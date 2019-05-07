Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA31688B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfEGQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 12:58:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35182 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:58:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so8616527pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yCv8sSMR6ScKjEy1rfKWXGO+DU+5zcc2adHgmKc5Xg8=;
        b=MbQxKye7rA//CkI9bEGuRwPAFkJISCOT4QAqjGufCOelreGxFdXLEZcRtwrcr/bvmn
         5F8SCUFRLBYgFUOndqdEsgbFiQCyk3BAF+glzr8cWI49YTy12LnWHKErN20OhtXqlOTK
         jUPUYtC31fYoW8RLeI9pWHBT+kN1iMHh/Qh/nBkCTNfNTyD0ZBDTE9v5swEddHPAiBp5
         fTyMkrRmy2KlbWlaGSKuE88RQGhhaCYQg4yDvsKRfjrh1ANSoheFZ3uExna2UEn5jxyy
         OstuX6uCMHAxWF7VTPw776bKcU5k+SpegZh+Pa8Une6s9XSM4f54lWCsOBpF9iv1lXMD
         xgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yCv8sSMR6ScKjEy1rfKWXGO+DU+5zcc2adHgmKc5Xg8=;
        b=ZAeFNfwpWkaoOnNNoE3N3BvIcrgOWJJS52Wv5e1TELr+fWtDHahATWQPU/bk9z3WxO
         n0jO24OnYaMbktE6ds2tNobt3Z6InXm7bmyLWbjvpml3Za9Y9T140GfEAnxBwiKeJ6X3
         fejwp25Ish/M3Hs/Y30I7BExKzMKeELa4uPxDfa9Fee7kPVtVmvAkiJTIBw72kJqXc5g
         7L8nr+ORAIj5R8QMbsZ/BxkFZbfog+wLldxBcWnjr/8ABck6qHHFGx4AOUjxlRqJobnQ
         Y3y9KdFStvHRLZO8eqM5hP+4B71BGlPsNKqqQQZ2QZvqWtKQaEuGzke4O0c/9imrRXjH
         8lYQ==
X-Gm-Message-State: APjAAAUMHb7+BQmzy+O6M8uE8DCBpGZsajRBJSgrJXwAgd/el6cgCMwM
        8F/5z7Kah1J/ocuRdJ3iqhBk5rW+
X-Google-Smtp-Source: APXvYqy3RvniSsGhL6GQuYhBIGPKuJeK5+qo9p8zgaZO6UBphnwJmO5t/7I7TYPdO3EnicMp8ubK7A==
X-Received: by 2002:a63:2d41:: with SMTP id t62mr41260420pgt.113.1557248332851;
        Tue, 07 May 2019 09:58:52 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:1b24:991b:df50:ea3f])
        by smtp.gmail.com with ESMTPSA id r12sm18140093pfn.144.2019.05.07.09.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 09:58:52 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v2 1/7] devcoredump: use memory_read_from_buffer
Date:   Wed,  8 May 2019 01:58:28 +0900
Message-Id: <1557248314-4238-2-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use memory_read_from_buffer() to simplify devcd_readv().

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- Add Reviewed-by tag.

 drivers/base/devcoredump.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index f1a3353..3c960a6 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -164,16 +164,7 @@ static struct class devcd_class = {
 static ssize_t devcd_readv(char *buffer, loff_t offset, size_t count,
 			   void *data, size_t datalen)
 {
-	if (offset > datalen)
-		return -EINVAL;
-
-	if (offset + count > datalen)
-		count = datalen - offset;
-
-	if (count)
-		memcpy(buffer, ((u8 *)data) + offset, count);
-
-	return count;
+	return memory_read_from_buffer(buffer, count, &offset, data, datalen);
 }
 
 static void devcd_freev(void *data)
-- 
2.7.4

