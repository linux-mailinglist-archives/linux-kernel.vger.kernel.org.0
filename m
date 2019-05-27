Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE562AF59
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 09:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfE0HWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 03:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfE0HWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:22:48 -0400
Received: from localhost (unknown [84.241.203.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB4C21721;
        Mon, 27 May 2019 07:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558941767;
        bh=1cA0cnInqvTzulrpX7d6hXfocOLgpBBrZG8Ny9ZxLfk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ceREux1QwTsso3dG4v3GF5RI6RERXGAx5Pkm03bCgLmj01YUcOYonXcmpkIeVTfw3
         tDtqyFmhoJoX1Nfm6GyRLl/bcYPP3pYUtr8lxGIjz4x5hi8x2nwzGEaCdGKbirpqf1
         icAfoPLCCpNRl/tP4xPiiB4c+OwZ4V+xOikYIHbc=
Date:   Mon, 27 May 2019 09:22:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: Re: [PATCH 14/33] staging/olpc: lock_fb_info can't fail
Message-ID: <20190527072243.GC7997@kroah.com>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
 <20190524085354.27411-15-daniel.vetter@ffwll.ch>
 <20190527071010.GK21222@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527071010.GK21222@phenom.ffwll.local>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 09:10:10AM +0200, Daniel Vetter wrote:
> On Fri, May 24, 2019 at 10:53:35AM +0200, Daniel Vetter wrote:
> > Simply because olpc never unregisters the damn thing. It also
> > registers the framebuffer directly by poking around in fbdev
> > core internals, so it's all around rather broken.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Jens Frederich <jfrederich@gmail.com>
> > Cc: Daniel Drake <dsd@laptop.org>
> > Cc: Jon Nettleton <jon.nettleton@gmail.com>
> 
> Hi Greg,
> 
> Somehow get_maintainers didn't pick you up for this. Ack for merging this
> through drm/fbdev? It's part of a bigger series to rework fbdev/fbcon
> interactions.

Again, all good for you to take:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
