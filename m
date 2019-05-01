Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C227210B01
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 18:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfEAQPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 12:15:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfEAQPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AgyYCrdyHA/DUWKViXqZytoa4N1LG8lnnVDKFRW9Xh8=; b=VwC7sAiO0fCRhbS9CcMMcwFhvn
        0Yl7LHtShEYOMpXkRsQFkjFSj/rEFev734bYgeucMXxU9Gk0ib/hPWqZB4TwZXy/qL9/9VufxKcjy
        uU6A2s7srLzVXGaK8nD4gfpSRvBGpYrf2TQiLGwXYei+jgqUbFNkqEM4govk4lg3y6Jb5JY0TELzB
        JVa1lFf/eRX6oGxxeL+tTEZLeH9DztU5NyP5UgdxXpBQJ0N3pDtwZgziorwGdORfFUGxBKIXlyoEO
        sXQTy3o0JobIMpZa37ItFVZ4XjImglq0jNVTelTFTyg55LIfCueDrRLgU8bUGedMUkrTzChWZxhIj
        o4syWuxA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrtK-0005gZ-3d; Wed, 01 May 2019 16:15:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>, Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 21/24] sg: switch to SPDX tags
Date:   Wed,  1 May 2019 12:14:14 -0400
Message-Id: <20190501161417.32592-22-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190501161417.32592-1-hch@lst.de>
References: <20190501161417.32592-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the the GPLv2+ SPDX tag instead of verbose boilerplate text.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sg.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index d3f15319b9b3..bcdc28e5ede7 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  History:
  *  Started: Aug 9 by Lawrence Foard (entropy@world.std.com),
@@ -8,12 +9,6 @@
  *        Copyright (C) 1992 Lawrence Foard
  * Version 2 and 3 extensions to driver:
  *        Copyright (C) 1998 - 2014 Douglas Gilbert
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
  */
 
 static int sg_version_num = 30536;	/* 2 digits for each component */
-- 
2.20.1

