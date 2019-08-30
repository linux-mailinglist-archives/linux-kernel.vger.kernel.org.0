Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885EDA2DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfH3EKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 00:10:52 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42718 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbfH3EKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:10:50 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 Aug 2019 07:10:46 +0300
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7U4AiDA010368;
        Fri, 30 Aug 2019 07:10:45 +0300
From:   Parav Pandit <parav@mellanox.com>
To:     linux-kernel@vger.kernel.org, jiri@mellanox.com
Cc:     Parav Pandit <parav@mellanox.com>
Subject: [PATCH internal net-next 1/2] devlink: Make port index data type as unsigned int
Date:   Thu, 29 Aug 2019 23:10:34 -0500
Message-Id: <20190830041035.60581-2-parav@mellanox.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190830041035.60581-1-parav@mellanox.com>
References: <20190830041035.60581-1-parav@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devlink port index attribute is returned to users as u32 through
netlink response.
Change index data type from 'unsigned' to 'unsigned int' to avoid any
size ambiguity and to avoid below checkpatch.pl warning.

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
81: FILE: include/net/devlink.h:81:
+       unsigned index;

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 include/net/devlink.h | 2 +-
 net/core/devlink.c    | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 7f43c48f54cd..13523b0a0642 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -75,7 +75,7 @@ struct devlink_port {
 	struct list_head list;
 	struct list_head param_list;
 	struct devlink *devlink;
-	unsigned index;
+	unsigned int index;
 	bool registered;
 	spinlock_t type_lock; /* Protects type and type_dev
 			       * pointer consistency.
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 650f36379203..b7091329987a 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -136,7 +136,7 @@ static struct devlink *devlink_get_from_info(struct genl_info *info)
 }
 
 static struct devlink_port *devlink_port_get_by_index(struct devlink *devlink,
-						      int port_index)
+						      unsigned int port_index)
 {
 	struct devlink_port *devlink_port;
 
@@ -147,7 +147,8 @@ static struct devlink_port *devlink_port_get_by_index(struct devlink *devlink,
 	return NULL;
 }
 
-static bool devlink_port_index_exists(struct devlink *devlink, int port_index)
+static bool devlink_port_index_exists(struct devlink *devlink,
+				      unsigned int port_index)
 {
 	return devlink_port_get_by_index(devlink, port_index);
 }
-- 
2.19.2

