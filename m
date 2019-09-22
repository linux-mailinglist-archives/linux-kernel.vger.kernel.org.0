Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1650ABA2CC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2019 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfIVNhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Sep 2019 09:37:33 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:63970 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfIVNhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 09:37:33 -0400
Date:   Sun, 22 Sep 2019 13:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=default; t=1569159450;
        bh=qHs4PYKGN4gucVzg/OdVbyMsjMNs4bE10O7osfBic2Y=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=yOD7bzGR9+SB7NLTdQxdxzNk5Isgui/8q1M6CWuldKxCzCfhvrXqTzQZ4dJZotOSx
         KAH0cIIsmAJISjDnJ4tAC6xRsV/2wVy+FlyA5u80u0N7bXYbgNHs9crb2MDcXnRFn1
         LiHC9bItMbKER2jNM5eD0AwjKA09Mj9faAagVTMQ=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Reply-To: Dmitry Goldin <dgoldin@protonmail.ch>
Subject: [PATCH] kheaders: making headers archive reproducible
Message-ID: <IQMyD-PDXUKT0AUM6nMO2xzV3oJqgdois_F-LtaUnpMXywiuwxH1pPZL_SAv4eYu-PwyhoTxPHqXQ295i2DsjMwUyQqm6ARydcgqySKoqlo=@protonmail.ch>
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

In commit 43d8ce9d65a5 ("Provide in-kernel headers to make
extending kernel easier") a new mechanism was introduced, for kernels
>=3D5.2, which embeds the kernel headers in the kernel image or a module
and exposed them in procfs for use by userland tools.

The archive containing the header files has nondeterminism through the
header files metadata. This patch normalizes the metadata and utilizes
KBUILD_BUILD_TIMESTAMP if provided and otherwise falls back to the
default behaviour.

In commit f7b101d33046 ("kheaders: Move from proc to sysfs") it was
modified to use sysfs and the script for generation of the archive was
renamed to what is being patched.

Signed-off-by: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
---
 kernel/gen_kheaders.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 9ff449888d9c..2e154741e3b2 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -71,7 +71,10 @@ done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1
 find $cpio_dir -type f -print0 |
 =09xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\=
///smg;'

-tar -Jcf $tarfile -C $cpio_dir/ . > /dev/null
+# Create archive and try to normalized metadata for reproducibility
+tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
+    --owner=3D0 --group=3D0 --sort=3Dname --numeric-owner \
+    -Jcf $tarfile -C $cpio_dir/ . > /dev/null

 echo "$src_files_md5" >  kernel/kheaders.md5
 echo "$obj_files_md5" >> kernel/kheaders.md5
--
2.19.2



