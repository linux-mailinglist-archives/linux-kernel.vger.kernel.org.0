Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11837732E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfGXPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 11:37:28 -0400
Received: from verein.lst.de ([213.95.11.211]:51954 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfGXPh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:37:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 24FAE68BFE; Wed, 24 Jul 2019 17:37:25 +0200 (CEST)
Date:   Wed, 24 Jul 2019 17:37:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Roger Quadros <rogerq@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: add swiotlb support to arm32
Message-ID: <20190724153724.GB10681@lst.de>
References: <20190709142011.24984-1-hch@lst.de> <6a56eacd-d481-de93-e0d8-64d8385de214@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a56eacd-d481-de93-e0d8-64d8385de214@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I've tentatively pulled the branch into the dma-mapping for-next
branch so that we get some linux-next exposure.
