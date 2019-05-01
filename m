Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F0010B04
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfEAQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 12:15:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfEAQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cC6LJAycF0WEXN1PiWNfS+TYLowm8sPMN91Aj88qDwo=; b=XMp1By9pBXIazfy6Hr5U4dnsqH
        oT+8Ype/+4B+jECj/8pA+ARGFcm4khCv4XGAzxQD21x4c1PsBCBi/X4Z2gJJiMV51EbuURFSZ0N4A
        fmAWGhtPmOgWjbH7DUCyXMq3OP8646AntV2HGVQ6zgAtRUosYs/ug3WRUGe6nICZYcnB545jWKkwJ
        h7e5GkijeNRpAfhKGnMDDMTX9J+LCB60hMsslrpQkNbq2eua2qgNFQq8oKQPDUL5DTQaGvq9xIvlo
        WPjK2+vhjgI//AAgJbVyvRct3MtbkKqlmT9ORMIeETlYZHkL6rboggzADjcgHdVyJDrhU7zjsWu6F
        3/W/Nk1Q==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrtP-0005hN-FZ; Wed, 01 May 2019 16:15:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>, Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chriosstoph Hellwig <hch@losst.de>
Subject: [PATCH 24/24] osst: add a SPDX tag to osst.c
Date:   Wed,  1 May 2019 12:14:17 -0400
Message-Id: <20190501161417.32592-25-hch@lst.de>
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

osst.c is the only osst file missing licensing information.  Add a
GPLv2 tag for the default kernel license.

Signed-off-by: Chriosstoph Hellwig <hch@losst.de>
---
 drivers/scsi/osst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
index be3c73ebbfde..fe4f0e7d6359 100644
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
   SCSI Tape Driver for Linux version 1.1 and newer. See the accompanying
   file Documentation/scsi/st.txt for more information.
-- 
2.20.1

