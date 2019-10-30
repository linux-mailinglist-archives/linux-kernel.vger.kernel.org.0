Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5726AEA45D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 20:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfJ3Tph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 15:45:37 -0400
Received: from verein.lst.de ([213.95.11.211]:47490 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3Tpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:45:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE4BF68B05; Wed, 30 Oct 2019 20:45:32 +0100 (CET)
Date:   Wed, 30 Oct 2019 20:45:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dma-mapping: Add vmap checks to dma_map_single()
Message-ID: <20191030194532.GA21020@lst.de>
References: <20191029213423.28949-1-keescook@chromium.org> <20191029213423.28949-2-keescook@chromium.org> <20191030091849.GA637042@kroah.com> <20191030180921.GB19366@lst.de> <20191030192640.GC709410@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030192640.GC709410@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 08:26:40PM +0100, Greg Kroah-Hartman wrote:
> Looks good!  You can apply patch 2/2 as well if you want to take that
> through your tree too.

I can do that, I'll just need a formal ACK from you.
