Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE4A69E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfICNaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 09:30:55 -0400
Received: from verein.lst.de ([213.95.11.211]:58443 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbfICNay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:30:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 571B8227A8A; Tue,  3 Sep 2019 15:30:51 +0200 (CEST)
Date:   Tue, 3 Sep 2019 15:30:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        Christoph Hellwig <hch@lst.de>, aik@ozlabs.ru,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powernv: fix a W=1 compilation warning
Message-ID: <20190903133051.GA23985@lst.de>
References: <1558541369-8263-1-git-send-email-cai@lca.pw> <1567517354.5576.45.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567517354.5576.45.camel@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 09:29:14AM -0400, Qian Cai wrote:
> I saw Christ start to remove npu-dma.c code [1]
> 
> [1] https://lore.kernel.org/linuxppc-dev/20190625145239.2759-4-hch@lst.de/
> 
> Should pnv_npu_dma_set_32() be removed too?
> 
> It was only called by pnv_npu_try_dma_set_bypass() but the later is not used
> anywhere in the kernel tree. If that is a case, I don't need to bother fixing
> the warning here.

Yes, pnv_npu_try_dma_set_bypass and pnv_npu_dma_set_32 should go away
as well as they are unused.  Do you want to send a patch or should I
prepare one?
