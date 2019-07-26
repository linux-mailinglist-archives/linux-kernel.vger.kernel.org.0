Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1A76495
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 13:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfGZLbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 07:31:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44918 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:31:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hqyRz-0005S7-Dq; Fri, 26 Jul 2019 11:31:51 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] intel_th: msu: fix overflow in shift of an unsigned int
Date:   Fri, 26 Jul 2019 12:31:51 +0100
Message-Id: <20190726113151.8967-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The shift of the unsigned int win->nr_blocks by PAGE_SHIFT may
potentially overflow. Note that the intended return of this shift
is expected to be a size_t however the shift is being performed as
an unsigned int.  Fix this by casting win->nr_blocks to a size_t
before performing the shift.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 615c164da0eb ("intel_th: msu: Introduce buffer interface")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index fc9f15f36ad4..4892ac446c01 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -327,7 +327,7 @@ static size_t msc_win_total_sz(struct msc_window *win)
 		struct msc_block_desc *bdesc = sg_virt(sg);
 
 		if (msc_block_wrapped(bdesc))
-			return win->nr_blocks << PAGE_SHIFT;
+			return (size_t)win->nr_blocks << PAGE_SHIFT;
 
 		size += msc_total_sz(bdesc);
 		if (msc_block_last_written(bdesc))
-- 
2.20.1

