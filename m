Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF58117E7E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 04:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfLJDmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 22:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfLJDmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:22 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BDFF20828;
        Tue, 10 Dec 2019 03:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949341;
        bh=kcnvqzPm19XI3s3B5/yd7FRqHJyep2utfI7AJtFZ7oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PV17zJpMeUMcgsqGJZEYa7v+dK1p35WPEshNMPLuRqDIfD851ptRInMP44S3Rf+A3
         SysiulIOt+USsnO9cV9nce9k5FPujO+9KKQ96olPi3W2FPajuWPZzoTEENmkfYfNFK
         +J8+bOx7n16DpHxjRBXCVFnC1hCaEyXfBltLOZoQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/12] rcutorture: Dispense with Dracut for initrd creation
Date:   Mon,  9 Dec 2019 19:42:07 -0800
Message-Id: <20191210034217.405-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The dracut scripting does not work on all platforms, and there are no
known failures from the init binary based on the statically linked C
program.  This commit therefore removes the dracut scripting so that the
statically linked C program is always used to create the init "script".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 55 ++--------------------
 1 file changed, 3 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index 6fa9bd1..38e424d 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -20,58 +20,9 @@ if [ -s "$D/initrd/init" ]; then
     exit 0
 fi
 
-T=${TMPDIR-/tmp}/mkinitrd.sh.$$
-trap 'rm -rf $T' 0 2
-mkdir $T
-
-cat > $T/init << '__EOF___'
-#!/bin/sh
-# Run in userspace a few milliseconds every second.  This helps to
-# exercise the NO_HZ_FULL portions of RCU.  The 192 instances of "a" was
-# empirically shown to give a nice multi-millisecond burst of user-mode
-# execution on a 2GHz CPU, as desired.  Modern CPUs will vary from a
-# couple of milliseconds up to perhaps 100 milliseconds, which is an
-# acceptable range.
-#
-# Why not calibrate an exact delay?  Because within this initrd, we
-# are restricted to Bourne-shell builtins, which as far as I know do not
-# provide any means of obtaining a fine-grained timestamp.
-
-a4="a a a a"
-a16="$a4 $a4 $a4 $a4"
-a64="$a16 $a16 $a16 $a16"
-a192="$a64 $a64 $a64"
-while :
-do
-	q=
-	for i in $a192
-	do
-		q="$q $i"
-	done
-	sleep 1
-done
-__EOF___
-
-# Try using dracut to create initrd
-if command -v dracut >/dev/null 2>&1
-then
-	echo Creating $D/initrd using dracut.
-	# Filesystem creation
-	dracut --force --no-hostonly --no-hostonly-cmdline --module "base" $T/initramfs.img
-	cd $D
-	mkdir -p initrd
-	cd initrd
-	zcat $T/initramfs.img | cpio -id
-	cp $T/init init
-	chmod +x init
-	echo Done creating $D/initrd using dracut
-	exit 0
-fi
-
-# No dracut, so create a C-language initrd/init program and statically
-# link it.  This results in a very small initrd, but might be a bit less
-# future-proof than dracut.
-echo "Could not find dracut, attempting C initrd"
+# Create a C-language initrd/init infinite-loop program and statically
+# link it.  This results in a very small initrd.
+echo "Creating a statically linked C-language initrd"
 cd $D
 mkdir -p initrd
 cd initrd
-- 
2.9.5

