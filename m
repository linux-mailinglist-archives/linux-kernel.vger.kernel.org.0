Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22A8BEDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfIZItC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 04:49:02 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:36840 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbfIZItB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 04:49:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9BFBB9079;
        Thu, 26 Sep 2019 08:49:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:4321:4362:5007:10004:10400:10848:11232:11658:11914:12048:12296:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21063:21080:21433:21627:30054:30070:30091,0,RBL:172.58.27.131:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: shop50_6b6c133c79719
X-Filterd-Recvd-Size: 1340
Received: from XPS-9350 (unknown [172.58.27.131])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Sep 2019 08:48:57 +0000 (UTC)
Message-ID: <698e9c5310003fb71dcc7e5b096c8a415c86cc8c.camel@perches.com>
Subject: Re: [PATCH v2] scripts: Move ipc/ to kernel/ipc/: don't check the
 ipc dir
From:   Joe Perches <joe@perches.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>, apw@canonical.com,
        mingo@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Sep 2019 01:48:27 -0700
In-Reply-To: <bd70558e-5126-6460-81d7-edf72cbbce7a@huawei.com>
References: <bd70558e-5126-6460-81d7-edf72cbbce7a@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-26 at 09:26 +0800, Yunfeng Ye wrote:
> After the commit 76128326f97c ("toplevel: Move ipc/ to kernel/ipc/: move
> the files"), we met some error messages:
> 
>   ./scripts/checkpatch.pl:
>   "Must be run from the top-level dir. of a kernel tree"
> 
>   ./scripts/get_maintainer.pl:
>   "The current directory does not appear to be a linux kernel source tree.
> 
> Don't check the ipc dir in checkpatch.pl and get_maintainer.pl.

Thanks.


