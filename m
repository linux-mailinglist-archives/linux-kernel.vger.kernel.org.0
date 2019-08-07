Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD28483E0E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 01:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfHFX5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 19:57:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37263 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfHFX5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:57:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so78100015wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jfBO9hCNqYo64ONFM6ciZWbt58m9OYqaTu2HQ9ca9Ro=;
        b=W8eEgM2it0wryCQemd+9sTsxohxFSftJHniJZ5Qr1hletzTU3TNMP1w2zUH/hfEuyL
         0au0nFicRsBByjUVgItZ0FtKdIpaCavvW1sRv2pm8h3YDr6nL2e8gnVavWNGVQpWip/T
         5mI7nVfekdb19B4eyRMnImDBHWb0FMcuYpX5A97FOG6afLhCWQb+V7KsuMdmM8CJgMTj
         gY58iFdklW31tLr8gjYOP6HV4zZtOWxNsDsPPtFNu0t4Qs97YGVrncp3eRuqu5RfuI2l
         LELLaXTY4KdsSWOpYJSSqfhMOT0S3g+8iQK0nNIljP4ioEqsDzwKUjIFNI4cl1v+ZBzQ
         eBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jfBO9hCNqYo64ONFM6ciZWbt58m9OYqaTu2HQ9ca9Ro=;
        b=i0+3YIfww5FLuplIhIRRGNqtzGKktmApU9UgCvDoIKtg70BCi8PW1Qvx7pbj/lHF/8
         EIzF0zQaW/HXF+/Q4QwCjE5p3ilWIFims00rh8CbSJ8tNMmTtkzFmuOR9sXshDQTO7rj
         /C3/+QhBr9AxhZjCodSZwTIZPSfYnKbdN3SBhRqxJXoCrUxtlBFNzmrALt8GU5hX111j
         tCGbTSg9+4mkXCYUawXuEoojp4xWScFXH6Vl+rNHGZmTFkPCJNE9XSJd0Vj6OCeGX2tI
         VnLfOJQwC9iyWHEhZHztBccP9YpbvywNcokSI+DkwczhANdy0QCE675lymdWbtFg1BD1
         U7vw==
X-Gm-Message-State: APjAAAX/FzzoQe+H9T6BXTRPW51y0sJMLVgiAAfyT/JQMA0otRggA/Rx
        xksIsoDfvriYn26mSKB2+G4xpQ==
X-Google-Smtp-Source: APXvYqwvAhL5NTzknYTD6D/k6t0NbWDbuFz6QsImjCl9poL59Fzt5ijxAEO79VvVV+dV8ZfyhIK5nA==
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr7085231wma.25.1565135830388;
        Tue, 06 Aug 2019 16:57:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id b19sm63982440wmj.13.2019.08.06.16.57.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 16:57:09 -0700 (PDT)
Date:   Wed, 7 Aug 2019 00:57:08 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, dvander@gmail.com,
        Yifan Hong <elsk@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_DIRECT_IO in compat ioctl
Message-ID: <20190806235708.GA10161@google.com>
References: <20190806220524.251404-1-balsini@android.com>
 <CAJWu+oq9JLnbGdqy+362JZUzjv6PvuRTNwiarTQiEfizsY32hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oq9JLnbGdqy+362JZUzjv6PvuRTNwiarTQiEfizsY32hQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

I was considering the rationale for this patch totally strightforward:
it enables Direct I/O ioctl to 32 bit processes running on 64 bit
systems for compatibility reasons, as for all the other lo_compat_ioctl
commands.
Also the reason why someone would decide to use Direct I/O with loop
devices is well known, that is why the feature exists :) So I thought
this was another redundant information to put in the commit message and
decided to omit it.

If you still think that I should update the commit message with this
information, I will do so.

Thanks again,
Alessio

On Tue, Aug 06, 2019 at 06:25:42PM -0400, 'Joel Fernandes' via kernel-team wrote:
> Hi Alessio,
> 
> On Tue, Aug 6, 2019 at 6:05 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > Export LOOP_SET_DIRECT_IO as additional lo_compat_ioctl.
> > The input argument for this ioctl is a single long, in the end converted
> > to a 1-bit boolean. Compatibility is then preserved.
> >
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Alessio Balsini <balsini@android.com>
> 
> This looks Ok to me, but I believe the commit message should also
> explain what was this patch "fixing", how was this lack of an "export"
> noticed, why does it matter, etc as well.
> 
> thanks,
> 
>  - Joel
> 
> 
> > ---
> >  drivers/block/loop.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index 3036883fc9f8..a7461f482467 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -1755,6 +1755,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
> >         case LOOP_SET_FD:
> >         case LOOP_CHANGE_FD:
> >         case LOOP_SET_BLOCK_SIZE:
> > +       case LOOP_SET_DIRECT_IO:
> >                 err = lo_ioctl(bdev, mode, cmd, arg);
> >                 break;
> >         default:
> > --
> > 2.22.0.770.g0f2c4a37fd-goog
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
