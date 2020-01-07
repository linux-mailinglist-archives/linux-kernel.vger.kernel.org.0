Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D1132473
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 12:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgAGLFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 06:05:12 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35223 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgAGLFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:05:12 -0500
X-Originating-IP: 84.44.14.226
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 47D181C000C;
        Tue,  7 Jan 2020 11:05:06 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] fs: pstore: fix double-free on ramoops_init_przs
Date:   Tue,  7 Jan 2020 14:04:46 +0300
Message-Id: <20200107110445.162404-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Coverity scanner (CID 1457526) kfree on ram.c:591 frees
label which has already been freed.

Here's the flow as I have understood (this is my first time reading
pstore's files):

Whenever `persistent_ram_new` fails, it implicitly calls
`persistent_ram_free(prz)` which already does `kfree(prz->label)` and a
`kfree(prz)` consequently.

Removed `kfree(label)` to prevent double-free.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 fs/pstore/ram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 487ee39b4..e196aa08f 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -588,7 +588,6 @@ static int ramoops_init_przs(const char *name,
 			dev_err(dev, "failed to request %s mem region (0x%zx@0x%llx): %d\n",
 				name, record_size,
 				(unsigned long long)*paddr, err);
-			kfree(label);
 
 			while (i > 0) {
 				i--;
-- 
2.24.1

