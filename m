Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7B4FFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfD3Sne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 14:43:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfD3Sn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VtvqCpPMvaLealpqt8TqrRPmPafSLENaY7UnUfqCu+0=; b=WU//qThwkq7rkiG3xyscTZIews
        fYpo7se+Y6DNH9lih+zw0mu0XYs+JGn74zhpb0N7PpQUB8rW7Bwa9iHWe3rIKUVW02xVpylLPGUtt
        P1T3Ja2uJxs45rG8VQmtj7+HB9welsboYgp/2a10k2S/UKvGBWDDDoDHyAJZsLvxt+zVHYGTO/fZI
        luTUFsQFAYKQftZ1mPmvdk/R2Ls1xb5wNq0m+68XZ4ZX9kqrba8L8Tlr2v3sF9bV72+no4Uyj9Px4
        eVIe9OH6BCDJ+xlosHBgELqCsXh9ZztQCq+ylSCRUqn27zRJIMnixwvk+aw0Gx1Lon2wbFNhwqDPd
        4ZNmo6Sg==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLXiw-0000st-KY; Tue, 30 Apr 2019 18:43:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] block: add a SPDX tag to blk-mq-rdma.h
Date:   Tue, 30 Apr 2019 14:42:42 -0400
Message-Id: <20190430184243.23436-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430184243.23436-1-hch@lst.de>
References: <20190430184243.23436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file has no copyright notice, but was added as part of a commit
adding another file using the default kernel GPLv2 license.  Add
a matching SPDX tag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-mq-rdma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blk-mq-rdma.h b/include/linux/blk-mq-rdma.h
index 7b6ecf9ac4c3..5cc5f0f36218 100644
--- a/include/linux/blk-mq-rdma.h
+++ b/include/linux/blk-mq-rdma.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_BLK_MQ_RDMA_H
 #define _LINUX_BLK_MQ_RDMA_H
 
-- 
2.20.1

