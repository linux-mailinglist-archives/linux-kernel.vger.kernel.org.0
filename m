Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20FC3C9CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 13:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfJCLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 07:12:27 -0400
Received: from foss.arm.com ([217.140.110.172]:41800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbfJCLMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:12:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ED1015A1;
        Thu,  3 Oct 2019 04:12:21 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8743F3F706;
        Thu,  3 Oct 2019 04:12:20 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Julien Grall <julien.grall@arm.com>
Subject: [PATCH 4/4] docs/arm64: cpu-feature-registers: Documents missing visible fields
Date:   Thu,  3 Oct 2019 12:12:11 +0100
Message-Id: <20191003111211.483-5-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191003111211.483-1-julien.grall@arm.com>
References: <20191003111211.483-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of fields visible to userspace are not described in the
documentation. So update it.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 Documentation/arm64/cpu-feature-registers.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index 2955287e9acc..ffcf4e2c71ef 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -193,6 +193,10 @@ infrastructure:
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
+     | SB                           | [36-39] |    y    |
+     +------------------------------+---------+---------+
+     | FRINTTS                      | [32-35] |    y    |
+     +------------------------------+---------+---------+
      | GPI                          | [31-28] |    y    |
      +------------------------------+---------+---------+
      | GPA                          | [27-24] |    y    |
-- 
2.11.0

