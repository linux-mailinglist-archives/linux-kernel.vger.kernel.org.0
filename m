Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C578B86B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbfISWOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 18:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393780AbfISWOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:14:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 232F121924;
        Thu, 19 Sep 2019 22:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931279;
        bh=6fqBZnqQpxCIse9H8W99MnTop6fF0NhNRxtQG6Zy2QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erVwh+UYUdXyMDrXSt5/OSxu+l/+2TTX8d65c77V14MwSO/vm9Hq3Yy9nfGZ55P+F
         c0BP2ou/GdQUOgPImYGsmvP7Vd6HEmm33+GbwzC9C0QQcpDeo4p5PvmUXNE+aJ79jD
         7hweb7Qz2OR1CW/zm+Iycgy+wdU0H3HJsuutlmvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 41/79] qed: Add cleanup in qed_slowpath_start()
Date:   Fri, 20 Sep 2019 00:03:26 +0200
Message-Id: <20190919214811.329022256@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit de0e4fd2f07ce3bbdb69dfb8d9426b7227451b69 ]

If qed_mcp_send_drv_version() fails, no cleanup is executed, leading to
memory leaks. To fix this issue, introduce the label 'err4' to perform the
cleanup work before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Acked-by: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index cf3b0e3dc350c..637687b766ff0 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1150,7 +1150,7 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 					      &drv_version);
 		if (rc) {
 			DP_NOTICE(cdev, "Failed sending drv version command\n");
-			return rc;
+			goto err4;
 		}
 	}
 
@@ -1158,6 +1158,8 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 
 	return 0;
 
+err4:
+	qed_ll2_dealloc_if(cdev);
 err3:
 	qed_hw_stop(cdev);
 err2:
-- 
2.20.1



