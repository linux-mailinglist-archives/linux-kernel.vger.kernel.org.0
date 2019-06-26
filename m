Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6959356FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 19:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfFZRgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 13:36:13 -0400
Received: from ms.lwn.net ([45.79.88.28]:40902 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfFZRf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:35:56 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 7A3E65A0;
        Wed, 26 Jun 2019 17:29:11 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 3/4] kernel-doc: Don't try to mark up function names
Date:   Wed, 26 Jun 2019 11:28:58 -0600
Message-Id: <20190626172859.16113-4-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626172859.16113-1-corbet@lwn.net>
References: <20190626172859.16113-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have better automarkup in sphinx itself and, besides, this markup
was incorrect and left :c:func: gunk in the processed docs.  Sort of
discouraging that nobody ever noticed...:)

As a first step toward the removal of impenetrable regex magic from
kernel-doc it's a tiny one, but you have to start somewhere.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c0cb41e65b9b..6b03012750da 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -249,7 +249,7 @@ my @highlights_rst = (
                        [$type_member_func, "\\:c\\:type\\:`\$1\$2\$3\\\\(\\\\) <\$1>`"],
                        [$type_member, "\\:c\\:type\\:`\$1\$2\$3 <\$1>`"],
 		       [$type_fp_param, "**\$1\\\\(\\\\)**"],
-                       [$type_func, "\\:c\\:func\\:`\$1()`"],
+                       [$type_func, "\$1()"],
                        [$type_enum, "\\:c\\:type\\:`\$1 <\$2>`"],
                        [$type_struct, "\\:c\\:type\\:`\$1 <\$2>`"],
                        [$type_typedef, "\\:c\\:type\\:`\$1 <\$2>`"],
-- 
2.21.0

