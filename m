Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AE2D1069
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 15:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfJINmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 09:42:23 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:25697 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbfJINmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:42:22 -0400
Date:   Wed, 09 Oct 2019 13:42:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1570628540;
        bh=Fw03kMjLPd8j1SiB/+D4/nukD3ATLXHGq8C5r35qhIE=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=R1YnAMsv+wO6CGcZ5yPC/pyShuPV3BTSKnYPI4KQhvWzKN0r5wyAj8K6taD/OHdPL
         FWhGxoFfR0j04vVUuq+5j8wmzSuStb7vSuODP0A+Qgl0HyetXqD84aCtkFvwn4c5Ds
         u/HVVJOrKqVxk5IEQFarDIIkdydIyWeAORm3ijVA=
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel\\\\\\\\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel\\\\\\\\@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Reply-To: Dmitry Goldin <dgoldin@protonmail.ch>
Subject: [PATCH] kheaders: substituting --sort in archive creation
Message-ID: <oZ31wh8h96sDGJ_uQWJbvFDzh4-ByMMeoyOhTLmfdf5B5T0KWgLhhNbC49J6EM_Nlgo_zH-bUScrWxYTgP9eNNMF1D5AbpcbIHbBuzbS_44=@protonmail.ch>
Feedback-ID: Z14zYPZ70AFJyYagXjx-jk2Vw9RTvF5p9C9xp4Pq6DJAMFg9PDsfB7GoMmtR_dfa0BaFgToZb9Q4V0UiY2YiMQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Goldin <dgoldin+lkml@protonmail.ch>

The option --sort=3DORDER was only introduced in tar 1.28 (2014), which
is rather new and might not be available in some setups.

This patch tries to replicate the previous behaviour as closely as possible
to fix the kheaders build for older environments. It does not produce ident=
ical
archives compared to the previous version due to minor sorting
differences but produces reproducible results itself in my tests.

Signed-off-by: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
---
 kernel/gen_kheaders.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index aff79e461fc9..5a0fc0b0403a 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -71,10 +71,13 @@ done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
 find $cpio_dir -type f -print0 |
 =09xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\=
///smg;'

-# Create archive and try to normalize metadata for reproducibility
-tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
-    --owner=3D0 --group=3D0 --sort=3Dname --numeric-owner \
-    -Jcf $tarfile -C $cpio_dir/ . > /dev/null
+# Create archive and try to normalize metadata for reproducibility.
+# For compatibility with older versions of tar, files are fed to tar
+# pre-sorted, as --sort=3Dname might not be available.
+find $cpio_dir -printf "./%P\n" | LC_ALL=3DC sort | \
+    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
+    --owner=3D0 --group=3D0 --numeric-owner --no-recursion \
+    -Jcf $tarfile -C $cpio_dir/ -T - > /dev/null

 echo "$src_files_md5" >  kernel/kheaders.md5
 echo "$obj_files_md5" >> kernel/kheaders.md5
--
2.23.0
