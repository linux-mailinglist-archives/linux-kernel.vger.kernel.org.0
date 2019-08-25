Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 359439C241
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 08:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfHYFzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 01:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfHYFzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 01:55:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9352173E;
        Sun, 25 Aug 2019 05:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566712509;
        bh=Aa5tlO6MtJvUzYgM9FFUC3GIcckVnGylV0rhrPhlqOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGE8rSjfWXzHLKnKOydAEA3qP3w4cwqGjQP3PSTli25pmypzQ6ibm6tBFSW6zEbEK
         EP6aAruqxF+xuqWoZV3fd4pAW9twqHjJdvSXE7pIiTmT23dIdQbNtz60yChhMG8w+A
         swPgIg+2t/t5VkmOVn2p0+/JHixnehAAR21lo3cA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Subject: [PATCH 6/9] staging: greybus: loopback: Fix up some alignment checkpatch issues
Date:   Sun, 25 Aug 2019 07:54:26 +0200
Message-Id: <20190825055429.18547-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190825055429.18547-1-gregkh@linuxfoundation.org>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some function prototypes do not match the expected alignment formatting
so fix that up so that checkpatch is happy.

Cc: "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/greybus/loopback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 48d85ebe404a..b0ab0eed5c18 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -882,7 +882,7 @@ static int gb_loopback_fn(void *data)
 				gb->type = 0;
 				gb->send_count = 0;
 				sysfs_notify(&gb->dev->kobj,  NULL,
-						"iteration_count");
+					     "iteration_count");
 				dev_dbg(&bundle->dev, "load test complete\n");
 			} else {
 				dev_dbg(&bundle->dev,
@@ -1054,7 +1054,7 @@ static int gb_loopback_probe(struct gb_bundle *bundle,
 
 	/* Allocate kfifo */
 	if (kfifo_alloc(&gb->kfifo_lat, kfifo_depth * sizeof(u32),
-			  GFP_KERNEL)) {
+			GFP_KERNEL)) {
 		retval = -ENOMEM;
 		goto out_conn;
 	}
-- 
2.23.0

