Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C7063C02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 21:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfGITiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 15:38:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34007 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbfGITiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:38:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so15243173qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 12:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgO5fSFnkpRb91YH7i6eymSVmXaxAMQJWlwBQj0Dv40=;
        b=K/M5xMWDURInZ5VvYwyhsANggO+IVV1mFKvZHIKsrzDRUYB+D8hNS0U4sE1Q88bWnU
         MuFlsCFzYwWyGErYNONq8Hp9AS/UZHS9kuz1OhkX1M/sWVkVuN01+tUeyKTEEwlCTS9c
         pLBecJGN2NCI6ABM3NWl3Fug36TLPcc6y+ThzkEJBnVV0oK7iTalzU7qdCaSc1EiU8XJ
         T/00Yv1FQzcdqdZ+IaIfTvJvpP0ncd+0ZjBeECX75vEq3JGWWwEULmSrZJdJWc+S4rO+
         A31pMGeoUdfHLujiTDgMcBFCOtn2dtYseuh0o4fNmZGfFZYkZrFyvimIWQfu1iucueQ5
         YZGw==
X-Gm-Message-State: APjAAAU2LwwyXde0UwuK5l2p9+9sX3OlPqWgnvjeVMc57tjvM8xrWxE5
        ObZA3NpkE5ZyXZh0GWZq5DLfJ6swbvAf2WD9CUg=
X-Google-Smtp-Source: APXvYqy75RtS1X3Ao5vvsJC+OpR8FANcjcm6rTGH3ZL2vjWjUB2czjyRgpuS62Ljn9y1uzhZ8P3FzW885/0ZtrujVFc=
X-Received: by 2002:ac8:5311:: with SMTP id t17mr19828557qtn.304.1562701091662;
 Tue, 09 Jul 2019 12:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190708135238.651483-1-arnd@arndb.de> <DM6PR12MB320967C48957C4F2F0E92438FEF10@DM6PR12MB3209.namprd12.prod.outlook.com>
 <BN6PR12MB1809956A9C61870CB7F675F5F7F10@BN6PR12MB1809.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB1809956A9C61870CB7F675F5F7F10@BN6PR12MB1809.namprd12.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Jul 2019 21:37:54 +0200
Message-ID: <CAK8P3a2GbpkDnpq_MS4iRe7HM0MTxSkx=rB0=OHQZk4TXbvh1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: avoid 64-bit division
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Abramov, Slava" <Slava.Abramov@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Liu, Charlene" <Charlene.Liu@amd.com>,
        "Park, Chris" <Chris.Park@amd.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Cornij, Nikola" <Nikola.Cornij@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Lei, Jun" <Jun.Lei@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Koo, Anthony" <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 6:40 PM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> I'll just apply Arnd's patch.  If the display team wants to adjust it later to clarify the
> operation, they should go ahead as a follow up patch.

Thanks!

> From: Abramov, Slava
> Sent: Tuesday, July 9, 2019 12:31 PM
> > Thanks for bisecting this issue.
> >
> > I wonder whether you are going to commit your patch or planning to update it and it's
> > still in your work queue.  We have one of our 32-bit builds failing because of this
> > issue, so that I would like either to fix it or wait to your fix if it has chances to go
> > upstream today.

I was going to update the patch, but had not gotten to that yet.

     Arnd
