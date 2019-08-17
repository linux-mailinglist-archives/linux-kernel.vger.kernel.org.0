Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C680911F5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 18:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfHQQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 12:35:54 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:56762 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfHQQfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 12:35:54 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 8559C2004D;
        Sat, 17 Aug 2019 18:35:50 +0200 (CEST)
Date:   Sat, 17 Aug 2019 18:35:49 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/arm: drop use of drmP.h
Message-ID: <20190817163549.GA15813@ravnborg.org>
References: <20190817074115.19116-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817074115.19116-1-realwakka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=PZMyd2dMwuOkAlfwmFgA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidong

On Sat, Aug 17, 2019 at 08:41:15AM +0100, Sidong Yang wrote:
> Drop use of deprecated drmP.h header file.
> Remove drmP.h includes and add some include headers for function or
> struct that used in code.

Thanks for your patch.
We already have a similiar patch in drm-misc-next, that
drop the use of drmP.h from arm so this patch is obsoleted.

But keep up the spirit and send us other good stuff.

	Sam
