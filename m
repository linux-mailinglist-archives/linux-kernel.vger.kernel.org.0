Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD01DB4D13
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfIQLkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 07:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfIQLkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:40:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62364369AC;
        Tue, 17 Sep 2019 11:40:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 037C76012E;
        Tue, 17 Sep 2019 11:40:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7883E16E05; Tue, 17 Sep 2019 13:40:41 +0200 (CEST)
Date:   Tue, 17 Sep 2019 13:40:41 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Huang, Ray" <Ray.Huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] drm/ttm: drop VM_DONTDUMP
Message-ID: <20190917114041.6oaukfnsai5rmf54@sirius.home.kraxel.org>
References: <20190917092404.9982-1-kraxel@redhat.com>
 <20190917092404.9982-8-kraxel@redhat.com>
 <c29222f7-2737-2416-62c9-eafd4d608ded@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c29222f7-2737-2416-62c9-eafd4d608ded@amd.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 17 Sep 2019 11:40:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 11:22:35AM +0000, Koenig, Christian wrote:
> Am 17.09.19 um 11:24 schrieb Gerd Hoffmann:
> > Not obvious why this is needed.  According to Deniel Vetter this is most
> > likely a historic artefact dating back to the days where drm drivers
> > exposed hardware registers as mmap'able gem objects, to avoid dumping
> > touching those registers.
> 
> Clearly a NAK.
> 
> We still have that and really don't want to try dumping any CPU 
> inaccessible VRAM content even if it is mapped into the address space 
> somewhere.

Thanks for the clarification, I'll drop the patch.

cheers,
  Gerd

