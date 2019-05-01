Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C37A010AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 18:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfEAQPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 12:15:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfEAQPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kqkRyqJ2EE6kG6MIQJuCBicRKsHNMcWcqBqw8JwJ1OU=; b=aeltI4ssNOB5S4aMVag+/jceFU
        EY2iVwJBprXjYckIAr1Apm1jLfRlEyIMhkYrG42gpDt63BwAngeWIu7ROh1J8rvpECXCW0OVwtcy3
        SFda+0B9LxJ6/w1mMTGZ39VK7FKBwp0VLVvd5xD+y+25Evjl3a0h343yJhuQQfoy/pLxpn/ulNeUU
        LnkJUyoccXFDDcYnfCv2Cvf90j6RfwEuXo+5g50A6u9KZ8TannGELRPS0KnHnyL10rrmttG8wXk+Y
        QILmB+pu4E8BZI/q0pwZ38PniGXvN5/obkM+6wMz+EyBIfbofIKbPBuaCt9ULoxK08UAQnPb1ZJnX
        4sB6x47A==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrsw-0004zf-Gz; Wed, 01 May 2019 16:15:06 +0000
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
Subject: [PATCH 08/24] scsi_transport_sas: switch to SPDX tags
Date:   Wed,  1 May 2019 12:14:01 -0400
Message-Id: <20190501161417.32592-9-hch@lst.de>
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

Use the the GPLv2 SPDX tag instead of a free form blurb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_transport_sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 60f1a81d2034..fbfe01b06eb3 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -1,6 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2005-2006 Dell Inc.
- *	Released under GPL v2.
  *
  * Serial Attached SCSI (SAS) transport class.
  *
-- 
2.20.1

