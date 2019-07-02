Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4955D3E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 18:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGBQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 12:08:09 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:60095 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbfGBQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:08:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 40A97282A;
        Tue,  2 Jul 2019 16:08:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:960:968:973:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2892:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3871:3872:4250:4321:4419:5007:7576:7903:7904:10004:10400:10848:10967:11232:11658:11914:12043:12048:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21212:21433:21451:21611:21627:21772:30054:30070:30075:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:50,LUA_SUMMARY:none
X-HE-Tag: cake36_63c80d15d405d
X-Filterd-Recvd-Size: 2264
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  2 Jul 2019 16:08:05 +0000 (UTC)
Message-ID: <c26343465261e636ef029b8d0d7cb46183a23d23.camel@perches.com>
Subject: Re: [PATCH] openpromfs: Adjust three seq_printf() calls in
 property_show()
From:   Joe Perches <joe@perches.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 02 Jul 2019 09:08:04 -0700
In-Reply-To: <22563348-fefa-8540-9d71-de37764f0596@web.de>
References: <22563348-fefa-8540-9d71-de37764f0596@web.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-02 at 17:40 +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jul 2019 17:24:27 +0200
> 
> A bit of information should be put into a sequence.
> Thus improve the execution speed for this data output by better usage
> of corresponding functions.
> 
> This issue was detected by using the Coccinelle software.

(wasn't Markus perma-banned?)

> diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
[]
> @@ -76,14 +76,14 @@ static int property_show(struct seq_file *f, void *v)
>  		while (len > 0) {
>  			int n = strlen(pval);
> 
> -			seq_printf(f, "%s", (char *) pval);
> +			seq_puts(f, (char *) pval);
> 
>  			/* Skip over the NULL byte too.  */
>  			pval += n + 1;
>  			len -= n + 1;
> 
>  			if (len > 0)
> -				seq_printf(f, " + ");
> +				seq_puts(f, " + ");
>  		}
>  	} else {
>  		if (len & 3) {
> @@ -111,8 +111,7 @@ static int property_show(struct seq_file *f, void *v)
>  			}
>  		}
>  	}
> -	seq_printf(f, "\n");
> -
> +	seq_putc(f, '\n');
>  	return 0;
>  }

If this is really useful (and it's really not),
at least change void *pval to char *pval and
remove a bunch of useless casts.


