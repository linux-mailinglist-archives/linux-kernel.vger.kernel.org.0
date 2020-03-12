Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168A0182D55
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 11:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCLKVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 06:21:43 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:42982 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgCLKVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:21:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5C1362C94;
        Thu, 12 Mar 2020 10:21:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3866:3867:3868:3871:3872:4321:5007:6119:10004:10400:10848:11232:11658:11914:12043:12297:12679:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: thumb39_48ee4dd62f451
X-Filterd-Recvd-Size: 1674
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Mar 2020 10:21:41 +0000 (UTC)
Message-ID: <81bad451e9ffee6990ffc3571bc7b558c1c26bb3.camel@perches.com>
Subject: Re: [PATCH -next 006/491] ARM/RISCPC ARCHITECTURE: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Date:   Thu, 12 Mar 2020 03:19:57 -0700
In-Reply-To: <20200312101130.GX25745@shell.armlinux.org.uk>
References: <cover.1583896344.git.joe@perches.com>
         <fb956ff22b89ac7a7f97489b29ecf13a32de8d06.1583896348.git.joe@perches.com>
         <20200312101130.GX25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-12 at 10:11 +0000, Russell King - ARM Linux admin wrote:
> On Tue, Mar 10, 2020 at 09:51:20PM -0700, Joe Perches wrote:
> > Convert the various uses of fallthrough comments to fallthrough;
> 
> And the point of what on the face of it seems to be useless churn is?
> 
> What compilers support this?

gcc 7.1, clang 9

clang does not support the /* fallthrough */ comment styles.

clang does support the __attribute__((__fallthrough__))
and the c++17 [[fallthrough]] weirdness.

see:

commit 294f69e662d1 ("compiler_attributes.h: Add 'fallthrough' pseudo
keyword for switch/case use")

