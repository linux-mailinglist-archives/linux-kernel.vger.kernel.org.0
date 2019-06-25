Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09EFE55C23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 01:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFYXTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 19:19:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40914 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:19:01 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfuiE-0002co-Rt; Tue, 25 Jun 2019 23:18:54 +0000
Date:   Wed, 26 Jun 2019 00:18:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sean Paul <sean@poorly.run>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm: return -EFAULT if copy_to_user() fails
Message-ID: <20190625231854.GL17978@ZenIV.linux.org.uk>
References: <20190618125623.GA24896@mwanda>
 <20190618131843.GA29463@mwanda>
 <20190618171629.GB25413@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618171629.GB25413@art_vandelay>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 01:16:29PM -0400, Sean Paul wrote:
> On Tue, Jun 18, 2019 at 04:18:43PM +0300, Dan Carpenter wrote:
> > The copy_from_user() function returns the number of bytes remaining
> > to be copied but we want to return a negative error code.  Otherwise
> > the callers treat it as a successful copy.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks Dan, I've applied this to drm-misc-fixes.

FWIW, Acked-by: Al Viro <viro@zeniv.linux.org.uk>
