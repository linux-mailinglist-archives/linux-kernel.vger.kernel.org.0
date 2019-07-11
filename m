Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55A46544A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 12:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfGKKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 06:05:19 -0400
Received: from verein.lst.de ([213.95.11.211]:56818 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfGKKFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:05:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EF0B68B20; Thu, 11 Jul 2019 12:05:17 +0200 (CEST)
Date:   Thu, 11 Jul 2019 12:05:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for
 certain DMA masks
Message-ID: <20190711100516.GB5853@lst.de>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

this looks good to me.  I'll wait a bit for feedback from the x86 folks,
and if everything is fine I'll apply it to the dma-mapping tree.
