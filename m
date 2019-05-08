Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF5317C9D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 16:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfEHOwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 10:52:50 -0400
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:53832 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727224AbfEHOws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:52:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0A3E7180A814F;
        Wed,  8 May 2019 14:52:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2687:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4250:4321:5007:7903:8603:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13311:13357:13439:14040:14659:21080:21433:21627:30012:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: sand63_18313cd388c03
X-Filterd-Recvd-Size: 1786
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 14:52:46 +0000 (UTC)
Message-ID: <73a79b49d0183468a63876b170d1318d38c78d73.camel@perches.com>
Subject: Re: [PATCH 4/4] checkpatch: replace magic value for TAB size
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 07:52:45 -0700
In-Reply-To: <20190508122721.7513-4-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
         <20190508122721.7513-4-borneo.antonio@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 14:27 +0200, Antonio Borneo wrote:
> The size of 8 characters used for both TAB and indentation is
> embedded as magic value allover the checkpatch script, and this
> makes the script less readable.
> 
> Replace the magic value 8 with the perl variable "$tabsize".
> From the context of the code it's clear if it is used for
> indentation or tabulation, so no need to use two separate
> variables.
> 
> As side benefit of this change, it makes easy to replace the TAB
> size when this script is used by other projects with different
> requirements in their coding style (e.g. OpenOCD [1] requires
> TAB size of 4 characters [2]).
> In these cases the script will be probably modified and adapted,
> so there is no need (at least for the moment) to expose this
> setting on the script's command line.

Disagree.  Probably getter to add a --tabsize=<foo> option now.


