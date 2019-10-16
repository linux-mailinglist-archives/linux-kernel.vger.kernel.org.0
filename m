Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29AEED9102
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393105AbfJPMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 08:33:25 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51456 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733070AbfJPMdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:33:24 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKiUR-0007XK-Ke; Wed, 16 Oct 2019 13:33:19 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKiUR-0000pe-1y; Wed, 16 Oct 2019 13:33:19 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: make 'pstore_choose_compression' static
Date:   Wed, 16 Oct 2019 13:33:17 +0100
Message-Id: <20191016123317.3154-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pstore_choose_compression function is not exported
so make it static to avoid the following sparse warning:

fs/pstore/platform.c:796:13: warning: symbol 'pstore_choose_compression' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Kees Cook <keescook@chromium.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
---
 fs/pstore/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 3d7024662d29..d896457e7c11 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -793,7 +793,7 @@ static void pstore_timefunc(struct timer_list *unused)
 			  jiffies + msecs_to_jiffies(pstore_update_ms));
 }
 
-void __init pstore_choose_compression(void)
+static void __init pstore_choose_compression(void)
 {
 	const struct pstore_zbackend *step;
 
-- 
2.23.0

