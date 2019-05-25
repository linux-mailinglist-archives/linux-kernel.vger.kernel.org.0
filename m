Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5481A2A43D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 13:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfEYLtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 07:49:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51548 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbfEYLtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 07:49:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B4D5E6F2072E705EE811;
        Sat, 25 May 2019 19:49:44 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 25 May 2019 19:49:36 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] usb: dwc3: qcom: Use of_clk_get_parent_count()
Date:   Sat, 25 May 2019 19:58:08 +0800
Message-ID: <20190525115808.108142-1-wangkefeng.wang@huawei.com>
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

Use of_clk_get_parent_count() instead of open coding.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 184df4daa590..821f5179d7b6 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -446,8 +446,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		goto reset_assert;
 	}
 
-	ret = dwc3_qcom_clk_init(qcom, of_count_phandle_with_args(np,
-						"clocks", "#clock-cells"));
+	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
 	if (ret) {
 		dev_err(dev, "failed to get clocks\n");
 		goto reset_assert;
-- 
2.20.1

