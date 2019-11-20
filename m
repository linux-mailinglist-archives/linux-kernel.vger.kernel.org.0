Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78952103084
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 01:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKTAHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 19:07:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54408 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKTAHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:07:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so5140878wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 16:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6vKO+uuoshpZcYawl3rQxkKnD1hFkbBYYlGIAyAxcQ=;
        b=cL9YM298AhlC+XIzzjSgWryLJ/RABmUoty3972uTeiYUu8JwItJm/iYaSytaXWUO/8
         baiRNS1m0tAS4OszK6upXPqsttsuwXk6M1+q9BYywy8GDpiBXsbp5aY7EgZBtACDbBMK
         Fyhh0Z4vOrqGd/f9VAZXjk2Cjj+0SVij8NinxTCo3XQ+YuXukb4D2xq04bti1DfvtJZ0
         XJw3tlSV196uEAhTr6UH0JXGOrAFzQGcic2tSJq86ys7g6kf2x3plKtdkZ+4nRtm+rXE
         L6KU0ngBVTgD3BVpLePXOylFs7B+BoorzJL7hAaY8foKBUh48mtxChoBRZLpSMV69Aoz
         RKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+6vKO+uuoshpZcYawl3rQxkKnD1hFkbBYYlGIAyAxcQ=;
        b=Jjq/+E5jxF5h9gv01OuZAv547o42FobSrFdoWJDKvrfXVUqDUt4fMEP7AO//5UI0Tx
         h4P7PIgZJeVYin6lZ0kvgbhszJYvzRSIllVe5h686DAqrF52uoNqC9VPDQ6BGKGv3fes
         M9kt0pOwOQ8chrSn5mHWvS4HJ1ynaofslse/VXinTljtsQGZErN9sw2yV0SfLppu28dt
         bBNIYRNCS+JgFzkex7mU+mgbjQkoerfBA0cElkIa2C+IdgeVk4fZr4cUh7tnc07wLiFI
         tUrOt1FlZ0e+ElliZBhz4+H/P8vff4pm7WX4ZuBXC+NSobG/lfTZbf72EC3UW7WNTaO0
         Wb9w==
X-Gm-Message-State: APjAAAWeydVT17ZL/gTG4uxq+D3o8yFtxSkg7/kNoqiRrpQZ0xYp7YR5
        AgQA0MN4RF/n3OS6+C6wo56z/AYW
X-Google-Smtp-Source: APXvYqyVIm4tZPRKJYne1zleCls/1LdyRRVB5s4mVTElbxn26wYMT/q3yKva6g44jOOf9vq1sMN8yA==
X-Received: by 2002:a1c:9ccd:: with SMTP id f196mr51697wme.152.1574208464969;
        Tue, 19 Nov 2019 16:07:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:40e1:9900:5dce:1599:e3b5:7d61])
        by smtp.gmail.com with ESMTPSA id o189sm5072870wmo.23.2019.11.19.16.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:07:44 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] ipmi: fix ipmb_poll()'s return type
Date:   Wed, 20 Nov 2019 01:07:41 +0100
Message-Id: <20191120000741.30657-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipmb_poll() is defined as returning 'unsigned int' but the
.poll method is declared as returning '__poll_t', a bitwise type.

Fix this by using the proper return type and using the EPOLL
constants instead of the POLL ones, as required for __poll_t.

CC: Corey Minyard <minyard@acm.org>
CC: openipmi-developer@lists.sourceforge.net
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 285e0b8f9a97..2ea51147c3e8 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -154,16 +154,16 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
 	return ret ? : count;
 }
 
-static unsigned int ipmb_poll(struct file *file, poll_table *wait)
+static __poll_t ipmb_poll(struct file *file, poll_table *wait)
 {
 	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
-	unsigned int mask = POLLOUT;
+	__poll_t mask = EPOLLOUT;
 
 	mutex_lock(&ipmb_dev->file_mutex);
 	poll_wait(file, &ipmb_dev->wait_queue, wait);
 
 	if (atomic_read(&ipmb_dev->request_queue_len))
-		mask |= POLLIN;
+		mask |= EPOLLIN;
 	mutex_unlock(&ipmb_dev->file_mutex);
 
 	return mask;
-- 
2.24.0

