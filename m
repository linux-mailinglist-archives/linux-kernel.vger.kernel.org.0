Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E069658234
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 14:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfF0MKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 08:10:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfF0MKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:10:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE5DFC18B2E5;
        Thu, 27 Jun 2019 12:10:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404FB1975F;
        Thu, 27 Jun 2019 12:10:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CC5DA11AAF; Thu, 27 Jun 2019 14:10:16 +0200 (CEST)
Date:   Thu, 27 Jun 2019 14:10:16 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/2] drm/vram: store dumb bo dimensions.
Message-ID: <20190627121016.fddmd6rxq7vpl7ev@sirius.home.kraxel.org>
References: <20190626065551.12956-1-kraxel@redhat.com>
 <20190626065551.12956-2-kraxel@redhat.com>
 <a5663141-ebee-db14-30cc-f0b3f90fe6bb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5663141-ebee-db14-30cc-f0b3f90fe6bb@suse.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 27 Jun 2019 12:10:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> For the Gnome issue, a fix would be to program the display HW's line
> pitch to the correct value.

Yes, and drm_framebuffer actually has the pitches,
so no need for this patch indeed.

cheers,
  Gerd

