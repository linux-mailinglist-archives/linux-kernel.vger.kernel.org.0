Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013864D4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfFTRX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 13:23:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfFTRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e/+2h49PQTLebtYTQ2y+poBPVIU3vbzyE9O3TGMGRrw=; b=FO3Jm0awjBRhKIs4KwoLJxkCUQ
        mB8qj+a8APl+5dMCkoWWBRw62H1V6CDFliaQd/h2PQ1Gl+hHbC7MEp0z4n99qWCBQkJA2JkYawc3Z
        u5ovPv97ta0fWqUQI9xsKir+OqxXVN3smLOzBmGiSyylCYxsQnhoKfT63iIZdVCE6bS0FhM1kN8Jb
        ZUroYiGuMKl67DDCsuHStakvfvgHcylKSIA59fLvwxTvUnUEIyc7fvYD5p+aPUw+2MsA0I8ReAYnj
        07OfE0CAWxLDoLpyxdnT0DZuD/Ma38VNyTx+e0lthgXsrtkVj+FwtPTd30xrulYDCGC0hiVEyeDOv
        LjkxGXJg==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mL-0008Rl-PY; Thu, 20 Jun 2019 17:23:17 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000Cs-Ke; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 04/22] scripts/get_abi.pl: parse files with text at beginning
Date:   Thu, 20 Jun 2019 14:22:56 -0300
Message-Id: <46c30cf8ed898e85a0ee59781687e58efd6264d1.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It sounds usefult o parse files with has some text at the
beginning. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 59 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index f7c9944a833c..ef9b6e108973 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -55,7 +55,10 @@ sub parse_abi {
 	my $what;
 	my $new_what;
 	my $tag;
+	my $label;
 	my $ln;
+	my $has_file;
+	my $xrefs;
 
 	print STDERR "Opening $file\n" if ($debug > 1);
 	open IN, $file;
@@ -67,7 +70,7 @@ sub parse_abi {
 
 			if (!($new_tag =~ m/(what|date|kernelversion|contact|description|users)/)) {
 				if ($tag eq "description") {
-					$data{$what}->{$tag} .= "\n$content";;
+					$data{$what}->{$tag} .= "\n$content";
 					$data{$what}->{$tag} =~ s/\n+$//;
 					next;
 				} else {
@@ -83,6 +86,25 @@ sub parse_abi {
 					$new_what = 1;
 				}
 				$tag = $new_tag;
+
+				if ($has_file) {
+					$label = "abi_" . $content . " ";
+					$label =~ tr/A-Z/a-z/;
+
+					# Convert special chars to "_"
+					$label =~s/[\x00-\x2f]+/_/g;
+					$label =~s/[\x3a-\x40]+/_/g;
+					$label =~s/[\x7b-\xff]+/_/g;
+					$label =~ s,_+,_,g;
+					$label =~ s,_$,,;
+
+					$data{$what}->{label} .= $label;
+
+					# Escape special chars from content
+					$content =~s/([\x00-\x1f\x21-\x2f\x3a-\x40\x7b-\xff])/\\$1/g;
+
+					$xrefs .= "- :ref:`$content <$label>`\n\n";
+				}
 				next;
 			}
 
@@ -104,8 +126,18 @@ sub parse_abi {
 			next;
 		}
 
-		# Silently ignore any headers before the database
-		next if (!$tag);
+		# Store any contents before the database
+		if (!$tag) {
+			next if (/^\n/);
+
+			my $my_what = "File $name";
+			$data{$my_what}->{what} = "File $name";
+			$data{$my_what}->{type} = "File";
+			$data{$my_what}->{file} = $name;
+			$data{$my_what}->{description} .= $_;
+			$has_file = 1;
+			next;
+		}
 
 		if (m/^\s*(.*)/) {
 			$data{$what}->{$tag} .= "\n$1";
@@ -117,6 +149,11 @@ sub parse_abi {
 		parse_error($file, $ln, "Unexpected line:", $_);
 	}
 	close IN;
+
+	if ($has_file) {
+		my $my_what = "File $name";
+		$data{$my_what}->{xrefs} = $xrefs;
+	}
 }
 
 # Outputs the output on ReST format
@@ -128,8 +165,17 @@ sub output_rest {
 		my $w = $what;
 		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
 
+		if ($data{$what}->{label}) {
+			my @labels = split(/\s/, $data{$what}->{label});
+			foreach my $label (@labels) {
+				printf ".. _%s:\n\n", $label;
+			}
+		}
+
 		print "$w\n\n";
-		print "- defined on file $file (type: $type)\n\n::\n\n";
+
+		print "- defined on file $file (type: $type)\n\n" if ($type ne "File");
+		print "::\n\n";
 
 		my $desc = $data{$what}->{description};
 		$desc =~ s/^\s+//;
@@ -144,8 +190,11 @@ sub output_rest {
 		if (!($desc =~ /^\s*$/)) {
 			print " $desc\n\n";
 		} else {
-			print " DESCRIPTION MISSING\n\n";
+			print " DESCRIPTION MISSING for $what\n\n";
 		}
+
+		printf "Has the following ABI:\n\n%s", $data{$what}->{xrefs} if ($data{$what}->{xrefs});
+
 	}
 }
 
-- 
2.21.0

