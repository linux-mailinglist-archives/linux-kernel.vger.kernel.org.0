Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD401619CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 19:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgBQSgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 13:36:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37737 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727601AbgBQSgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581964613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iYn/WApkZknuw8/6G/scxzQls76dRRJn9vUap7y4zFM=;
        b=iA6UYFahqLI60BfDIsXilgbE/aK625m5SaS2BWfSOk3Vuc68YH87+8a56bnjWyDlCSYg3y
        kJAnClsdADzLoeS/VS/nQmkx+NLtcrWOEeYhu8nqOKrJYizk9PEfFyphJpOEefl+F+JEO8
        3NswkJfdDnz91sshLRPRdIeCaZlxPHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44--n7DHrG4OeeiK6e-41apXQ-1; Mon, 17 Feb 2020 13:36:45 -0500
X-MC-Unique: -n7DHrG4OeeiK6e-41apXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 999F8107ACC4;
        Mon, 17 Feb 2020 18:36:44 +0000 (UTC)
Received: from lithium.redhat.com (ovpn-204-63.brq.redhat.com [10.40.204.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BCB285735;
        Mon, 17 Feb 2020 18:36:42 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     rcu@vger.kernel.org, ebiederm@xmission.com, paulmck@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2] ipc: use a work queue to free_ipc
Date:   Mon, 17 Feb 2020 19:36:27 +0100
Message-Id: <20200217183627.4099690-1-gscrivan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it avoids blocking on synchronize_rcu() in kern_umount().

the code:

\#define _GNU_SOURCE
\#include <sched.h>
\#include <error.h>
\#include <errno.h>
\#include <stdlib.h>
int main()
{
  int i;
  for (i  =3D 0; i < 1000; i++)
    if (unshare (CLONE_NEWIPC) < 0)
      error (EXIT_FAILURE, errno, "unshare");
}

gets from:

	Command being timed: "./ipc-namespace"
	User time (seconds): 0.00
	System time (seconds): 0.06
	Percent of CPU this job got: 0%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:08.05

to:

	Command being timed: "./ipc-namespace"
	User time (seconds): 0.00
	System time (seconds): 0.02
	Percent of CPU this job got: 96%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.03

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
v2:
- comment added in free_ipc_ns()

v1: https://lkml.org/lkml/2020/2/11/692

 include/linux/ipc_namespace.h |  2 ++
 ipc/namespace.c               | 20 ++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.=
h
index c309f43bde45..a06a78c67f19 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -68,6 +68,8 @@ struct ipc_namespace {
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
=20
+	struct llist_node mnt_llist;
+
 	struct ns_common ns;
 } __randomize_layout;
=20
diff --git a/ipc/namespace.c b/ipc/namespace.c
index b3ca1476ca51..7b9922244891 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -117,6 +117,10 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_=
ids *ids,
=20
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
+	/* mq_put_mnt() waits for a grace period as kern_unmount()
+	 * uses synchronize_rcu().
+	 */
+	mq_put_mnt(ns);
 	sem_exit_ns(ns);
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
@@ -127,6 +131,17 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	kfree(ns);
 }
=20
+static LLIST_HEAD(free_ipc_list);
+static void free_ipc(struct work_struct *unused)
+{
+	struct llist_node *node =3D llist_del_all(&free_ipc_list);
+	struct ipc_namespace *n, *t;
+
+	llist_for_each_entry_safe(n, t, node, mnt_llist)
+		free_ipc_ns(n);
+}
+static DECLARE_WORK(free_ipc_work, free_ipc);
+
 /*
  * put_ipc_ns - drop a reference to an ipc namespace.
  * @ns: the namespace to put
@@ -148,8 +163,9 @@ void put_ipc_ns(struct ipc_namespace *ns)
 	if (refcount_dec_and_lock(&ns->count, &mq_lock)) {
 		mq_clear_sbinfo(ns);
 		spin_unlock(&mq_lock);
-		mq_put_mnt(ns);
-		free_ipc_ns(ns);
+
+		if (llist_add(&ns->mnt_llist, &free_ipc_list))
+			schedule_work(&free_ipc_work);
 	}
 }
=20
--=20
2.24.1

