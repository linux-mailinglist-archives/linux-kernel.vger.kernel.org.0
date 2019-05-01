Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1B410AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfEAQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 12:15:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfEAQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5DncLWmfQGv02tR863wEfmmFVjP6/uAldmRvmhszOvg=; b=ffNcogma9nVD2p87SWlfoBV+z6
        fpFrOEK+0g21e8+Ynmbw9lPkIPJgiJM73U4PHtq6DtW6bER3Wt9CF4g+CmMyl9LHHNlbDfdIJya/H
        TPReGOp9e+EetPXs1lLNrOE2lnh5faN3/V7r2l+VvD2if6xHx1hWnIYRbUG1z553fgbP6RrP3wZBu
        5AC83vvB4j6lHxRqb3H+/gdRdavYFolIc0jv+oFynKoMBHX5DZ01GiPOF0vLhEoJbEAH0MzKbb0yl
        LX3821VlvxRIzHfiSkT77gPNBVETMHZ19O+QT+gf0o8FWh6jTHN2c/P7g9m/0lhqwPjWB4R3M2Y88
        2IExCJTA==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLrtE-0005fk-KG; Wed, 01 May 2019 16:15:24 +0000
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
Subject: [PATCH 18/24] sd: add a SPDX tag to sd.c
Date:   Wed,  1 May 2019 12:14:11 -0400
Message-Id: <20190501161417.32592-19-hch@lst.de>
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

sd.c is the only sd file missing licensing information.  Add a
GPLv2 tag for the default kernel license.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2b2bc4b49d78..4852c2223359 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *      sd.c Copyright (C) 1992 Drew Eckhardt
  *           Copyright (C) 1993, 1994, 1995, 1999 Eric Youngdale
-- 
2.20.1

