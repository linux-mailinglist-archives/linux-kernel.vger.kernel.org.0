Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B083136A25
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 10:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgAJJqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 04:46:10 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33043 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgAJJqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:46:10 -0500
Received: by mail-pj1-f65.google.com with SMTP id u63so1755713pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 01:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kVXjETvA9K8/lP9ZBnbh1cVxAMGV1mSFPntHWPphT5k=;
        b=ORb+fnTIv6NoPl8sJCI+ZXc5y2kRw21j1E60VarEzwIjLsD3zEzDM192gZFBtTCzqK
         IdZZLjTJ85iEnkB+4D+TOJrapLFlSrRYTTZcO6L7/AhuRkhMUSdIyluFU0Z3EbAFnQ9i
         UrmTHtVePJjVBoQCXvdjEiyTlg7PpL4JbelIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kVXjETvA9K8/lP9ZBnbh1cVxAMGV1mSFPntHWPphT5k=;
        b=BjmSN/Va8+zGcF1MSHvqFZ+eVtyzOiWAtRm1+Kh5ue31fJAhmSuLSBdmA709v2zYXZ
         1nWqj5vSYIfBwhKSaXK7sEXRpeFh+w8QILGZUdw4VN82mA1RsH/L21LHLp4zFhq6uXAL
         n7vQbWnxNTLoBSagrYiBC0RqgqXywWVFZrLWqGC210poHz57M0oUtgSdK8fvz7FSuXcv
         HcmlRCoYwKEIlHGGxIRTpiUz1EPI+25zbf7ZQBVfPklF9GE7MLBqg0rpBy30Jr+znBP4
         UrhKObc4++N9bQODcGE41QLSb7gWr+ypnjmI+qH3tYxENDKh6UvPawtcKT7XEy59fGjd
         u4dQ==
X-Gm-Message-State: APjAAAX/bMfZvpVPX9EXoZYQcLQ1bBYPwnGVo8YNPbMQjIA2qK25iJLf
        igoYS+EAEUd9WDDcXhsgQcRFUA==
X-Google-Smtp-Source: APXvYqzjIJ8v2NA2EXA8o0hEnespVu1na2a2y1A+8wSnIYd+HWQ7dqrnrEH4SIcmpRMCF3yimeILyw==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr3525192pjb.125.1578649569314;
        Fri, 10 Jan 2020 01:46:09 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id g2sm2059453pgn.59.2020.01.10.01.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 01:46:08 -0800 (PST)
Date:   Fri, 10 Jan 2020 18:46:07 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 03/15] videobuf2: add
 V4L2_FLAG_MEMORY_NON_CONSISTENT flag
Message-ID: <20200110094607.GB202391@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-4-senozhatsky@chromium.org>
 <750a0c62-0f0f-a5c9-1d7f-f0c5d6b620fa@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750a0c62-0f0f-a5c9-1d7f-f0c5d6b620fa@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/10 10:36), Hans Verkuil wrote:
[..]
> > diff --git a/Documentation/media/uapi/v4l/buffer.rst b/Documentation/media/uapi/v4l/buffer.rst
> > index 9149b57728e5..b08b5609f5f3 100644
> > --- a/Documentation/media/uapi/v4l/buffer.rst
> > +++ b/Documentation/media/uapi/v4l/buffer.rst
> > @@ -705,6 +705,25 @@ Buffer Flags
> >  
> >  .. c:type:: v4l2_memory
> >  
> > +Memory Consistency Flags
> > +========================
> > +
> > +.. tabularcolumns:: |p{7.0cm}|p{2.2cm}|p{8.3cm}|
> > +
> > +.. cssclass:: longtable
> > +
> > +.. flat-table::
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +    :widths:       3 1 4
> > +
> > +    * .. _`V4L2_FLAG_MEMORY_NON_CONSISTENT`:
> > +
> > +      - ``V4L2_FLAG_MEMORY_NON_CONSISTENT``
> > +      - 0x00000001
> > +      - Set DMA_ATTR_NON_CONSISTENT queue memory consistency bit,
> > +	so all queue buffers may be allocated in non-consistent memory.
> 
> This needs much more extensive documentation. This is a userspace API,
> and it shouldn't refer to a kernelspace API. Instead, explain what it
> means from a user perspective. Also, how does this relate to the cache
> buffer flags?
> 
> These things are tricky, so it is worth spending some time on writing
> good documentation.

Agreed. I'll give it a shot, will try to improve it.

	-ss
