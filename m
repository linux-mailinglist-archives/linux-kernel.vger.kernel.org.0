Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30FA137460
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgAJRGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 12:06:49 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50288 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgAJRGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:06:48 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so1215350pjb.0;
        Fri, 10 Jan 2020 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHv1uXIjZrBkPDtqd3SWrlnhplYEAEov1hk0+vF++bc=;
        b=D6QloqUyjA7aqfAZzs4kwh2nt3pyT0OymgieI8yxI4wPm1p2eXG8sII04YqS24v3Is
         Mo9L8DH3TiCYa2CFdFIdJWheaCXhp0wrRGwZpAOCsJpAu26FAib968ZTs6vm42clut9M
         p6qjzCkQIQPH81lr1dru0y8guNmELSU+zDHiKywJAkrtvhhNBZA9NbnrwTGFiMgh6I3D
         mohLOtEeTr+b4nzZYfezm+dJDJ/qq6ekCPbh1/hhyf9B3KQap/n+mMjR5VINvjlIU+Fz
         QfeUjoR19XnQKOrIiYlcSYG/EbcMtuT8r9QWpSXAMCuXvwmNdq3GSa9mP+6P9SbblM1K
         kfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHv1uXIjZrBkPDtqd3SWrlnhplYEAEov1hk0+vF++bc=;
        b=g/JBv7fY7ic5lxEpE9W7xd5hC8eNnzWHHi0IkeBxZcY8U91cXqrKQ+5P+Rt1rCuMQT
         tRsu+DKjKvCzOoh8moafwQsAPunUiSdnQ0nUqEpiqpyW+9kZT31aKQk0FUkqWsI/Xt2Y
         gKZs6tbGsuXVuXNdBEDaxeGMFslI0/IpaJMy35tU5ocnmNZ4stScfQvdqSo6apL0ak3v
         zwvpJnpyusE+EQik0InL3tidLGcPcI7MllX062b0qHw3ZIWlAXkkaQHAYvRS9ioNLAlf
         8iGfTj8EGLkHnXCVNTbr+lLIBHnqb2JosnY2Ys72E3A3H5TsDgASxhWFZLR4y32D+Lhk
         +jcg==
X-Gm-Message-State: APjAAAXzEEiLYXOsoHqBS7CVvC9WKutdsgQ259LU3qRc3N24xovsb5Tr
        qtKoGzy01PPQWb5yh9agfPg=
X-Google-Smtp-Source: APXvYqx3gqGSFiAwvC6krHLnqHoT6cxVpd3wtWFIYmQO3dWFbHKJ4+9cRs/OmdPPAAfpMhC+suke+A==
X-Received: by 2002:a17:902:9885:: with SMTP id s5mr5464097plp.217.1578676007973;
        Fri, 10 Jan 2020 09:06:47 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.220])
        by smtp.googlemail.com with ESMTPSA id x4sm3613268pff.143.2020.01.10.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:06:47 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v2 1/3] drivers: target: target_core_device: Pass lockdep expression to RCU lists
Date:   Fri, 10 Jan 2020 22:35:57 +0530
Message-Id: <20200110170558.23466-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nacl->lun_entry_hlist is traversed with hlist_for_each_entry_rcu
outside an RCU read-side critical section but under the
protection of nacl->lun_entry_mutex.

Hence, add the corresponding lockdep expression to the list traversal
primitive to silence false-positive lockdep warnings, and
harden RCU lists.

Add macro for the corresponding lockdep expression to make the code
clean and concise.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v2:
- Fix sparse error
  CHECK: Alignment should match open parenthesis

 drivers/target/target_core_device.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 2d19f0e332b0..7627583e2509 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -36,6 +36,9 @@
 #include "target_core_pr.h"
 #include "target_core_ua.h"
 
+#define lun_entry_mutex_held() \
+	lockdep_is_held(&nacl->lun_entry_mutex)
+
 static DEFINE_MUTEX(device_mutex);
 static LIST_HEAD(device_list);
 static DEFINE_IDR(devices_idr);
@@ -247,9 +250,10 @@ void core_free_device_list_for_node(
 	struct se_dev_entry *deve;
 
 	mutex_lock(&nacl->lun_entry_mutex);
-	hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link) {
+	hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link,
+				 lun_entry_mutex_held()) {
 		struct se_lun *lun = rcu_dereference_check(deve->se_lun,
-					lockdep_is_held(&nacl->lun_entry_mutex));
+							lun_entry_mutex_held());
 		core_disable_device_list_for_node(lun, deve, nacl, tpg);
 	}
 	mutex_unlock(&nacl->lun_entry_mutex);
@@ -276,7 +280,8 @@ struct se_dev_entry *target_nacl_find_deve(struct se_node_acl *nacl, u64 mapped_
 {
 	struct se_dev_entry *deve;
 
-	hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link)
+	hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link,
+				 rcu_read_lock_held() || lun_entry_mutex_held())
 		if (deve->mapped_lun == mapped_lun)
 			return deve;
 
@@ -339,7 +344,7 @@ int core_enable_device_list_for_node(
 	orig = target_nacl_find_deve(nacl, mapped_lun);
 	if (orig && orig->se_lun) {
 		struct se_lun *orig_lun = rcu_dereference_check(orig->se_lun,
-					lockdep_is_held(&nacl->lun_entry_mutex));
+							lun_entry_mutex_held());
 
 		if (orig_lun != lun) {
 			pr_err("Existing orig->se_lun doesn't match new lun"
@@ -460,9 +465,10 @@ void core_clear_lun_from_tpg(struct se_lun *lun, struct se_portal_group *tpg)
 	list_for_each_entry(nacl, &tpg->acl_node_list, acl_list) {
 
 		mutex_lock(&nacl->lun_entry_mutex);
-		hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link) {
+		hlist_for_each_entry_rcu(deve, &nacl->lun_entry_hlist, link,
+					 lun_entry_mutex_held()) {
 			struct se_lun *tmp_lun = rcu_dereference_check(deve->se_lun,
-					lockdep_is_held(&nacl->lun_entry_mutex));
+							lun_entry_mutex_held());
 
 			if (lun != tmp_lun)
 				continue;
-- 
2.24.1

