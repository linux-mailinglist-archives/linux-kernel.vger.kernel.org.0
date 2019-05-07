Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6866416257
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 12:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfEGKys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 06:54:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfEGKyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:54:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7489F1993;
        Tue,  7 May 2019 03:54:23 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 379E73F5AF;
        Tue,  7 May 2019 03:54:22 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        rjw@rjwysocki.net, mathieu.poirier@linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 29/30] coresight: acpi: Support for AMBA components
Date:   Tue,  7 May 2019 11:52:56 +0100
Message-Id: <1557226378-10131-30-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
References: <1557226378-10131-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All AMBA devices are handled via ACPI AMBA scan notifier
infrastructure. The platform devices get the ACPI id
added to their driver.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/acpi/acpi_amba.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index 7f77c07..eef5a69 100644
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
+	{"ARMHC9FF", 0}, /* ARM CoreSight Funnel */
 	{"", 0},
 };
 
-- 
2.7.4

