Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C76D3392
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 23:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfJJVke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 17:40:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39932 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfJJVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:40:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so8201939wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5YEeIOaPo1JGlJWQewk3M0wcqwSy5upFgX2fmJpZCaw=;
        b=jxQgazH0gRz9X53R/oxw4eLM8Sv2X6SQnLG0qkR/c3GAuSNs8/ydl0EpB1UL2iy46g
         A7dDD44p6whsuGf9dstCb+WTukxybSNKDNqFemc4SRGa2j+a63aYNb+00dUNXLBcnsHI
         mzplDcZdnWrOErdsLXDgo71WJ0Fyh7BQyaXx37R+NXr47uYb7s532YAO+Taecllp6E56
         8ZUvt1N6Elw9wB2Eo5zYgDeYTb4vCAbkUb6lrtJLGD97K7TWnfdDzgDiqMIqLK9Bk7j1
         NMErXMErfjEdRCYJ65Edjqk9ZK6t9Pb1doEpjlw8uRJDJ4mWvSGXqJb1QpyV1f2VUZ12
         78sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5YEeIOaPo1JGlJWQewk3M0wcqwSy5upFgX2fmJpZCaw=;
        b=BjlrmK5Oy3p3EOKdR5jZ7o/JNMTdVK1D5gwJGSu1vMjTw195dTzbJMegpGP4W2Wr2B
         +Kaut4l8a4u8Exkfr4es2ZAeU5JTTq70Ho+JW5aZHsZj1q0016rrOB0QgJiS2GPDo4/B
         Hg34iUXyOvI8Ec6Tw0VK0iziQ018OD6+9t5YCLomOqNbN/gwKaZgSj/nC93tStGtZPpi
         NUZNmbiNcteE+KdCudV8DkJ1R2pTzbrLAuXGfM4lCi1ZKpYEhIOZyIj8mWrJQhjJUkUc
         k3JZMsa0jLKru2IpgUSxFMlcVZAtLL3JBLZmysDon/1FpIhd99cTU6+Cagrb3nm9HMH1
         1vQg==
X-Gm-Message-State: APjAAAWQeMhgvS2YRxvLhbmyL9/0KwXnrqyb/fQEbRF5SfKOFh0+F5TX
        Ia62wF/+ah22yC6hMiD/dg==
X-Google-Smtp-Source: APXvYqx+Rig5tHdfHgGET0cHZ6i7yt1alXpv/bO1LJsawEajjDGuFlvlPZ4JNF1ipA/qPQ5IsgTmzA==
X-Received: by 2002:a1c:7dce:: with SMTP id y197mr426404wmc.171.1570743626164;
        Thu, 10 Oct 2019 14:40:26 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.googlemail.com with ESMTPSA id h63sm11455423wmf.15.2019.10.10.14.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:40:25 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Jules Irenge <jbi.octave@gmail.com>
Subject: [RESEND PATCH v1 5/5] staging: qlge: fix comparison to NULL warning
Date:   Thu, 10 Oct 2019 22:40:06 +0100
Message-Id: <20191010214006.23677-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010214006.23677-1-jbi.octave@gmail.com>
References: <20191010214006.23677-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comparison to NULL by replacing with !ptr instead.
 Issue detected by checkpatch.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index eb993207d224..12a62a6fbb69 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -1804,7 +1804,7 @@ void ql_dump_hw_cb(struct ql_adapter *qdev, int size, u32 bit, u16 q_id)
 	pr_err("%s: Enter\n", __func__);
 
 	ptr = kmalloc(size, GFP_ATOMIC);
-	if (ptr == NULL)
+	if (!ptr)
 		return;
 
 	if (ql_write_cfg(qdev, ptr, size, bit, q_id)) {
-- 
2.21.0

