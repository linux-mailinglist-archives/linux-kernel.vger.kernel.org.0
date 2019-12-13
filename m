Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B365E11EBD3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 21:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfLMUZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 15:25:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44602 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbfLMUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:25:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id d199so2036908pfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 12:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nxSm7tgroROdEPl3eszZpyOKF7ZUt7YQNLaaQ2KtPDw=;
        b=OQFfePJq98DdDPxVGMs0UExHWaeiLhsNPNd1HDpzx7sV4pEkG75/mn8H7G7vL7ieS/
         Kq+v0ZhfAMjlvTBJ2RY2BFBd/bCzDLG36cwWKU7uYUx7SNBp56jhDlrCvnlJ3tp1CoLi
         CL2H8puLOF31BHddE0g8KZ0ofCBJJf9YEdgFjrli+xlET9+GQNp/FWWt6rBuq2np1oK9
         q1h9w1vufYkGpqJZ1Z9vvzSY0U2krn/yk3Yu74lZxKzxPFg57eafAyJ3eO7SJ4BSpM/9
         I9VAZOeA5V44gkJ7Kj5sfO20zMHgujtOIhqH9UKN4ji7K2t/g9fItZVYZXh1H1LUoVj4
         j/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nxSm7tgroROdEPl3eszZpyOKF7ZUt7YQNLaaQ2KtPDw=;
        b=JKvINJu6Ozk9YFGJt6voNiImTG6d8/tJUrUIT7qWw15e99Gug7JkAjR1vo/WLXkcqG
         YOpBZTfv+eWmlwIFbCv+yHDMwFD8EkNX9pn5DPkPROkY2XqUUsEZ7YbVtMOg+sXHetUk
         NbokDt+QhNtlblvBp/4ZM+oiU7bWZQl8oiAMUhXPkTHTyAHcGzczMVZMI9BPhXf5GVyu
         45OBtsq39cQumgI0J4oJmQUdfWGVD8CP/4fIoJESG6rIPr7PUv7sEJiSOpbAf0upb5qF
         PyiIDLHpdEoebwMWvZOMtZ7nXJEJM4pHu0Ib+usPpE0mr98USola9gRdNfo/KzxxmO/9
         Kfww==
X-Gm-Message-State: APjAAAVdaLasllehidnVxNOibrRnPihB6IG8AYfRiZZYBB8qZ+NgcfiT
        zW4+hJN7P4AaktEJgdKqXUk0mw==
X-Google-Smtp-Source: APXvYqyEIp81+z7sCimyY10euoklrxZVo2wYjhKcwH6l+idB4a450j9Hai/Lk8ptt120y5sfewwVig==
X-Received: by 2002:a62:e519:: with SMTP id n25mr1468679pff.220.1576268741192;
        Fri, 13 Dec 2019 12:25:41 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:0:b2de:593e:a6f0:9b20])
        by smtp.googlemail.com with ESMTPSA id d14sm13548720pfq.117.2019.12.13.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 12:25:40 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Subject: [PATCH] binder: fix incorrect calculation for num_valid
Date:   Fri, 13 Dec 2019 12:25:31 -0800
Message-Id: <20191213202531.55010-1-tkjos@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For BINDER_TYPE_PTR and BINDER_TYPE_FDA transactions, the
num_valid local was calculated incorrectly causing the
range check in binder_validate_ptr() to miss out-of-bounds
offsets.

Fixes: bde4a19fc04f ("binder: use userspace pointer as base of buffer space")
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e9bc9fcc7ea5..b2dad43dbf82 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3310,7 +3310,7 @@ static void binder_transaction(struct binder_proc *proc,
 			binder_size_t parent_offset;
 			struct binder_fd_array_object *fda =
 				to_binder_fd_array_object(hdr);
-			size_t num_valid = (buffer_offset - off_start_offset) *
+			size_t num_valid = (buffer_offset - off_start_offset) /
 						sizeof(binder_size_t);
 			struct binder_buffer_object *parent =
 				binder_validate_ptr(target_proc, t->buffer,
@@ -3384,7 +3384,7 @@ static void binder_transaction(struct binder_proc *proc,
 				t->buffer->user_data + sg_buf_offset;
 			sg_buf_offset += ALIGN(bp->length, sizeof(u64));
 
-			num_valid = (buffer_offset - off_start_offset) *
+			num_valid = (buffer_offset - off_start_offset) /
 					sizeof(binder_size_t);
 			ret = binder_fixup_parent(t, thread, bp,
 						  off_start_offset,
-- 
2.24.1.735.g03f4e72817-goog

