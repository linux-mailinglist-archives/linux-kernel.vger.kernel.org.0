Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93736BFE40
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 06:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfI0Eqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 00:46:40 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:53042 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbfI0Eqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 00:46:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C8D02182CED28;
        Fri, 27 Sep 2019 04:46:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3355:3653:3865:3866:3867:3868:3870:3874:4250:4321:5007:6119:7903:8957:9010:9040:9592:10004:10400:10848:11026:11658:11914:12043:12291:12296:12297:12438:12555:12679:12681:12683:12760:12986:13095:13138:13161:13229:13231:13255:13439:14181:14394:14659:14721:21080:21212:21221:21324:21433:21451:21627:21819:30022:30029:30046:30054:30062:30064:30070,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: comb94_56d9f54a7e10f
X-Filterd-Recvd-Size: 4689
Received: from XPS-9350 (unknown [113.22.183.150])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Sep 2019 04:46:36 +0000 (UTC)
Message-ID: <33605b9fc0e0f711236951ae84185a6218acff4f.camel@perches.com>
Subject: [PATCH] get_maintainer: Add signatures from Fixes: <badcommit>
 lines in commit message
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>
Date:   Thu, 26 Sep 2019 21:46:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: lines in a commit message generally indicate that a
previous commit was inadequate for whatever reason.

The signers of the previous inadequate commit should also be
cc'd on this new commit so update get_maintainer to find the
old commit and add the original signers.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 5ef59214c555..34085d146fa2 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -26,6 +26,7 @@ my $email = 1;
 my $email_usename = 1;
 my $email_maintainer = 1;
 my $email_reviewer = 1;
+my $email_fixes = 1;
 my $email_list = 1;
 my $email_moderated_list = 1;
 my $email_subscriber_list = 0;
@@ -249,6 +250,7 @@ if (!GetOptions(
 		'r!' => \$email_reviewer,
 		'n!' => \$email_usename,
 		'l!' => \$email_list,
+		'fixes!' => \$email_fixes,
 		'moderated!' => \$email_moderated_list,
 		's!' => \$email_subscriber_list,
 		'multiline!' => \$output_multiline,
@@ -503,6 +505,7 @@ sub read_mailmap {
 ## use the filenames on the command line or find the filenames in the patchfiles
 
 my @files = ();
+my @fixes = ();			# If a patch description includes Fixes: lines
 my @range = ();
 my @keyword_tvi = ();
 my @file_emails = ();
@@ -568,6 +571,8 @@ foreach my $file (@ARGV) {
 		my $filename2 = $2;
 		push(@files, $filename1);
 		push(@files, $filename2);
+	    } elsif (m/^Fixes:\s+([0-9a-fA-F]{6,40})/) {
+		push(@fixes, $1) if ($email_fixes);
 	    } elsif (m/^\+\+\+\s+(\S+)/ or m/^---\s+(\S+)/) {
 		my $filename = $1;
 		$filename =~ s@^[^/]*/@@;
@@ -598,6 +603,7 @@ foreach my $file (@ARGV) {
 }
 
 @file_emails = uniq(@file_emails);
+@fixes = uniq(@fixes);
 
 my %email_hash_name;
 my %email_hash_address;
@@ -612,7 +618,6 @@ my %deduplicate_name_hash = ();
 my %deduplicate_address_hash = ();
 
 my @maintainers = get_maintainers();
-
 if (@maintainers) {
     @maintainers = merge_email(@maintainers);
     output(@maintainers);
@@ -927,6 +932,10 @@ sub get_maintainers {
 	}
     }
 
+    foreach my $fix (@fixes) {
+	vcs_add_commit_signers($fix, "blamed_fixes");
+    }
+
     foreach my $email (@email_to, @list_to) {
 	$email->[0] = deduplicate_email($email->[0]);
     }
@@ -1031,6 +1040,7 @@ MAINTAINER field selection options:
     --roles => show roles (status:subsystem, git-signer, list, etc...)
     --rolestats => show roles and statistics (commits/total_commits, %)
     --file-emails => add email addresses found in -f file (default: 0 (off))
+    --fixes => for patches, add signatures of commits with 'Fixes: <commit>' (default: 1 (on))
   --scm => print SCM tree(s) if any
   --status => print status if any
   --subsystem => print subsystem name if any
@@ -1730,6 +1740,32 @@ sub vcs_is_hg {
     return $vcs_used == 2;
 }
 
+sub vcs_add_commit_signers {
+    return if (!vcs_exists());
+
+    my ($commit, $desc) = @_;
+    my $commit_count = 0;
+    my $commit_authors_ref;
+    my $commit_signers_ref;
+    my $stats_ref;
+    my @commit_authors = ();
+    my @commit_signers = ();
+    my $cmd;
+
+    $cmd = $VCS_cmds{"find_commit_signers_cmd"};
+    $cmd =~ s/(\$\w+)/$1/eeg;	#substitute variables in $cmd
+
+    ($commit_count, $commit_signers_ref, $commit_authors_ref, $stats_ref) = vcs_find_signers($cmd, "");
+    @commit_authors = @{$commit_authors_ref} if defined $commit_authors_ref;
+    @commit_signers = @{$commit_signers_ref} if defined $commit_signers_ref;
+
+    foreach my $signer (@commit_signers) {
+	$signer = deduplicate_email($signer);
+    }
+
+    vcs_assign($desc, 1, @commit_signers);
+}
+
 sub interactive_get_maintainers {
     my ($list_ref) = @_;
     my @list = @$list_ref;


