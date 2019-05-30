Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2C30035
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfE3Qdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 12:33:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52332 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3Qdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:33:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hWNzk-0003HE-Ds; Thu, 30 May 2019 16:33:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Wool <vitalywool@gmail.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] z3fold: remove redundant assignment to bud
Date:   Thu, 30 May 2019 17:33:36 +0100
Message-Id: <20190530163336.5148-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable bud is initialized with the value 'LAST' which is never
read and bud is reassigned later on the return from the call to the
function handle_to_buddy. This initialization is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/z3fold.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 2bc3dbde6255..0a62bc293de4 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1176,7 +1176,7 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 {
 	struct z3fold_header *zhdr;
 	struct page *page;
-	enum buddy bud = LAST; /* initialize to !HEADLESS */
+	enum buddy bud;
 
 	zhdr = get_z3fold_header(handle);
 
-- 
2.20.1

