Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461C6C9125
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 20:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfJBSxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 14:53:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42236 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfJBSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:53:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so12397qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgMn8hpZTEDtXKP05G/wCdRDIlvQDI9VA80s3qnQFrQ=;
        b=bUZDb3W8+XUWTBN6BdUdPZGJSsOi/WfDyiPxtWNOF9SjccoYCybT71UtGBSdnzoHdh
         vBQkx0LmwHCEStXdQ3YD/KSwMXEyGPt5ncX2gvT0W8h6nfQhs3HwMgk1we1NFq7miz83
         HRS1DRA7ZVd7mkJfD/yi/6YVNvhmtWla3X3Qims7xeUAyGlQ4qU92SEt9jjVllNCzRIE
         Pu2qpXnxRZWJO8gufmxeHrTNvHbOUrOckgz71Qt6W+Vt3LDt00cYhZ3FPIeqZFGnrswS
         4LdVgowA/+iiDdq1+PIDiFrGsJFQyR8PchkAcFARqQsyRseP8ViPwG5j+vpxF1Si7P8F
         eFVg==
X-Gm-Message-State: APjAAAV9IkqtY0RIPripVIjfaF/ZuFGpKq7GKRCksbBqY2B7IqgfuCHm
        TkpBmGnY96wZEL6Ook/nJLU2g11LJMli00UcRlk=
X-Google-Smtp-Source: APXvYqxAl+Rxh2NCLtdzmTkMG+IYTvU3DliWCdDujCeb72QNPVpAcUeZwzPLzn0JfNoMiKtrgiWXhaCj8wvWNzjbU3s=
X-Received: by 2002:ac8:1a2e:: with SMTP id v43mr5699655qtj.204.1570042412182;
 Wed, 02 Oct 2019 11:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de> <CADnq5_MLg=J5dmSGzx8jC=1--d2S3HJzWH3EHhyzT6da5a3wcA@mail.gmail.com>
In-Reply-To: <CADnq5_MLg=J5dmSGzx8jC=1--d2S3HJzWH3EHhyzT6da5a3wcA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Oct 2019 20:53:16 +0200
Message-ID: <CAK8P3a33yAirHFnZq5GCSJFDM3dpub6vTMyTdpnV429WsP5Eyg@mail.gmail.com>
Subject: Re: [PATCH 0/6] amdgpu build fixes
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 8:47 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Oct 2, 2019 at 8:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Here are a couple of build fixes from my backlog in the randconfig
> > tree. It would be good to get them all into linux-5.4.
> >
> >      Arnd
> >
> > Arnd Bergmann (6):
> >   drm/amdgpu: make pmu support optional, again
> >   drm/amdgpu: hide another #warning
> >   drm/amdgpu: display_mode_vba_21: remove uint typedef
> >   drm/amd/display: fix dcn21 Makefile for clang
> >   [RESEND] drm/amd/display: hide an unused variable
> >   [RESEND] drm/amdgpu: work around llvm bug #42576
>
> I've applied 1-5 and I'll send them for 5.4.  There still seems to be
> some debate about 6.

Awesome, thanks a lot!

      Arnd
