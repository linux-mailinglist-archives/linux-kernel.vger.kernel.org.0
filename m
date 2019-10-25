Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E55E4BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 15:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393855AbfJYNM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 09:12:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45129 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731514AbfJYNM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:12:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iNzOF-0002vT-HD; Fri, 25 Oct 2019 13:12:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: sm5502: remove redundant assignment to variable cable_type
Date:   Fri, 25 Oct 2019 14:12:27 +0100
Message-Id: <20191025131227.24894-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable cable_type is being initialized with a value that
is never read and is being re-assigned a little later on. The
assignment is redundant and hence can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/extcon/extcon-sm5502.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index b3d93baf4fc5..bcf65aaca5d2 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -276,7 +276,7 @@ static int sm5502_muic_set_path(struct sm5502_muic_info *info,
 /* Return cable type of attached or detached accessories */
 static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 {
-	unsigned int cable_type = -1, adc, dev_type1;
+	unsigned int cable_type, adc, dev_type1;
 	int ret;
 
 	/* Read ADC value according to external cable or button */
-- 
2.20.1

