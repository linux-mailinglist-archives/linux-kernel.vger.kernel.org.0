Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1941816
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 00:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436809AbfFKWWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 18:22:15 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:3281 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436796AbfFKWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:22:13 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 11 Jun 2019 15:22:05 -0700
Received: from rlwimi.localdomain (unknown [10.129.220.121])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 1751141BAC;
        Tue, 11 Jun 2019 15:22:12 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [PATCH v2 01/13] recordmcount: Remove redundant strcmp
Date:   Tue, 11 Jun 2019 15:21:43 -0700
Message-ID: <79ccf2fec939ca66446857d9203a893c96c2f5f8.1560285597.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1560285597.git.mhelsley@vmware.com>
References: <cover.1560285597.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strcmp is unnecessary since .text is already accepted as a
prefix in the strncmp().

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 scripts/recordmcount.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index 8387a9bc064a..ebe98c39f3cd 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -405,8 +405,7 @@ is_mcounted_section_name(char const *const txtname)
 		strcmp(".irqentry.text", txtname) == 0 ||
 		strcmp(".softirqentry.text", txtname) == 0 ||
 		strcmp(".kprobes.text", txtname) == 0 ||
-		strcmp(".cpuidle.text", txtname) == 0 ||
-		strcmp(".text.unlikely", txtname) == 0;
+		strcmp(".cpuidle.text", txtname) == 0;
 }
 
 /* 32 bit and 64 bit are very similar */
-- 
2.20.1

