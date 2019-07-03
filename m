Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841EA5DFC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 10:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfGCIal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 04:30:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28547 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727004AbfGCIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:30:41 -0400
X-UUID: d53c660dd6324e06b80c195c314dc690-20190703
X-UUID: d53c660dd6324e06b80c195c314dc690-20190703
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1792083996; Wed, 03 Jul 2019 16:30:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Jul 2019 16:30:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Jul 2019 16:30:32 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] checkpatch: avoid default n
Date:   Wed, 3 Jul 2019 16:30:31 +0800
Message-ID: <20190703083031.2950-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change reports a warning when "default n" is used.

I have seen several "remove default n" patches, so I think
it might be helpful to add this test in checkpatch.

tested:
WARNING: 'default n' is the default value, no need to write it explicitly.
+       default n

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 342c7c781ba5..6531b5757c6b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3005,6 +3005,13 @@ sub process {
 			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
 		}
 
+# avoid redundant 'default n'
+		if ($realfile =~ /Kconfig/ &&
+		    $line =~ /^\+\s*\bdefault n\b/) {
+			WARN("AVOID_DEFAULT_N",
+			     "'default n' is the default value, no need to write it explicitly.\n" . $herecurr);
+		}
+
 		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
 		    ($line =~ /\+(EXTRA_[A-Z]+FLAGS).*/)) {
 			my $flag = $1;
-- 
2.18.0

