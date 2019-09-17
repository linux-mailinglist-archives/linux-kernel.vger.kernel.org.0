Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD5B5659
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 21:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfIQTnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 15:43:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44004 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQTnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:43:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id F1AC328DE02
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, kernel@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/2] kernel-doc: fix processing nested structs with attributes
Date:   Tue, 17 Sep 2019 16:41:45 -0300
Message-Id: <20190917194146.35642-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190917194146.35642-1-andrealmeid@collabora.com>
References: <20190917194146.35642-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current regular expression for strip attributes of structs (and
for nested ones as well) also removes all whitespaces that may
surround the attribute. After that, the code will split structs and
iterate for each symbol separated by comma at the end of struct
definition (e.g. "} alias1, alias2;"). However, if the nested struct
does not have any alias and has an attribute, it will result in a
empty string at the closing bracket (e.g "};"). This will make the
split return nothing and $newmember will keep uninitialized. Fix
that, by ensuring that the attribute substitution will leave at least
one whitespace.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 scripts/kernel-doc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 6b03012750da..f1faa036ee59 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1073,10 +1073,10 @@ sub dump_struct($$) {
 	# strip comments:
 	$members =~ s/\/\*.*?\*\///gos;
 	# strip attributes
-	$members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)//gi;
-	$members =~ s/\s*__aligned\s*\([^;]*\)//gos;
-	$members =~ s/\s*__packed\s*//gos;
-	$members =~ s/\s*CRYPTO_MINALIGN_ATTR//gos;
+	$members =~ s/\s*__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)/ /gi;
+	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
+	$members =~ s/\s*__packed\s*/ /gos;
+	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
 	# replace DECLARE_BITMAP
 	$members =~ s/DECLARE_BITMAP\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
 	# replace DECLARE_HASHTABLE
-- 
2.23.0

