Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD5D1F96A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfEORk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 13:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfEORkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:40:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54DB620873;
        Wed, 15 May 2019 17:40:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hQxtA-0006Of-IL; Wed, 15 May 2019 13:40:24 -0400
Message-Id: <20190515174024.455182467@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 15 May 2019 13:39:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [for-next][PATCH 1/6] ktest: introduce _get_grub_index
References: <20190515173951.753467660@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Introduce _get_grub_index() to deal with Boot Loader
Specification (BLS) and cleanup.

Link: http://lkml.kernel.org/r/20190509213647.6276-2-msys.mizuma@gmail.com

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 275ad8ac8872..43868ee07e17 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1871,6 +1871,43 @@ sub run_scp_mod {
     return run_scp($src, $dst, $cp_scp);
 }
 
+sub _get_grub_index {
+
+    my ($command, $target, $skip) = @_;
+
+    return if (defined($grub_number) && defined($last_grub_menu) &&
+	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
+	       $last_machine eq $machine);
+
+    doprint "Find $reboot_type menu ... ";
+    $grub_number = -1;
+
+    my $ssh_grub = $ssh_exec;
+    $ssh_grub =~ s,\$SSH_COMMAND,$command,g;
+
+    open(IN, "$ssh_grub |")
+	or dodie "unable to execute $command";
+
+    my $found = 0;
+
+    while (<IN>) {
+	if (/$target/) {
+	    $grub_number++;
+	    $found = 1;
+	    last;
+	} elsif (/$skip/) {
+	    $grub_number++;
+	}
+    }
+    close(IN);
+
+    dodie "Could not find '$grub_menu' through $command on $machine"
+	if (!$found);
+    doprint "$grub_number\n";
+    $last_grub_menu = $grub_menu;
+    $last_machine = $machine;
+}
+
 sub get_grub2_index {
 
     return if (defined($grub_number) && defined($last_grub_menu) &&
-- 
2.20.1


