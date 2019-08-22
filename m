Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAA998D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfHVIL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 04:11:56 -0400
Received: from verein.lst.de ([213.95.11.211]:44790 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfHVIL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:11:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 999B968C4E; Thu, 22 Aug 2019 10:11:53 +0200 (CEST)
Date:   Thu, 22 Aug 2019 10:11:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [PATCH v4 3/3] RISC-V: Issue a tlb page flush if possible
Message-ID: <20190822081153.GC17573@lst.de>
References: <20190822075151.24838-1-atish.patra@wdc.com> <20190822075151.24838-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822075151.24838-4-atish.patra@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 12:51:51AM -0700, Atish Patra wrote:
> If tlbflush request is for page only, there is no need to do a
> complete local tlb shootdown.
> 
> Just do a local tlb flush for the given address.

Looks good, although I suspect in many cases even doing multiple
single-page sfence.vma calls might be cheaper than the global one.

But I think that is worth a ѕeparate discussion, preferably with actual
numbers.

Reviewed-by: Christoph Hellwig <hch@lst.de>
