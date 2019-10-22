Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0C7DFFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 10:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbfJVIn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 04:43:28 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:44766 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbfJVIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:43:28 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iMplF-0003JS-4F; Tue, 22 Oct 2019 09:43:25 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iMplE-0003Y1-Ee; Tue, 22 Oct 2019 09:43:24 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH] cpu-topology: declare parse_acpi_topology in <linux/arch_topology.h>
Date:   Tue, 22 Oct 2019 09:43:23 +0100
Message-Id: <20191022084323.13594-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parse_acpi_topology() is not declared anywhere which
causes the following sparse warning:

drivers/base/arch_topology.c:522:19: warning: symbol 'parse_acpi_topology' was not declared. Should it be static?

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
---
 include/linux/arch_topology.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 42f2b5126094..3015ecbb90b1 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -57,6 +57,7 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
 void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
+int parse_acpi_topology(void);
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.23.0

