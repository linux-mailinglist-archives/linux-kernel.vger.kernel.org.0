Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB8817CD4D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 10:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbgCGJjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 04:39:25 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:44124 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgCGJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:39:25 -0500
Received: by mail-pf1-f175.google.com with SMTP id y26so2352533pfn.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 01:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7a3AAdOd9aTW9nDmpj4pfI4b0wQoKltwVVKhvV6YEWo=;
        b=Z6Qq6/1BqFIylyqfS6Pv05Y6BNWVpCBFW7z4NRcvmpUbx0CCBnp383iDE0xtThbgF0
         CvlCohuP6bRjR/9CaLi7X6m7p+Jg1DeaBU4v/ZyAPTkswwjFbMxm9jQgiH78PNSTFbqC
         sOBuUr21Ll7e8Ep/vSwax0azbtJntHQOFwbMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7a3AAdOd9aTW9nDmpj4pfI4b0wQoKltwVVKhvV6YEWo=;
        b=O2asKjFywyAbHTPKfg7P5YHmP2NyJfCx9GiR+9xPumngzJu240W2HXxt4RjcXRjsoH
         cnA53zdPAu3vf0y2pfEAc3kI0jAQaDtgWXutf3jDHkbm4vxkv4HkM2rB9I9fG5iV102t
         6pwieHiOHLyaONipZuHYg/qyxTu2O8s5rQ6DTOkkmj4S6wza2dslBQ4MCcBxnuOZH14M
         2BOPO9dxR6KGK4dpAuZfi55M5YHuo8XlvY/8ucV1hufqJcChUSzYuALgsm/Gph3PdJmd
         aQe9PAA0lkAI9DdleaAlXLs1Z8+eI8wlSR5TPJrjgKpw7fYr5PDWZnf6uMlQX2H9QQRy
         8pqw==
X-Gm-Message-State: ANhLgQ2lbKrMArAfTdx65gzawGHVOa79ZDRFAGAFiTzaFiQq0SGgW0VE
        ieA2QvsN9YYlbuct+IhYnZe3yw==
X-Google-Smtp-Source: ADFU+vvn+Juchn8PjjSyhg0i99Mf32mKkqJVst/dcmMctSpXzE9UH+SIP0x31txil9XG5a1Hj4flwg==
X-Received: by 2002:a63:1e44:: with SMTP id p4mr7242868pgm.367.1583573964284;
        Sat, 07 Mar 2020 01:39:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id x197sm23115196pfd.74.2020.03.07.01.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 01:39:23 -0800 (PST)
Date:   Sat, 7 Mar 2020 18:39:22 +0900
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
Subject: Re: [PATCHv4 10/11] videobuf2: add begin/end cpu_access callbacks to
 dma-sg
Message-ID: <20200307093922.GA29464@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-11-senozhatsky@chromium.org>
 <f99cd8d2-26a2-acd1-a986-aee66cd2ba12@xs4all.nl>
 <20200307052628.GB176460@google.com>
 <8150bc6c-f6a4-fa2c-4e2e-552dcb168df0@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8150bc6c-f6a4-fa2c-4e2e-552dcb168df0@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/07 10:32), Hans Verkuil wrote:
> >>> +static int vb2_dma_sg_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> >>> +					enum dma_data_direction direction)
> >>
> >> I suggest you use this style to avoid checkpatch warnings:
> >>
> >> static int
> >> vb2_dma_sg_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> >> 				       enum dma_data_direction direction)
> > 
> > OK, will do.
> > 
> > Just for information, my checkpatch doesn't warn me:
> > 
> > $ ./scripts/checkpatch.pl outgoing/0010-videobuf2-add-begin-end-cpu_access-callbacks-to-dma-.patch
> 
> We use the --strict option to checkpatch.

Got it.

	-ss
