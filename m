Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D964A9887A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 02:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfHVA2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 20:28:23 -0400
Received: from verein.lst.de ([213.95.11.211]:42082 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfHVA2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:28:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 149D468BFE; Thu, 22 Aug 2019 02:28:18 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:28:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Paul Pawlowski <paul@mrarm.io>
Subject: Re: [PATCH v4 2/4] nvme-pci: Add support for variable IO SQ
 element size
Message-ID: <20190822002818.GA10391@lst.de>
References: <20190807075122.6247-1-benh@kernel.crashing.org> <20190807075122.6247-3-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807075122.6247-3-benh@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:51:20PM +1000, Benjamin Herrenschmidt wrote:
> +#define NVME_NVM_ADMSQES	6
>  #define NVME_NVM_IOSQES		6
>  #define NVME_NVM_IOCQES		4

The NVM in the two defines here stands for the NVM command set,
so this should just be named NVME_ADM_SQES or so.  But except for this
the patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

So maybe Sagi can just fix this up in the tree.
