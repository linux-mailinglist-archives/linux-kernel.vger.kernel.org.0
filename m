Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446948F7B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 01:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfHOXqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 19:46:05 -0400
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:35436 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbfHOXqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:46:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 918DF18225E1B;
        Thu, 15 Aug 2019 23:46:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2380:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3873:4250:4321:4605:5007:8660:10004:10400:10848:11026:11232:11658:11914:12043:12295:12296:12297:12438:12555:12740:12760:12895:12986:13069:13148:13230:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21627:21939:30012:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: sheet19_6eed4fd187f5f
X-Filterd-Recvd-Size: 2681
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Aug 2019 23:46:02 +0000 (UTC)
Message-ID: <d98d1f0150bec8b69a886f77fc375b8ca9d24262.camel@perches.com>
Subject: Re: [PATCH] afs: Move comments after /* fallthrough */
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 15 Aug 2019 16:46:01 -0700
In-Reply-To: <12308.1565876416@warthog.procyon.org.uk>
References: <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
         <12308.1565876416@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-15 at 14:40 +0100, David Howells wrote:
> Joe Perches <joe@perches.com> wrote:
> 
> > Make the code a bit easier for a script to appropriately convert
> > case statement blocks with /* fallthrough */ comments to a macro by
> > moving comments describing the next case block to the case statement.
> 
> This doesn't sound good.  Can you give an illustration of what a resulting
> case might look like?  Say taking the following as an example:
> 
> > @@ -282,10 +282,8 @@ static int afs_deliver_cb_callback(struct afs_call *call)
> >  	case 0:
> >  		afs_extract_to_tmp(call);
> >  		call->unmarshall++;
> > -
> > -		/* extract the FID array and its count in two steps */
> >  		/* fall through */
> > -	case 1:
> > +	case 1:		/* extract the FID array and its count in two steps */
> >  		_debug("extract FID count");
> >  		ret = afs_extract_data(call, true);
> >  		if (ret < 0)

This case above would not change, but this case below would:

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 114f281f3687..d9dc1bdfa695 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -341,8 +341,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
                }
                /* Fall through */
 
-               /* extract the returned data length */
-       case 1:
+       case 1:         /* extract the returned data length */
                _debug("extract data length");
                ret = afs_extract_data(call, true);
                if (ret < 0)

Here the script would not convert the /* Fall through */
because the next non-blank line does not start with
case or default


