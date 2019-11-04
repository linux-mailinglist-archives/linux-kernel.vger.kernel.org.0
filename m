Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4EEE119
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 14:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfKDN2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 08:28:19 -0500
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:58063 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727236AbfKDN2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:28:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C13FB182CED2A;
        Mon,  4 Nov 2019 13:28:17 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::::::::::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3743:3865:3867:3868:3870:3873:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4362:5007:6248:6261:6742:7875:9025:9040:10004:10400:10848:10967:11232:11657:11658:11914:12043:12114:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:14777:21080:21433:21627:30054:30070:30090:30091,0,RBL:146.247.46.6:@goodmis.org:.lbl8.mailshell.net-62.8.41.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: rain90_db18710e4e53
X-Filterd-Recvd-Size: 1789
Received: from grimm.local.home (unknown [146.247.46.6])
        (Authenticated sender: rostedt@goodmis.org)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Nov 2019 13:28:13 +0000 (UTC)
Date:   Mon, 4 Nov 2019 08:28:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Torsten Duwe <duwe@suse.de>, linux-arm-kernel@lists.infradead.org,
        Jessica Yu <jeyu@kernel.org>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, amit.kachhap@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 2/8] module/ftrace: handle patchable-function-entry
Message-ID: <20191104082810.70f1b72a@grimm.local.home>
In-Reply-To: <20191031130022.GB3477@blommer>
References: <20191029165832.33606-1-mark.rutland@arm.com>
        <20191029165832.33606-3-mark.rutland@arm.com>
        <20191030150302.GA965@suse.de>
        <20191031090231.GA3340@blommer>
        <20191031114223.GA11684@suse.de>
        <20191031130022.GB3477@blommer>
X-Mailer: Claws Mail 3.17.4git49 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 13:00:22 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> Sure. I've folded the above into this patch, and pushed out an updated branch:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/ftrace-with-regs

Just to keep this change in lore, can you at a minimum reply to this
patch's thread with the new update?

Thanks!

-- Steve
