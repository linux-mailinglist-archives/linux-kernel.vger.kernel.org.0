Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B69394B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 20:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfFGSxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 14:53:17 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.178]:25064 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728736AbfFGSxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:53:17 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 5EDC8F4F9E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2019 13:53:16 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZJzIhtsmEdnCeZJzIhWy95; Fri, 07 Jun 2019 13:53:16 -0500
X-Authority-Reason: nr=8
Received: from [189.250.134.24] (port=47362 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hZJzH-002Xxo-A5; Fri, 07 Jun 2019 13:53:15 -0500
Date:   Fri, 7 Jun 2019 13:53:14 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] remoteproc: Use struct_size() helper
Message-ID: <20190607185314.GA15771@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.134.24
X-Source-L: No
X-Exim-ID: 1hZJzH-002Xxo-A5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.134.24]:47362
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct resource_table {
	...
        u32 offset[0];
} __packed;

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

table->num * sizeof(table->offset[0]) + sizeof(struct resource_table)

with:

struct_size(table, offset, table->num)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index 215a4400f21e..606aae166eba 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -247,8 +247,7 @@ find_table(struct device *dev, struct elf32_hdr *ehdr, size_t fw_size)
 		}
 
 		/* make sure the offsets array isn't truncated */
-		if (table->num * sizeof(table->offset[0]) +
-				sizeof(struct resource_table) > size) {
+		if (struct_size(table, offset, table->num) > size) {
 			dev_err(dev, "resource table incomplete\n");
 			return NULL;
 		}
-- 
2.21.0

