Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B897C860
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 18:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfGaQRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 12:17:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:59890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbfGaQRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:17:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3600ADE0;
        Wed, 31 Jul 2019 16:17:45 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH linux-firmware] Install only listed firmware files
Date:   Wed, 31 Jul 2019 18:17:44 +0200
Message-Id: <20190731161744.3612-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current make-install procedure leaves lots of garbage files that
aren't really firmware files in /lib/firmware.

Instead of copy-all-and-prune approach, copy only the listed files and
links in WHENCE by make-install for assuring only the proper firmware
files.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Makefile         |  5 +----
 copy-firmware.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100755 copy-firmware.sh

diff --git a/Makefile b/Makefile
index d1163b871096..16b5b1a02a49 100644
--- a/Makefile
+++ b/Makefile
@@ -10,7 +10,4 @@ check:
 
 install:
 	mkdir -p $(DESTDIR)$(FIRMWAREDIR)
-	cp -r * $(DESTDIR)$(FIRMWAREDIR)
-	rm -rf $(DESTDIR)$(FIRMWAREDIR)/usbdux
-	find $(DESTDIR)$(FIRMWAREDIR) \( -name 'WHENCE' -or -name 'LICENSE.*' -or \
-		-name 'LICENCE.*' \) -exec rm -- {} \;
+	./copy-firmware.sh $(DESTDIR)$(FIRMWAREDIR)
diff --git a/copy-firmware.sh b/copy-firmware.sh
new file mode 100755
index 000000000000..7b276e271cfa
--- /dev/null
+++ b/copy-firmware.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copy firmware files based on WHENCE list
+#
+
+verbose=:
+if [ x"$1" = x"-v" ]; then
+    verbose=echo
+    shift
+fi
+
+destdir="$1"
+
+grep '^File:' WHENCE | sed -e's/^File: *//g' -e's/"//g' | while read f; do
+    test -f "$f" || continue
+    $verbose "copying file $f"
+    mkdir -p $destdir/$(dirname "$f")
+    cp -d "$f" $destdir/"$f"
+done
+
+grep -E '^Link:' WHENCE | sed -e's/^Link: *//g' -e's/-> //g' | while read f d; do
+    test -L "$f" || continue
+    test -f "$destdir/$f" && continue
+    $verbose "copying link $f"
+    mkdir -p $destdir/$(dirname "$f")
+    cp -d "$f" $destdir/"$f"
+done
+
+exit 0
-- 
2.16.4

