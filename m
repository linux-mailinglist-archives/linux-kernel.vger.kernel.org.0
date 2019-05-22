Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E381268F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbfEVRQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 13:16:47 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:37669 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729915AbfEVRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:16:46 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 689BF18011ADF;
        Wed, 22 May 2019 17:16:45 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 799BB180A887B;
        Wed, 22 May 2019 17:16:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3870:3872:4250:4321:5007:6119:7901:7903:8568:10004:10400:10848:11232:11658:11914:12043:12555:12740:12760:12895:12986:13069:13311:13357:13439:14093:14097:14181:14659:14721:21060:21080:21221:21433:21451:21627:21740:21741:30054:30070:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: sock87_3abe498a27f2d
X-Filterd-Recvd-Size: 2531
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 17:16:43 +0000 (UTC)
Message-ID: <2b4878de1404e71d3085ee4832a5abc3526f2cdf.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Update DT vendor prefix check
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org
Date:   Wed, 22 May 2019 10:16:41 -0700
In-Reply-To: <20190522151238.25176-1-robh@kernel.org>
References: <20190522151238.25176-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 10:12 -0500, Rob Herring wrote:
> In commit 8122de54602e ("dt-bindings: Convert vendor prefixes to
> json-schema"), vendor-prefixes.txt has been converted to a DT schema.
> Update the checkpatch.pl DT check to extract vendor prefixes from the new
> vendor-prefixes.yaml file.
> 
> Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bb28b178d929..073051a4471b 100755
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
> @@ -3042,7 +3042,7 @@ sub process {
>  
>  				next if $compat !~ /^([a-zA-Z0-9\-]+)\,/;
>  				my $vendor = $1;
> -				`grep -Eq "^$vendor\\b" $vp_file`;
> +				`grep -oE "\\"\\^[a-zA-Z0-9]+" $vp_file | grep -q "$vendor"`;

I think this does't work well as it loses the -
in various vendor prefixes:

  "^active-semi,.*":
  "^asahi-kasei,.*":
  "^ebs-systart,.*":
  "^inside-secure,.*":
  "^multi-inno,.*":
  "^netron-dy,.*":
  "^si-en,.*":
  "^si-linux,.*":
  "^tbs-biometrics,.*":
  "^u-blox,.*":
  "^x-powers,.*":

Perhaps the grep should be something like: (untested)

	`grep -Eq "\\"\\^\Q$vendor\E,\\.\\*\\":" $vp_file`;

