Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5FA32484
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2019 20:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfFBSEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 14:04:33 -0400
Received: from smtprelay0190.hostedemail.com ([216.40.44.190]:38314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbfFBSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 14:04:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5FD4E83777EE;
        Sun,  2 Jun 2019 18:04:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:69:152:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6117:6119:7264:7903:7904:10004:10400:10848:11232:11658:11914:12043:12050:12663:12683:12740:12895:13019:13053:13069:13146:13230:13311:13357:13894:14096:14097:14181:14659:14721:21080:21611:21627:30012:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: spot30_618cb00fb963a
X-Filterd-Recvd-Size: 2528
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Jun 2019 18:04:30 +0000 (UTC)
Message-ID: <f53401a0aba4c20b542ae89860bef371077d693f.camel@perches.com>
Subject: Re: checkpatch query regarding .c and .h files..
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Rob Herring <robh@kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Date:   Sun, 02 Jun 2019 11:04:28 -0700
In-Reply-To: <25942.1559494964@turing-police>
References: <25942.1559494964@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-02 at 13:02 -0400, Valdis Klētnieks wrote:
> scripts/checkpatch.pl contains this code near line 3070:
> 
>                                if ($realfile =~ /\.(h|s|S)$/) {
>                                         $comment = '/*';
>                                 } elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
>                                         $comment = '//';
>                                 } elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc)$/) {
>                                         $comment = '#';
>                                 } elsif ($realfile =~ /\.rst$/) {
>                                         $comment = '..';
>                                 }
> 
> Was there a specific reason why .h files have /* */ and .c files have C89 // on
> the SPDX comment line?
> 
> Would anybody like a patch that fixed checkpatch to allow either flavor on .c and .h files?
> (I know I would, I just blew close to an hour trying to figure out why it whined about a
> SPDX in a .h file I'm getting ready to upstream...)

It's described in Documentation/process/license-rules.rst

----------------------------------

2. Style:

   The SPDX license identifier is added in form of a comment.  The comment
   style depends on the file type::

      C source:	// SPDX-License-Identifier: <SPDX License Expression>
      C header:	/* SPDX-License-Identifier: <SPDX License Expression> */

----------------------------------

It was because old versions of build tools could not handle
// in asm files.

It could be changed today because build tool version minimums
have been increased.



