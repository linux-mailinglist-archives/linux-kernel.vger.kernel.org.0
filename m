Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD7C75B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 01:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfGYXTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 19:19:02 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:35600 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbfGYXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:19:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 42B0A181D33FC;
        Thu, 25 Jul 2019 23:19:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3872:3874:4321:5007:6691:6742:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21433:21627:30054:30055:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: sand48_6b5f3660fae4f
X-Filterd-Recvd-Size: 1709
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jul 2019 23:18:57 +0000 (UTC)
Message-ID: <ad5ec66830b502d68e6d3c814706b52490418f0f.camel@perches.com>
Subject: Re: [tip:perf/urgent] perf/x86/intel: Mark expected switch
 fall-throughs
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        gustavo@embeddedor.com, torvalds@linux-foundation.org,
        acme@kernel.org, kan.liang@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, keescook@chromium.org,
        linux-tip-commits@vger.kernel.org
Date:   Thu, 25 Jul 2019 16:18:56 -0700
In-Reply-To: <20190725173521.GM31381@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
         <tip-289a2d22b5b611d85030795802a710e9f520df29@git.kernel.org>
         <20190725170613.GC27348@nazgul.tnic>
         <20190725173521.GM31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 19:35 +0200, Peter Zijlstra wrote:
> Seriously though; I detest these patches and we really, as in _really_
> should have done that attribute thing.

At least it'll be fairly easy to convert to something
sensible later.

Variants of the equivalent of:

s@/* fallthrough */@fallthrough;@

with some trivial whitespace reformatting will read
_much_ better.

It's pretty scriptable.


