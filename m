Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA62FEAEC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 07:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfKPGXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 01:23:01 -0500
Received: from verein.lst.de ([213.95.11.211]:47899 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfKPGXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 01:23:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EC8968BE1; Sat, 16 Nov 2019 07:22:58 +0100 (CET)
Date:   Sat, 16 Nov 2019 07:22:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: generic DMA bypass flag
Message-ID: <20191116062258.GA8913@lst.de>
References: <20191113133731.20870-1-hch@lst.de> <d27b7b29-df78-4904-8002-b697da5cb013@arm.com> <20191114074105.GC26546@lst.de> <9c8f4d7b-43e0-a336-5d93-88aef8aae716@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c8f4d7b-43e0-a336-5d93-88aef8aae716@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 06:12:48PM +0000, Robin Murphy wrote:
> And is that any different from where you would choose to "just" set a 
> generic bypass flag?

Same spots, as intel-iommu moves from the identify to a dma domain when
setting a 32-bit mask.  But that means once a 32-bit mask is set we can't
ever go back to the 64-bit one.  And we had a couple drivers playing
interesting games there.  FYI, this is the current intel-iommu
WIP conversion to the dma bypass flag:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-bypass
