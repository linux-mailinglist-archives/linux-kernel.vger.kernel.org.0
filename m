Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4EE2C51B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 13:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfE1LF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 07:05:28 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:52691 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbfE1LF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:05:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 022CA182CED34;
        Tue, 28 May 2019 11:05:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:4321:5007:10004:10400:10848:11026:11658:11914:12043:12296:12438:12555:12740:12760:12895:12986:13069:13132:13231:13311:13357:13439:14096:14097:14659:14721:21080:21212:21627:30029:30054:30069:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:36,LUA_SUMMARY:none
X-HE-Tag: legs83_4c81ae6e44a07
X-Filterd-Recvd-Size: 2509
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 May 2019 11:05:25 +0000 (UTC)
Message-ID: <6cc73c5454785faec229c8b78e63170e021a7c0d.camel@perches.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: ratelimit recovery messages
From:   Joe Perches <joe@perches.com>
To:     Chao Yu <yuchao0@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>,
        Sahitya Tummala <stummala@codeaurora.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Date:   Tue, 28 May 2019 04:05:24 -0700
In-Reply-To: <0341eb2c-6788-1c85-2036-ed57b7f99dab@huawei.com>
References: <1558962655-25994-1-git-send-email-stummala@codeaurora.org>
         <94025a6d-f485-3811-5521-ed5c9b4d1d77@huawei.com>
         <20190528030509.GE10043@codeaurora.org>
         <2575bd54-d67c-6b26-ebf7-d6adb2e193a7@huawei.com>
         <b5665201-d13d-5fcb-100d-21630960e5f1@huawei.com>
         <0341eb2c-6788-1c85-2036-ed57b7f99dab@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-28 at 15:37 +0800, Chao Yu wrote:
[]
> > > > > > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
[]
> > > > > > @@ -188,8 +188,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
> > > > > >  		name = "<encrypted>";
> > > > > >  	else
> > > > > >  		name = raw_inode->i_name;
> > > > > > -	f2fs_msg(inode->i_sb, KERN_NOTICE,
> > > > > > -			"%s: ino = %x, name = %s, dir = %lx, err = %d",
> > > > > > +	printk_ratelimited(KERN_NOTICE
> > > > > > +			"%s: ino = %x, name = %s, dir = %lx, err = %d\n",
> > > > > >  			__func__, ino_of_node(ipage), name,
> > > > > >  			IS_ERR(dir) ? 0 : dir->i_ino, err);

Probably better to add and use a f2fs_msg_ratelimited macro.

And the generic f2fs_msg should add printf
format and argument verification.
---
 fs/f2fs/f2fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b3d9977cd1e..2373bc3cb267 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1798,6 +1798,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	return -ENOSPC;
 }
 
+__printf(3, 4)
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,


