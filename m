Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 469791C124
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 06:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfENEBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 00:01:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37040 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENEBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 00:01:52 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id D18612074A35; Mon, 13 May 2019 21:01:51 -0700 (PDT)
From:   longli@linuxonhyperv.com
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH 1/2] cifs:smbd When reconnecting to server, call smbd_destroy() after all MIDs have been called
Date:   Mon, 13 May 2019 21:01:28 -0700
Message-Id: <1557806489-11272-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: longli@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

commit 214bab448476 ("cifs: Call MID callback before destroying transport")
assumes that the MID callback should not take srv_mutex, this may not always
be true. SMB Direct requires the MID callback completed before calling
transport so all pending memory registration can be freed. So restore the
orignal calling sequence so TCP transport will use the same code, but moving
smbd_destroy() after all MID has been called.

fixes: 214bab448476 ("cifs: Call MID callback before destroying transport")
Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/connect.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 084756cfdaee..0b3ac8b76d18 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -528,6 +528,21 @@ cifs_reconnect(struct TCP_Server_Info *server)
 	/* do not want to be sending data on a socket we are freeing */
 	cifs_dbg(FYI, "%s: tearing down socket\n", __func__);
 	mutex_lock(&server->srv_mutex);
+	if (server->ssocket) {
+		cifs_dbg(FYI, "State: 0x%x Flags: 0x%lx\n",
+			 server->ssocket->state, server->ssocket->flags);
+		kernel_sock_shutdown(server->ssocket, SHUT_WR);
+		cifs_dbg(FYI, "Post shutdown state: 0x%x Flags: 0x%lx\n",
+			 server->ssocket->state, server->ssocket->flags);
+		sock_release(server->ssocket);
+		server->ssocket = NULL;
+	}
+	server->sequence_number = 0;
+	server->session_estab = false;
+	kfree(server->session_key.response);
+	server->session_key.response = NULL;
+	server->session_key.len = 0;
+	server->lstrp = jiffies;
 
 	/* mark submitted MIDs for retry and issue callback */
 	INIT_LIST_HEAD(&retry_list);
@@ -540,6 +555,7 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		list_move(&mid_entry->qhead, &retry_list);
 	}
 	spin_unlock(&GlobalMid_Lock);
+	mutex_unlock(&server->srv_mutex);
 
 	cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
 	list_for_each_safe(tmp, tmp2, &retry_list) {
@@ -548,24 +564,11 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		mid_entry->callback(mid_entry);
 	}
 
-	if (server->ssocket) {
-		cifs_dbg(FYI, "State: 0x%x Flags: 0x%lx\n",
-			 server->ssocket->state, server->ssocket->flags);
-		kernel_sock_shutdown(server->ssocket, SHUT_WR);
-		cifs_dbg(FYI, "Post shutdown state: 0x%x Flags: 0x%lx\n",
-			 server->ssocket->state, server->ssocket->flags);
-		sock_release(server->ssocket);
-		server->ssocket = NULL;
-	} else if (cifs_rdma_enabled(server))
+	if (cifs_rdma_enabled(server)) {
+		mutex_lock(&server->srv_mutex);
 		smbd_destroy(server);
-	server->sequence_number = 0;
-	server->session_estab = false;
-	kfree(server->session_key.response);
-	server->session_key.response = NULL;
-	server->session_key.len = 0;
-	server->lstrp = jiffies;
-
-	mutex_unlock(&server->srv_mutex);
+		mutex_unlock(&server->srv_mutex);
+	}
 
 	do {
 		try_to_freeze();
-- 
2.17.1

