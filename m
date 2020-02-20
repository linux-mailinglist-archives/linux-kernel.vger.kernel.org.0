Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E23166857
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 21:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgBTUbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 15:31:48 -0500
Received: from smtprelay0049.hostedemail.com ([216.40.44.49]:35239 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728400AbgBTUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:31:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C3767182CED5B;
        Thu, 20 Feb 2020 20:31:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:541:800:960:968:973:982:988:989:1260:1311:1314:1345:1437:1515:1535:1605:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2692:3138:3139:3140:3141:3142:3653:3865:3867:3868:3870:3871:3873:4050:4118:4605:4641:5007:6119:6261:6299:7875:7903:7974:8531:8957:10226:10848:11026:11658:11914:12043:12291:12296:12297:12555:12679:12683:12895:12986:13255:13894:14394:14877:21080:21221:21324:21433:21451:21627:21740:21939:21990:30054:30055:30070:30090,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: jail73_66bdb5886c035
X-Filterd-Recvd-Size: 7972
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Feb 2020 20:31:45 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com
Subject: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */ comments to fallthrough;
Date:   Thu, 20 Feb 2020 12:30:21 -0800
Message-Id: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert /* fallthrough */ style comments to the pseudo-keyword fallthrough
to allow clang 10 and higher to work at finding missing fallthroughs too.

Requires a git repository and overwrites the input files.

Typical command use:
    ./scripts/cvt_fallthrough.pl <path|file>

i.e.:

   $ ./scripts/cvt_fallthrough.pl block
     converts all files in block and its subdirectories
   $ ./scripts/cvt_fallthrough.pl drivers/net/wireless/zydas/zd1201.c
     converts a single file

A fallthrough comment with additional comments is converted akin to:

-		/* fall through - maybe userspace knows this conn_id. */
+		fallthrough;    /* maybe userspace knows this conn_id */

A fallthrough comment or fallthrough; between successive case statements
is deleted.

e.g.:

    case FOO:
    	/* fallthrough */ (or fallthrough;)
    case BAR:

is converted to:

    case FOO:
    case BAR:

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/cvt_fallthrough.pl | 215 +++++++++++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100755 scripts/cvt_fallthrough.pl

diff --git a/scripts/cvt_fallthrough.pl b/scripts/cvt_fallthrough.pl
new file mode 100755
index 000000..6585e4
--- /dev/null
+++ b/scripts/cvt_fallthrough.pl
@@ -0,0 +1,215 @@
+#!/usr/bin/perl -w
+
+# script to modify /* fallthrough */ style comments to fallthrough;
+# use: perl cvt_fallthrough.pl <paths|files>
+# e.g.: perl cvtfallthrough.pl drivers/net/ethernet/intel
+
+use strict;
+
+my $P = $0;
+my $modified = 0;
+my $quiet = 0;
+
+sub expand_tabs {
+    my ($str) = @_;
+
+    my $res = '';
+    my $n = 0;
+    for my $c (split(//, $str)) {
+	if ($c eq "\t") {
+	    $res .= ' ';
+	    $n++;
+	    for (; ($n % 8) != 0; $n++) {
+		$res .= ' ';
+	    }
+	    next;
+	}
+	$res .= $c;
+	$n++;
+    }
+
+    return $res;
+}
+
+my $args = join(" ", @ARGV);
+my $output = `git ls-files -- $args`;
+my @files = split("\n", $output);
+
+foreach my $file (@files) {
+    my $f;
+    my $cvt = 0;
+    my $del = 0;
+    my $text;
+
+# read the file
+
+    next if ((-d $file));
+
+    open($f, '<', $file)
+	or die "$P: Can't open $file for read\n";
+    $text = do { local($/) ; <$f> };
+    close($f);
+
+    next if ($text eq "");
+
+    # for style:
+
+    # /* <fallthrough comment> */
+    # case FOO:
+
+    # while (comment has fallthrough and next non-blank, non-continuation line is (case or default:)) {
+    #   remove newline, whitespace before, fallthrough comment and whitespace after
+    #   insert newline, adjusted spacing and fallthrough; newline
+    # }
+
+    my $count = 0;
+    my @fallthroughs = (
+	'fallthrough',
+	'@fallthrough@',
+	'lint -fallthrough[ \t]*',
+	'[ \t.!]*(?:ELSE,? |INTENTIONAL(?:LY)? )?',
+	'intentional(?:ly)?[ \t]*fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)',
+	'(?:else,?\s*)?FALL(?:S | |-)?THR(?:OUGH|U|EW)[ \t.!]*(?:-[^\n\r]*)?',
+	'[ \t.!]*(?:Else,? |Intentional(?:ly)? )?',
+	'Fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)[ \t.!]*(?:-[^\n\r]*)?',
+	'[ \t.!]*(?:[Ee]lse,? |[Ii]ntentional(?:ly)? )?',
+	'fall(?:s | |-)?thr(?:ough|u|ew)[ \t.!]*(?:-[^\n\r]*)?',
+    );
+    do {
+	$count = 0;
+	pos($text) = 0;
+	foreach my $ft (@fallthroughs) {
+	    my $regex = '(((?:[ \t]*\n)*[ \t]*)(/\*\s*(?!\*/)?\b' . "$ft" . '\s*(?!\*/)?\*/(?:[ \t]*\n)*)([ \t]*))(?:case\s+|default\s*:)';
+
+	    while ($text =~ m{${regex}}i) {
+		my $all_but_case = $1;
+		my $space_before = $2;
+		my $fallthrough = $3;
+		my $space_after = $4;
+		my $pos_before = $-[1];
+		my $pos_after = $+[3];
+
+		# try to maintain any additional comment on the same line
+		my $comment = "";
+		if ($regex =~ /\\r/) {
+		    $comment = $fallthrough;
+		    $comment =~ s@^/\*\s*@@;
+		    $comment =~ s@\s*\*/\s*$@@;
+		    $comment =~ s@^\s*(?:intentional(?:ly)?\s+|else,?\s*)?fall[s\-]*\s*thr(?:ough|u|ew)[\s\.\-]*@@i;
+		    $comment =~ s@\s+$@@;
+		    $comment =~ s@\.*$@@;
+		    $comment = "\t/* $comment */" if ($comment ne "");
+		}
+		substr($text, $pos_before, $pos_after - $pos_before, "");
+		substr($text, $pos_before, 0, "\n${space_after}\tfallthrough;${comment}\n");
+		pos($text) = $pos_before;
+		$count++;
+	    }
+	}
+	$cvt += $count;
+        } while ($count > 0);
+
+    # Reset the fallthroughs types to a single regex
+
+    @fallthroughs = (
+	'fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)'
+    );
+
+    # Convert the // <fallthrough> style comments followed by case/default:
+
+    do {
+	$count = 0;
+	pos($text) = 0;
+	foreach my $ft (@fallthroughs) {
+	    my $regex = '(((?:[ \t]*\n)*[ \t]*)(//[ \t]*(?!\n)?\b' . "$ft" . '[ \t]*(?!\n)?\n(?:[ \t]*\n)*)([ \t]*))(?:case\s+|default\s*:)';
+	    while ($text =~ m{${regex}}i) {
+		my $all_but_case = $1;
+		my $space_before = $2;
+		my $fallthrough = $3;
+		my $space_after = $4;
+		my $pos_before = $-[1];
+		my $pos_after = $+[3];
+
+		substr($text, $pos_before, $pos_after - $pos_before, "");
+		substr($text, $pos_before, 0, "\n${space_after}\tfallthrough;\n");
+		pos($text) = $pos_before;
+		$count++;
+	    }
+	}
+	$cvt += $count;
+    } while ($count > 0);
+
+    # Convert /* fallthrough */ comment macro lines with trailing \
+
+    do {
+	$count = 0;
+	pos($text) = 0;
+	foreach my $ft (@fallthroughs) {
+	    my $regex = '((?:[ \t]*\\\\\n)*([ \t]*)(/\*[ \t]*\b' . "$ft" . '[ \t]*\*/)([ \t]*))\\\\\n*([ \t]*(?:case\s+|default\s*:))';
+
+	    while ($text =~ m{${regex}}i) {
+		my $all_but_case = $1;
+		my $space_before = $2;
+		my $fallthrough = $3;
+		my $space_after = $4;
+		my $pos_before = $-[2];
+		my $pos_after = $+[4];
+
+		my $oldline = "${space_before}${fallthrough}${space_after}";
+		my $len = length(expand_tabs($oldline));
+
+		my $newline = "${space_before}fallthrough;${space_after}";
+		$newline .= "\t" while (length(expand_tabs($newline)) < $len);
+
+		substr($text, $pos_before, $pos_after - $pos_before, "");
+		substr($text, $pos_before, 0, "$newline");
+		pos($text) = $pos_before;
+		$count++;
+	    }
+	}
+	$cvt += $count;
+    } while ($count > 0);
+
+    # delete any unnecessary fallthrough; between successive cases and default:
+
+    do {
+	pos($text) = 0;
+	$count = $text =~ s/(case\s+\w+\s*:\n)[ \t]*fallthrough;\n((?:\s*default\s*:|\s*case\s+\w+\s*:))/$1$2/;
+	$del += $count;
+    } while ($count > 0);
+
+# write the file if something was changed
+
+    if ($cvt > 0 || $del > 0) {
+	$modified = 1;
+
+	open($f, '>', $file)
+	    or die "$P: Can't open $file for write\n";
+	print $f $text;
+	close($f);
+
+	if (!$quiet) {
+	    print "fallthroughs:";
+	    print "	converted: $cvt" if ($cvt > 0);
+	    print "	deleted: $del" if ($del > 0);
+	    print "	$file\n";
+	}
+    }
+}
+
+if ($modified && !$quiet) {
+    print <<EOT;
+
+Warning: these changes may not be correct.
+
+These changes should be carefully reviewed manually and not combined with
+any functional changes.
+
+Compile, build and test your changes.
+
+You should understand and be responsible for all object changes.
+
+Make sure you read Documentation/SubmittingPatches before sending
+any changes to reviewers, maintainers or mailing lists.
+EOT
+}
-- 
2.24.0

