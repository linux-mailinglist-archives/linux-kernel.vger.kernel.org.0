Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33DCE13BA2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfEDSjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 14:39:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45270 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfEDSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 14:38:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id w12so7812216ljh.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/u9rNGqOW2dOSLffOJfHUaleI765lJLPMsmmCLoHEoc=;
        b=TA0kfa5a7yuV08ff1+JbCgAoOJbcdBLQ5CETXoxxSVhSc9OHulrS7YU8H24sagCfx9
         PpzI0YwB4q1xbLwvKVwW+v6iwuJOiKwqTVO05fs9KetRFpkNu4OjsHSRNtq8vndNGsIP
         8rlzfpod4KPDB0oJgISEE6C2qvE01AiwGlXnlZCPerpnYe4KU2JSTnsRNRrhpvT+oVVO
         iG0Le2SFhtMy8S8xIDWpVvdZSQX2iTy7v8fRsFAmIxp9fTEm3pupwEEUdTGxPuLkZhh3
         IoSApqwjpwzfRGvBR+qnJiKrQPhn6RF+ulnaRJYzVtCo1Rrxiu8QA64ZsDEdiZpMPoyl
         4tWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/u9rNGqOW2dOSLffOJfHUaleI765lJLPMsmmCLoHEoc=;
        b=I5k/46ZRE9Kppgxs/+S9jSU4IdgmpEcAwAkOcn1O9YDDZ3xtGZ3sMZbjcprMtJl+V6
         tvWubxn01XuV4QcQ4FeObCLKg7w+edviaNbsZZ9UOHAMNaF6QpMRwgr/YInZe7+1bTqc
         lsRabXp1yJrr89QHi82qFyOcvFCPgH2rz3TVhFXiuaiIrzRaohhtU4405/8z/LYav0BK
         ZU3Mc8CSqrNZFj2qFYcWFZWjzzuLiq2Bg6fzBlAxJCaP/Sr9X9Mh4jRbTkczxpVNHm3m
         nuCbbZTtELVU4qy2T4sQAJfy/FA2sOsuMpyGf1n/7JdUL0CW0O7WJUZBpigU8+YC9Sfr
         LjZw==
X-Gm-Message-State: APjAAAUvo9mJRVtJ3AUZstkXKb1sRA81zR3m7yTnniC2MORQA+GE7tCz
        7XCZIXsqozXd/WTSI+/G80iUcg==
X-Google-Smtp-Source: APXvYqwMKtTafOy3OTCIPqUvF3tcL3YpX+JXGtt7kgusKlIxbosPShp9kENluuCduTVMz1j76uIiNQ==
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr8892631lja.193.1556995130124;
        Sat, 04 May 2019 11:38:50 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id q21sm1050260lfa.84.2019.05.04.11.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 11:38:49 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 24/26] lightnvm: do not remove instance under global lock
Date:   Sat,  4 May 2019 20:38:09 +0200
Message-Id: <20190504183811.18725-25-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190504183811.18725-1-mb@lightnvm.io>
References: <20190504183811.18725-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Konopko <igor.j.konopko@intel.com>

Currently all the target instances are removed under global nvm_lock.
This was needed to ensure that nvm_dev struct will not be freed by
hot unplug event during target removal. However, current implementation
has some drawbacks, since the same lock is used when new nvme subsystem
is registered, so we can have a situation, that due to long process of
target removal on drive A, registration (and listing in OS) of the
drive B will take a lot of time, since it will wait for that lock.

Now when we have kref which ensures that nvm_dev will not be freed in
the meantime, we can easily get rid of this lock for a time when we are
removing nvm targets.

Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Reviewed-by: Javier González <javier@javigon.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/core.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 0e9f7996ff1d..0df7454832ef 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -483,7 +483,6 @@ static void __nvm_remove_target(struct nvm_target *t, bool graceful)
 
 /**
  * nvm_remove_tgt - Removes a target from the media manager
- * @dev:	device
  * @remove:	ioctl structure with target name to remove.
  *
  * Returns:
@@ -491,18 +490,27 @@ static void __nvm_remove_target(struct nvm_target *t, bool graceful)
  * 1: on not found
  * <0: on error
  */
-static int nvm_remove_tgt(struct nvm_dev *dev, struct nvm_ioctl_remove *remove)
+static int nvm_remove_tgt(struct nvm_ioctl_remove *remove)
 {
 	struct nvm_target *t;
+	struct nvm_dev *dev;
 
-	mutex_lock(&dev->mlock);
-	t = nvm_find_target(dev, remove->tgtname);
-	if (!t) {
+	down_read(&nvm_lock);
+	list_for_each_entry(dev, &nvm_devices, devices) {
+		mutex_lock(&dev->mlock);
+		t = nvm_find_target(dev, remove->tgtname);
+		if (t) {
+			mutex_unlock(&dev->mlock);
+			break;
+		}
 		mutex_unlock(&dev->mlock);
+	}
+	up_read(&nvm_lock);
+
+	if (!t)
 		return 1;
-	}
+
 	__nvm_remove_target(t, true);
-	mutex_unlock(&dev->mlock);
 	kref_put(&dev->ref, nvm_free);
 
 	return 0;
@@ -1348,8 +1356,6 @@ static long nvm_ioctl_dev_create(struct file *file, void __user *arg)
 static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 {
 	struct nvm_ioctl_remove remove;
-	struct nvm_dev *dev;
-	int ret = 0;
 
 	if (copy_from_user(&remove, arg, sizeof(struct nvm_ioctl_remove)))
 		return -EFAULT;
@@ -1361,15 +1367,7 @@ static long nvm_ioctl_dev_remove(struct file *file, void __user *arg)
 		return -EINVAL;
 	}
 
-	down_read(&nvm_lock);
-	list_for_each_entry(dev, &nvm_devices, devices) {
-		ret = nvm_remove_tgt(dev, &remove);
-		if (!ret)
-			break;
-	}
-	up_read(&nvm_lock);
-
-	return ret;
+	return nvm_remove_tgt(&remove);
 }
 
 /* kept for compatibility reasons */
-- 
2.19.1

