Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6FCF639
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 11:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfJHJkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 05:40:11 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:35738 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbfJHJkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:40:10 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id Axg82100105gfCL01xg8E1; Tue, 08 Oct 2019 11:40:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iHlyR-0002jM-TZ; Tue, 08 Oct 2019 11:40:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iHlyR-00029o-RI; Tue, 08 Oct 2019 11:40:07 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] checkpatch: use patch subject when reading from stdin
Date:   Tue,  8 Oct 2019 11:40:06 +0200
Message-Id: <20191008094006.8251-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading a patch file from standard input, checkpatch calls it "Your
patch", and reports its state as:

    Your patch has style problems, please review.

or:

    Your patch has no obvious style problems and is ready for submission.

Hence when checking multiple patches by piping them to checkpatch, e.g.
when checking patchwork bundles using:

    formail -s scripts/checkpatch.pl < bundle-foo.mbox

it is difficult to identify which patches need to be reviewed and
improved.

Fix this by replacing "Your patch" by the patch subject, if present.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 scripts/checkpatch.pl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6fcc66afb0880830..6b9feb4d646a116b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1047,6 +1047,10 @@ for my $filename (@ARGV) {
 	}
 	while (<$FILE>) {
 		chomp;
+		if ($vname eq 'Your patch') {
+			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
+			$vname = '"' . $subject . '"' if $subject;
+		}
 		push(@rawlines, $_);
 	}
 	close($FILE);
-- 
2.17.1

