Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E904C1858AA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 03:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgCOCR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Mar 2020 22:17:27 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:39758 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727053AbgCOCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:17:27 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 46150180373CD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:10:26 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 17EDB18029DAE;
        Sat, 14 Mar 2020 19:10:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3865:3866:3867:4321:5007:6119:7903:8957:10004:10400:10848:11658:11914:12297:12346:12555:12679:12760:12986:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30012:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: honey36_3b71627ac205
X-Filterd-Recvd-Size: 1364
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Mar 2020 19:10:25 +0000 (UTC)
Message-ID: <f0b213d90e0c2138bedcc4822063dde2650f787f.camel@perches.com>
Subject: vim: linux-kernel: Add "fallthrough" as a keyword
From:   Joe Perches <joe@perches.com>
To:     Vivien Didelot <vivien.didelot@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 14 Mar 2020 12:08:40 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fallthrough as a keyword for source code highlighting as
fallthrough was added as a pseudo-keyword macro to replace the
various forms of switch/case /* fallthrough */ comments.

Signed-off-by: Joe Perches <joe@perches.com>
---
 plugin/linuxsty.vim | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
index 18b28..44824 100644
--- a/plugin/linuxsty.vim
+++ b/plugin/linuxsty.vim
@@ -69,6 +69,7 @@ function s:LinuxFormatting()
 endfunction
 
 function s:LinuxKeywords()
+    syn keyword cStatement fallthrough
     syn keyword cOperator likely unlikely
     syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
     syn keyword cType __u8 __u16 __u32 __u64 __s8 __s16 __s32 __s64

