Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F35186955
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 11:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgCPKpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 06:45:30 -0400
Received: from verein.lst.de ([213.95.11.211]:53699 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730478AbgCPKpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:45:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7B75168CEC; Mon, 16 Mar 2020 11:45:27 +0100 (CET)
Date:   Mon, 16 Mar 2020 11:45:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     robin.murphy@arm.com, m.szyprowski@samsung.com, hch@lst.de,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316104526.GA14735@lst.de>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314000007.13778-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm tempted to apply this, athough we it has the risk of introducing
regression.  Robin, Mark: any comments?
