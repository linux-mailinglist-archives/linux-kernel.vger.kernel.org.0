Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6626042A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 12:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfGEKLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 06:11:15 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:34090 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726436AbfGEKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 06:11:15 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id B459918002E23
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2019 10:11:13 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EF1D81801BB73;
        Fri,  5 Jul 2019 10:11:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3870:3871:4250:4321:5007:6119:7901:7903:9121:10004:10400:10848:11232:11233:11658:11914:12043:12262:12297:12438:12555:12679:12740:12760:12895:12986:13069:13255:13311:13357:13439:14093:14096:14097:14181:14659:14721:21080:21365:21433:21451:21627:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: seed23_44a9efdbb190e
X-Filterd-Recvd-Size: 2467
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Jul 2019 10:11:11 +0000 (UTC)
Message-ID: <9fecfbe081987df1415c9d12317fcfb782a0107e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: DT bindings vendor prefixes file yas been
 translated into yaml
From:   Joe Perches <joe@perches.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Date:   Fri, 05 Jul 2019 03:11:10 -0700
In-Reply-To: <20190705100345.29269-1-miquel.raynal@bootlin.com>
References: <20190705100345.29269-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-05 at 12:03 +0200, Miquel Raynal wrote:
> The extension is now .yaml instead of .txt.
> 
> Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bb28b178d929..9a3163020d67 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3027,7 +3027,7 @@ sub process {
>  			my @compats = $rawline =~ /\"([a-zA-Z0-9\-\,\.\+_]+)\"/g;
>  
>  			my $dt_path = $root . "/Documentation/devicetree/bindings/";
> -			my $vp_file = $dt_path . "vendor-prefixes.txt";
> +			my $vp_file = $dt_path . "vendor-prefixes.yaml";
>  
>  			foreach my $compat (@compats) {
>  				my $compat2 = $compat;

Already fixed in -next by:

commit 852d095d16a6298834839f441593f59d58a31978
Author: Rob Herring <robh@kernel.org>
Date:   Wed May 22 09:55:34 2019 -0500

    checkpatch.pl: Update DT vendor prefix check
    
    In commit 8122de54602e ("dt-bindings: Convert vendor prefixes to
    json-schema"), vendor-prefixes.txt has been converted to a DT schema.
    Update the checkpatch.pl DT check to extract vendor prefixes from the new
    vendor-prefixes.yaml file.
    
    Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
    Cc: Joe Perches <joe@perches.com>
    Signed-off-by: Rob Herring <robh@kernel.org>


