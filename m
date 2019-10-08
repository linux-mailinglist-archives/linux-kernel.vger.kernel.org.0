Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3074CF6AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 12:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfJHKB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 06:01:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50795 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfJHKB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:01:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iHmJV-0004oR-Sv; Tue, 08 Oct 2019 10:01:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] efi/tpm: fix sanity check of unsigned tbl_size being less than zero
Date:   Tue,  8 Oct 2019 11:01:53 +0100
Message-Id: <20191008100153.8499-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check for tbl_size being less than zero is always false
because tbl_size is unsigned. Fix this by making it a signed int.

Addresses-Coverity: ("Unsigned compared against 0")
Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after successful event log parsing")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/firmware/efi/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 703469c1ab8e..ebd7977653a8 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -40,7 +40,7 @@ int __init efi_tpm_eventlog_init(void)
 {
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct efi_tcg2_final_events_table *final_tbl;
-	unsigned int tbl_size;
+	int tbl_size;
 	int ret = 0;
 
 	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
-- 
2.20.1

