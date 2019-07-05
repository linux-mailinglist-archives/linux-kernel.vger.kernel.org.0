Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E85F924
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 15:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfGDNal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 09:30:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43262 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfGDNak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:30:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hj1ol-0000ig-BO; Thu, 04 Jul 2019 13:30:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: remove redundant assignment to variable is_empty
Date:   Thu,  4 Jul 2019 14:30:31 +0100
Message-Id: <20190704133031.28809-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable is_empty is being initialized with a value that is never
read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/greybus/audio_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
index c2a4af4c1d06..9b19ea9d3fa1 100644
--- a/drivers/staging/greybus/audio_manager.c
+++ b/drivers/staging/greybus/audio_manager.c
@@ -86,7 +86,7 @@ EXPORT_SYMBOL_GPL(gb_audio_manager_remove);
 void gb_audio_manager_remove_all(void)
 {
 	struct gb_audio_manager_module *module, *next;
-	int is_empty = 1;
+	int is_empty;
 
 	down_write(&modules_rwsem);
 
-- 
2.20.1

