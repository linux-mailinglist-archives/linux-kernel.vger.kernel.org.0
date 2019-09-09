Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 912EFADF7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 21:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405711AbfIITeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 15:34:46 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:59174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbfIITeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:34:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id AD784AF9B;
        Mon,  9 Sep 2019 19:34:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3871:3872:4321:5007:7576:10004:10400:10848:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21627:30012:30054:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: ball72_6381a34270650
X-Filterd-Recvd-Size: 1705
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Sep 2019 19:34:43 +0000 (UTC)
Message-ID: <7053662366e29927123b9881c05aeae299c850f8.camel@perches.com>
Subject: Re: [PATCH 2/9] thunderbolt: show key using %*s not %*pE
From:   Joe Perches <joe@perches.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date:   Mon, 09 Sep 2019 12:34:42 -0700
In-Reply-To: <1567712673-1629-2-git-send-email-bfields@redhat.com>
References: <20190905193604.GC31247@fieldses.org>
         <1567712673-1629-1-git-send-email-bfields@redhat.com>
         <1567712673-1629-2-git-send-email-bfields@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 15:44 -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> %*pEp (without "h" or "o") is a no-op.  This string could contain
> arbitrary (non-NULL) characters, so we do want escaping.  Use %*pE like
> every other caller.
[]
> diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
[]
> @@ -636,7 +636,7 @@ static ssize_t key_show(struct device *dev, struct device_attribute *attr,
>  	 * It should be null terminated but anything else is pretty much
>  	 * allowed.
>  	 */
> -	return sprintf(buf, "%*pEp\n", (int)strlen(svc->key), svc->key);
> +	return sprintf(buf, "%*pE\n", (int)strlen(svc->key), svc->key);

The code does not match the patch subject / commit title.


