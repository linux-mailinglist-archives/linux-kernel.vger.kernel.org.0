Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65E0E2F81D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 09:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfE3Hx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 03:53:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfE3Hx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:53:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07D0730001DD;
        Thu, 30 May 2019 07:53:58 +0000 (UTC)
Received: from rhel3.localdomain (ovpn-12-96.pek2.redhat.com [10.72.12.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 378E75DD74;
        Thu, 30 May 2019 07:53:52 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk, nbd@other.debian.org
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, atumball@redhat.com,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] nbd: no need to check all the connections one by one if all are dead
Date:   Thu, 30 May 2019 15:53:25 +0800
Message-Id: <20190530075325.123109-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 30 May 2019 07:53:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

If all connections are dead the live_connections should be already
set to 0. And set the nsock->fallback to -1 again if all connections
are dead.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 drivers/block/nbd.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 98be6ca..6da42aa 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -783,13 +783,16 @@ static int find_fallback(struct nbd_device *nbd, int index)
 		return new_index;
 	}
 
+	if (atomic_read(&config->live_connections) <= 0) {
+		dev_err_ratelimited(disk_to_dev(nbd->disk),
+				    "Dead connection, failed to find a fallback\n");
+		goto out;
+	}
+
 	if (fallback >= 0 && fallback < config->num_connections &&
-	    !config->socks[fallback]->dead)
+		!config->socks[fallback]->dead) {
 		return fallback;
-
-	if (nsock->fallback_index < 0 ||
-	    nsock->fallback_index >= config->num_connections ||
-	    config->socks[nsock->fallback_index]->dead) {
+	} else {
 		int i;
 		for (i = 0; i < config->num_connections; i++) {
 			if (i == index)
@@ -799,14 +802,10 @@ static int find_fallback(struct nbd_device *nbd, int index)
 				break;
 			}
 		}
-		nsock->fallback_index = new_index;
-		if (new_index < 0) {
-			dev_err_ratelimited(disk_to_dev(nbd->disk),
-					    "Dead connection, failed to find a fallback\n");
-			return new_index;
-		}
 	}
-	new_index = nsock->fallback_index;
+
+out:
+	nsock->fallback_index = new_index;
 	return new_index;
 }
 
-- 
1.8.3.1

