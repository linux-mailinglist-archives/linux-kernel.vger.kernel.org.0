Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A65EF4A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 06:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfKEE75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 23:59:57 -0500
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:57286 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387399AbfKEE75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:59:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 412FF1801A991;
        Tue,  5 Nov 2019 04:59:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:152:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:3138:3139:3140:3141:3142:3622:3867:3872:3874:4043:4321:5007:7903:10004:10400:10848:11232:11658:11914:12297:12740:12895:13069:13311:13357:13894:14659:21080:21451:21627:21939:30012:30054:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: tiger32_90babfc2ae605
X-Filterd-Recvd-Size: 1412
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Nov 2019 04:59:54 +0000 (UTC)
Message-ID: <4df246124153bcece639fdd026c4eee629b4bb7a.camel@perches.com>
Subject: Re: [PATCH 0/3] drm/tegra: Remove space after parenthesis
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Jamal Shareef <jamal.k.shareef@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, thierry.reding@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 04 Nov 2019 20:59:43 -0800
In-Reply-To: <20191105045337.GB1764@qmqm.qmqm.pl>
References: <cover.1572920482.git.jamal.k.shareef@gmail.com>
         <20191105045337.GB1764@qmqm.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 05:53 +0100, Michał Mirosław wrote:
> On Mon, Nov 04, 2019 at 06:23:19PM -0800, Jamal Shareef wrote:
> > This patchset removes spaces after left open parenthesis.
> > Issue found by checkpatch.
> 
> I'd say that those spaces make code easier to look at, so it would
> be better to teach checkpatch to ignore cases like these.

Good luck with that.


