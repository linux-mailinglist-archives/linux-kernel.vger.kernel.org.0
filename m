Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5F10B09
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 18:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEAQQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 12:16:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfEAQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=73fVpgtKFRyvxsqOU0LWpDO/to7iwBP7xuc/fGa1KTU=; b=pHaC0WTpybCsBSssf2N90H0nle
        qYrZWxwoKoRngfSIx7xfqIhUOF/bgjis1ONXngq1sQfNB7tfmsgHuRR7cHyEACEavPmFVpK5ofjzs
        y5NrwFRHH33gMRQ14eDMdHYWMVikc5wiqo76Kh1m+kM9+mHvwREO1eOrQG8OMhjoSl89YwUDkaKx4
        Jc+ld5XbzUni/+yX26yKyrUSBQLhz60zi87iPi5/yf+3FI8qxsmb63hHDNnHnT/csr1f4H6Od3iaF
        PggjCwCYCqYqGTRoMMAUDr8O9JerG5MJX3rby86kQYdVveoqlhuQf9CrbZKHoyly5nhuJtEFfN+Ci
        W7H+ohLA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrtG-0005g5-Bu; Wed, 01 May 2019 16:15:26 +0000
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
Subject: [PATCH 19/24] sd: switch remaining files to SPDX tags
Date:   Wed,  1 May 2019 12:14:12 -0400
Message-Id: <20190501161417.32592-20-hch@lst.de>
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

Use the the GPLv2 SPDX tag instead of verbose boilerplate text.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd_dif.c | 16 +---------------
 drivers/scsi/sd_zbc.c | 16 +---------------
 2 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/sd_dif.c b/drivers/scsi/sd_dif.c
index db72c82486e3..93ac1e4cab73 100644
--- a/drivers/scsi/sd_dif.c
+++ b/drivers/scsi/sd_dif.c
@@ -1,23 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * sd_dif.c - SCSI Data Integrity Field
  *
  * Copyright (C) 2007, 2008 Oracle Corporation
  * Written by: Martin K. Petersen <martin.petersen@oracle.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; see the file COPYING.  If not, write to
- * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
- * USA.
- *
  */
 
 #include <linux/blkdev.h>
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index a340af797a85..d5e83cfa4d74 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SCSI Zoned Block commands
  *
@@ -5,21 +6,6 @@
  * Written by: Hannes Reinecke <hare@suse.de>
  * Modified by: Damien Le Moal <damien.lemoal@hgst.com>
  * Modified by: Shaun Tancheff <shaun.tancheff@seagate.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; see the file COPYING.  If not, write to
- * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
- * USA.
- *
  */
 
 #include <linux/blkdev.h>
-- 
2.20.1

