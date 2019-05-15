Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7D51FC91
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 00:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEOW3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 18:29:52 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:42184 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbfEOW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 18:29:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 992CE837F24C;
        Wed, 15 May 2019 22:29:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:800:960:967:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2393:2525:2559:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3000:3022:3138:3139:3140:3141:3142:3351:3622:3865:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6117:6119:7514:8599:9025:9388:10004:10049:10400:10848:11232:11658:11914:12043:12555:12740:12760:12776:12895:13069:13311:13357:13439:14096:14097:14181:14651:14659:14721:14764:21080:21451:21627:30025:30054:30064:30070:30091,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: lace66_38b74b7a2e71a
X-Filterd-Recvd-Size: 1692
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 May 2019 22:29:49 +0000 (UTC)
Message-ID: <391f21cf5f04c61b75e739f67c8a308864b4e68c.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update UBI/UBIFS git tree location
From:   Joe Perches <joe@perches.com>
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 15:29:48 -0700
In-Reply-To: <20190515200423.17809-1-richard@nod.at>
References: <20190515200423.17809-1-richard@nod.at>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 22:04 +0200, Richard Weinberger wrote:
> Linus asked to use kernel.org.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c38f21aee78..ba428cd613b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15879,7 +15879,7 @@ M:	Richard Weinberger <richard@nod.at>
>  M:	Artem Bityutskiy <dedekind1@gmail.com>
>  M:	Adrian Hunter <adrian.hunter@intel.com>
>  L:	linux-mtd@lists.infradead.org
> -T:	git git://git.infradead.org/ubifs-2.6.git
> +T:	git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git

Please keep the initial separate git

T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git

>  W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
>  S:	Supported
>  F:	Documentation/filesystems/ubifs.txt

