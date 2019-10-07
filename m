Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012DECE7A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfJGPeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 11:34:00 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:57724 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727947AbfJGPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:33:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 582B5180A8452;
        Mon,  7 Oct 2019 15:33:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2376:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3868:4250:5007:6119:8957:10004:10400:11026:11658:11914:12043:12296:12297:12438:12555:12760:13069:13095:13311:13357:13439:14181:14394:14659:14721:21080:21433:21451:21627:30054,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: pigs13_3fa3fecc87e3d
X-Filterd-Recvd-Size: 2029
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Oct 2019 15:33:57 +0000 (UTC)
Message-ID: <5ce6f9131327fd2e12d7a0e20a55f588448de090.camel@perches.com>
Subject: [PATCH] checkpatch: Improve ignoring CamelCase SI style variants
 like mA
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jules Irenge <jbi.octave@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 07 Oct 2019 08:33:56 -0700
In-Reply-To: <20191006190726.GB237538@kroah.com>
References: <20191006184903.12089-1-jbi.octave@gmail.com>
         <20191006190726.GB237538@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore all upper-case variants before and after SI units like
mA, mV and uV so uses like RANGE_mA do not emit a CAMELCASE message.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cf7543a9d1b2..edd20f7fa83c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5044,8 +5044,9 @@ sub process {
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
 #Ignore Page<foo> variants
 			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
-#Ignore SI style variants like nS, mV and dB (ie: max_uV, regulator_min_uA_show)
-			    $var !~ /^(?:[a-z_]*?)_?[a-z][A-Z](?:_[a-z_]+)?$/ &&
+#Ignore SI style variants like nS, mV and dB
+#(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
+			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
 #Ignore some three character SI units explicitly, like MiB and KHz
 			    $var !~ /^(?:[a-z_]*?)_?(?:[KMGT]iB|[KMGT]?Hz)(?:_[a-z_]+)?$/) {
 				while ($var =~ m{($Ident)}g) {


