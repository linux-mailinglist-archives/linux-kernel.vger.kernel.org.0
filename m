Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E54DF2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 18:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfJUQZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 12:25:36 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:58675 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbfJUQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:25:34 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iMaUt-00032G-LA; Mon, 21 Oct 2019 17:25:31 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iMaUt-0003YI-7X; Mon, 21 Oct 2019 17:25:31 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RFC: cpu-topology: declare parse_acpi_topology in <linux/arch_topology.h>
Date:   Mon, 21 Oct 2019 17:25:30 +0100
Message-Id: <20191021162530.13611-1-ben.dooks@codethink.co.uk>
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

RFC: is this the best place to put it?

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/arch_topology.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 42f2b5126094..7ae32900d9a2 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -59,4 +59,6 @@ void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 #endif
 
+extern int parse_acpi_topology(void);
+
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.23.0

