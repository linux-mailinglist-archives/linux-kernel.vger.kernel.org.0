Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2374165D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 13:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgBTMT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 07:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgBTMT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:19:27 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E863524672;
        Thu, 20 Feb 2020 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582201166;
        bh=dgn6olFp0KDBN8hifcEtw3QbsBVEs+td4iZ0ONnuJ8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzsFznyppG9vdFrMgiuxQRz8XFmCDmHQ1PmsVtxyrfTqZnlg8AkCnItgjp24qcWZs
         8wq5UcuZmZj2Rp4KF4afI9h2Q9V0mctYj0GfCurfgcAJV36+UFIcOdY8Gqw7k3Vb2F
         f0/stsCU/gNMGfj5citvDN5+rq1/EOkL6/xJoeiM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 6/8] bootconfig: Overwrite value on same key by default
Date:   Thu, 20 Feb 2020 21:19:22 +0900
Message-Id: <158220116248.26565.12553080867501195108.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158220110257.26565.4812934676257459744.stgit@devnote2>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, bootconfig does not overwrite existing value
on same key, but add new value to the tail of an array.
But this looks a bit confusing because similar syntax
configuration always overwrite the value by default.

This changes the behavior to overwrite value on same key.

For example, if there are 2 entries

  key = value
  ...
  key = value2

Then, the key is updated as below.

  key = value2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.rst |   12 ++++++++++++
 lib/bootconfig.c                         |   18 ++++++++++++++----
 tools/bootconfig/test-bootconfig.sh      |   16 ++++++++++++++--
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 4a106584eb21..0c18e3f540e6 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -62,6 +62,18 @@ Or more shorter, written as following::
 In both styles, same key words are automatically merged when parsing it
 at boot time. So you can append similar trees or key-values.
 
+Same-key Values
+---------------
+
+If two or more values or arraies share a same-key, the latter one remains.
+For example,::
+
+ foo = bar, baz
+ foo = qux
+
+In this case ``bar`` and ``baz`` is overwritten by ``qux``, and ``foo = qux``
+remains.
+
 Note that a sub-key and a value can not co-exist under a parent key.
 For example, following config is NOT allowed.::
 
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 54ac623ca781..9a094162ea3e 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -578,10 +578,18 @@ static int __init __xbc_parse_keys(char *k)
 	return __xbc_add_key(k);
 }
 
+static void xbc_node_overwrite(struct xbc_node *node, char *v)
+{
+	unsigned long offset = v - xbc_data;
+
+	node->data = (u16)offset | XBC_VALUE;
+	node->next = 0;
+}
+
 static int __init xbc_parse_kv(char **k, char *v)
 {
 	struct xbc_node *prev_parent = last_parent;
-	struct xbc_node *node, *child;
+	struct xbc_node *child;
 	char *next;
 	int c, ret;
 
@@ -597,9 +605,11 @@ static int __init xbc_parse_kv(char **k, char *v)
 	if (c < 0)
 		return c;
 
-	node = xbc_add_sibling(v, XBC_VALUE);
-	if (!node)
-		return -ENOMEM;
+	if (!child) {
+		if (!xbc_add_sibling(v, XBC_VALUE))
+			return -ENOMEM;
+	} else
+		xbc_node_overwrite(child, v);
 
 	if (c == ',') {	/* Array */
 		c = xbc_parse_array(&next);
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index c5965eff62c5..f6948790c693 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -9,7 +9,7 @@ TEMPCONF=`mktemp temp-XXXX.bconf`
 NG=0
 
 cleanup() {
-  rm -f $INITRD $TEMPCONF
+  rm -f $INITRD $TEMPCONF $OUTFILE
   exit $NG
 }
 
@@ -71,7 +71,6 @@ printf " \0\0\0 \0\0\0" >> $INITRD
 $BOOTCONF -a $TEMPCONF $INITRD > $OUTFILE 2>&1
 xfail grep -i "failed" $OUTFILE
 xfail grep -i "error" $OUTFILE
-rm $OUTFILE
 
 echo "Max node number check"
 
@@ -96,6 +95,19 @@ truncate -s 32764 $TEMPCONF
 echo "\"" >> $TEMPCONF	# add 2 bytes + terminal ('\"\n\0')
 xpass $BOOTCONF -a $TEMPCONF $INITRD
 
+echo "Overwrite same-key values"
+cat > $TEMPCONF << EOF
+key = bar, baz
+key = qux
+EOF
+echo > $INITRD
+
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xfail grep -q "bar" $OUTFILE
+xfail grep -q "baz" $OUTFILE
+xpass grep -q "qux" $OUTFILE
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD

