Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0284158304
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 19:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBJSxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 13:53:34 -0500
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:45833 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726991AbgBJSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:53:33 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 52FC41F10;
        Mon, 10 Feb 2020 18:53:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:69:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1712:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3653:3865:3866:3867:3868:3874:4321:4605:5007:10004:10400:10432:10433:10848:11026:11473:11658:11914:12043:12291:12296:12297:12438:12555:12683:12760:12986:13221:13229:13439:14181:14394:14659:14721:19903:19997:21080:21221:21433:21627:21660:21819:21990:30003:30022:30029:30030:30054:30055:30070,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bone32_761312919442d
X-Filterd-Recvd-Size: 4953
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Feb 2020 18:53:31 +0000 (UTC)
Message-ID: <ebaa2f7c8f94e25520981945cddcc1982e70e072.camel@perches.com>
Subject: [PATCH] checkpatch: Remove email address comment from email address
 comparisons
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Feb 2020 10:52:16 -0800
In-Reply-To: <20200207123334.GT14946@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
         <20200131125403.882175409@infradead.org>
         <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
         <20200207113417.GG14914@hirez.programming.kicks-ass.net>
         <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
         <20200207123035.GI14914@hirez.programming.kicks-ass.net>
         <20200207123334.GT14946@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

About 2% of the last 100K commits have email addresses that include an
RFC2822 compliant comment like:

	Peter Zijlstra (Intel) <peterz@infradead.org>

checkpatch currently does a comparison of the complete name and address
to the submitted author to determine if the author has signed-off and
emits a warning if the exact email names and addresses do not match.

Unfortunately, the author email address can be written without the comment
like:

	Peter Zijlstra <peterz@infradead.org>

Add logic to compare the comment stripped email addresses to avoid this
warning.

Signed-off-by: Joe Perches <joe@perches.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/checkpatch.pl | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f3b8434..17637d0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1132,6 +1132,7 @@ sub parse_email {
 	my ($formatted_email) = @_;
 
 	my $name = "";
+	my $name_comment = "";
 	my $address = "";
 	my $comment = "";
 
@@ -1164,6 +1165,10 @@ sub parse_email {
 
 	$name = trim($name);
 	$name =~ s/^\"|\"$//g;
+	$name =~ s/(\s*\([^\)]+\))\s*//;
+	if (defined($1)) {
+		$name_comment = trim($1);
+	}
 	$address = trim($address);
 	$address =~ s/^\<|\>$//g;
 
@@ -1172,7 +1177,7 @@ sub parse_email {
 		$name = "\"$name\"";
 	}
 
-	return ($name, $address, $comment);
+	return ($name, $name_comment, $address, $comment);
 }
 
 sub format_email {
@@ -1198,6 +1203,23 @@ sub format_email {
 	return $formatted_email;
 }
 
+sub reformat_email {
+	my ($email) = @_;
+
+	my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
+	return format_email($email_name, $email_address);
+}
+
+sub same_email_addresses {
+	my ($email1, $email2) = @_;
+
+	my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
+	my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
+
+	return $email1_name eq $email2_name &&
+	       $email1_address eq $email2_address;
+}
+
 sub which {
 	my ($bin) = @_;
 
@@ -2618,17 +2640,16 @@ sub process {
 			$author = $1;
 			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
 			$author =~ s/"//g;
+			$author = reformat_email($author);
 		}
 
 # Check the patch for a signoff:
-		if ($line =~ /^\s*signed-off-by:/i) {
+		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
 			$signoff++;
 			$in_commit_log = 0;
 			if ($author ne '') {
-				my $l = $line;
-				$l =~ s/"//g;
-				if ($l =~ /^\s*signed-off-by:\s*\Q$author\E/i) {
-				    $authorsignoff = 1;
+				if (same_email_addresses($1, $author)) {
+					$authorsignoff = 1;
 				}
 			}
 		}
@@ -2678,7 +2699,7 @@ sub process {
 				}
 			}
 
-			my ($email_name, $email_address, $comment) = parse_email($email);
+			my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
 			my $suggested_email = format_email(($email_name, $email_address));
 			if ($suggested_email eq "") {
 				ERROR("BAD_SIGN_OFF",
@@ -2689,9 +2710,7 @@ sub process {
 				$dequoted =~ s/" </ </;
 				# Don't force email to have quotes
 				# Allow just an angle bracketed address
-				if ("$dequoted$comment" ne $email &&
-				    "<$email_address>$comment" ne $email &&
-				    "$suggested_email$comment" ne $email) {
+				if (!same_email_addresses($email, $suggested_email)) {
 					WARN("BAD_SIGN_OFF",
 					     "email address '$email' might be better as '$suggested_email$comment'\n" . $herecurr);
 				}


