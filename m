Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6370438EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbfFGPOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 11:14:32 -0400
Received: from foss.arm.com ([217.140.110.172]:42434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfFGPOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:14:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81E5B367;
        Fri,  7 Jun 2019 08:14:30 -0700 (PDT)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 633B33F718;
        Fri,  7 Jun 2019 08:14:29 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-doc@vger.kernel.org, x86@kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>
Subject: [PATCH 3/4] Documentation: x86: Clarify MBA takes MB as referring to mba_sc
Date:   Fri,  7 Jun 2019 16:14:08 +0100
Message-Id: <20190607151409.15476-4-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607151409.15476-1-james.morse@arm.com>
References: <20190607151409.15476-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"If the MBA is specified in MB then user can enter the max b/w in MB"
is a tautology. How can the user know if the schemata takes a percentage
or a MB/s value?

This is referring to whether the software controller is interpreting
the schemata's value. Make this clear.

Signed-off-by: James Morse <james.morse@arm.com>
---
 Documentation/x86/resctrl_ui.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.rst b/Documentation/x86/resctrl_ui.rst
index 638cd987937d..866b66aa289b 100644
--- a/Documentation/x86/resctrl_ui.rst
+++ b/Documentation/x86/resctrl_ui.rst
@@ -677,8 +677,8 @@ allocations can overlap or not. The allocations specifies the maximum
 b/w that the group may be able to use and the system admin can configure
 the b/w accordingly.
 
-If the MBA is specified in MB(megabytes) then user can enter the max b/w in MB
-rather than the percentage values.
+If resctrl is using the software controller (mba_sc) then user can enter the
+max b/w in MB rather than the percentage values.
 ::
 
   # echo "L3:0=3;1=c\nMB:0=1024;1=500" > /sys/fs/resctrl/p0/schemata
-- 
2.20.1

