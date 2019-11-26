Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD38E10A46F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 20:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKZTYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 14:24:51 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:49834 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:24:50 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B03BA20055;
        Tue, 26 Nov 2019 20:24:46 +0100 (CET)
Date:   Tue, 26 Nov 2019 20:24:45 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/30] drm: Introduce drm_bridge_init()
Message-ID: <20191126192445.GA2044@ravnborg.org>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <20191126131541.47393-2-mihail.atanassov@arm.com>
 <20191126142610.GV29965@phenom.ffwll.local>
 <11447519.fzG14qnjOE@e123338-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11447519.fzG14qnjOE@e123338-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=oJJ1f2mEg_3WOdBYLHIA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mihail.

> Ack, but with one caveat: bridge->dev is the struct drm_device that is
> the bridge client, we need to add a bridge->device (patch 29 in this
> series) which is the struct device that will manage the bridge lifetime.
Other places uses the variable name "drm" for a drm_device.
This is less confusion than the "dev" name.

It seems a recent trend to use the variable name "drm" so you can find a
lot of places using "dev".

bike-shedding - but also about readability.

	Sam
