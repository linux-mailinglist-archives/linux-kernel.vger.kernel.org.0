Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95586B26B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 22:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfIMUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 16:33:19 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:46641 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbfIMUdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:33:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F12BD18224D86;
        Fri, 13 Sep 2019 20:33:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3872:3874:4321:4419:4605:5007:6119:6742:7903:10004:10400:10562:10848:10946:10967:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30054:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: tub87_73cd010985e19
X-Filterd-Recvd-Size: 3342
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Sep 2019 20:33:15 +0000 (UTC)
Message-ID: <8be2df9936fb405ffaee75d6e24bbac0e938a653.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Rob Herring <robherring2@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
Date:   Fri, 13 Sep 2019 13:33:14 -0700
In-Reply-To: <20190913161731.6e3405a3@coco.lan>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
         <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
         <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
         <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
         <4299c79e33f22e237e42515ea436f187d8beb32e.camel@perches.com>
         <CAL_JsqJju36BZPK6DJab28Ne-ORpEyPpxH0H4DuymxFMabpMRQ@mail.gmail.com>
         <78f67ee934f167b433517da81c6a0d3f35c4b123.camel@perches.com>
         <20190913161731.6e3405a3@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-13 at 16:17 -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 13 Sep 2019 11:42:38 -0700
> Joe Perches <joe@perches.com> escreveu:
[]
> > Just fyi:  for an x86-64 defconfig with gcc 8.3
> > 
> > $ { make clean ; make defconfig ; make -j4 W=1 ; } > make.log 2>&1
> > 
> > There are ~300 W=1 for non kernel-doc -W<foo> warnings.
> > 
> > $ grep -i -P -oh '\[\-W[\w\-]+\]' make.log |sort | uniq -c | sort -rn
> >     163 [-Wmissing-prototypes]
> >      69 [-Wunused-but-set-variable]
> >      16 [-Wempty-body]
> >      10 [-Wtype-limits]
> >       6 [-Woverride-init]
> >       2 [-Wstringop-truncation]
> >       2 [-Wcast-function-type]
> >       1 [-Wunused-but-set-parameter]
> 
> On my eyes, it doesn't sound too much.

In general, I agree and most of these are pretty
trivial to remove.  It'd just take some time to
remove most of the missing-prototypes and
unused-but-set warnings before being able to
enable the warnings at the default W=0.

> I suspect that, 
> with gcc-9, it should produce more warnings, though.

It doesn't though.
At least not so far as I can tell.
gcc-9.1 produces the same output.

$ { make clean ; make defconfig ; make CC=/usr/bin/gcc-9 -j4 W=1 V=1 ; } > make_gcc9.log 2>&1
$  grep -i -P -oh '\[\-W[\w\-]+\]' make_gcc9.log | sort | uniq -c | sort -rn
    163 [-Wmissing-prototypes]
     69 [-Wunused-but-set-variable]
     16 [-Wempty-body]
     10 [-Wtype-limits]
      6 [-Woverride-init]
      2 [-Wstringop-truncation]
      2 [-Wcast-function-type]
      1 [-Wunused-but-set-parameter]


