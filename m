Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825D5D40EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 15:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfJKNTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 09:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbfJKNTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:19:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBB832089F;
        Fri, 11 Oct 2019 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570799961;
        bh=dWjC/hvz/DtRoHtaFNCYUXiEfD7jlPKm02wix0EgDkc=;
        h=Date:From:To:Cc:Subject:From;
        b=vylaj/R46PJDjK435FpqvG+uMJS9sPSVhrfQ6UayWG1A0puhAGCZioWnvGPbJj7lu
         LVtOL3UFCtIoaENWJm0vr9z/XCW68ZFIPdPTYrVglQnv+DGWNLLIc+N1akjl4iwWad
         IswZiAoMJIfZdt9+kepNhkyTWs7xbxu9ppc98JtE=
Date:   Fri, 11 Oct 2019 15:19:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ntb: ntb_pingpong: no need to check the return value of
 debugfs calls
Message-ID: <20191011131919.GA1174815@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to check the return value of debugfs_create_atomic_t as
nothing happens with the error.  Also, the code will never return NULL,
so this check has never caught anything :)

Fix this by removing the check entirely.

Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/test/ntb_pingpong.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 65865e460ab8..04dd46647db3 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -354,13 +354,10 @@ static void pp_clear_ctx(struct pp_ctx *pp)
 static void pp_setup_dbgfs(struct pp_ctx *pp)
 {
 	struct pci_dev *pdev = pp->ntb->pdev;
-	void *ret;
 
 	pp->dbgfs_dir = debugfs_create_dir(pci_name(pdev), pp_dbgfs_topdir);
 
-	ret = debugfs_create_atomic_t("count", 0600, pp->dbgfs_dir, &pp->count);
-	if (!ret)
-		dev_warn(&pp->ntb->dev, "DebugFS unsupported\n");
+	debugfs_create_atomic_t("count", 0600, pp->dbgfs_dir, &pp->count);
 }
 
 static void pp_clear_dbgfs(struct pp_ctx *pp)
-- 
2.23.0

