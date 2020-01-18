Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8F01415D1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 05:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAREZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 23:25:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51759 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgAREZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 23:25:36 -0500
Received: by mail-pj1-f68.google.com with SMTP id d15so4069351pjw.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 20:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHBJFZwYhK7Tmr8esHxqJUtoRn8WnZqTo+H+EnwYrJo=;
        b=Ta7ULbJ9wR6kMfZta5m7PrCEQqG28jhlvt1bjqZZFQJSYf4GxA71p6YbO45HBWUSgf
         MfbwElMbBtq5KSBmCdrgdcU2bAn5Ktkj1vv0Ic/RRKhl1A1hcbZnq9K4XHnlqR8usnHC
         SRtKpDxusODzswKsqwDzJajlJoZcSUPH3/eSXUj/FS+fHIWtJS5ATuwWad48pIq/ClvE
         FEss3YD02wwPEZ0Vw7fY66T88s2r6svVRxfZ9LTAhzOHC+Zf0U7dsjuv2a5VhwlMsjn2
         cy7gmeZAYdBcash7krqzGBtluNuTwaB3WM3Gq1P8Qovfm4KuDd3K/iGKwgmjzx+w32Wb
         yQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHBJFZwYhK7Tmr8esHxqJUtoRn8WnZqTo+H+EnwYrJo=;
        b=jyVqrM1sQZlRHqCbZoz2VARh/+46ny9ZUmNCsTRYZKhe8FgWCYz3eyOTNhooizSxgQ
         PNy4Jg8Ulnn+OGG5zDEqX8P4edRDe0Ce7yq0sd75Gg/7akFWvzE+YRQQqmg5DQr1b97V
         fxmLUEte64T9+BeLpfgVE4lqd9QWkDjsXHCZvxmqxgIS5WU19TO6snGw4Eq+bBYabeyv
         hqVw9ZfDcqJ1eSSXdf2FLQB8Ls4+jDLeW5lBEIrTnU9ZMrgBj4Kka68bHz4GxCU3kCb6
         k46jyHzBK5142ydofL2Ys+8awkmjItecZp74kfyb/d/DTcndfE04YoM/LDcc1F5UM5rZ
         /7QQ==
X-Gm-Message-State: APjAAAX1lOc+KbR7dfXyIozinLWPIRB4kx3DoAYUV2XBy/APiF+Sy6Ig
        cGam2Ww4b0ILK5Kqxcy7XXDUzNrFGiw=
X-Google-Smtp-Source: APXvYqzfq2rQlvfACHCOS+RwFwK6woYWos+WSMvOBXpfFgrS0GmGE6BLdwKkUxdrfeti3s13++vWpQ==
X-Received: by 2002:a17:90b:4398:: with SMTP id in24mr10196469pjb.29.1579321535509;
        Fri, 17 Jan 2020 20:25:35 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.181])
        by smtp.googlemail.com with ESMTPSA id r37sm8995812pjb.7.2020.01.17.20.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 20:25:34 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     santosh.shilimkar@oracle.com, arm@kernel.org, soc@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v2] drivers: soc: ti: knav_qmss_queue: Pass lockdep expression to RCU lists
Date:   Sat, 18 Jan 2020 09:54:34 +0530
Message-Id: <20200118042433.4968-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inst->handles is traversed using list_for_each_entry_rcu
outside an RCU read-side critical section but under the protection
of knav_dev_lock.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists.

Add macro for the corresponding lockdep expression.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v2:
- Remove rcu_read_lock_held() from lockdep expression since it is
  implicitly checked for.

 drivers/soc/ti/knav_qmss_queue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 1ccc9064e1eb..37f3db6c041c 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -25,6 +25,8 @@
 
 static struct knav_device *kdev;
 static DEFINE_MUTEX(knav_dev_lock);
+#define knav_dev_lock_held() \
+	lockdep_is_held(&knav_dev_lock)
 
 /* Queue manager register indices in DTS */
 #define KNAV_QUEUE_PEEK_REG_INDEX	0
@@ -52,8 +54,9 @@ static DEFINE_MUTEX(knav_dev_lock);
 #define knav_queue_idx_to_inst(kdev, idx)			\
 	(kdev->instances + (idx << kdev->inst_shift))
 
-#define for_each_handle_rcu(qh, inst)			\
-	list_for_each_entry_rcu(qh, &inst->handles, list)
+#define for_each_handle_rcu(qh, inst)				\
+	list_for_each_entry_rcu(qh, &inst->handles, list,	\
+				knav_dev_lock_held())
 
 #define for_each_instance(idx, inst, kdev)		\
 	for (idx = 0, inst = kdev->instances;		\
-- 
2.24.1

