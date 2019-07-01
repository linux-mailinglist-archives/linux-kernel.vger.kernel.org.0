Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5195630F03
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEaNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 09:39:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47425 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfEaNje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:39:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hWhkk-0007Qf-Sd; Fri, 31 May 2019 13:39:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vc04_services: remove redundant assignment to pointer service
Date:   Fri, 31 May 2019 14:39:26 +0100
Message-Id: <20190531133926.17644-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer service is being set to NULL however this value is never
read and so the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_shim.c    | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 13910d205fce..17a4f2c8d8b1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -639,10 +639,8 @@ int32_t vchi_service_close(const VCHI_SERVICE_HANDLE_T handle)
 
 	if (service) {
 		VCHIQ_STATUS_T status = vchiq_close_service(service->handle);
-		if (status == VCHIQ_SUCCESS) {
+		if (status == VCHIQ_SUCCESS)
 			service_free(service);
-			service = NULL;
-		}
 
 		ret = vchiq_status_to_vchi(status);
 	}
-- 
2.20.1

