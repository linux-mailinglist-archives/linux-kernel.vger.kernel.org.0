Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3978110FAEE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2019 10:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLCJja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Dec 2019 04:39:30 -0500
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:45879 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbfLCJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:39:29 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DD905100E7B4E;
        Tue,  3 Dec 2019 09:39:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3653:3866:3871:3873:3874:4321:4823:5007:6119:7903:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: uncle09_8cd93dde3eb45
X-Filterd-Recvd-Size: 1707
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Dec 2019 09:39:27 +0000 (UTC)
Message-ID: <7d7c97b0d2aea09f32688bd6644af72b4be121d4.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Look for Kconfig indentation errors
From:   Joe Perches <joe@perches.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date:   Tue, 03 Dec 2019 01:38:54 -0800
In-Reply-To: <874kyhkbje.fsf@intel.com>
References: <1574906800-19901-1-git-send-email-krzk@kernel.org>
         <87a78gnyaz.fsf@intel.com>
         <ab3309596fac1c5a0cb4e0abed0cf1ee7ac13a3d.camel@perches.com>
         <CAJKOXPdqn7+ucwqu2vJFL9ggCerpBz1qN6BSJvcsi4BQ3DU6fg@mail.gmail.com>
         <ea57f41e30f962227855d4f60a93c89a6bf0b2f0.camel@perches.com>
         <874kyhkbje.fsf@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-03 at 11:23 +0200, Jani Nikula wrote:
> Alternatively, perhaps you could complain about indentation that is not
> one of 1) empty string, 2) exactly one tab, or 3) exactly one tab
> followed by exactly two spaces?

Way too many false positives.

Try something like:

$ git grep -P -oh "^\s*\w+\b" -- '*/Kconfig*' | \
  perl -p -e 'my $tabs=0;my $spaces=0;while ($_ =~ /^\s/) { if (substr($_,0,1) eq " ") { $spaces++; } else { $tabs++; } $_ = substr($_, 1); } print "tabs: $tabs spaces: $spaces: word: $_";'


