Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E273AA1E04
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 16:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfH2OyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 10:54:20 -0400
Received: from verein.lst.de ([213.95.11.211]:46987 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfH2OyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:54:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 11F1468B20; Thu, 29 Aug 2019 16:54:17 +0200 (CEST)
Date:   Thu, 29 Aug 2019 16:54:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Christoph Hellwig <hch@lst.de>, tomi.valkeinen@ti.com,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove dma_{alloc,free,mmap}_writecombine
Message-ID: <20190829145416.GA19460@lst.de>
References: <20190730061849.29686-1-hch@lst.de> <20190730135045.GA4806@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730135045.GA4806@pendragon.ideasonboard.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 04:50:45PM +0300, Laurent Pinchart wrote:
> I would have indented this line to match the rest. Apart from that,

I've fixed that up now that I've applied the patch.
