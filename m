Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE9A5240
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 10:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfIBIzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 04:55:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbfIBIzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:55:07 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1014A882F5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2019 08:55:07 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a17so8484320wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zn38zF8kCwg/Vx1WwgH4NCJKhUG8AC5IPLG4wa1Ab7U=;
        b=FkLmfUuFoS25QINL2G65mkRHqR7dQ1s8mNpQqGHEzcFXihKlZ0knWwDwK98g1VpsE0
         rgXjPeEfi6adCTjm9l0t1x9Z3vTeHx9IGBGAGtz7uE4lZ2L+JFh8VaYRmxGSMxpge/Il
         rdU+Qdl2aoMmTkLLR7A8qyPEAP7LvLrh9/rEzsBLRnrTbEvsKic1m4P4bUh3KKpT/ehw
         kE/PiparRxN3XrLeR34DE5NSgc9TAocJF0k8z6MRgS7CuG5EvN2zk0UISMmqF4ZDo9pq
         nDaHD+a8/4b+UWGUH34Y5YKfK2VuDQ/0DcQo0LMfC7kpibOUvy6XTWxB/ukIo73eq/15
         rgfA==
X-Gm-Message-State: APjAAAXgF/+1oRF2mEMufXFXsCAIzmapLKoEWKtBPgaQa8W17abigAA9
        xe2sd0qYOC0dAbw2Gyh1FtDA2A/zVwe+YP1Gs0FsKjkS2+nMghP9v0jHKHouyTXm7Kpi9hUd/KH
        8sSMPKGpDDnGenOeUNyk46ut+
X-Received: by 2002:adf:e710:: with SMTP id c16mr35878957wrm.292.1567414505726;
        Mon, 02 Sep 2019 01:55:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxRv2dxDp5HY9Bd5yGXlGV+SOSiRsI1AgF+9hTAgXTKirFFUPOo1BMgb+sEqhfw0/g7IncCmA==
X-Received: by 2002:adf:e710:: with SMTP id c16mr35878922wrm.292.1567414505448;
        Mon, 02 Sep 2019 01:55:05 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it. [79.36.61.170])
        by smtp.gmail.com with ESMTPSA id r5sm12305474wmh.35.2019.09.02.01.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 01:55:04 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:55:02 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>
Cc:     kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Message-ID: <20190902085502.jlfo36aoka7lwi2u@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190717113030.163499-2-sgarzare@redhat.com>
 <20190729095956-mutt-send-email-mst@kernel.org>
 <20190830094059.c7qo5cxrp2nkrncd@steredhat>
 <20190901024525-mutt-send-email-mst@kernel.org>
 <20190902083912.GA9069@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902083912.GA9069@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 09:39:12AM +0100, Stefan Hajnoczi wrote:
> On Sun, Sep 01, 2019 at 02:56:44AM -0400, Michael S. Tsirkin wrote:
> > 
> > OK let me try to clarify.  The idea is this:
> > 
> > Let's say we queue a buffer of 4K, and we copy if len < 128 bytes.  This
> > means that in the worst case (128 byte packets), each byte of credit in
> > the socket uses up 4K/128 = 16 bytes of kernel memory. In fact we need
> > to also account for the virtio_vsock_pkt since I think it's kept around
> > until userspace consumes it.
> > 
> > Thus given X buf alloc allowed in the socket, we should publish X/16
> > credits to the other side. This will ensure the other side does not send
> > more than X/16 bytes for a given socket and thus we won't need to
> > allocate more than X bytes to hold the data.
> > 
> > We can play with the copy break value to tweak this.

Thanks Michael, now it is perfectly clear. It seems an excellent solution and
easy to implement. I'll work on that.

> 
> This seems like a reasonable solution.  Hopefully the benchmark results
> will come out okay too.

Yes, as Michael suggested I'll play with the copy break value to see as
benchmark has affected.

Thank you very much,
Stefano
