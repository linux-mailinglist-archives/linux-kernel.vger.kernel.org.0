Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0419BA65
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 04:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbgDBCn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 22:43:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbgDBCn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:43:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4A6E4FDFE08292E57FF0;
        Thu,  2 Apr 2020 10:43:13 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 10:43:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] virtio-balloon: Make virtballoon_free_page_report static
Date:   Thu, 2 Apr 2020 10:43:02 +0800
Message-ID: <20200402024302.35192-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/virtio/virtio_balloon.c:168:5: warning:
 symbol 'virtballoon_free_page_report' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/virtio/virtio_balloon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 0ef16566c3f3..bc10f94718e3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -165,8 +165,9 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 
 }
 
+static
 int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
-				   struct scatterlist *sg, unsigned int nents)
+				 struct scatterlist *sg, unsigned int nents)
 {
 	struct virtio_balloon *vb =
 		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
-- 
2.17.1


