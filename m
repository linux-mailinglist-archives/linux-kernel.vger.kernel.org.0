Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F17B3EB440
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 16:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfJaPwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 11:52:25 -0400
Received: from verein.lst.de ([213.95.11.211]:51719 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:52:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4526368BE1; Thu, 31 Oct 2019 16:52:22 +0100 (CET)
Date:   Thu, 31 Oct 2019 16:52:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RISC-V nommu support v6
Message-ID: <20191031155222.GA7270@lst.de>
References: <20191028121043.22934-1-hch@lst.de> <alpine.DEB.2.21.9999.1910301311240.6452@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1910301311240.6452@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 01:21:21PM -0700, Paul Walmsley wrote:
> I tried building this series from your git branch mentioned above, and 
> booted it with a buildroot userspace built from your custom buildroot 
> tree.  Am seeing some segmentation faults from userspace (below). 
> 
> Am still planning to merge your patches.
> 
> But I'm wondering whether you are seeing these segmentation faults also? 
> Or is it something that might be specific to my test setup?

I just built a fresh image using make -j4 with that report and it works
perfectly fine with my tree.
