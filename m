Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3759CCF6F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 12:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfJHKXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 06:23:15 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49434 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730051AbfJHKXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:23:14 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iHme8-0005Dv-Pg; Tue, 08 Oct 2019 11:23:12 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iHme8-0006cx-9g; Tue, 08 Oct 2019 11:23:12 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] mm: include <linux/ramfs.h> for generic_file_vm_ops definition
Date:   Tue,  8 Oct 2019 11:23:11 +0100
Message-Id: <20191008102311.25432-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic_file_vm_ops is defined in <linux/ramfs.h> so include
it to fix the following warning:

mm/filemap.c:2717:35: warning: symbol 'generic_file_vm_ops' was not declared. Should it be static?

Signed-off0-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 mm/filemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1146fcfa3215..85b7d087eb45 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -40,6 +40,7 @@
 #include <linux/rmap.h>
 #include <linux/delayacct.h>
 #include <linux/psi.h>
+#include <linux/ramfs.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
-- 
2.23.0

