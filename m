Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1363642B49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 17:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409439AbfFLPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 11:53:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46840 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407173AbfFLPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:53:09 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:d719:d9b5:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 57C692808F4;
        Wed, 12 Jun 2019 16:53:06 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        kernel@collabora.com, akpm@linux-foundation.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 1/2] mm: kmemleak: change error at _write when kmemleak is disabled
Date:   Wed, 12 Jun 2019 12:52:30 -0300
Message-Id: <20190612155231.19448-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to POSIX, EBUSY means that the "device or resource is busy",
and this can lead to people thinking that the file
`/sys/kernel/debug/kmemleak/` is somehow locked or being used by other
process. Change this error code to a more appropriate one.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Hello,

This time I've added the mailing list, not only the maintainers.

Changes in v2:
- Remove pr_error.
- Replace EINVAL for EPERM, since the command isn't invalid, in fact, the
user don't have the permission to trigger commands when kmemleak is
disabled.
- Reword the commit message to be clearer the rationale behind the
patch.

 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 9dd581d11565..848333a591fa 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1866,7 +1866,7 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
 	}
 
 	if (!kmemleak_enabled) {
-		ret = -EBUSY;
+		ret = -EPERM;
 		goto out;
 	}
 
-- 
2.22.0

