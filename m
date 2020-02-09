Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F81156B45
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Feb 2020 16:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgBIPy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Feb 2020 10:54:56 -0500
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:35201 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727514AbgBIPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 10:54:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 13C4D499606;
        Sun,  9 Feb 2020 15:54:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2902:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:9707:10004:10400:10848:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21611:21627:21795:21939:21966:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: oven90_64c8e8bfe430b
X-Filterd-Recvd-Size: 2080
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Feb 2020 15:54:52 +0000 (UTC)
Message-ID: <c6db92330696e0e1145103b4e59bf30a982f5e4b.camel@perches.com>
Subject: Re: [PATCH v5] dynamic_debug: allow to work if debugfs is disabled
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>,
        Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Sun, 09 Feb 2020 07:53:38 -0800
In-Reply-To: <20200209110549.GA1621867@kroah.com>
References: <20200209110549.GA1621867@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-09 at 12:05 +0100, Greg Kroah-Hartman wrote:
> With the realization that having debugfs enabled on "production" systems
> is generally not a good idea, debugfs is being disabled from more and
> more platforms over time.  However, the functionality of dynamic
> debugging still is needed at times, and since it relies on debugfs for
> its user api, having debugfs disabled also forces dynamic debug to be
> disabled.
> 
> To get around this, also create the "control" file for dynamic_debug in
> procfs.  This allows people turn on debugging as needed at runtime for
> individual driverfs and subsystems.
> 
> Reported-by: many different companies
> Cc: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v5: as many people asked for it, now enable the control file in both
>     debugfs and procfs at the same time.

So now there can be differences in the two control files
and these are readable files are sometimes parsed by
scripts.

It'd be better to figure out how to soft link the files.


