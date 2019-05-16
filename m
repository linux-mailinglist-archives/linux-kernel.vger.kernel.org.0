Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A820B74
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfEPPpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 11:45:34 -0400
Received: from rosenzweig.io ([107.170.207.86]:48198 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPPpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:45:34 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 11:45:34 EDT
Received: by rosenzweig.io (Postfix, from userid 1000)
        id 091D860AC9; Thu, 16 May 2019 08:36:28 -0700 (PDT)
Date:   Thu, 16 May 2019 08:36:27 -0700
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/panfrost: drm_gem_map_offset() helper
Message-ID: <20190516153627.GA22778@rosenzweig.io>
References: <20190516141447.46839-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516141447.46839-1-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing maintainers more aware of the substance review it and ok it,
patches 1-2 are:

	Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Patch 3 should be:

	Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
