Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7BD4957B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 08:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfHTG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 02:57:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHTG5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:57:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7565BA38186;
        Tue, 20 Aug 2019 06:57:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 107E45D9CD;
        Tue, 20 Aug 2019 06:57:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4A2B011AAF; Tue, 20 Aug 2019 08:57:24 +0200 (CEST)
Date:   Tue, 20 Aug 2019 08:57:24 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/qxl: fix a memory leak bug
Message-ID: <20190820065724.mc3anvne2sf356x3@sirius.home.kraxel.org>
References: <1566238098-3962-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566238098-3962-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Tue, 20 Aug 2019 06:57:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:08:18PM -0500, Wenwen Wang wrote:
> In qxl_bo_create(), the temporary 'bo' is allocated through kzalloc().
> However, it is not deallocated in the following execution if ttm_bo_init()
> fails, leading to a memory leak bug. To fix this issue, free 'bo' before
> returning the error.

No.  ttm_bo_init() calls the destroy callback (qxl_ttm_bo_destroy for
qxl) on failure, which will properly cleanup 'bo' and also free it.

cheers,
  Gerd

