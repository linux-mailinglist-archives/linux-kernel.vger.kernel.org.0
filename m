Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3835FDB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfGDUPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 16:15:42 -0400
Received: from mail.skrimstad.net ([139.162.145.221]:44992 "EHLO
        mail.skrimstad.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfGDUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:15:42 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by mail.skrimstad.net (Postfix) with ESMTPA id 64BC9DF2DA;
        Thu,  4 Jul 2019 20:15:37 +0000 (UTC)
Date:   Thu, 4 Jul 2019 22:15:35 +0200
From:   Yrjan Skrimstad <yrjan@skrimstad.net>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amd/powerplay/smu7_hwmgr: replace blocking delay
 with non-blocking
Message-ID: <20190704201535.GA21911@obi-wan>
References: <20190530000819.GA25416@obi-wan>
 <20190604202149.GA20116@obi-wan>
 <CADnq5_OqVSz7Vfo0zP88i=wJur=wtz6Jd99ZTiQSbFNBcc3j7w@mail.gmail.com>
 <20190616144309.GA8174@obi-wan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616144309.GA8174@obi-wan>
Authentication-Results: mail.skrimstad.net;
        auth=pass smtp.auth=yrjan@skrimstad.net smtp.mailfrom=yrjan@skrimstad.net
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 04:43:10PM +0200, Yrjan Skrimstad wrote:
> That is an interesting observation to me. I am actually running
> lm-sensors, although only every 15 seconds. I suppose that this might
> be the reason this happens to me.

Though I don't think this should reasonably cause problems with the
system, even if it does here. Is there an update on the status of this
patch?

- Yrjan
