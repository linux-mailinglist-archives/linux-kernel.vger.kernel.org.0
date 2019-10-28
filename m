Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC68E6D78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 08:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfJ1Hqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 03:46:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbfJ1Hqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=70HmlurglAAJniJsVRSXqyyvPjG5hWGb7QIptsE5/dw=; b=gpwTNv9LlrjBzgxTbn2JJCgfx
        yo2KmFz4Ql2+VRN6InGivZiXsCqgEFHRSaL2RwSgnPt+LasNjvuxfNE8gkKzxXPqUP933RsJKgkUM
        C2g5gPcOEfgE7Zz12IVRJQQzVBKmH+APEObKsCMvxwGX4VWd95Gq/Vz8MTv7zMm8Ukya9w22hZhI8
        sNZX2S5hXFKY9tFdNPz8fH7qnZ86sXFXxW+ruKzTXNq93h/t/PlGKKIwU7bhotVwanxjJ1eZCtzL5
        SI+hDOOs+atLJNmFcStMa1H/Huuo3YjPXoKGuID+95tSMpMkBY5G5Jr56UI2gVx8NnZLMI7pvbcoN
        BMB783yiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iOzje-0001kr-Sp; Mon, 28 Oct 2019 07:46:42 +0000
Date:   Mon, 28 Oct 2019 00:46:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 1/2] mm: cma: Export cma symbols for cma heap as a
 module
Message-ID: <20191028074642.GB31867@infradead.org>
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025234834.28214-2-john.stultz@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:48:33PM +0000, John Stultz wrote:
>  struct cma *dma_contiguous_default_area;
> +EXPORT_SYMBOL(dma_contiguous_default_area);

Please CC the dma maintainer.  And no, you have no business using this.

Even if you did, internals like this should always be EXPORT_SYMBOL_GPL.
