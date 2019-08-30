Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846F3A2DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 06:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfH3EKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 00:10:51 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42721 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbfH3EKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:10:50 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from parav@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 Aug 2019 07:10:47 +0300
Received: from sw-mtx-036.mtx.labs.mlnx (sw-mtx-036.mtx.labs.mlnx [10.12.150.149])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7U4AiDB010368;
        Fri, 30 Aug 2019 07:10:47 +0300
From:   Parav Pandit <parav@mellanox.com>
To:     linux-kernel@vger.kernel.org, jiri@mellanox.com
Cc:     Parav Pandit <parav@mellanox.com>
Subject: [PATCH internal net-next 2/2] devlink: Use switch-case instead of if-else
Date:   Thu, 29 Aug 2019 23:10:35 -0500
Message-Id: <20190830041035.60581-3-parav@mellanox.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190830041035.60581-1-parav@mellanox.com>
References: <20190830041035.60581-1-parav@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make core more readable with switch-case for various port flavours.

Signed-off-by: Parav Pandit <parav@mellanox.com>
---
 net/core/devlink.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index b7091329987a..6e52d639dac6 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -510,32 +510,37 @@ static int devlink_nl_port_attrs_put(struct sk_buff *msg,
 		return 0;
 	if (nla_put_u16(msg, DEVLINK_ATTR_PORT_FLAVOUR, attrs->flavour))
 		return -EMSGSIZE;
-	if (devlink_port->attrs.flavour == DEVLINK_PORT_FLAVOUR_PCI_PF) {
+	switch (devlink_port->attrs.flavour) {
+	case DEVLINK_PORT_FLAVOUR_PCI_PF:
 		if (nla_put_u16(msg, DEVLINK_ATTR_PORT_PCI_PF_NUMBER,
 				attrs->pci_pf.pf))
 			return -EMSGSIZE;
-	} else if (devlink_port->attrs.flavour == DEVLINK_PORT_FLAVOUR_PCI_VF) {
+		break;
+	case DEVLINK_PORT_FLAVOUR_PCI_VF:
 		if (nla_put_u16(msg, DEVLINK_ATTR_PORT_PCI_PF_NUMBER,
 				attrs->pci_vf.pf) ||
 		    nla_put_u16(msg, DEVLINK_ATTR_PORT_PCI_VF_NUMBER,
 				attrs->pci_vf.vf))
 			return -EMSGSIZE;
+		break;
+	case DEVLINK_PORT_FLAVOUR_PHYSICAL:
+	case DEVLINK_PORT_FLAVOUR_CPU:
+	case DEVLINK_PORT_FLAVOUR_DSA:
+		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_NUMBER,
+				attrs->phys.port_number))
+			return -EMSGSIZE;
+		if (!attrs->split)
+			return 0;
+		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_SPLIT_GROUP,
+				attrs->phys.port_number))
+			return -EMSGSIZE;
+		if (nla_put_u32(msg, DEVLINK_ATTR_PORT_SPLIT_SUBPORT_NUMBER,
+				attrs->phys.split_subport_number))
+			return -EMSGSIZE;
+		break;
+	default:
+		break;
 	}
-	if (devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_PHYSICAL &&
-	    devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_CPU &&
-	    devlink_port->attrs.flavour != DEVLINK_PORT_FLAVOUR_DSA)
-		return 0;
-	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_NUMBER,
-			attrs->phys.port_number))
-		return -EMSGSIZE;
-	if (!attrs->split)
-		return 0;
-	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_SPLIT_GROUP,
-			attrs->phys.port_number))
-		return -EMSGSIZE;
-	if (nla_put_u32(msg, DEVLINK_ATTR_PORT_SPLIT_SUBPORT_NUMBER,
-			attrs->phys.split_subport_number))
-		return -EMSGSIZE;
 	return 0;
 }
 
-- 
2.19.2

