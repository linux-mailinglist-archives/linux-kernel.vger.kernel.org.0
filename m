Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B086787CC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 16:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406802AbfHIOb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 10:31:28 -0400
Received: from verein.lst.de ([213.95.11.211]:55714 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfHIOb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:31:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E1E568C4E; Fri,  9 Aug 2019 16:31:24 +0200 (CEST)
Date:   Fri, 9 Aug 2019 16:31:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH for-5.3] drm/omap: ensure we have a valid dma_mask
Message-ID: <20190809143124.GA10121@lst.de>
References: <20190808101042.18809-1-hch@lst.de> <7fff8fd3-16ae-1f42-fcd6-9aa360fe36b5@ti.com> <20190809080750.GA21874@lst.de> <c219e7e6-0f66-d6fd-e0cf-59c803386825@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c219e7e6-0f66-d6fd-e0cf-59c803386825@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:00:38PM +0300, Tomi Valkeinen wrote:
> Alright, thanks for the clarification!
> 
> Here's my version.

Looks god to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
