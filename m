Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CC181DE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 23:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfEHV7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 17:59:52 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:42754 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726837AbfEHV7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:59:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 69C172C12;
        Wed,  8 May 2019 21:59:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2551:2553:2559:2562:2687:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:4250:4321:4605:5007:7576:7903:7904:8603:8957:9121:9545:10004:10400:10848:11232:11658:11914:12043:12048:12050:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:21795:30034:30051:30054:30063:30070:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: dirt93_72df139f4a755
X-Filterd-Recvd-Size: 2459
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 21:59:49 +0000 (UTC)
Message-ID: <4ce8826150026abd7649acb7b9fc143a033b7720.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add command-line option for TAB size
From:   Joe Perches <joe@perches.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 08 May 2019 14:59:48 -0700
In-Reply-To: <AT5PR8401MB1169149078CDB1274A259703AB320@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190508174356.13952-1-borneo.antonio@gmail.com>
         <AT5PR8401MB1169149078CDB1274A259703AB320@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 21:14 +0000, Elliott, Robert (Servers) wrote:
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
> > Antonio Borneo
> > Sent: Wednesday, May 8, 2019 12:44 PM
> > Subject: [PATCH v2] checkpatch: add command-line option for TAB size
> ...
> > Add a command-line option "--tab-size" to let the user select a
> > TAB size value other than 8.
> > This makes easy to reuse this script by other projects with
> > different requirements in their coding style (e.g. OpenOCD [1]
> > requires TAB size of 4 characters [2]).
> ...
> > +  --tab-size=n               set the number of spaces for tab (default 8)
> ...
> > +	'tab-size=i'	=> \$tabsize,
> ...
> > -			for (; ($n % 8) != 0; $n++) {
> > +			for (; ($n % $tabsize) != 0; $n++) {
> ...
> > -			if ($indent % 8) {
> > +			if ($indent % $tabsize) {
> > -					"\t" x ($pos / 8) .
> > -					" "  x ($pos % 8);
> > +					"\t" x ($pos / $tabsize) .
> > +					" "  x ($pos % $tabsize);
> ...
> > -			    (($sindent % 8) != 0 ||
> > +			    (($sindent % $tabsize) != 0 ||
> ...
> > -			     ($sindent > $indent + 8))) {
> > +			     ($sindent > $indent + $tabsize))) {
> 
> Checking for 0 before using the value in division and modulo
> operations would be prudent.

true.

Maybe test $tabsize for <= 0 after GetOptions and error out
if so.


