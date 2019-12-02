Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16A310ED8D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfLBQyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 11:54:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43720 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBQyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:54:10 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iboxc-00009b-Dx; Mon, 02 Dec 2019 16:54:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] loop: remove redundant assignment to err
Date:   Mon,  2 Dec 2019 16:54:08 +0000
Message-Id: <20191202165408.64510-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable err is being assigned with a value that is never
read and it is being updated later with a new value.  The assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/loop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..30f187786dae 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2006,7 +2006,6 @@ static int loop_add(struct loop_device **l, int i)
 		goto out_free_dev;
 	i = err;
 
-	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
 	lo->tag_set.queue_depth = 128;
-- 
2.24.0

