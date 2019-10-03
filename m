Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F14C9CFA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfJCLMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 07:12:22 -0400
Received: from foss.arm.com ([217.140.110.172]:41790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbfJCLMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:12:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52C471000;
        Thu,  3 Oct 2019 04:12:20 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34C173F706;
        Thu,  3 Oct 2019 04:12:19 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Julien Grall <julien.grall@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 3/4] docs/arm64: elf_hwcaps: Document HWCAP_SB
Date:   Thu,  3 Oct 2019 12:12:10 +0100
Message-Id: <20191003111211.483-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191003111211.483-1-julien.grall@arm.com>
References: <20191003111211.483-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the hardware capabilities but HWCAP_SB is not documented in
elf_hwcaps.rst. So document it.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 Documentation/arm64/elf_hwcaps.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 9ee7f8ff1fae..7fa3d215ae6a 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -155,6 +155,9 @@ HWCAP_FLAGM
 HWCAP_SSBS
     Functionality implied by ID_AA64PFR1_EL1.SSBS == 0b0010.
 
+HWCAP_SB
+    Functionality implied by ID_AA64ISAR1_EL1.SB == 0b0001.
+
 HWCAP_PACA
     Functionality implied by ID_AA64ISAR1_EL1.APA == 0b0001 or
     ID_AA64ISAR1_EL1.API == 0b0001, as described by
-- 
2.11.0

