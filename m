Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2895510814
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 14:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfEAM6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 08:58:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46911 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfEAM6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 08:58:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hLonV-0002Vk-J1; Wed, 01 May 2019 12:57:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dm: remove redundant unsigned comparison to less than zero
Date:   Wed,  1 May 2019 13:57:17 +0100
Message-Id: <20190501125717.5695-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable block is an unsigned long long hence the less than zero
comparison is always false, hence it is redundant and can be removed.

Addresses-Coverity: ("Unsigned compared against 0")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/md/dm-dust.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-dust.c b/drivers/md/dm-dust.c
index 178587bdc626..e739092bfc65 100644
--- a/drivers/md/dm-dust.c
+++ b/drivers/md/dm-dust.c
@@ -411,7 +411,7 @@ static int dust_message(struct dm_target *ti, unsigned int argc, char **argv,
 
 		block = tmp;
 		sector_div(size, dd->sect_per_block);
-		if (block > size || block < 0) {
+		if (block > size) {
 			DMERR("selected block value out of range");
 			return result;
 		}
-- 
2.20.1

