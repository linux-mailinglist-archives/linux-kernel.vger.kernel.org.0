Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B50052323
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 07:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfFYFvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 01:51:35 -0400
Received: from verein.lst.de ([213.95.11.211]:59613 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbfFYFvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:51:35 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D331368B02; Tue, 25 Jun 2019 07:51:03 +0200 (CEST)
Date:   Tue, 25 Jun 2019 07:51:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Vincent Chen <deanbo422@gmail.com>,
        iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] switch nds32 to use the generic remapping DMA allocator
Message-ID: <20190625055103.GA28854@lst.de>
References: <20190614100928.9791-1-hch@lst.de> <CAEbi=3dnZNfMeLeuf9Y-d0HxTe_v1F_45Tb_TZwaat_LJq66SQ@mail.gmail.com> <20190614122143.GA26467@lst.de> <CAEbi=3dv=bfuFt0f3Pp4W8Cgir3zOO8gXO-5AYPgfZQF-g+yHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEbi=3dv=bfuFt0f3Pp4W8Cgir3zOO8gXO-5AYPgfZQF-g+yHw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to dma-mapping for-next.
