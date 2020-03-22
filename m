Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A51918E97A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Mar 2020 15:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCVO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 10:57:52 -0400
Received: from smtprelay0099.hostedemail.com ([216.40.44.99]:53152 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgCVO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 10:57:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8E4F0182CF665;
        Sun, 22 Mar 2020 14:57:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2691:2828:2901:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:4321:5007:7576:10004:10400:10848:11026:11232:11473:11658:11914:12043:12295:12296:12297:12740:12760:12895:13069:13138:13231:13311:13357:13439:14181:14659:14721:21080:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: steel34_a211d3b44761
X-Filterd-Recvd-Size: 1815
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Mar 2020 14:57:49 +0000 (UTC)
Message-ID: <d88cce8ff37f336087899226668abcbcacd96baa.camel@perches.com>
Subject: Re: [PATCH v2] f2fs: fix potential .flags overflow on 32bit
 architecture
From:   Joe Perches <joe@perches.com>
To:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Date:   Sun, 22 Mar 2020 07:56:01 -0700
In-Reply-To: <20200322135614.10413-1-chao@kernel.org>
References: <20200322135614.10413-1-chao@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-22 at 21:56 +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
> 
> To fix this issue, let's expand .flags as an array to grab enough
> space to store new flags.
[]
> +static inline void __set_inode_flag(struct inode *inode, int flag)
> +{
> +	if (!test_bit(flag % BITS_PER_LONG,
> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]))
> +		set_bit(flag % BITS_PER_LONG,
> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]);
> +}

I believe you don't need to do anything like this
but just let test_bit and set_bit do the indexing.

	if (!test_bit(flg, F2FS_I(inode->flags)))
		set_bit(flag, F2FS_I(inode->flags));

And there already is a function called test_and_set_bit()


