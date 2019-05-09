Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8A5018369
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 03:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfEIBzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 21:55:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfEIBzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:55:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9797352B6074DAB37541;
        Thu,  9 May 2019 09:55:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 9 May 2019 09:55:39 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] iio: dummy_evgen: check iio_evgen in iio_dummy_evgen_free()
Date:   Thu, 9 May 2019 10:04:47 +0800
Message-ID: <20190509020447.20243-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if iio_dummy_evgen_create() fails, iio_evgen should be NULL, when call
iio_evgen_release() to cleanup, it throws some warning and could cause
double free.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/iio/dummy/iio_dummy_evgen.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index c6033e341963..2327b5f52086 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -58,6 +58,7 @@ static int iio_dummy_evgen_create(void)
 	ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
 	if (ret < 0) {
 		kfree(iio_evgen);
+		iio_evgen = NULL;
 		return ret;
 	}
 
@@ -118,6 +119,9 @@ EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_regs);
 
 static void iio_dummy_evgen_free(void)
 {
+	if (!iio_evgen)
+		return;
+
 	irq_sim_fini(&iio_evgen->irq_sim);
 	kfree(iio_evgen);
 }
-- 
2.20.1

