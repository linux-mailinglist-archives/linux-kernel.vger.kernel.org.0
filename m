Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FBE98884
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 02:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfHVAbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 20:31:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:41311 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfHVAbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:31:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7M0VEVU012747;
        Wed, 21 Aug 2019 19:31:15 -0500
Message-ID: <87e1fea1c297ef98f989175b3041c69e8b7de020.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 2/4] nvme-pci: Add support for variable IO SQ element
 size
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>
Date:   Thu, 22 Aug 2019 10:31:14 +1000
In-Reply-To: <20190822002818.GA10391@lst.de>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
         <20190807075122.6247-3-benh@kernel.crashing.org>
         <20190822002818.GA10391@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-22 at 02:28 +0200, Christoph Hellwig wrote:
> On Wed, Aug 07, 2019 at 05:51:20PM +1000, Benjamin Herrenschmidt
> wrote:
> > +#define NVME_NVM_ADMSQES	6
> >  #define NVME_NVM_IOSQES		6
> >  #define NVME_NVM_IOCQES		4
> 
> The NVM in the two defines here stands for the NVM command set,
> so this should just be named NVME_ADM_SQES or so.  But except for
> this
> the patch looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> So maybe Sagi can just fix this up in the tree.

Ah ok I missed the meaning. Thanks. Sagi, can you fix that up or do you
need me to resubmit ?

Cheers,
Ben.


