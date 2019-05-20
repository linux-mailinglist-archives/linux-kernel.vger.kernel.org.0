Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C424B24240
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfETUwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 16:52:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:16868 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfETUwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:52:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 13:52:14 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 20 May 2019 13:52:14 -0700
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] Documentation/x86: Fix path to entry_32.S
Date:   Mon, 20 May 2019 13:52:53 -0700
Message-Id: <20190520205253.23762-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/x86/exception-tables.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/exception-tables.txt b/Documentation/x86/exception-tables.txt
index e396bcd8d830..001c0f1ad935 100644
--- a/Documentation/x86/exception-tables.txt
+++ b/Documentation/x86/exception-tables.txt
@@ -30,7 +30,7 @@ page fault handler
 void do_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 in arch/x86/mm/fault.c. The parameters on the stack are set up by
-the low level assembly glue in arch/x86/kernel/entry_32.S. The parameter
+the low level assembly glue in arch/x86/entry/entry_32.S. The parameter
 regs is a pointer to the saved registers on the stack, error_code
 contains a reason code for the exception.
 
-- 
2.20.1

