Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 025012669E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 17:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfEVPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 May 2019 11:06:39 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:33426 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfEVPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:06:39 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D5AB2803D6;
        Wed, 22 May 2019 17:06:35 +0200 (CEST)
Date:   Wed, 22 May 2019 17:06:34 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/cirrus: remove leftover files
Message-ID: <20190522150634.GA26677@ravnborg.org>
References: <20190522103307.12711-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522103307.12711-1-kraxel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8
        a=7gkXJVJtAAAA:8 a=Uddh69Z27F23pCbIwTIA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:33:07PM +0200, Gerd Hoffmann wrote:
> cirrus_drv.h and cirrus_ttm.c are unused since commit ab3e023b1b4c
> ("drm/cirrus: rewrite and modernize driver"), apparently I ran "rm"
> instead of "git rm" on them so they are still in present the tree.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Always nice with the code removal patches.
Will you apply yourself?

	Sam
