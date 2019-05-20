Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E19FE237B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbfETM4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 08:56:45 -0400
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:49686 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728898AbfETM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:56:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C0A8818224D8A;
        Mon, 20 May 2019 12:56:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1536:1559:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3871:3874:3876:4321:5007:10004:10400:10848:11232:11658:11914:12196:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:30,LUA_SUMMARY:none
X-HE-Tag: salt35_66507bbc90e
X-Filterd-Recvd-Size: 974
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 May 2019 12:56:42 +0000 (UTC)
Message-ID: <ed26df86d7d0e12263404842895460b1611def61.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add test for empty line after Fixes
 statement
From:   Joe Perches <joe@perches.com>
To:     Michal Kalderon <michal.kalderon@marvell.com>, leon@kernel.org,
        apw@canonical.com
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 20 May 2019 05:56:36 -0700
In-Reply-To: <20190520124238.10298-1-michal.kalderon@marvell.com>
References: <20190520124238.10298-1-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-20 at 15:42 +0300, Michal Kalderon wrote:
> Check that there is no empty line after a fixes statement

why?


