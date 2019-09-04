Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE411A8400
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfIDMzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 08:55:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfIDMzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gdrnI3IApvphw67NNHv0WFysZo4kw+6WTJSwiRiiRWU=; b=NVlcjAzROJCtIAKfEJ54n264cn
        OiYo3wOq58yhAgz7G3QG8MqJ5wYXIituzytSQ7QLX+/6FO0w5g4RxqAinZWvGr/PRMvjx9d+XwEHt
        t1AG7BVx+UqoiX3776j/wNGzHsX2/ZkH55B8T1ht+Y6fVbzG6kGLdvTMDJ+eFhnFff7oJycg9xD4N
        iwcez0sgKS1G+eAM02vcsBBFAWvjZ1LFrFmn/ejfgg0XfXZVUDQX7G+QifN76j2LU1SNn6T/Xb3Fp
        tAp7hIwv7mNxKULUFymI2I2fwftm3egGZMluZRxP0W1t0YVqFjdiklQZjz5diiIkOkhXYN17lgXn1
        WQcCEo2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5Up0-0000gK-HV; Wed, 04 Sep 2019 12:55:38 +0000
Date:   Wed, 4 Sep 2019 05:55:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dma api errors with swiotlb
Message-ID: <20190904125538.GA30177@infradead.org>
References: <e3c4b2e1-7518-ab0e-a6ce-3fae9903dac0@shipmail.org>
 <20190904121722.GA15601@infradead.org>
 <4e21951d-025a-2b3d-14c8-878c6f237525@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e21951d-025a-2b3d-14c8-878c6f237525@shipmail.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:54:26PM +0200, Thomas Hellström (VMware) wrote:
> On 9/4/19 2:17 PM, Christoph Hellwig wrote:
> > A call to dma_max_mapping_size() to limit the maximum I/O size solves
> > that problem.  With the latest kernel that should actually be done
> > automatically by the SCSI midlayer for you.
> 
> Hmm, OK. I guess with a sufficient queue depth and many mappings waiting for
> DMA completion, the SWIOTLB may fill up anyway...
> 
> I'll see if I can come up with something.

You are supposed to return SCSI_MLQUEUE_HOST_BUSY in that case,
which means that the kernel won't send more commands until another
one completed.
