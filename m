Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21BC1903A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 03:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCXCjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 22:39:14 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:38492 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgCXCjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 22:39:14 -0400
Received: by mail-pf1-f179.google.com with SMTP id z25so4194199pfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 19:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bTaRA5htpsqxmsFBZbxgA8lCpOcv0k2H5w1W5iPSjBI=;
        b=WgaGQhfC8mZ6nlYEovTrbyZwdm3ttCaLC09dPRGyDUnQboi38YlSRsxovnliYrwPSw
         m/3qUx95F43aIhy+vXuJUcyJNeqBpgKMcNiAvXPlCbDeie8bYOp/trq8luWfpHt3/x8S
         o3LNeeoeRYJRm5L1pJ4dubQtxwWe9UFM7K/9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bTaRA5htpsqxmsFBZbxgA8lCpOcv0k2H5w1W5iPSjBI=;
        b=BHXxvfgNsruQWLSRhpUoltCaqobj+Z1b40JxCftVpiljjt0DjaEx0eo0XrgHaLYX/s
         pJ/TPCDSjj0QSYnzmogmoYirP/xZTcblrcx15jxevW/ZOtjLk4/NVLV+rQrdqxSMaaWk
         Hy0+jIlpl5OX8S1SnVec5njmQo8j6fMxpfTgxP9wKfOKpo25domCIahaW8Z9NUwFcwUP
         Cx5YJ10NitcMWYnD57YQwtYhr4NhrM7Qb16UlZz2AsS7FzFykXP4IzIlYTTzI88tBEFR
         XlQWHOMRkMQQ/8GEwiLfi6MCXTRQQc4iklJJoBt34eraQbQj/84iysT3FpqBXDZBxSdK
         NyVQ==
X-Gm-Message-State: ANhLgQ2jTHMrnQ2BnafWkw4HLvafw30vEjahcUKgLY6VmH96CBnsSXUY
        rFDnZ2tur3YojZp8yXdZcPBYzA==
X-Google-Smtp-Source: ADFU+vvgjyn//CUHKXeLMz1tY2HElpEHCGd+yhmgojhq7G/KZugPso67+RvAzwJhxHHVOrdODgok7A==
X-Received: by 2002:a62:62c3:: with SMTP id w186mr26402375pfb.238.1585017552663;
        Mon, 23 Mar 2020 19:39:12 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id y18sm14072169pfe.19.2020.03.23.19.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 19:39:11 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:39:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
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
        Ezequiel Garcia <ezequiel@collabora.com>,
        nicolas.dufresne@collabora.co.uk
Subject: Re: [PATCHv4 04/11] videobuf2: add queue memory consistency parameter
Message-ID: <20200324023909.GA201720@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-5-senozhatsky@chromium.org>
 <6e4fc7f9-0068-92ff-77d7-9c77c047f3db@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4fc7f9-0068-92ff-77d7-9c77c047f3db@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/20 14:46), Dafna Hirschfeld wrote:
[..]
> > +static void set_queue_consistency(struct vb2_queue *q, bool consistent_mem)
> > +{
> > +	if (!vb2_queue_allows_cache_hints(q))
> > +		return;
> > +
> > +	if (consistent_mem)
> > +		q->dma_attrs &= ~DMA_ATTR_NON_CONSISTENT;
> > +	else
> > +		q->dma_attrs |= DMA_ATTR_NON_CONSISTENT;
> > +}
> > +
> >   int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
> > -		unsigned int *count)
> > +		bool consistent_mem, unsigned int *count)
> You extended the vb2_core_reqbufs accepting a new boolean that
> is decided according to the setting of the V4L2_FLAG_MEMORY_NON_CONSISTENT
> but in the future some other flags might be added, and so I think it
> is better to replace the boolean with a u32 consisting of all the flags.

Don't have any objections. Can change the `bool' to `u32'.

	-ss
