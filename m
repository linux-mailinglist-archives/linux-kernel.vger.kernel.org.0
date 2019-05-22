Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA5261E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 12:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfEVKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 06:35:59 -0400
Received: from foss.arm.com ([217.140.101.70]:47236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbfEVKf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:35:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97C191684;
        Wed, 22 May 2019 03:35:56 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C0A83F575;
        Wed, 22 May 2019 03:35:55 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v4 29/30] coresight: acpi: Support for AMBA components
Date:   Wed, 22 May 2019 11:35:02 +0100
Message-Id: <1558521304-27469-30-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All AMBA devices are handled via ACPI AMBA scan notifier
infrastructure. The platform devices get the ACPI id
added to their driver.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/acpi/acpi_amba.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index 7f77c07..e2142e3 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -24,6 +24,15 @@
 
 static const struct acpi_device_id amba_id_list[] = {
 	{"ARMH0061", 0}, /* PL061 GPIO Device */
+	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
+	{"ARMHC501", 0}, /* ARM CoreSight ETR */
+	{"ARMHC502", 0}, /* ARM CoreSight STM */
+	{"ARMHC503", 0}, /* ARM CoreSight Debug */
+	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
+	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
+	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
+	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
+	{"ARMHC9FF", 0}, /* ARM CoreSight Dynamic Funnel */
 	{"", 0},
 };
 
-- 
2.7.4

