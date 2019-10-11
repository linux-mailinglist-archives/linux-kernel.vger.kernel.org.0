Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01858D4404
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfJKPSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 11:18:45 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:35305 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726331AbfJKPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:18:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1A029837F24C;
        Fri, 11 Oct 2019 15:18:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:421:599:960:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:2890:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4042:4250:4321:5007:8603:10004:10400:10848:11026:11232:11658:11914:12043:12295:12296:12297:12740:12760:12895:13019:13069:13153:13228:13311:13357:13439:14659:14721:21080:21450:21627:21740:30001:30012:30054:30070:30090:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: trip06_11eada1f9c817
X-Filterd-Recvd-Size: 2799
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 11 Oct 2019 15:18:43 +0000 (UTC)
Message-ID: <e0b24ff49eb69a216b11f97db1fc26c5d3b971b4.camel@perches.com>
Subject: Re: [PATCH v1] ipmi: use %*ph to print small buffer
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Oct 2019 08:18:41 -0700
In-Reply-To: <20191011151220.GB32742@smile.fi.intel.com>
References: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
         <4eaca9a1bcbf9d87c1fb3c9135876c3ecb72a91b.camel@perches.com>
         <20191011151220.GB32742@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 18:12 +0300, Andy Shevchenko wrote:
> On Fri, Oct 11, 2019 at 07:58:14AM -0700, Joe Perches wrote:
> > On Fri, 2019-10-11 at 17:52 +0300, Andy Shevchenko wrote:
> > > Use %*ph format to print small buffer as hex string.
> > > 
> > > The change is safe since the specifier can handle up to 64 bytes and taking
> > > into account the buffer size of 100 bytes on stack the function has never been
> > > used to dump more than 32 bytes. Note, this also avoids potential buffer
> > > overflow if the length of the input buffer is bigger.
> > []
> > > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> > []
> > > @@ -48,14 +48,7 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
> > >  static void ipmi_debug_msg(const char *title, unsigned char *data,
> > >  			   unsigned int len)
> > >  {
> > > -	int i, pos;
> > > -	char buf[100];
> > > -
> > > -	pos = snprintf(buf, sizeof(buf), "%s: ", title);
> > > -	for (i = 0; i < len; i++)
> > > -		pos += snprintf(buf + pos, sizeof(buf) - pos,
> > > -				" %2.2x", data[i]);
> > > -	pr_debug("%s\n", buf);
> > > +	pr_debug("%s: %*ph\n", title, len, buf);
> > >  }
> > >  #else
> > >  static void ipmi_debug_msg(const char *title, unsigned char *data,
> > 
> > Now you might as well remove the #ifdef DEBUG above this
> > and the empty function in the #else too.
> 
> It's up to maintainer.

That's like suggesting any function with a single pr_debug
should have another duplicative empty function without.

Using code like the below is not good form as it's prone
to defects when the arguments in one block is changed but
not the other.

Also the first form doesn't work with dynamic debug.

#ifdef DEBUG
void debug_print(...)
{
	pr_debug(...);
}
#else
void debug_print(...)
{
}
#endif



