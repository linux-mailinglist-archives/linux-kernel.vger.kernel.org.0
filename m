Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7600299C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 16:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403938AbfEXOKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 10:10:36 -0400
Received: from verein.lst.de ([213.95.11.211]:54179 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403843AbfEXOKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:10:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D03B7227A81; Fri, 24 May 2019 16:10:11 +0200 (CEST)
Date:   Fri, 24 May 2019 16:10:11 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     "hch@lst.de" <hch@lst.de>, "cai@lca.pw" <cai@lca.pw>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vmwgfx: fix a warning due to missing dma_parms
Message-ID: <20190524141011.GA23514@lst.de>
References: <20190524023719.1495-1-cai@lca.pw> <20190524061936.GA2337@lst.de> <c0290fd3af63cbbf677871370df29f6983ad1938.camel@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0290fd3af63cbbf677871370df29f6983ad1938.camel@vmware.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:57:04AM +0000, Thomas Hellstrom wrote:
> It's a PCI device. The struct device * used in dma_map_sg() is the same
> as the &pci_dev->dev handed to the probe() callback. But at probe time,
> the struct device::dma_parms is non-NULL, at least on my system so
> there shouldn't really be a need to kzalloc() it.

Then there is something really odd going on in the OPs setup..
