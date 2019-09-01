Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F00A4858
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfIAIDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 04:03:44 -0400
Received: from verein.lst.de ([213.95.11.211]:40677 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbfIAIDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 04:03:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B83B9227A8A; Sun,  1 Sep 2019 10:03:41 +0200 (CEST)
Date:   Sun, 1 Sep 2019 10:03:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] riscv: refactor the IPI code
Message-ID: <20190901080341.GC12035@lst.de>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-4-hch@lst.de> <alpine.DEB.2.21.9999.1908132141350.18249@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908132141350.18249@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:41:58PM -0700, Paul Walmsley wrote:
> On Tue, 13 Aug 2019, Christoph Hellwig wrote:
> 
> > This prepare for adding native non-SBI IPI code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Thanks, queued for v5.4-rc1.

I still don't see it in any tree, so I'll resend it with the next
version.
