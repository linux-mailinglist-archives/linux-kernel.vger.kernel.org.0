Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 751C4181E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 00:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfEHWCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 18:02:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEHWCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 18:02:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hOUdc-0007yV-Eg; Wed, 08 May 2019 22:02:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nbd: add null check on dev_list to avoid potential null pointer dereference
Date:   Wed,  8 May 2019 23:02:08 +0100
Message-Id: <20190508220208.26146-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to nla_nest_start_noflag can return a null pointer and currently
this is not being checked and this can lead to a null pointer dereference
when the null pointer dev_list is passed to function nla_nest_end. Fix
this by adding in a null pointer check.

Addresses-Coverity: ("Dereference null return value")
Fixes: 47d902b90a32 ("nbd: add a status netlink command")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 053958a8a2ba..ed263963e778 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2117,6 +2117,10 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		goto out;
+	}
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.20.1

