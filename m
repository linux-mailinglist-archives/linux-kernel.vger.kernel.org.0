Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2B28DC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfHNRtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 13:49:32 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:38643 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbfHNRtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:49:32 -0400
Received: by mail-ed1-f45.google.com with SMTP id r12so13496edo.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hb464daFGycQhSgA9BEwjg8HNKIy+QMbts1XhF2KkhY=;
        b=XbdmfFcT3jnZqRlVTGuaAFo1OtCPLWFWljVro0mfCdbdxEefp8fNvLYheP9O/U9RZ5
         YWZ3imdFdL067IfOXnulKaXhUdDc+FcfNtu2hXsJNTM3bqKaa2YWSCA2NxFoIkrLyN7v
         daxCcz4A95TTfgIwKhFdy5WvEkqqbj31ATPN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Hb464daFGycQhSgA9BEwjg8HNKIy+QMbts1XhF2KkhY=;
        b=tC+MoN2odsPVZUEHayUhXj7OdpSA39tYJGV6MEpKZzw8pF6q6DG2UrGk/K7wTAtIm4
         /l0SRETXxE3/Y04Rp2ZD5ciN6J8kxOc7pURZXoFP1hb45mxMQyIpPqO87Swqu63ElDFo
         oXSIC/AsZwNF0B5m2wDC9CBVkjMgxDDpj7Xe2xxpk8lWDBxknGA7EQs4my0zJPGST96A
         4W0AMhoXVxDoqpFjpnMU8s0BDR81J8FaUBCwGqmO7ku8DxI0Oa4V6dTyWh4sHh4LVTn4
         nPlP+lMu7waBVEalTj1Qocyen2OLVQboVoSA/P41HmiuyWF5fiZwLXD2fI3WtXYnsra4
         tTAQ==
X-Gm-Message-State: APjAAAXF4QPq5uZPTa9w378g9hdBh6KCo/d5UU/o3TfXND41wOO3K8Mf
        afxnYkq3uUPr6I6eNFbFr80WtA==
X-Google-Smtp-Source: APXvYqwBl2F3g+zroJnkq4eZ/+bHbYQoVu/ZDXQOMXZayvH7IQw3wqGZbNdQii7iJcpfIK39yqAZTQ==
X-Received: by 2002:a17:906:7681:: with SMTP id o1mr710091ejm.207.1565804970147;
        Wed, 14 Aug 2019 10:49:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b17sm81942edy.43.2019.08.14.10.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 10:49:29 -0700 (PDT)
Date:   Wed, 14 Aug 2019 19:49:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: DMA-API: cacheline tracking ENOMEM, dma-debug disabled due to
 nouveau ?
Message-ID: <20190814174927.GT7444@phenom.ffwll.local>
Mail-Followup-To: Corentin Labbe <clabbe.montjoie@gmail.com>,
        bskeggs@redhat.com, airlied@linux.ie, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20190814145033.GA11190@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814145033.GA11190@Red>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 04:50:33PM +0200, Corentin Labbe wrote:
> Hello
> 
> Since lot of release (at least since 4.19), I hit the following error message:
> DMA-API: cacheline tracking ENOMEM, dma-debug disabled
> 
> After hitting that, I try to check who is creating so many DMA mapping and see:
> cat /sys/kernel/debug/dma-api/dump | cut -d' ' -f2 | sort | uniq -c
>       6 ahci
>     257 e1000e
>       6 ehci-pci
>    5891 nouveau
>      24 uhci_hcd
> 
> Does nouveau having this high number of DMA mapping is normal ?

Yeah seems perfectly fine for a gpu.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
