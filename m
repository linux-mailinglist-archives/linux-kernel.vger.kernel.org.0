Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC4774663A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 19:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfFNRwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 13:52:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfFNRwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=586q93trGkcGISVFlxTu0MYtP/Zjkyx9dVxOsh9CY3I=; b=dqRYZrkf04xtsHWnCka2zGqutk
        oRuFMAWI9A+AFVO0O8vKCOqUY4JI8TffLDxxvrIpWRJOSOlL7N0bGlmtPguRll/B0ZSo6ivG3/hC/
        u58oTv8bsJmZZKkGgLNuumHhXBl09BFhu3pOqhz43px3OtUpuF5f2KHX56k9jM388O/CBcpm4gBDa
        O7k/6fKTszoAr9oNRTT8tzmaFd0G0TgFRmFRPFCSnnRxtKWGzfqa7Anbb4XXy3VNHVyrWPOAjPJrt
        /hU+UMNQFOL6Nt1azA+mwKrlEBVdIhWOwQEKq+UHi9hw244KSczOUN76wTAUDM/TywPnwXFK6czWK
        dmz2cctQ==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNT-0000Ph-Ag; Fri, 14 Jun 2019 17:52:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNM-0002PA-02; Fri, 14 Jun 2019 14:52:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 12/16] scripts/get_abi.pl: add a validate command
Date:   Fri, 14 Jun 2019 14:52:26 -0300
Message-Id: <d4c24e9ceb8f2f9bbabf663a7fa1caf365f286e2.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, we just want the parser to retrieve all symbols from
ABI, in order to check for parsing errors. So, add a new
"validate" command.

While here, update the man/help pages.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index c5038a0a7313..774e9b809ead 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -25,7 +25,7 @@ pod2usage(2) if (scalar @ARGV < 1 || @ARGV > 2);
 
 my ($cmd, $arg) = @ARGV;
 
-pod2usage(2) if ($cmd ne "search" && $cmd ne "rest");
+pod2usage(2) if ($cmd ne "search" && $cmd ne "rest" && $cmd ne "validate");
 pod2usage(2) if ($cmd eq "search" && !$arg);
 
 require Data::Dumper if ($debug);
@@ -82,7 +82,7 @@ sub parse_abi {
 			my $sep = $2;
 			my $content = $3;
 
-			if (!($new_tag =~ m/(what|date|kernelversion|contact|description|users)/)) {
+			if (!($new_tag =~ m/(what|where|date|kernelversion|contact|description|users)/)) {
 				if ($tag eq "description") {
 					# New "tag" is actually part of
 					# description. Don't consider it a tag
@@ -368,7 +368,7 @@ print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
 #
 if ($cmd eq "rest") {
 	output_rest;
-} else {
+} elsif ($cmd eq "search") {
 	search_symbols;
 }
 
@@ -381,7 +381,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug] <COMAND> [<ARGUMENT>]
+B<abi_book.pl> [--debug] [--man] [--help] [--dir=<dir>] <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
@@ -389,7 +389,9 @@ Where <COMMAND> can be:
 
 B<search> [SEARCH_REGEX] - search for [SEARCH_REGEX] inside ABI
 
-B<rest>   - output the ABI in ReST markup language
+B<rest>                  - output the ABI in ReST markup language
+
+B<validate>              - validate the ABI contents
 
 =back
 
@@ -451,11 +453,11 @@ $ scripts/get_abi.pl rest --dir Documentation/ABI/obsolete
 
 =head1 BUGS
 
-Report bugs to Mauro Carvalho Chehab <mchehab@s-opensource.com>
+Report bugs to Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
 
 =head1 COPYRIGHT
 
-Copyright (c) 2016-2017 by Mauro Carvalho Chehab <mchehab@s-opensource.com>.
+Copyright (c) 2016-2019 by Mauro Carvalho Chehab <mchehab+samsung@kernel.org>.
 
 License GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
 
-- 
2.21.0

