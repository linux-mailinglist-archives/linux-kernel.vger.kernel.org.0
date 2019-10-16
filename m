Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E43A4D8C50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391601AbfJPJPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 05:15:16 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:43093 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfJPJPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:15:16 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKfOh-0001AB-75; Wed, 16 Oct 2019 10:15:11 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKfOg-0006xX-Gi; Wed, 16 Oct 2019 10:15:10 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: include <linux/mman.h> for vm_committed_as_batch
Date:   Wed, 16 Oct 2019 10:15:09 +0100
Message-Id: <20191016091509.26708-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm_init.c needs to include <linux/mman.h> for the
definition of vm_committed_as_batch. Fixes the following
sparse warning:

mm/mm_init.c:141:5: warning: symbol 'vm_committed_as_batch' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/init-mm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index fb1e15028ef0..19603302a77f 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -5,6 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/cpumask.h>
+#include <linux/mman.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
-- 
2.23.0

