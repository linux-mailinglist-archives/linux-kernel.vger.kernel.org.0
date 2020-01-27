Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5714A0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 10:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgA0JbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 04:31:11 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:52460 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgA0JbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:31:11 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id vMX82100m5USYZQ01MX8js; Mon, 27 Jan 2020 10:31:09 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iw0jc-0003G7-KQ; Mon, 27 Jan 2020 10:31:08 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iw0jc-0006ua-Gi; Mon, 27 Jan 2020 10:31:08 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] scripts/find-unused-docs: Fix massive false positives
Date:   Mon, 27 Jan 2020 10:31:07 +0100
Message-Id: <20200127093107.26401-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/find-unused-docs.sh invokes scripts/kernel-doc to find out if a
source file contains kerneldoc or not.

However, as it passes the no longer supported "-text" option to
scripts/kernel-doc, the latter prints out its help text, causing all
files to be considered containing kerneldoc.

Get rid of these false positives by removing the no longer supported
"-text" option from the scripts/kernel-doc invocation.

Fixes: b05142675310d2ac ("scripts: kernel-doc: get rid of unused output formats")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Triggered by https://lwn.net/Articles/810404/

 scripts/find-unused-docs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/find-unused-docs.sh b/scripts/find-unused-docs.sh
index 3f46f8977dc4dc88..ee6a50e33aba805d 100755
--- a/scripts/find-unused-docs.sh
+++ b/scripts/find-unused-docs.sh
@@ -54,7 +54,7 @@ for file in `find $1 -name '*.c'`; do
 	if [[ ${FILES_INCLUDED[$file]+_} ]]; then
 	continue;
 	fi
-	str=$(scripts/kernel-doc -text -export "$file" 2>/dev/null)
+	str=$(scripts/kernel-doc -export "$file" 2>/dev/null)
 	if [[ -n "$str" ]]; then
 	echo "$file"
 	fi
-- 
2.17.1

