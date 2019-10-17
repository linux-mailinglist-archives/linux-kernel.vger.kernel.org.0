Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FBFDAC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 14:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406227AbfJQMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 08:32:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfJQMct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:32:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A2C13082A6C;
        Thu, 17 Oct 2019 12:32:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C756194B6;
        Thu, 17 Oct 2019 12:32:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6A58D16E2D; Thu, 17 Oct 2019 14:32:48 +0200 (CEST)
Date:   Thu, 17 Oct 2019 14:32:48 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/qxl: Fix randbuild error
Message-ID: <20191017123248.b4d4jd6wfu7np25n@sirius.home.kraxel.org>
References: <20191008024054.32368-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008024054.32368-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 17 Oct 2019 12:32:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:40:54AM +0800, YueHaibing wrote:
> If DEM_QXL is y and DRM_TTM_HELPER is m, building fails:
> 
> drivers/gpu/drm/qxl/qxl_object.o: undefined reference to `drm_gem_ttm_print_info'
> 
> Select DRM_TTM_HELPER to fix this.

Queued up for drm-misc-next.

thanks,
  Gerd

