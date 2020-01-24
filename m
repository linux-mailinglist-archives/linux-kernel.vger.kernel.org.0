Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C87148647
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 14:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389906AbgAXNlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 08:41:16 -0500
Received: from foss.arm.com ([217.140.110.172]:51768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387743AbgAXNlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:41:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B5591FB;
        Fri, 24 Jan 2020 05:41:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F2263F68E;
        Fri, 24 Jan 2020 05:41:14 -0800 (PST)
From:   Mark Brown <broonie@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] random: Document add_hwgenerator_randomness() with other input functions
Date:   Fri, 24 Jan 2020 13:41:06 +0000
Message-Id: <20200124134106.8472-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section at the top of random.c which documents the input functions
available does not document add_hwgenerator_randomness() which might lead
a reader to overlook it. Add a brief note about it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/char/random.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8..16070c36add3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -228,6 +228,14 @@
  * particular randomness source.  They do this by keeping track of the
  * first and second order deltas of the event timings.
  *
+ * There is also an interface for true hardware RNGs:
+ *
+ *	void add_hwgenerator_randomness(const char *buffer, size_t count,
+ *				size_t entropy);
+ *
+ * This will credit entropy as specified by the caller, if the entropy
+ * pool is full it will block until more entropy is needed.
+ *
  * Ensuring unpredictability at system startup
  * ============================================
  *
-- 
2.20.1

