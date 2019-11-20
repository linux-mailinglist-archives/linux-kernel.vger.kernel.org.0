Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1831041B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 18:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfKTRCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 12:02:48 -0500
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:39082 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728134AbfKTRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:02:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A23C6182CED5B;
        Wed, 20 Nov 2019 17:02:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3873:4321:4605:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21433:21611:21627:30054:30069:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: dolls67_351a93e0e3454
X-Filterd-Recvd-Size: 1742
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 Nov 2019 17:02:44 +0000 (UTC)
Message-ID: <ce1787fcb5fcb8f2aba8fbc6ab95dec7e43c98ba.camel@perches.com>
Subject: Re: [PATCH] ASoC: Fix Kconfig indentation
From:   Joe Perches <joe@perches.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Date:   Wed, 20 Nov 2019 09:02:22 -0800
In-Reply-To: <c58df5a9-216f-2f4c-5afe-23866875a168@linux.intel.com>
References: <20191120133252.6365-1-krzk@kernel.org>
         <c58df5a9-216f-2f4c-5afe-23866875a168@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-20 at 09:02 -0600, Pierre-Louis Bossart wrote:
> 
> On 11/20/19 7:32 AM, Krzysztof Kozlowski wrote:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> > 	$ sed -e 's/^        /\t/' -i */Kconfig
> Thanks for the changes, is there a way for checkpatch.pl or some tool to 
> detect this?

Sure, if you want to stick a Kconfig grammar parser into
checkpatch and validate any Kconfig file content.

Otherwise, maybe improve scripts/kconfig/lexer.l and
(optionally?) emit a message whenever the line's content
doesn't fit some preferred style.


