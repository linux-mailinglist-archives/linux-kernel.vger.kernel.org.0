Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06AFE0E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 16:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfKOPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 10:09:40 -0500
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:45530 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727406AbfKOPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 10:09:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 7F1888383F91;
        Fri, 15 Nov 2019 15:09:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:979:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3872:3873:4321:4383:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21450:21451:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: death47_53dfe8b37a120
X-Filterd-Recvd-Size: 1331
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 15 Nov 2019 15:09:36 +0000 (UTC)
Message-ID: <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
Subject: Re: [PATCH] checkpatch: whitelist Originally-by: signature
From:   Joe Perches <joe@perches.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 15 Nov 2019 07:09:17 -0800
In-Reply-To: <20191115150202.15208-1-erosca@de.adit-jv.com>
References: <20191115150202.15208-1-erosca@de.adit-jv.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 16:02 +0100, Eugeniu Rosca wrote:
> Oftentimes [1], the contributor would like to honor or give credits [2]
> to somebody's original ideas in the submission/reviewing process. While
> "Co-developed-by:" and "Suggested-by:" (currently whitelisted) could be
> employed for this purpose, they are not ideal.

You need to get the use of this accepted into Documentation/process
before adding it to checkpatch


