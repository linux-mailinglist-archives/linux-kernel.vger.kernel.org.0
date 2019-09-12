Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D454B1578
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 22:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfILUey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 16:34:54 -0400
Received: from smtprelay0037.hostedemail.com ([216.40.44.37]:58531 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727250AbfILUex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:34:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B7E4E837F24A;
        Thu, 12 Sep 2019 20:34:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3871:3874:4321:5007:10004:10400:10562:10848:11232:11658:11914:12297:12740:12760:12895:13019:13069:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:17,LUA_SUMMARY:none
X-HE-Tag: wood38_47427da86d73d
X-Filterd-Recvd-Size: 1803
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 20:34:49 +0000 (UTC)
Message-ID: <4299c79e33f22e237e42515ea436f187d8beb32e.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
From:   Joe Perches <joe@perches.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Tobin C. Harding" <me@tobin.cc>
Date:   Thu, 12 Sep 2019 13:34:48 -0700
In-Reply-To: <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
         <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
         <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
         <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 13:01 -0700, Bart Van Assche wrote:

> Another argument in favor of W=1 is that the formatting of kernel-doc
> headers is checked only if W=1 is passed to make.

Actually, but for the fact there are far too many
to generally enable that warning right now,
(an x86-64 defconfig has more than 1000)
that sounds pretty reasonable to me.



