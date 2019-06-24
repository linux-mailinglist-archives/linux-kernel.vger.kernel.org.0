Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0617350B66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfFXNDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 09:03:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36797 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfFXNDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:30 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hfOd5-00027A-B6; Mon, 24 Jun 2019 15:03:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] get_maintainer: Add --cc option
Date:   Mon, 24 Jun 2019 15:03:23 +0200
Message-Id: <20190624130323.14137-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --cc adds a Cc: prefix infront of the email address so it can be
used by other Scripts directly instead of adding another wrapper for
this.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 scripts/get_maintainer.pl | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c1c088ef1420e..7f812d23218e5 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -46,6 +46,8 @@ my $output_multiline = 1;
 my $output_separator = ", ";
 my $output_roles = 0;
 my $output_rolestats = 1;
+my $output_cc_prefix = 0;
+my $cc_prefix = "";
 my $output_section_maxlen = 50;
 my $scm = 0;
 my $tree = 1;
@@ -252,6 +254,7 @@ if (!GetOptions(
 		'multiline!' => \$output_multiline,
 		'roles!' => \$output_roles,
 		'rolestats!' => \$output_rolestats,
+		'cc!' => \$output_cc_prefix,
 		'separator=s' => \$output_separator,
 		'subsystem!' => \$subsystem,
 		'status!' => \$status,
@@ -298,6 +301,10 @@ $output_multiline = 0 if ($output_separator ne ", ");
 $output_rolestats = 1 if ($interactive);
 $output_roles = 1 if ($output_rolestats);
 
+if ($output_cc_prefix) {
+    $cc_prefix = "Cc: ";
+}
+
 if ($sections || $letters ne "") {
     $sections = 1;
     $email = 0;
@@ -2462,9 +2469,9 @@ sub merge_email {
 	my ($address, $role) = @$_;
 	if (!$saw{$address}) {
 	    if ($output_roles) {
-		push(@lines, "$address ($role)");
+		push(@lines, "$cc_prefix" . "$address ($role)");
 	    } else {
-		push(@lines, $address);
+		push(@lines, "$cc_prefix" . "$address");
 	    }
 	    $saw{$address} = 1;
 	}
-- 
2.20.1

