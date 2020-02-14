Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70615F534
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 19:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390893AbgBNSZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 13:25:24 -0500
Received: from foss.arm.com ([217.140.110.172]:43288 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405570AbgBNSYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:24:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD4AB328;
        Fri, 14 Feb 2020 10:24:45 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74CEB3F68E;
        Fri, 14 Feb 2020 10:24:44 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 05/10] x86/resctrl: Include pid.h
Date:   Fri, 14 Feb 2020 18:23:56 +0000
Message-Id: <20200214182401.39008-6-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214182401.39008-1-james.morse@arm.com>
References: <20200214182401.39008-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to disturb the header soup. This header uses struct pid
and struct pid_namespace. Include their header.

Signed-off-by: James Morse <james.morse@arm.com>
---
 include/linux/resctrl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index daf5cf64c6a6..9b05af9b3e28 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,6 +2,8 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
 
+#include <linux/pid.h>
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 int proc_resctrl_show(struct seq_file *m,
-- 
2.24.1

