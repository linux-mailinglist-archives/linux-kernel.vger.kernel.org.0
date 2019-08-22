Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622759891A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 03:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfHVBub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 21:50:31 -0400
Received: from verein.lst.de ([213.95.11.211]:42689 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbfHVBub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:50:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1AA168BFE; Thu, 22 Aug 2019 03:50:27 +0200 (CEST)
Date:   Thu, 22 Aug 2019 03:50:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <Anup.Patel@wdc.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3 2/3] RISC-V: Issue a tlb page flush if possible
Message-ID: <20190822015027.GB11922@lst.de>
References: <20190822004644.25829-1-atish.patra@wdc.com> <20190822004644.25829-3-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822004644.25829-3-atish.patra@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 05:46:43PM -0700, Atish Patra wrote:
> +		if (size <= PAGE_SIZE && size != -1)
> +			local_flush_tlb_page(start);
> +		else
> +			local_flush_tlb_all();

As Andreas pointed out (unsigned long)-1 is actually larger than
PAGE_SIZE, so we don't need the extra check.
