Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A5A2867
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfH2Uu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 16:50:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfH2UuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:50:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD6E0180032B;
        Thu, 29 Aug 2019 20:50:17 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-116-163.phx2.redhat.com [10.3.116.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72E3660BF7;
        Thu, 29 Aug 2019 20:50:17 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 2/3 v3] tpm: provide a way to override the chip returned durations
Date:   Thu, 29 Aug 2019 13:49:46 -0700
Message-Id: <20190829204947.2591-3-jsnitsel@redhat.com>
In-Reply-To: <20190829204947.2591-1-jsnitsel@redhat.com>
References: <20190829204947.2591-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Thu, 29 Aug 2019 20:50:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds method ->update_durations to override returned
durations in case TPM chip misbehaves for TPM 1.2 drivers.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Alexey Klimov <aklimov@redhat.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v3: no changes
v2: newline cleanup as requested by Jarkko

 drivers/char/tpm/tpm1-cmd.c | 15 +++++++++++++++
 include/linux/tpm.h         |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 149e953ca369..ca7158fa6e6c 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -343,6 +343,7 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 {
 	cap_t cap;
 	unsigned long timeout_old[4], timeout_chip[4], timeout_eff[4];
+	unsigned long durations[3];
 	ssize_t rc;
 
 	rc = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, NULL,
@@ -427,6 +428,20 @@ int tpm1_get_timeouts(struct tpm_chip *chip)
 		usecs_to_jiffies(be32_to_cpu(cap.duration.tpm_long));
 	chip->duration[TPM_LONG_LONG] = 0; /* not used under 1.2 */
 
+	/*
+	 * Provide the ability for vendor overrides of duration values in case
+	 * of misreporting.
+	 */
+	if (chip->ops->update_durations)
+		chip->ops->update_durations(chip, durations);
+
+	if (chip->duration_adjusted) {
+		dev_info(&chip->dev, HW_ERR "Adjusting reported durations.");
+		chip->duration[TPM_SHORT] = durations[0];
+		chip->duration[TPM_MEDIUM] = durations[1];
+		chip->duration[TPM_LONG] = durations[2];
+	}
+
 	/* The Broadcom BCM0102 chipset in a Dell Latitude D820 gets the above
 	 * value wrong and apparently reports msecs rather than usecs. So we
 	 * fix up the resulting too-small TPM_SHORT value to make things work.
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 53c0ea9ec9df..bb1d1ac7081d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -67,6 +67,8 @@ struct tpm_class_ops {
 	u8 (*status) (struct tpm_chip *chip);
 	void (*update_timeouts)(struct tpm_chip *chip,
 				unsigned long *timeout_cap);
+	void (*update_durations)(struct tpm_chip *chip,
+				 unsigned long *duration_cap);
 	int (*go_idle)(struct tpm_chip *chip);
 	int (*cmd_ready)(struct tpm_chip *chip);
 	int (*request_locality)(struct tpm_chip *chip, int loc);
-- 
2.21.0

