Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716A7CC8CD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfJEIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 04:38:00 -0400
Received: from verein.lst.de ([213.95.11.211]:49353 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfJEIiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 04:38:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1994E68B05; Sat,  5 Oct 2019 10:37:54 +0200 (CEST)
Date:   Sat, 5 Oct 2019 10:37:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ryohei Suzuki <ryh.szk.cmnty@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peng Fan <peng.fan@nxp.com>, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] mm: export cma alloc and release
Message-ID: <20191005083753.GA14691@lst.de>
References: <20191002212257.196849-1-salyzyn@android.com> <20191003085528.GB21629@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003085528.GB21629@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:55:28AM +0100, Catalin Marinas wrote:
> Aren't drivers supposed to use the DMA API for such allocations rather
> than invoking cma_*() directly?

Yes, they are.
