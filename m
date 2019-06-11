Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00253D773
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405916AbfFKUEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 16:04:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40372 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405706AbfFKUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:04:13 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:d719:d9b5:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 79C902854A0;
        Tue, 11 Jun 2019 21:04:10 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, kernel@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH] sphinx.rst: Add note about code snippets embedded in the text
Date:   Tue, 11 Jun 2019 17:03:16 -0300
Message-Id: <20190611200316.30054-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a paragraph that explains how to create fixed width text block,
but it doesn't explains how to create fixed width text inline, although
this feature is really used through the documentation. Fix that adding a
quick note about it.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/doc-guide/sphinx.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index c039224b404e..f48abc07f4c5 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -218,7 +218,7 @@ Here are some specific guidelines for the kernel documentation:
   examples, etc.), use ``::`` for anything that doesn't really benefit
   from syntax highlighting, especially short snippets. Use
   ``.. code-block:: <language>`` for longer code blocks that benefit
-  from highlighting.
+  from highlighting. For a short snippet of code embedded in the text, use \`\`.
 
 
 the C domain
-- 
2.22.0

