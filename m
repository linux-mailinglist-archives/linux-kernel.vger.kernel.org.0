Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E401D725D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 06:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGXEUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 00:20:04 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:46845 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbfGXEUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:20:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 48986180A8124;
        Wed, 24 Jul 2019 04:20:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:69:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:4321:4605:5007:6119:7904:9121:10004:10394:10400:10848:11026:11232:11233:11473:11658:11914:12043:12295:12297:12438:12679:12683:12740:12760:12895:13069:13161:13229:13311:13357:13439:14095:14181:14659:14721:21080:21324:21433:21627:21740:21789:30054:30075:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: bath23_345d3f3e610
X-Filterd-Recvd-Size: 2618
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jul 2019 04:20:01 +0000 (UTC)
Message-ID: <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Jul 2019 21:19:57 -0700
In-Reply-To: <alpine.DEB.2.21.1907232252260.2539@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
         <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
         <alpine.DEB.2.21.1907231546090.2551@hadrien>
         <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
         <alpine.DEB.2.21.1907232252260.2539@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 22:54 -0500, Julia Lawall wrote:
> A seantic patch and the resulting output for the case where the third
> arugument is a constant is attached.  Likewise the resulting output on a
> recent linux-next.
> 
> julia

Nice.  Thanks Julia

A couple issues:

There is a problem with conversions with assignments
of strlcpy() so ideally the cocci script should make sure
any return value was not used before conversion.

This is not a provably good conversion:

drivers/s390/char/sclp_ftp.c
@@ -114,8 +114,7 @@ static int sclp_ftp_et7(const struct hmc
        sccb->evbuf.mdd.ftp.length = ftp->len;
        sccb->evbuf.mdd.ftp.bufaddr = virt_to_phys(ftp->buf);
 
-       len = strlcpy(sccb->evbuf.mdd.ftp.fident, ftp->fname,
-                     HMCDRV_FTP_FIDENT_MAX);
+       len = stracpy(sccb->evbuf.mdd.ftp.fident, ftp->fname);

And:

I would have expected the bit below to find and convert uses like
	drivers/hwmon/adc128d818.c:     strlcpy(info->type, "adc128d818", I2C_NAME_SIZE);
but it seems none of those were converted.

I don't know why.

//------------------------------------------
@r1@
struct i1 *e1;
expression e2;
identifier f,i1,i2;
position p;
@@
\(strscpy\|strlcpy\)(e1->f, e2, i2)@p

@@
identifier r1.i1,r1.i2;
type T;
@@
struct i1 { ... T i1[i2]; ... }

@@
identifier f,i2;
expression e1,e2;
position r1.p;
@@
(
-strscpy
+stracpy
|
-strlcpy
+stracpy
)(e1->f, e2
-    , i2
  )@p
//------------------------------------------

to find

