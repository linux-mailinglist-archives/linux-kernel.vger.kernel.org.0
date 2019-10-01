Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0317C2D97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 08:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfJAGnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 02:43:45 -0400
Received: from verein.lst.de ([213.95.11.211]:42743 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfJAGnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 02:43:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5558A68B20; Tue,  1 Oct 2019 08:43:40 +0200 (CEST)
Date:   Tue, 1 Oct 2019 08:43:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        vladimir.murzin@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma/coherent: remove unused dma_get_device_base()
Message-ID: <20191001064339.GA8582@lst.de>
References: <1568725242-2433-1-git-send-email-cai@lca.pw> <1569444877.5576.232.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569444877.5576.232.camel@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:54:37PM -0400, Qian Cai wrote:
> Ping. Please take a look at this trivial patch.

No need to rush.  We just had the 5.4 merge window closing.  I'll
queue this up in the dma-mapping for-next tree for 5.5 once I open it.
