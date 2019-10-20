Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06967DE036
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 21:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfJTT3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 15:29:05 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:47376 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbfJTT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:29:05 -0400
X-IronPort-AV: E=Sophos;i="5.67,320,1566856800"; 
   d="scan'208";a="407079772"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 21:29:02 +0200
Date:   Sun, 20 Oct 2019 21:29:02 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Joe Perches <joe@perches.com>, Jules Irenge <jbi.octave@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [Outreachy kernel] Re: [PATCH v1 1/5] staging: wfx: fix warnings
 of no space is necessary
In-Reply-To: <20191020191759.GJ24678@kadam>
Message-ID: <alpine.DEB.2.21.1910202123110.10441@hadrien>
References: <20191019140719.2542-1-jbi.octave@gmail.com> <20191019140719.2542-2-jbi.octave@gmail.com> <20191019142443.GH24678@kadam> <alpine.LFD.2.21.1910191603520.6740@ninjahub.org> <20191019180514.GI24678@kadam> <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
 <20191020191759.GJ24678@kadam>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 Oct 2019, Dan Carpenter wrote:

> On Sat, Oct 19, 2019 at 01:02:31PM -0700, Joe Perches wrote:
> > diff -u -p a/rtl8723bs/core/rtw_mlme_ext.c b/rtl8723bs/core/rtw_mlme_ext.c
> > --- a/rtl8723bs/core/rtw_mlme_ext.c
> > +++ b/rtl8723bs/core/rtw_mlme_ext.c
> > @@ -1132,7 +1132,7 @@ unsigned int OnAuthClient(struct adapter
> >  				goto authclnt_fail;
> >  			}
> >
> > -			memcpy((void *)(pmlmeinfo->chg_txt), (void *)(p + 2), len);
> > +			memcpy((void *)(pmlmeinfo->chg_txt), (p + 2), len);
>
> I wonder why it didn't remove the first void cast?

If "it" is a semantic patch, it is probably because Coccinelle wasn't able
to find the definition of the type of pmlmeinfo.  By default, Coccinelle
only consults a few header files (ones with the same names as the .c file
or ones included with "" and located in the same directory).

>
> [ The rest of the email is bonus comments for outreachy developers ].
>
> And someone needs to check the final patch probably to remove the extra
> parentheses around "(p + 2)".  Those were necessary when for the cast
> but not required after the cast is gone.

The rule could have contained

- (void *)(e)
+ e

That should also match cases with no parentheses.  I think there is even
something to put the parentheses back if they are needed, but overall the
final patch should be checked carefully in any case.

julia

>
> >  			pmlmeinfo->auth_seq = 3;
> >  			issue_auth(padapter, NULL, 0);
> >  			set_link_timer(pmlmeext, REAUTH_TO);
>
> It's sort of tricky to know what "one thing per patch means".
>
> -       memset((void *)(&(pHTInfo->SelfHTCap)), 0,
> +       memset((&(pHTInfo->SelfHTCap)), 0,
>                 sizeof(pHTInfo->SelfHTCap));
>
> Here the parentheses were never related to the cast so we should leave
> them as is.  In other words, in the first example, if we didn't remove
> the cast that would be "half a thing per patch" and in the second
> example that would be "two things in one patch".
>
> regards,
> dan carpenter
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191020191759.GJ24678%40kadam.
>
