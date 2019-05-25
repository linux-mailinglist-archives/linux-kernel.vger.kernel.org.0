Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94B2A33E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 08:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEYG6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 02:58:44 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:49481 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEYG6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 02:58:44 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D564C20098;
        Sat, 25 May 2019 08:58:40 +0200 (CEST)
Date:   Sat, 25 May 2019 08:58:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        michael@amarulasolutions.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH] drm/panel: st7701: Swap vertical front and back porch
 timings
Message-ID: <20190525065839.GD9586@ravnborg.org>
References: <20190512184827.13905-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512184827.13905-1-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=iP-xVBlJAAAA:8
        a=85sVP7tpRlSMwrdesq8A:9 a=CjuIK1q_8ugA:10 a=lHLH-nfn2y1bM_0xSXwp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 12:18:27AM +0530, Jagan Teki wrote:
> Vertical front and back porch values on existing driver are swapped.
> The existing timings are still working as expected, but to make sure 
> it can compatible with techstar ts8550b bsp timings this patch swap
> the same values.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Thanks, applied.

	Sam
