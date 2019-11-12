Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4B74F96BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 18:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKLRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 12:12:01 -0500
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:56135 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbfKLRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:12:01 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 74F6D18224083;
        Tue, 12 Nov 2019 17:12:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3868:3870:4321:5007:7903:10004:10400:10848:11026:11232:11657:11658:11914:12043:12050:12296:12297:12740:12760:12895:13019:13069:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: cats71_68b4d1f30855c
X-Filterd-Recvd-Size: 1580
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 17:11:59 +0000 (UTC)
Message-ID: <c243860eeabf9406d166deb6204a69255c51867d.camel@perches.com>
Subject: Re: [PATCH 7/9] staging: rtl8723bs: Fix incorrect type in argument
 warnings
From:   Joe Perches <joe@perches.com>
To:     "Javier F. Arias" <jarias.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Date:   Tue, 12 Nov 2019 09:11:42 -0800
In-Reply-To: <637726782ce6c6ed3d68b5e595481857916bbc56.1573577309.git.jarias.linux@gmail.com>
References: <cover.1573577309.git.jarias.linux@gmail.com>
         <637726782ce6c6ed3d68b5e595481857916bbc56.1573577309.git.jarias.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 11:55 -0500, Javier F. Arias wrote:
> Fix incorrect type in declarations to solve the 'incorrect
> type in argument 3' warnings in the rtw_get_ie function calls.
> Issue found by Sparse.
[]
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
[]
> @@ -83,7 +83,7 @@ static char *translate_scan(struct adapter *padapter,
>  {
>  	struct iw_event iwe;
>  	u16 cap;
> -	u32 ht_ielen = 0;
> +	sint ht_ielen = 0;

more likely the rtw_get_ie function should used u32
and not sint.

one day a sed of 's/\bsint\b/int/g' would be good too.



