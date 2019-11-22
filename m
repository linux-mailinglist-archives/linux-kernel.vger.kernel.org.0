Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB91073A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 14:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfKVNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 08:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbfKVNuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:50:23 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA3020707;
        Fri, 22 Nov 2019 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574430622;
        bh=1j7jq5pzhcTbwy0u76M9Rv5JeZ9UHE4g2b5e/liny1s=;
        h=From:To:Cc:Subject:Date:From;
        b=FuIaQm17HWkghGLQUjRZks57ZpwgGb3L7/3yYdlPdCy4Y3ZZHX3m+kMzzUlitxP23
         Sm1fUL0Mj/3kxlCN4g51SXu8TI42k2pLAp5EWVaA487JG8QzNWVUwSNIfwdv3k6OKu
         DjH2CAp1rkknrzGdg5+dJqYgWyDHMuJ1XbtcHyGQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] Documentation: Remove bootmem_debug from kernel-parameters.txt
Date:   Fri, 22 Nov 2019 22:50:17 +0900
Message-Id: <157443061745.20995.9432492850513217966.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bootmem_debug kernel paramenter because it has been
replaced by memblock=debug.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/kernel-parameters.txt |    2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a84a83f8881e..02eae837272e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -437,8 +437,6 @@
 			no delay (0).
 			Format: integer
 
-	bootmem_debug	[KNL] Enable bootmem allocator debug messages.
-
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 

