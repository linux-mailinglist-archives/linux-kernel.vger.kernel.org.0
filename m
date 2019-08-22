Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1269887B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 02:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfHVA2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 20:28:45 -0400
Received: from verein.lst.de ([213.95.11.211]:42086 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfHVA2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:28:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3DE4068BFE; Thu, 22 Aug 2019 02:28:42 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:28:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH v4 3/4] nvme-pci: Add support for Apple 2018+ models
Message-ID: <20190822002842.GB10391@lst.de>
References: <20190807075122.6247-1-benh@kernel.crashing.org> <20190807075122.6247-4-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807075122.6247-4-benh@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:51:21PM +1000, Benjamin Herrenschmidt wrote:
> Based on reverse engineering and original patch by
> 
> Paul Pawlowski <paul@mrarm.io>
> 
> This adds support for Apple weird implementation of NVME in their
> 2018 or later machines. It accounts for the twice-as-big SQ entries
> for the IO queues, and the fact that only interrupt vector 0 appears
> to function properly.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
