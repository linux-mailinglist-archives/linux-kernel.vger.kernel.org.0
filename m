Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31F019AEA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbgDAPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 11:19:51 -0400
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:44396 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732504AbgDAPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:19:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E5210180238C3;
        Wed,  1 Apr 2020 15:19:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3872:3874:4250:4321:5007:6119:7550:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12679:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: plane54_3880c5014bc02
X-Filterd-Recvd-Size: 2018
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Apr 2020 15:19:48 +0000 (UTC)
Message-ID: <9de4fb8fa1223fc61d6d8d8c41066eea3963c12e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn about data_race() without comment
From:   Joe Perches <joe@perches.com>
To:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        Will Deacon <will@kernel.org>
Date:   Wed, 01 Apr 2020 08:17:52 -0700
In-Reply-To: <20200401101714.44781-1-elver@google.com>
References: <20200401101714.44781-1-elver@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-01 at 12:17 +0200, Marco Elver wrote:
> Warn about applications of data_race() without a comment, to encourage
> documenting the reasoning behind why it was deemed safe.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5833,6 +5833,14 @@ sub process {
>  			}
>  		}
>  
> +# check for data_race without a comment.
> +		if ($line =~ /\bdata_race\s*\(/) {
> +			if (!ctx_has_comment($first_line, $linenr)) {
> +				WARN("DATA_RACE",
> +				     "data_race without comment\n" . $herecurr);
> +			}
> +		}
> +
>  # check for smp_read_barrier_depends and read_barrier_depends
>  		if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
>  			WARN("READ_BARRIER_DEPENDS",

Sensible enough but it looks like ctx_has_comment should
be updated to allow c99 comments too, but that should be
a separate change from this patch.

Otherwise, this style emits a message:

WARNING: data_race without comment
#135: FILE: kernel/rcu/tasks.h:135:
+	int i = data_race(rtp->gp_state); // Let KCSAN detect update races

