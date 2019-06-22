Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370524F7B5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfFVSBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 14:01:23 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:43104 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbfFVSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 14:01:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 26E81100E86C2;
        Sat, 22 Jun 2019 18:01:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:6737:7903:7904:8957:9025:10004:10400:10848:10967:11026:11232:11657:11658:11914:12043:12048:12266:12297:12438:12555:12679:12740:12760:12895:13069:13161:13229:13311:13357:13439:14180:14181:14659:14721:21060:21063:21080:21365:21451:21627:30012:30054:30090:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: patch81_45b8c85498e5e
X-Filterd-Recvd-Size: 2250
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Jun 2019 18:01:19 +0000 (UTC)
Message-ID: <7ec724a310a710e6415320ff530daba0e1d30505.camel@perches.com>
Subject: Re: [tip:x86/cpu] x86/cpu: Create Zhaoxin processors architecture
 support file
From:   Joe Perches <joe@perches.com>
To:     HerryYang@zhaoxin.com, CooperYan@zhaoxin.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, lenb@kernel.org,
        gregkh@linuxfoundation.org, QiyuanWang@zhaoxin.com,
        mingo@kernel.org, DavidWang@zhaoxin.com, tglx@linutronix.de,
        rjw@rjwysocki.net, TonyWWang-oc@zhaoxin.com,
        linux-tip-commits@vger.kernel.org
Date:   Sat, 22 Jun 2019 11:01:17 -0700
In-Reply-To: <tip-761fdd5e3327db6c646a09bab5ad48cd42680cd2@git.kernel.org>
References: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>
         <tip-761fdd5e3327db6c646a09bab5ad48cd42680cd2@git.kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-06-22 at 03:16 -0700, tip-bot for Tony W Wang-oc wrote:
> Commit-ID:  761fdd5e3327db6c646a09bab5ad48cd42680cd2
> Gitweb:     https://git.kernel.org/tip/761fdd5e3327db6c646a09bab5ad48cd42680cd2
> Author:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> AuthorDate: Tue, 18 Jun 2019 08:37:05 +0000
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Sat, 22 Jun 2019 11:45:57 +0200
> 
> x86/cpu: Create Zhaoxin processors architecture support file
> 
[]
> diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
[]
> +static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
> +{
> +	u32  lo, hi;
> +
> +	/* Test for Extended Feature Flags presence */
> +	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
> +		u32 tmp = cpuid_edx(0xC0000001);
> +
> +		/* Enable ACE unit, if present and disabled */
> +		if ((tmp & (ACE_PRESENT | ACE_ENABLED)) == ACE_PRESENT) {

trivia:

Perhaps this is more intelligible for humans to read
and it deduplicates the comment as:

		if ((tmp & ACE_PRESENT) && !(tmp & ACE_ENABLED))

The compiler produces the same object code.


