Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0920E7502
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 16:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfJ1PZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 11:25:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37705 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfJ1PZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:25:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id u9so2369552pfn.4;
        Mon, 28 Oct 2019 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pL2Y/Napl6xRtES8uxsPO4Id7Om/+VG/4N+uJFv9jeU=;
        b=QngVd56bCF3awkXja0+4u23UGHljYZp+veoLXhE5fBAhNDlZ5j6rFPLuyU+XvJDSw2
         zPGZSxQPVvaofcptT9Lbw82nA65AhUnRhPXS9m6okpPS1KtCu4K9hwGMr1ZyLYin0jWZ
         cVpCL1DFlX3RHKvnes+Q7FwrF+zhr3foaTgkhk4zSO1SeNYEdGHA1vrSVFAjQ3FY3Et8
         8dVQY9SIEsovfoZzmG6s1wGr4Bd1YTzddnVkJcsekfggOEgttJjw73U+udEO01qPR3gF
         +xwUKIgkioQY0UHjs98IDi+COfScDwNQbxak7mpISHPPqETOt/3jxW71U6UnzUgQ1mod
         N3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pL2Y/Napl6xRtES8uxsPO4Id7Om/+VG/4N+uJFv9jeU=;
        b=MvSh/CropdxZQ/BxBkzsFm+AdPQc4Ji5ADg2r6RfG7ya4RYnw5hWGw+0yCc6SUbyzh
         1E5U3qCVy7a/HXVu9shZ0T4QjffppeQjyjA0i6jBHaLKpXPHe3484vn3Ql7m0imaEa7s
         DJGJK3k9lelnCSwNN395Q+71OASjvbZb9XioxDDqKxB+JBDzuF7ZtW7l2gFQ1BALQ0Yh
         3+dehGYUd8FAkrf1ke3a9VKdajF+uXIoc43OqYOtNjaeZdynwIZ31TbS59dwIIvFL0lP
         Nn5DZ1uphu7vCbtotqWuqk95Z7r5YzabpquM52rEjmk/Fc9vrKINdKFoNOt0wHEn2/2b
         byHA==
X-Gm-Message-State: APjAAAXa9DNnqVTpFmeCpitjSqcGhENqIpZRaRfwA2MwR8bjfiajeuFe
        w0OpGQA9piSg8jm87dEkqCg=
X-Google-Smtp-Source: APXvYqxouyzNm6f/ekIsibuoJxCA9z/lYenaWWg2c48z768Wjkey77dRgkBqRfYg4UMU9OoMmENmkA==
X-Received: by 2002:a17:90a:4804:: with SMTP id a4mr693067pjh.102.1572276300287;
        Mon, 28 Oct 2019 08:25:00 -0700 (PDT)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:51e:687:393e:2dcf:24de:b4fb])
        by smtp.gmail.com with ESMTPSA id j25sm10691763pfi.113.2019.10.28.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 08:24:59 -0700 (PDT)
From:   madhuparnabhowmik04@gmail.com
To:     paulmck@kernel.org, joel@joelfernandes.org, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 2/2] Documentation: RCU: Converted arrayRCU.txt to arrayRCU.rst.
Date:   Mon, 28 Oct 2019 20:54:49 +0530
Message-Id: <20191028152449.27264-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch converts arrayRCU from txt to rst format.
arrayRCU.rst is also added in the index.rst file.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 .../RCU/{arrayRCU.txt => arrayRCU.rst}         | 18 ++++++++++++++----
 Documentation/RCU/index.rst                    |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)
 rename Documentation/RCU/{arrayRCU.txt => arrayRCU.rst} (91%)

diff --git a/Documentation/RCU/arrayRCU.txt b/Documentation/RCU/arrayRCU.rst
similarity index 91%
rename from Documentation/RCU/arrayRCU.txt
rename to Documentation/RCU/arrayRCU.rst
index f05a9afb2c39..c8a26f7b2577 100644
--- a/Documentation/RCU/arrayRCU.txt
+++ b/Documentation/RCU/arrayRCU.rst
@@ -1,4 +1,7 @@
+.. _array_rcu_doc:
+
 Using RCU to Protect Read-Mostly Arrays
+=======================================
 
 
 Although RCU is more commonly used to protect linked lists, it can
@@ -26,6 +29,7 @@ described in the following sections.
 
 
 Situation 1: Hash Tables
+------------------------
 
 Hash tables are often implemented as an array, where each array entry
 has a linked-list hash chain.  Each hash chain can be protected by RCU
@@ -34,6 +38,7 @@ to other array-of-list situations, such as radix trees.
 
 
 Situation 2: Static Arrays
+--------------------------
 
 Static arrays, where the data (rather than a pointer to the data) is
 located in each array element, and where the array is never resized,
@@ -41,11 +46,14 @@ have not been used with RCU.  Rik van Riel recommends using seqlock in
 this situation, which would also have minimal read-side overhead as long
 as updates are rare.
 
-Quick Quiz:  Why is it so important that updates be rare when
-	     using seqlock?
+Quick Quiz:
+		Why is it so important that updates be rare when using seqlock?
+
+:ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
 
 
 Situation 3: Resizeable Arrays
+------------------------------
 
 Use of RCU for resizeable arrays is demonstrated by the grow_ary()
 function formerly used by the System V IPC code.  The array is used
@@ -60,7 +68,7 @@ the remainder of the new, updates the ids->entries pointer to point to
 the new array, and invokes ipc_rcu_putref() to free up the old array.
 Note that rcu_assign_pointer() is used to update the ids->entries pointer,
 which includes any memory barriers required on whatever architecture
-you are running on.
+you are running on.::
 
 	static int grow_ary(struct ipc_ids* ids, int newsize)
 	{
@@ -112,7 +120,7 @@ a simple check suffices.  The pointer to the structure corresponding
 to the desired IPC object is placed in "out", with NULL indicating
 a non-existent entry.  After acquiring "out->lock", the "out->deleted"
 flag indicates whether the IPC object is in the process of being
-deleted, and, if not, the pointer is returned.
+deleted, and, if not, the pointer is returned.::
 
 	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
 	{
@@ -144,8 +152,10 @@ deleted, and, if not, the pointer is returned.
 		return out;
 	}
 
+.. _answer_quick_quiz_seqlock:
 
 Answer to Quick Quiz:
+	Why is it so important that updates be rare when using seqlock?
 
 	The reason that it is important that updates be rare when
 	using seqlock is that frequent updates can livelock readers.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 340a9725676c..c4586602e7e2 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -7,6 +7,7 @@ RCU concepts
 .. toctree::
    :maxdepth: 1
 
+   arrayRCU
    rcu
    listRCU
    UP
-- 
2.17.1

