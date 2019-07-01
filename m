Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3F47542
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2019 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfFPOnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jun 2019 10:43:17 -0400
Received: from mail.skrimstad.net ([139.162.145.221]:57472 "EHLO
        mail.skrimstad.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfFPOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 10:43:17 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by mail.skrimstad.net (Postfix) with ESMTPA id 9B3DEDE093;
        Sun, 16 Jun 2019 14:43:12 +0000 (UTC)
Date:   Sun, 16 Jun 2019 16:43:10 +0200
From:   Yrjan Skrimstad <yrjan@skrimstad.net>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay/smu7_hwmgr: replace blocking delay
 with non-blocking
Message-ID: <20190616144309.GA8174@obi-wan>
References: <20190530000819.GA25416@obi-wan>
 <20190604202149.GA20116@obi-wan>
 <CADnq5_OqVSz7Vfo0zP88i=wJur=wtz6Jd99ZTiQSbFNBcc3j7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OqVSz7Vfo0zP88i=wJur=wtz6Jd99ZTiQSbFNBcc3j7w@mail.gmail.com>
Authentication-Results: mail.skrimstad.net;
        auth=pass smtp.auth=yrjan@skrimstad.net smtp.mailfrom=yrjan@skrimstad.net
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 09:57:24AM -0400, Alex Deucher wrote:
> The patch is fine and I can apply it (I don't think there are any
> restrictions on sleeping in sysfs), but this code only gets executed
> when you actually read the power status from the card (e.g., via sysfs
> or debugfs).  Presumably you have something in userspace polling one
> of those files on a regular basis?
> 
> Alex

That is an interesting observation to me. I am actually running
lm-sensors, although only every 15 seconds. I suppose that this might
be the reason this happens to me.

- Yrjan
