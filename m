Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D645D07A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfJIGvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 02:51:18 -0400
Received: from verein.lst.de ([213.95.11.211]:50523 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJIGvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:51:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C056968B05; Wed,  9 Oct 2019 08:51:15 +0200 (CEST)
Date:   Wed, 9 Oct 2019 08:51:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
Message-ID: <20191009065115.GB30157@lst.de>
References: <20191008143357.GA599223@rani.riverdale.lan> <76d680ab-a454-4a69-597a-c0edbfc5014b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d680ab-a454-4a69-597a-c0edbfc5014b@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:45:15AM +0800, Lu Baolu wrote:
> Do you mind explaining why we always return 32 bit here?

See the comment in dma_get_required_mask().
