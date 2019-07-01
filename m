Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7041FC19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfEOVJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 17:09:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58088 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfEOVJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:09:17 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id BCBB520110AD; Wed, 15 May 2019 14:09:16 -0700 (PDT)
From:   longli@linuxonhyperv.com
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH 1/2] cifs: Don't match port on SMBDirect transport
Date:   Wed, 15 May 2019 14:09:04 -0700
Message-Id: <1557954545-17831-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: longli@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

SMBDirect manages its own ports in the transport layer, there is no need to
check the port to find a connection.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/connect.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 0b3ac8b76d18..8c4121da624e 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2446,6 +2446,10 @@ match_port(struct TCP_Server_Info *server, struct sockaddr *addr)
 {
 	__be16 port, *sport;
 
+	/* SMBDirect manages its own ports, don't match it here */
+	if (server->rdma)
+		return true;
+
 	switch (addr->sa_family) {
 	case AF_INET:
 		sport = &((struct sockaddr_in *) &server->dstaddr)->sin_port;
-- 
2.17.1

