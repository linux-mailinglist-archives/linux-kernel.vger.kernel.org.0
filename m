Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA6B565B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 21:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfIQTnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 15:43:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44008 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfIQTnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:43:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8F21C28DE06
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, kernel@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/2] kernel-doc: add support for ____cacheline_aligned_in_smp attribute
Date:   Tue, 17 Sep 2019 16:41:46 -0300
Message-Id: <20190917194146.35642-3-andrealmeid@collabora.com>
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

Subroutine dump_struct uses type attributes to check if the struct
syntax is valid. Then, it removes all attributes before using it for
output. `____cacheline_aligned_in_smp` is an attribute that is
not included in both steps. Add it, since it is used by kernel structs.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 scripts/kernel-doc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f1faa036ee59..5505750261d7 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1062,7 +1062,7 @@ sub dump_struct($$) {
     my $x = shift;
     my $file = shift;
 
-    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
+    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
 	my $decl_type = $1;
 	$declaration_name = $2;
 	my $members = $3;
@@ -1077,6 +1077,7 @@ sub dump_struct($$) {
 	$members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
 	$members =~ s/\s*__packed\s*/ /gos;
 	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
+	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
 	# replace DECLARE_BITMAP
 	$members =~ s/DECLARE_BITMAP\s*\(([^,)]+),\s*([^,)]+)\)/unsigned long $1\[BITS_TO_LONGS($2)\]/gos;
 	# replace DECLARE_HASHTABLE
-- 
2.23.0

