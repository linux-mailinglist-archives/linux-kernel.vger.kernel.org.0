Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 276A116BEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 11:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgBYKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 05:42:36 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:33380 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729417AbgBYKmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:42:36 -0500
Received: from [109.168.11.45] (port=34904 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1j6Xfd-00B8cq-Ha; Tue, 25 Feb 2020 11:42:33 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: [DT-OVERLAY PATCH] of: overlay: print the offending node name on fixup failure
Date:   Tue, 25 Feb 2020 11:42:23 +0100
Message-Id: <20200225104223.30891-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a DT overlay has a fixup node that is not present in the base DT
__symbols__, this error is printed:

  OF: resolver: overlay phandle fixup failed: -22
  create_overlay: Failed to create overlay (err=-22)

which does not help much in finding the node that caused the problem.

Add a debug print with the name of the fixup node that caused the
error. The new output is:

  OF: resolver: node gpio9 not found in base DT, fixup failed
  OF: resolver: overlay phandle fixup failed: -22
  create_overlay: Failed to create overlay (err=-22)

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

NOTE: this patch is not for mainline!

It applies on top of the runtime overlay patches at
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git on
branch topic/overlays, currently based on v5.6-rc1. This looked like the
most up-to-date version of the overlay patches. Should there be a better
place, please let me know.
---
 drivers/of/resolver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 83c766233181..ade817407b78 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -321,8 +321,11 @@ int of_resolve_phandles(struct device_node *overlay)
 
 		err = of_property_read_string(tree_symbols,
 				prop->name, &refpath);
-		if (err)
+		if (err) {
+			pr_err("node %s not found in base DT, fixup failed",
+			       prop->name);
 			goto out;
+		}
 
 		refnode = of_find_node_by_path(refpath);
 		if (!refnode) {
-- 
2.25.0

