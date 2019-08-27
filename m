Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90F969F163
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 19:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfH0RVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 13:21:05 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:55187 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726871AbfH0RVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:21:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EF1A618045A64;
        Tue, 27 Aug 2019 17:21:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2525:2559:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3870:3871:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6119:7903:9025:9391:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12555:12679:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14181:14659:14721:14777:14913:21080:21212:21221:21433:21451:21627:21819:30012:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:48,LUA_SUMMARY:none
X-HE-Tag: dime76_435d6d917c65a
X-Filterd-Recvd-Size: 2830
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 27 Aug 2019 17:21:02 +0000 (UTC)
Message-ID: <94f293d3d31e9f686e601e2e3c972ae371a40585.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for nested (un)?likely calls
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 27 Aug 2019 10:21:01 -0700
In-Reply-To: <20190827165515.21668-1-efremov@linux.com>
References: <20190827165515.21668-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-27 at 19:55 +0300, Denis Efremov wrote:
> IS_ERR, IS_ERR_OR_NULL, IS_ERR_VALUE already contain unlikely optimization
> internally. Thus, there is no point in calling these functions under
> likely/unlikely.
> 
> This check is based on the coccinelle rule developed by Enrico Weigelt
> https://lore.kernel.org/lkml/1559767582-11081-1-git-send-email-info@metux.net/
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6480,6 +6480,13 @@ sub process {
>  			     "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
>  		}
>  
> +# nested likely/unlikely calls
> +		if ($perl_version_ok &&
> +		    $line =~ /\b(?:(?:un)?likely)\s*\(!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?)\s*${balanced_parens}\s*\)/) {
> +			WARN("LIKELY_MISUSE",
> +			     "nested (un)?likely calls, unlikely already used in $1 internally\n" . $herecurr);
> +		}
> +

Couple things:

1:

Are you going to submit patches for the just 10 instances that exist?

$ git grep -P -n '\b(?:(?:un)?likely)\s*\(!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?)\s*\([^\)]+\)\s*\)'
arch/x86/kernel/irq.c:246:      if (likely(!IS_ERR_OR_NULL(desc))) {
drivers/infiniband/hw/hfi1/verbs.c:1044:        if (unlikely(IS_ERR_OR_NULL(pbuf))) {
drivers/input/mouse/alps.c:1479:        } else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
fs/ntfs/mft.c:74:       if (likely(!IS_ERR(page))) {
fs/ntfs/mft.c:157:      if (likely(!IS_ERR(m)))
fs/ntfs/mft.c:274:              if (likely(!IS_ERR(m))) {
fs/ntfs/mft.c:1779:             if (likely(!IS_ERR(rl2)))
fs/ntfs/namei.c:118:            if (likely(!IS_ERR(dent_inode))) {
fs/ntfs/runlist.c:954:  if (likely(!IS_ERR(old_rl)))
include/net/udp.h:483:  if (unlikely(IS_ERR_OR_NULL(segs))) {

2:

This will not warn about code like:

fs/ntfs/mft.c:  if (unlikely(IS_ERR(rl) || !rl->length || rl->lcn < 0)) {

that could probably be better written as:

		if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {


