Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43ADA26DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 21:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbfEVTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 15:45:13 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:47657 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731413AbfEVTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:45:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4EEC218224D70;
        Wed, 22 May 2019 19:45:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2892:2902:3138:3139:3140:3141:3142:3350:3622:3865:3867:3868:3871:3872:4321:5007:9010:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13161:13229:13311:13357:13439:14180:14181:14659:14721:21080:21627:30054:30060:30075:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: curve67_2d0c89522f351
X-Filterd-Recvd-Size: 1329
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 19:45:09 +0000 (UTC)
Message-ID: <7b7287463e830fa8d981dc440f8165622cbc628e.camel@perches.com>
Subject: Re: PSA: Do not use "Reported-By" without reporter's approval
From:   Joe Perches <joe@perches.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 May 2019 12:45:06 -0700
In-Reply-To: <20190522193011.GB21412@chatter.i7.local>
References: <20190522193011.GB21412@chatter.i7.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 15:30 -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> It is common courtesy to include this tagline when submitting patches: 
> 
> Reported-By: J. Doe <jdoe@example.com>
> 
> Please ask the reporter's permission before doing so (even if they'd 
> submitted a public bugzilla report or sent a report to the mailing 
> list).

I disagree with this.

If the report is public, and lists like vger are public,
then using a Reported-by: and/or a Link: are simply useful
history and tracking information.


