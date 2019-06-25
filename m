Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD752396
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 08:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfFYGee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 02:34:34 -0400
Received: from verein.lst.de ([213.95.11.211]:59917 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfFYGee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:34:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2A77268B02; Tue, 25 Jun 2019 08:34:03 +0200 (CEST)
Date:   Tue, 25 Jun 2019 08:34:02 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 7/7] arc: use the generic remapping allocator for
 coherent DMA allocations
Message-ID: <20190625063402.GC29561@lst.de>
References: <20190614144431.21760-1-hch@lst.de> <20190614144431.21760-8-hch@lst.de> <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com> <20190615083554.GC23406@lst.de> <20190624131417.GA10593@lst.de> <d9ed8f6a82801b94d1d7792eb74effdbce09ce51.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ed8f6a82801b94d1d7792eb74effdbce09ce51.camel@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:13:17PM +0000, Eugeniy Paltsev wrote:
> Hi Christoph,
> 
> Yep I've reviewed and tested it for both cases:
> - coherent/noncoherent dma
> - allocation from atomic_pool/regular allocation
> 
> everything works fine for ARC.

Thanks.  I've applied the whole series to the dma-mapping for-next
branch.
