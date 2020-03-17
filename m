Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619C4188890
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCQPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 11:06:17 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:34638 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726388AbgCQPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:06:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 97CE318224D99;
        Tue, 17 Mar 2020 15:06:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3743:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7514:8957:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12679:12740:12760:12895:13439:14093:14096:14097:14181:14659:14721:21080:21324:21451:21627:21990:30030:30045:30054:30062:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:11,LUA_SUMMARY:none
X-HE-Tag: thumb35_53bba392fd11c
X-Filterd-Recvd-Size: 4244
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Mar 2020 15:06:15 +0000 (UTC)
Message-ID: <ee182711405229e85b5b5a44c683d5a2609b5ba3.camel@perches.com>
Subject: Re: [PATCH 2/2] staging: rtl8192u: Corrects 'Avoid CamelCase' for
 variables
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Date:   Tue, 17 Mar 2020 08:04:26 -0700
In-Reply-To: <20200317134329.GC4650@kadam>
References: <20200317085130.21213-1-c.cantanheide@gmail.com>
         <20200317085130.21213-2-c.cantanheide@gmail.com>
         <20200317134329.GC4650@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-17 at 16:43 +0300, Dan Carpenter wrote:
> On Tue, Mar 17, 2020 at 08:51:30AM +0000, Camylla Goncalves Cantanheide wrote:
> > The variables of function setKey triggered a 'Avoid CamelCase'
> > warning from checkpatch.pl. This patch renames these
> > variables to correct this warning.
> > 
> > Signed-off-by: Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r8192U_core.c | 52 +++++++++++++-------------
> >  1 file changed, 26 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> > index 93a15d57e..fcfb9024a 100644
> > --- a/drivers/staging/rtl8192u/r8192U_core.c
> > +++ b/drivers/staging/rtl8192u/r8192U_core.c
> > @@ -4877,50 +4877,50 @@ void EnableHWSecurityConfig8192(struct net_device *dev)
> >  	write_nic_byte(dev, SECR,  SECR_value);
> >  }
> >  
> > -void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType,
> > -	    u8 *MacAddr, u8 DefaultKey, u32 *KeyContent)
> > +void setKey(struct net_device *dev, u8 entryno, u8 keyindex, u16 keytype,
> > +	    u8 *macaddr, u8 defaultkey, u32 *keycontent)
> >  {
> > -	u32 TargetCommand = 0;
> > -	u32 TargetContent = 0;
> > -	u16 usConfig = 0;
> > +	u32 target_command = 0;
> > +	u32 target_content = 0;
> > +	u16 us_config = 0;
> 
> Use these renames to think deeply about naming.
> 
> I don't like "entryno".  I would prefer "entry_no".  Use the same
> underscore for spaces rule for key_index, mac_addr and all the rest.  Is
> "key_idx" better or "key_index"?
> 
> What added value or meaning does the "target_" part of "target_command"
> add?  Use "cmd" instead of "command".  "target_command" and
> "target_content" are the same length and mostly the same letters.  Avoid
> that sort of thing because it makes it hard to read at a glance.  The
> two get swapped in your head.
> 
> What does the "us_" mean in us_config?  Is it microsecond as in usec?
> Is it United states?  Actually it turns out it probably means "unsigned
> short".  Never make the variable names show the type.  If you have a
> good editor you can just hover the mouse over a variable to see the
> type.  Or if you're using vim like me, then you have to use '*' to
> highlight the variable and scroll to the top of the function.  Either
> way, never use "us_" to mean unsigned short.
> 
> What does the "config" part of "us_config" mean?  What does the "content"
> part of "target_content" mean?  Always think about that.  Variable names
> are hard and maybe "config" and "content" are clear enough.  But at
> think about it, and consider all the options.
> 
> Anyway, the reason that this patch needs to be re-written is because
> we want underscores in place of spaces for "key_type" and because
> "us_config" is against the rules.  The rest is just something to
> consider and if you find better names, then go with that but if you
> don't just fix those two things and resend.

What Dan said and:

Make sure to successfully compile the source files the patch
modifies before sending the patch.

Renaming function arguments and not renaming the uses of the
arguments in the function is not good.


