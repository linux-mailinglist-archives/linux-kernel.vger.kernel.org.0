Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7152167E63
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 14:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgBUNWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 08:22:13 -0500
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:41198 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727053AbgBUNWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:22:12 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id B0CA21802ED70;
        Fri, 21 Feb 2020 13:22:11 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B5B61182CED34;
        Fri, 21 Feb 2020 13:22:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1539:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3866:4321:5007:6114:6642:8957:10004:10400:10848:11026:11473:11658:11914:12296:12297:12438:12555:12760:13069:13311:13357:13439:14181:14659:14721:21080:21627:21990:30054:30070:30075,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: badge02_300193163bd5e
X-Filterd-Recvd-Size: 1390
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Feb 2020 13:22:09 +0000 (UTC)
Message-ID: <862518f826b35cd010a2e46f64f6f4cfa0d44582.camel@perches.com>
Subject: [trivial PATCH] cifs: Use #define in cifs_dbg
From:   Joe Perches <joe@perches.com>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Feb 2020 05:20:45 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other uses of cifs_dbg use defines so change this one.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/cifs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index b5e663..cd95e0 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -653,8 +653,8 @@ cifs_all_info_to_fattr(struct cifs_fattr *fattr, FILE_ALL_INFO *info,
 		 */
 		if ((fattr->cf_nlink < 1) && !tcon->unix_ext &&
 		    !info->DeletePending) {
-			cifs_dbg(1, "bogus file nlink value %u\n",
-				fattr->cf_nlink);
+			cifs_dbg(VFS, "bogus file nlink value %u\n",
+				 fattr->cf_nlink);
 			fattr->cf_flags |= CIFS_FATTR_UNKNOWN_NLINK;
 		}
 	}


