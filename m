Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44EEC6F271
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfGUJ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 05:56:58 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:38505 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfGUJ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 05:56:57 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d33 with ME
        id fMwr2000B4n7eLC03MwrcU; Sun, 21 Jul 2019 11:56:53 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 11:56:53 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dennis@kernel.org, tj@kernel.org, cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] percpu: Fix a typo
Date:   Sun, 21 Jul 2019 11:56:33 +0200
Message-Id: <20190721095633.10979-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/perpcu/percpu/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 9821241fdede..febf7c7c888e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2220,7 +2220,7 @@ static void pcpu_dump_alloc_info(const char *lvl,
  * @base_addr: mapped address
  *
  * Initialize the first percpu chunk which contains the kernel static
- * perpcu area.  This function is to be called from arch percpu area
+ * percpu area.  This function is to be called from arch percpu area
  * setup path.
  *
  * @ai contains all information necessary to initialize the first
-- 
2.20.1

