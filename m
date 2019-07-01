Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB45123A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 22:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfEBUvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 16:51:15 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54737 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEBUvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:51:15 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so5840649ite.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1edXRnaHapw6mxE7Ykg3KcGAB9chZQflPCtktoyCU8=;
        b=BOv/OEbxNVkUSRQHUCdhM+3+g24CzA4WaRs7o+PF967ZMMlu50KqIZiPmGMsh+2NnK
         21ztQatnnPbi+y5PEMfVkyKmlU/gxZKJnN+ZSBlxBX9j7nvnTNLt1z/IsqzbEoPia3I1
         3coinQxWmKkGSXSAzYi11uilWb2rViW/OTX4RVEIagZpIXGvxcoxlwZnuXmkiPHKBlQ4
         2WGuvTRSw1swHgA2cYOnmKKF3zNg2Dn8oUtmHp+PPV1HkMMQ5+W9jEV+7zo1PN31x54U
         wiA+fQVl4LgBZM77EiDKnVfz0LFtiU+BmRdugxiqq3YjkcmAK5BuAdrPYSXPfoAx40z4
         sMzw==
X-Gm-Message-State: APjAAAUqpR4ievGFrlLoWca6IXbw1OB3rKN4I7AizUP81lb07eK1faNq
        CuiuUxcy/S7AT9gu2PWRrGsaAA==
X-Google-Smtp-Source: APXvYqxY3bbewIYdpEdGd5JduuJsViERFz23XFvOvbPKbKEcb4Fbg2s3YHrMMnptBzjqS1iAYgJNhA==
X-Received: by 2002:a24:7f8f:: with SMTP id r137mr4240374itc.56.1556830274495;
        Thu, 02 May 2019 13:51:14 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id t196sm5385675ita.4.2019.05.02.13.51.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 02 May 2019 13:51:13 -0700 (PDT)
Date:   Thu, 2 May 2019 14:51:09 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix function name in comment
Message-ID: <20190502205109.GA103782@google.com>
References: <20190502194811.200677-1-rrangel@chromium.org>
 <1556829225.12970.10.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556829225.12970.10.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 01:33:45PM -0700, Bart Van Assche wrote:
> On Thu, 2019-05-02 at 13:48 -0600, Raul E Rangel wrote:
> > The comment was out of date.
> > 
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > 
> >  block/blk-mq.c | 2 +
> >  1 file changed, 1 insertion(), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 9516304a38ee..0e467ff440a2 100644
> > --- a/block/blk-mq.c
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 9516304a38ee..0e467ff440a2 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2062,7 +2062,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> >                 list_del_init(&page->lru);
> >                 /*
> >                  * Remove kmemleak object previously allocated in
> > -                * blk_mq_init_rq_map().
> > +                * blk_mq_alloc_rqs().
> >                  */
> >                 kmemleak_free(page_address(page));
> >                 __free_pages(page, page->private);
> 
> Does the entire comment fit on a single 80 column line? In other words, can
> the comment that is spread over four lines be reduced to a single line?
No, it would put it at 91 characters long.

Raul
> 
> Thanks,
> 
> Bart.
