Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89505E04CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbfJVNUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 09:20:03 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56402 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfJVNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:20:02 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iMu4p-00033V-3z; Tue, 22 Oct 2019 14:19:55 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iMu4o-0008Kk-Ke; Tue, 22 Oct 2019 14:19:54 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] coda: include coda_int.h for 'coda_fake_statfs' declaration
Date:   Tue, 22 Oct 2019 14:19:53 +0100
Message-Id: <20191022131953.31991-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coda_fake_statfs is declared in coda_int.h, so include
this in coda_linux.c where it is defined. This removes the
following sparse warning:

fs/coda/coda_linux.c:25:5: warning: symbol 'coda_fake_statfs' was not declared. Should it be static?

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu
Cc: linux-kernel@vger.kernel.org
---
 fs/coda/coda_linux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index 2e1a5a192074..229f7a0949ab 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -20,6 +20,7 @@
 #include <linux/coda.h>
 #include "coda_psdev.h"
 #include "coda_linux.h"
+#include "coda_int.h"
 
 /* initialize the debugging variables */
 int coda_fake_statfs;
-- 
2.23.0

