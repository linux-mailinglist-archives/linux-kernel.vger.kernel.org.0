Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11048375E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfFFOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 10:00:14 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:48104 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728669AbfFFOAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:00:11 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3A3BFC0BA1;
        Thu,  6 Jun 2019 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559829590; bh=KvCwUMSc/ssxfCEfFG115Dj1KyU+yGJ4OOCQiO1T/DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OvWqhG7DC9kXTDHWRl+4vDmhLV4ibiqfp+y2yR8GqyZxR/1NvCUiXNvYYiwcG8RQS
         d//2ochfyTZEAkrqqtXH0p+5EZxHOyKHzKiyD09EYrZybMkmIUMxVxRlzCY6xqcj1H
         m19wSlHmuO6Grg5rHekpX0v9aXffekWNoEAgb7aogeAuatF6q4VpzuxiyMY0evC3yk
         Cl9t5mX888hhdRhNjkoh5GfND26J67g6H3WP0VzTjkRbnmbnZuntMIwjIEkE43OZF4
         RWLeMlW7L/1jQOtM0OFZvqLgb1JMMSVRNzUxSo4/2XuVsVPlf4O0Id7TrQbgnxcjt4
         mwa8e00H1m3Hg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id E7E1FA005D;
        Thu,  6 Jun 2019 14:00:09 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id D6F4D3F6D4;
        Thu,  6 Jun 2019 16:00:09 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Vitor Soares <Vitor.Soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] i3c: dw: add limited bus mode support
Date:   Thu,  6 Jun 2019 16:00:03 +0200
Message-Id: <5d0fe045c9a557f24f76a01d1066de2831b8489f.1559821228.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559821227.git.vitor.soares@synopsys.com>
References: <cover.1559821227.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1559821227.git.vitor.soares@synopsys.com>
References: <cover.1559821227.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add limited bus mode support for DesignWare i3c master

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
Changes in v2:
  None

 drivers/i3c/master/dw-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1d83c97..9612d93 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -599,6 +599,7 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
+	case I3C_BUS_MODE_MIXED_LIMITED:
 		ret = dw_i2c_clk_cfg(master);
 		if (ret)
 			return ret;
-- 
2.7.4

