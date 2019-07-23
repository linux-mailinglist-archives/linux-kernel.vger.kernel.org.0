Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBED171784
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 13:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389335AbfGWLy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 07:54:27 -0400
Received: from smtprelay0163.hostedemail.com ([216.40.44.163]:58337 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387844AbfGWLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:54:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 49F54100E86C4;
        Tue, 23 Jul 2019 11:54:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7903:8985:9025:10004:10400:10848:11232:11658:11914:12043:12297:12555:12679:12681:12740:12760:12895:12986:13069:13311:13357:13439:13846:14180:14181:14659:14721:21060:21080:21451:21627:21795:21811:30046:30051:30054:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: soda70_7dbfed95b2e44
X-Filterd-Recvd-Size: 2059
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 11:54:24 +0000 (UTC)
Message-ID: <45d65cf7546fcb5f2195cc831fa60dea20098802.camel@perches.com>
Subject: Re: get_maintainers.pl subsystem output
From:   Joe Perches <joe@perches.com>
To:     "Duda, Sebastian" <sebastian.duda@fau.de>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        ralf.ramsauer@oth-regensburg.de, wolfgang.mauerer@oth-regensburg.de
Date:   Tue, 23 Jul 2019 04:54:22 -0700
In-Reply-To: <2835dfa18922905ffabafb11fca7e1d2@fau.de>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
         <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
         <2835dfa18922905ffabafb11fca7e1d2@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 09:29 +0200, Duda, Sebastian wrote:
> Hi Joe,
> 
> when analyzing the patch 
> `<20150128012747.824898918@linuxfoundation.org>` [1] with 

https://lore.kernel.org/lkml/220150128012747.824898918@linuxfoundation.org

> `get_maintainers.pl --subsystem --status --separator , /tmp/patch`, 
> there is the following output:

[]

> > Run the script with multiple invocations. once for each file
> > modified by the patch.

For example: perhaps use something like:

$ grep -h '^\+\+\+ b/' <patch> | \
  sed 's@^\+\+\+ b/@@' | sort | uniq | \
  while read file ; do \
    ./scripts/get_maintainer.pl --nogit --nogit-fallback --subsystem --status --separator , $file ; \
  done

or use parallel like:

$ grep -h '^\+\+\+ b/' <patch> | \
  sed 's@^\+\+\+ b/@@' | sort | uniq | \
  parallel -k ./scripts/get_maintainer.pl --nogit --nogit-fallback --subsystem --status --separator ,

runtime on my system for this is

Using while read loop:

real	0m2.509s
user	0m2.236s
sys	0m0.296s

Using parallel:

real	0m1.340s
user	0m4.159s
sys	0m0.429s


