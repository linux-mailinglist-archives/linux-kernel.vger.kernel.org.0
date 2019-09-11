Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A31F4AF8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfIKJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 05:31:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48174 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfIKJbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:31:25 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i7yyB-0005RP-Fc; Wed, 11 Sep 2019 09:31:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dtc: fix spelling mistake "mmory" -> "memory"
Date:   Wed, 11 Sep 2019 10:31:23 +0100
Message-Id: <20190911093123.11312-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/dtc/fdtput.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/fdtput.c b/scripts/dtc/fdtput.c
index a363c3cabc59..3755e5f68a5a 100644
--- a/scripts/dtc/fdtput.c
+++ b/scripts/dtc/fdtput.c
@@ -84,7 +84,7 @@ static int encode_value(struct display_info *disp, char **arg, int arg_count,
 			value_size = (upto + len) + 500;
 			value = realloc(value, value_size);
 			if (!value) {
-				fprintf(stderr, "Out of mmory: cannot alloc "
+				fprintf(stderr, "Out of memory: cannot alloc "
 					"%d bytes\n", value_size);
 				return -1;
 			}
-- 
2.20.1

