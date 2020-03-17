Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57418885C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCQOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgCQOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:31 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7441720757;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=W6DKYooNZrEGPawMaPvXWLbKPNyHeiMU5wl4g0Qtyt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxmu4eQw1skzqjUaf3Hzn/81rKYDkf6AtC842uB89x5bb6dv/RZ+h2pWV1TkQp54+
         Zdo6JUQpIY2bJwwpX9q/tCaUwPg5pSLi0Zfk6FdQ9LR4e1kHlmsc6ZULxEsVdRH7JW
         4AZAN1d1Itm6x4zietNYpGK2TGzZTwBi6ehxq8Z8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000AMT-FZ; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH 04/17] kernel: futex.c: get rid of a docs build warning
Date:   Tue, 17 Mar 2020 15:54:13 +0100
Message-Id: <aab1052263e340a3eada5522f32be318890314a1.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust whitespaces and blank lines in order to get rid of this:

	./kernel/futex.c:491: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/futex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 67f004133061..dda6ddbc2e7d 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -486,7 +486,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
  * The key words are stored in @key on success.
  *
  * For shared mappings (when @fshared), the key is:
- *   ( inode->i_sequence, page->index, offset_within_page )
+ * ( inode->i_sequence, page->index, offset_within_page )
+ *
  * [ also see get_inode_sequence_number() ]
  *
  * For private mappings (or when !@fshared), the key is:
-- 
2.24.1

