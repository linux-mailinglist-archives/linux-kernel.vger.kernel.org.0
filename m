Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DA9C240
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 08:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfHYFzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Aug 2019 01:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfHYFzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 01:55:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 013622173E;
        Sun, 25 Aug 2019 05:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566712506;
        bh=eynOF9t5+dXOyKaMiT5x7hg/MTlKzel512EyY0PZXB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i76Rp9ZXH5vGs/jjfYPY16LUiBdak8dNT63LtFXFYcB84KCSYLTAc/Jd5qo8sjQqn
         srhNNmAkJBfta6hT9qadup2TsE01ylULhw172ZkrS+mg09ipGk6VJA+WKkO9dgiLLx
         wwKcRN0Rmfiepsyvu6aWhDs5t654j+5immfangtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Lin <dtwlin@gmail.com>
Subject: [PATCH 5/9] staging: greybus: log: Fix up some alignment checkpatch issues
Date:   Sun, 25 Aug 2019 07:54:25 +0200
Message-Id: <20190825055429.18547-6-gregkh@linuxfoundation.org>
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

Cc: David Lin <dtwlin@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/greybus/log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/log.c b/drivers/staging/greybus/log.c
index 15a88574dbb0..4f1f161ff11c 100644
--- a/drivers/staging/greybus/log.c
+++ b/drivers/staging/greybus/log.c
@@ -31,14 +31,14 @@ static int gb_log_request_handler(struct gb_operation *op)
 	/* Verify size of payload */
 	if (op->request->payload_size < sizeof(*receive)) {
 		dev_err(dev, "log request too small (%zu < %zu)\n",
-				op->request->payload_size, sizeof(*receive));
+			op->request->payload_size, sizeof(*receive));
 		return -EINVAL;
 	}
 	receive = op->request->payload;
 	len = le16_to_cpu(receive->len);
 	if (len != (op->request->payload_size - sizeof(*receive))) {
 		dev_err(dev, "log request wrong size %d vs %zu\n", len,
-				(op->request->payload_size - sizeof(*receive)));
+			(op->request->payload_size - sizeof(*receive)));
 		return -EINVAL;
 	}
 	if (len == 0) {
@@ -83,7 +83,7 @@ static int gb_log_probe(struct gb_bundle *bundle,
 		return -ENOMEM;
 
 	connection = gb_connection_create(bundle, le16_to_cpu(cport_desc->id),
-			gb_log_request_handler);
+					  gb_log_request_handler);
 	if (IS_ERR(connection)) {
 		retval = PTR_ERR(connection);
 		goto error_free;
-- 
2.23.0

