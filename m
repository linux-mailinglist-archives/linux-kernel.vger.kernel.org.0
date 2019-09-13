Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB08B277D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 23:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbfIMVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 17:48:53 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:39734 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731274AbfIMVsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:48:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 99727100E86C1;
        Fri, 13 Sep 2019 21:48:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:966:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2904:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:4250:4321:4385:5007:6119:7901:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13019:13069:13141:13161:13200:13229:13230:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30054:30070:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: hen01_301fba1184944
X-Filterd-Recvd-Size: 2653
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Sep 2019 21:48:50 +0000 (UTC)
Message-ID: <713b2e5bbab16ddf850245ae1d92be66d9730e02.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Warn if DT bindings are not in schema format
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Whitcroft <apw@canonical.com>
Date:   Fri, 13 Sep 2019 14:48:49 -0700
In-Reply-To: <20190913211349.28245-1-robh@kernel.org>
References: <20190913211349.28245-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-13 at 16:13 -0500, Rob Herring wrote:
> DT bindings are moving to using a json-schema based schema format
> instead of freeform text. Add a checkpatch.pl check to encourage using
> the schema for new bindings. It's not yet a requirement, but is
> progressively being required by some maintainers.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2822,6 +2822,14 @@ sub process {
>  			     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
>  		}
>  
> +# Check for adding new DT bindings not in schema format
> +		if (!$in_commit_log &&
> +		    ($line =~ /^new file mode\s*\d+\s*$/) &&
> +		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
> +			WARN("DT_SCHEMA_BINDING_PATCH",
> +			     "DT bindings should be in DT schema format. See: Documentation/devicetree/writing-schema.rst\n");
> +		}
> +

As this already seems to be git dependent, perhaps
it's easier to read with a single line test like:

		if ($line =~ m{^\s*create mode\s*\d+\s*Documentation/devicetree/bindings/.*\.txt$}) {
			etc...
		}

There are ~3500 existing .txt files:

$ git ls-files -- 'Documentation/devicetree/bindings/*.txt' | wc -l
3476

Are these going to be converted somehow?

What about files like these? (not .txt)

Documentation/devicetree/bindings/timer/st,stih407-lpc
Documentation/devicetree/bindings/nds32/andestech-boards
Documentation/devicetree/bindings/media/nokia,n900-ir
Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
Documentation/devicetree/bindings/arm/cpu-enable-method/nuvoton,npcm750-smp
Documentation/devicetree/bindings/arm/cpu-enable-method/marvell,berlin-smp
Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
Documentation/devicetree/bindings/arm/arm-boards



