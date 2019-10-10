Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2361D2915
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 14:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733247AbfJJMRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 08:17:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33452 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728030AbfJJMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570709821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lHnonVw5Ni2BwUYIttHCnA3w1EKUNdv1m01q4IzX5U=;
        b=fHFwxPvrCAthTS8XkKSAVbBXrrSYJdiO2RGTKF5WEqqI0mAyDqc1+Cu2wkzvGRDL+KEzI0
        GBLODeGhBCMdqKgH4xK52nUPRg2jqZjO+40iAQ8MIxDRcfaODJuhAGRIWmm/kkyFtSUmBJ
        L3f6d5K6aTAqO4YkekHlvOXO2r7fz4c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-yznj07MfP6ikZx2JdMrhog-1; Thu, 10 Oct 2019 08:16:59 -0400
Received: by mail-qt1-f198.google.com with SMTP id c8so5516638qtd.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 05:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7inn7T78nlvJNzw0gTQf4L+rcqUs2LyvXLi2sC3zEA=;
        b=axrQd4xkkP8G4WIn9F2uwwc5DjInDvlqzJdx4NADrzjyTYNqAw/EbK5G3hKWQE8cSK
         GJrjm1KxgrSRy3exSa9IX2edHabfKoFBdTXsNv0kljEqoD85uxTgQtxeZwunNNj8NFxS
         m1T1zZKLpXyht0gKv4eFvWw2fSBHfH0U0C5qnEDf2e9QIxE7vy9vGs3SQuSGhsrl2DEX
         jOAXMQfsh7BiMB7BnH40VULufzQlBKlfciaBR8ryCPyTPL9Xn3vjTjbp3IyoW71toFDH
         9KvfywIWI/yF6LBkrFvBV9rl7fklH/5ciHgo8UiXLt5OfAAmMD7X91PLTGrGC1VvyS9C
         EM3A==
X-Gm-Message-State: APjAAAXQH55jxsXyXVhfabVsH6GMqPr8jAI/liTdRS4rGiLSL726jQbk
        WEqiowAqbtbHP2hOhNIU71s2tBJb8eCIZjXCqgVKi3+9ksvMfzYjTobNyrHD6u2NfXBsfsZ9531
        qyod8aD8i7kqpOfJ4jAHKO3lpcQUNpa0uOORgOsC/
X-Received: by 2002:ac8:1e83:: with SMTP id c3mr9928771qtm.294.1570709819501;
        Thu, 10 Oct 2019 05:16:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxRkW7AdvFDNqnvMgNQJTqUWcVFbQOfXSi/TrYiTpHKIad141T1gbycryZ8x/yjN9sQ4mymdPUrbnyPAAJdWq0=
X-Received: by 2002:ac8:1e83:: with SMTP id c3mr9928733qtm.294.1570709819174;
 Thu, 10 Oct 2019 05:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <1570625609-11083-1-git-send-email-candlesea@gmail.com>
 <d739f691b677fb3ed88a23476d221527a87c363d.camel@suse.de> <nycvar.YFH.7.76.1910091958120.13160@cbobk.fhfr.pm>
 <CAPnx3XNGBw+SKSFA3DhhHFZZ17f54DMfYjKOcqYTb3N-PWGKpw@mail.gmail.com>
In-Reply-To: <CAPnx3XNGBw+SKSFA3DhhHFZZ17f54DMfYjKOcqYTb3N-PWGKpw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 10 Oct 2019 14:16:47 +0200
Message-ID: <CAO-hwJJEcP3AEYfadhEbqzfszawxiQ7E9NAwmxHcK6SH8zzhiQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: core: check whether usage page item is after
 usage id item
To:     Candle Sun <candlesea@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        orson.zhai@unisoc.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Candle Sun <candle.sun@unisoc.com>,
        Nianfu Bai <nianfu.bai@unisoc.com>
X-MC-Unique: yznj07MfP6ikZx2JdMrhog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 5:19 AM Candle Sun <candlesea@gmail.com> wrote:
>
> On Thu, Oct 10, 2019 at 2:00 AM Jiri Kosina <jikos@kernel.org> wrote:
> >
> > On Wed, 9 Oct 2019, Nicolas Saenz Julienne wrote:
> >
> > > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > > index 3eaee2c..3394222 100644
> > > > --- a/drivers/hid/hid-core.c
> > > > +++ b/drivers/hid/hid-core.c
> > > > @@ -35,6 +35,8 @@
> > > >
> > > >  #include "hid-ids.h"
> > > >
> > > > +#define GET_COMPLETE_USAGE(page, id) (((page) << 16) + ((id) & 0xf=
fff))
> > >
> > > Not sure I like the macro. I'd rather have the explicit code. That sa=
id, lets
> > > see what Benjamin has to say.
> >
> > Not sure about Benjamin :) but I personally would ask for putting it
> > somewhere into hid.h as static inline.
> >
> > And even if it's for some reason insisted on this staying macro, please=
 at
> > least put it as close to the place(s) it's being used as possible, in
> > order to maintain some code sanity.
> >
> > Thanks,
> >
> > --
> > Jiri Kosina
> > SUSE Labs
> >
>
> Thanks Nicolas and Jiri,
> If macro is not good, I will change it to static function. But the
> funciton is only used in hid-core.c,
> maybe placing it into hid.h is not good?

I would rather use a function too (in hid-core.c, as it's not reused
anywhere else), and we can make it simpler from the caller point of
view (if I am not mistaken):
---
static void concatenate_usage_page(struct hid_parser *parser, int index)
{
    parser->local.usage[index] &=3D 0xFFFF;
    parser->local.usage[index] |=3D (parser->global.usage_page & 0xFFFF) <<=
 16;
}

// Which can then be called as:
+       parser->local.usage[parser->local.usage_index] =3D usage;
+       if (size <=3D 2)
+               concatenate_usage_page(parser, parser->local.usage_index);
+

// And
        for (i =3D 0; i < parser->local.usage_index; i++)
-               if (parser->local.usage_size[i] <=3D 2)
-                       parser->local.usage[i] +=3D
parser->global.usage_page << 16;
+               if (parser->local.usage_size[i] <=3D 2) {
+                       concatenate_usage_page(parser, i);
+               }
 }
---

And now that I have written this, the check on the size could also be
very well integrated in concatenate_usage_page().

Cheers,
Benjamin

>
> Regards,
> Candle

