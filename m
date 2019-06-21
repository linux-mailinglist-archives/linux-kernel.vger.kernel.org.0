Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B64E811
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 14:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfFUMck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 08:32:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFUMcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jfDLdG1JsACai41gG2VqGBxF4feZMwdDcvPG6u5absg=; b=Wyi4/zh+yGcOfgEWXQiYy40PYF
        UP+jNmsJlF7fvLJPjodWQBBEyFFgJ15bo1yZcC6OvYJFjh9b9ddYbWgVHIZUatdD0LH33tAne/ANB
        CSkZMtYHb3rpdvvCFpOQnC+pcWH5/ndsCEuiOlv9PrqYkX2t5gvCMysxGuxndXUKM/Wxfb3dqOjMm
        cwRaqUo1Wh66Qa5nQgVEXEZzbjs9/HMWs2Q13uGGRJivmbe9alcwBd/eE1FBh9E9MGMOhXaVkwBxU
        9rzwwB4S6VUMWdjECJHne4eeT+wAuknt41jG+V4hPAyH395FkYK12EGHTZAOdsMStaX/bxjD+Npw6
        QJu+lw6g==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heIiA-0003xN-E9; Fri, 21 Jun 2019 12:32:10 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1heIi7-0001Ev-Qd; Fri, 21 Jun 2019 09:32:07 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RFC 1/6] get_abi.pl: fix parsing on ReST mode
Date:   Fri, 21 Jun 2019 09:32:01 -0300
Message-Id: <25e3e20ef1a300ce2bb6f87dfbdc12dbdd7ffcb0.1561118631.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561118631.git.mchehab+samsung@kernel.org>
References: <cover.1561118631.git.mchehab+samsung@kernel.org>
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
index e2cd2234af34..03f3c57af7ab 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -159,7 +159,8 @@ sub parse_abi {
 						$content = $2;
 					}
 					while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-					$data{$what}->{$tag} .= $content;
+
+					$data{$what}->{$tag} .= "$content\n" if ($content);
 				} else {
 					$data{$what}->{$tag} = $content;
 				}
@@ -174,31 +175,28 @@ sub parse_abi {
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

