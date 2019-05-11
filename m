Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C821A1A844
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 17:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfEKPf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 11:35:57 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:47964 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728604AbfEKPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 11:35:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 694EE837F27D;
        Sat, 11 May 2019 15:35:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:966:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:4321:4385:5007:8603:10004:10400:10848:11026:11232:11658:11914:12296:12555:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: ant46_8ada80935915e
X-Filterd-Recvd-Size: 2045
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 May 2019 15:35:54 +0000 (UTC)
Message-ID: <eb1862ebb97f41dcdf85abbea43a22d51ec94c9c.camel@perches.com>
Subject: Re: [PATCH] afs: remove redundant assignment to variable ret
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 11 May 2019 08:35:52 -0700
In-Reply-To: <20190511123603.3265-1-colin.king@canonical.com>
References: <20190511123603.3265-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-11 at 13:36 +0100, Colin King wrote:
> The variable ret is being assigned a value however this is never
> read and later it is being reassigned to a new value. The assignment
> is redundant and hence can be removed.
[]
> diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
[]
> @@ -71,7 +71,6 @@ static int afs_xattr_get_acl(const struct xattr_handler *handler,
>  	if (ret == 0) {
>  		ret = acl->size;
>  		if (size > 0) {
> -			ret = -ERANGE;
>  			if (acl->size > size)
>  				return -ERANGE;
>  			memcpy(buffer, acl->data, acl->size);

It looks like the ret = acl->size immediately
after the memcpy should be removed as well.
---
 fs/afs/xattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index c81f85003fc7..e21de2f166a4 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -71,11 +71,9 @@ static int afs_xattr_get_acl(const struct xattr_handler *handler,
 	if (ret == 0) {
 		ret = acl->size;
 		if (size > 0) {
-			ret = -ERANGE;
 			if (acl->size > size)
 				return -ERANGE;
 			memcpy(buffer, acl->data, acl->size);
-			ret = acl->size;
 		}
 		kfree(acl);
 	}


