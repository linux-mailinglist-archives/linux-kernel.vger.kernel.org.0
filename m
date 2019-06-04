Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDE352ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 01:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfFDXAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 19:00:22 -0400
Received: from sed198n136.SEDSystems.ca ([198.169.180.136]:29140 "EHLO
        sed198n136.sedsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfFDXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:00:22 -0400
X-Greylist: delayed 1464 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 19:00:21 EDT
Received: from barney.sedsystems.ca (barney [198.169.180.121])
        by sed198n136.sedsystems.ca  with ESMTP id x54MZx7q011370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jun 2019 16:35:59 -0600 (CST)
Received: from SED.RFC1918.192.168.sedsystems.ca (eng1n65.eng.sedsystems.ca [172.21.1.65])
        by barney.sedsystems.ca (8.14.7/8.14.4) with ESMTP id x54MZtKq036309
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Jun 2019 16:35:58 -0600
From:   Robert Hancock <hancock@sedsystems.ca>
To:     linux-kernel@vger.kernel.org
Cc:     lee.jones@linaro.org, Robert Hancock <hancock@sedsystems.ca>
Subject: [PATCH 2/2] mfd: core: Set fwnode for created devices
Date:   Tue,  4 Jun 2019 16:35:43 -0600
Message-Id: <1559687743-31879-3-git-send-email-hancock@sedsystems.ca>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
References: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
X-Scanned-By: MIMEDefang 2.64 on 198.169.180.136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic for setting the of_node on devices created by mfd did not set
the fwnode pointer to match, which caused fwnode-based APIs to
malfunction on these devices since the fwnode pointer was null. Fix
this.

Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
---
 drivers/mfd/mfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 74bc895..228163c 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -182,6 +182,7 @@ static int mfd_add_device(struct device *parent, int id,
 			     !strcmp(cell->of_full_name,
 				     of_node_full_name(np)))) {
 				pdev->dev.of_node = np;
+				pdev->dev.fwnode = &np->fwnode;
 				break;
 			}
 		}
-- 
1.8.3.1

