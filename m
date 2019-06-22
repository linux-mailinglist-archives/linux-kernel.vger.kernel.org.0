Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4176F4F73A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 18:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFVQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 12:58:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CxC6cqjGqc9XtHGJl6ZLatRT2nawIKpXe2aBjxo+zQE=; b=gqAdIH/t3AWNNiMAZf8TdUBiMg
        kXIct0J8S4T/EqTLVB2dOb06ui38IB7+FTJEnVc8ATjx9CjrZQ0eZCjwMlwbwavVjDyhsxR/ZCaUH
        rp+Y62hGWeCcwh1jjDfRF3RcAJnRsbeamBdlhtD1qS0zmjfWkH18hkxLo9vvIIE1jCsUYg48g0ix3
        Y+FOvmZdS1lgcOqA1fkjLkn8G7QhAFNTT7VxdD0KDZyqraYroh9Bc4wP4uH3DnGtIzv7i36S5prZy
        qfrA3TiWO5VuLYXSVAUzbHqTQUQOSkkjC/3TCXWBAxMDqX+3Vjyps1wdQ1ngPrdJVHWI+AeyvP5Hb
        g32l4YyA==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLu-00054s-He; Sat, 22 Jun 2019 16:58:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLr-0000vD-RS; Sat, 22 Jun 2019 13:58:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] scripts/get_abi.pl: fix parsing on ReST mode
Date:   Sat, 22 Jun 2019 13:58:43 -0300
Message-Id: <73fb0849e7832dfa010f790bfa2a3e47f0b0c57a.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the source ABI file is using ReST notation, the script
should handle whitespaces and lines with care, as otherwise
the file won't be properly recognized.

Address the bugs that are on such part of the script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 107672cdacb3..0c403af86fd5 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -151,7 +151,8 @@ sub parse_abi {
 						$content = $2;
 					}
 					while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-					$data{$what}->{$tag} .= $content;
+
+					$data{$what}->{$tag} .= "$content\n" if ($content);
 				} else {
 					$data{$what}->{$tag} = $content;
 				}
@@ -166,31 +167,28 @@ sub parse_abi {
 		}
 
 		if ($tag eq "description") {
+			my $content = $_;
+			while ($content =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
 			if (!$data{$what}->{description}) {
-				s/^($space)//;
-				if (m/^(\s*)(.*)/) {
-					my $sp = $1;
-					while ($sp =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-					my $content = "$sp$2";
-
-					$content =~ s/^($space)//;
-
-					$data{$what}->{$tag} .= "$content";
+				# Preserve initial spaces for the first line
+				if ($content =~ m/^(\s*)(.*)$/) {
+					$space = $1;
+					$content = $2;
 				}
+
+				$data{$what}->{$tag} .= "$content\n" if ($content);
 			} else {
-				my $content = $_;
 				if (m/^\s*\n/) {
 					$data{$what}->{$tag} .= $content;
 					next;
 				}
 
-				while ($content =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
 				$space = "" if (!($content =~ s/^($space)//));
 
-				# Compress spaces with tabs
-				$content =~ s<^ {8}> <\t>;
-				$content =~ s<^ {1,7}\t> <\t>;
-				$content =~ s< {1,7}\t> <\t>;
+#				# Compress spaces with tabs
+#				$content =~ s<^ {8}> <\t>;
+#				$content =~ s<^ {1,7}\t> <\t>;
+#				$content =~ s< {1,7}\t> <\t>;
 				$data{$what}->{$tag} .= $content;
 			}
 			next;
-- 
2.21.0

