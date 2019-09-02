Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94933A5B97
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 18:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfIBQ7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 12:59:02 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:42188 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfIBQ7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:59:01 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Sep 2019 12:59:01 EDT
Received: from archibald.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id A5989C72856;
        Mon,  2 Sep 2019 18:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1567442990;
        bh=oJKuoxU5eSUldooJbFfaeJ+aojy6A8Sdw5Wn6VneLAk=;
        h=From:To:Cc:Subject:Date:From;
        b=Gd/onljmlyWrNMZ7HsAz0c7k0fm+4N1i2XEmPvC3ppswLGreJpShCZdzv+uXc4VUe
         swTrTtMT+KrG7ANA0qWexJZGZ6Hgpin1D/rXeLfUlghQhveDibU/HOftsyuVjf4RAR
         UDeZ4GOtnuIe742XSrFrRWY2RuOCnmI+hUUCbf6E=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@linux.ibm.com>,
        zhaoyang <huangzhaoyang@gmail.com>
Subject: [PATCH] arch: arm: reuse addr variable in pfn_valid
Date:   Mon,  2 Sep 2019 18:46:22 +0200
Message-Id: <20190902164622.18593-1-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid calling __pfn_to_phys twice.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: zhaoyang <huangzhaoyang@gmail.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 arch/arm/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 98e17388a563..a5fe2bdc76de 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -179,7 +179,7 @@ int pfn_valid(unsigned long pfn)
 	if (__phys_to_pfn(addr) != pfn)
 		return 0;
 
-	return memblock_is_map_memory(__pfn_to_phys(pfn));
+	return memblock_is_map_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
-- 
2.23.0

