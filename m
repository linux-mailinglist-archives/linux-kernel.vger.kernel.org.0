Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE16D191F17
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 03:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCYCcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 22:32:54 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:46681 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgCYCcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:32:52 -0400
Received: by mail-pf1-f172.google.com with SMTP id q3so276649pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L0byPyKsVMZgh2TI47PblbS4cxi4k/gb3aMdbr//qWM=;
        b=MVkLuY0qbCwRfXrKb6jF3fByfM+IIR1jD6Eetdv5shDt4UFneVZfWXgc7E1r3AL7gN
         VtXM0qRKvJukcN70k0M+sSaTuDKU61RcT25oiOU5G6tReaQ2RkRcFHPSFN+C86badtHc
         eilCyY46wrMdqs+nzxEHoWV4ff+0ak97PKq6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L0byPyKsVMZgh2TI47PblbS4cxi4k/gb3aMdbr//qWM=;
        b=sxbourVPrPHiwwL7KXlg+CyeqooroutmKSHDcCA99Hka2ap8FBdG5OLriLjqWZgQmg
         VMKHFLhSG0vkF75VCUx52Mq/HraY/rzcWhO+yzPkgc40LhBQFVXENIFIkej7V1dCxd4W
         Ke5rN4MlP8vh6p8PhhQwlHtZRSs/S7rF6+INhwNKeb94O76KJXjzJ+dyZ7df2aS3qflZ
         kb3gaLMkrlQ4Y4rdF8HhAGCW6MOjlGVT2K7C9ZIkebIz8uNLl2sj6AgU9mZmo2iKYjD/
         e4vFLZ9GdwHicT3W2cO0RM3bN43KYZk0kfIxYJVOWQi279tTcePD3/8APCTEksTV/Rnw
         Ozyg==
X-Gm-Message-State: ANhLgQ0BB7hS7oioZ3b68od8CxK7KZQ//pN5+syG/KxTadGnfNpklXFM
        dX1FIl3Oq2npJlX+SN+xwxX+0g==
X-Google-Smtp-Source: ADFU+vsG1erswUWnA2vJL77FIxAJXmJEtWnlPjHHAGst27S8TWcKk204VE/Jwm/vsrSAlFkbNHo43w==
X-Received: by 2002:a65:6244:: with SMTP id q4mr842322pgv.84.1585103570795;
        Tue, 24 Mar 2020 19:32:50 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id e3sm15638759pgm.15.2020.03.24.19.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 19:32:50 -0700 (PDT)
Date:   Wed, 25 Mar 2020 11:32:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>,
        nicolas.dufresne@collabora.co.uk
Subject: Re: [PATCHv4 04/11] videobuf2: add queue memory consistency parameter
Message-ID: <20200325023248.GA241329@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-5-senozhatsky@chromium.org>
 <6e4fc7f9-0068-92ff-77d7-9c77c047f3db@collabora.com>
 <20200324023909.GA201720@google.com>
 <1187a3f660b092d8a9d5437445155edfc0744a4f.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1187a3f660b092d8a9d5437445155edfc0744a4f.camel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/24 07:17), Ezequiel Garcia wrote:
[..]
> > > > +static void set_queue_consistency(struct vb2_queue *q, bool consistent_mem)
> > > > +{
> > > > +	if (!vb2_queue_allows_cache_hints(q))
> > > > +		return;
> > > > +
> > > > +	if (consistent_mem)
> > > > +		q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
> > > > +	else
> > > > +		q->dma_attrs |= DMA_ATTR_NON_CONSISTENT;
> > > > +}
> > > > +
> > > >   int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
> > > > -		unsigned int *count)
> > > > +		bool consistent_mem, unsigned int *count)
> > > You extended the vb2_core_reqbufs accepting a new boolean that
> > > is decided according to the setting of the V4L2_FLAG_MEMORY_NON_CONSISTENT
> > > but in the future some other flags might be added, and so I think it
> > > is better to replace the boolean with a u32 consisting of all the flags.
> > 
> > Don't have any objections. Can change the `bool' to `u32'.
> > 
> 
> or maybe an enum instead? That would help get a cleaner
> interface.

Hmm, interesting.

The flags in question can be from different, unrelated groups
(types), controlling various parts of the stack. Not necessarily
all of them are memory_consistency related. We can, for instance,
pass some additional flags to underlying memory allocators (contig,
sg), etc.

E.g.

	enum MEMORY_ATTR {
		MEM_NON_CONSISTENT,
		...
	};

	enum VMALLOC_ALLOCATOR_ATTR {
		DO_A_BARREL_ROLL,
		...
	};

	enum DMA_SG_ALLOCATOR_ATTR {
		WRITEBACK_TO_TAPE_DEVICE,
		...
	};

	enum DMA_CONTIG_ALLOCATOR_ATTR {
		PREFER_HTTPS,
		...
	};

and so on. We maybe can keep all of those in one enum (umm, what should
be the name?), and then either make sure that all of them are proper powers
of two

	enum AUX_FLAGS {
		MEM_NON_CONSISTENT		= (1 << 0),
		DO_A_BARREL_ROLL		= (1 << 1),
		WRITEBACK_TO_TAPE_DEVICE	= (1 << 2),
		PREFER_HTTPS			= (1 << 3),
	};

or
	enum AUX_FLAGS {
		MEM_NON_CONSISTENT		= 0,
		DO_A_BARREL_ROLL,
		WRITEBACK_TO_TAPE_DEVICE,
		PREFER_HTTPS,
	};

and make sure that those are not flags, but bits.
IOW, if (flags & BIT(MEM_NON_CONSISTENT)).


What do others think?

	-ss
