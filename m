Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99C7B16359B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 22:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBRV6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 16:58:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35360 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgBRV6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:58:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id n20so600803lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 13:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahpk/GappiCcM5wW00z5eRTm7XSNbwAT9p1AedeyQaE=;
        b=kdpjP80seFPRBqxhxIpalWncJhJycuWAQPQT0uf/BhAioMxpA/HQSrB4FFdQP+vo/L
         KzZMVoRXpw4PUTQavb0o6cZHHaGKHSVcOUgix+7f/NfUfAl9aCz7L0/IbtVECP3Hmx5k
         uQFJiRqinUNrrBdMEj/yIhEp3RBT2Uxd72BlqR4nMUwzHAyMKM7YPchqExAMmNWGqoBi
         Ph19zMTGlFHeCAUda62180ibnNyy2wl7eOxbVuLhU6Jsy9cLpevU3SYjCp9Zrk7UP43A
         VMce/XyzyXhUBuaWX2tdTaeUxZdF5O1Zs8APWnkdHzTNx1e2XTvdK45WjNKQLPXeMS0F
         1T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahpk/GappiCcM5wW00z5eRTm7XSNbwAT9p1AedeyQaE=;
        b=bRlaPXLfvd9pT7KZE37SD+QvqOPQtIjtBnpgCSAyxf/aIMwYc4OzH3B+QQEZwav+hs
         8qYLXwIK4wpj1aaX75038A+lNy9tnDYPuiMLU6DynKoXUyMZRvXhhDpM44QmvjiydIPR
         IcD+HNzDLcofIRplq93mtbkGyq8jvY8mbsKsWhM4CHQ9zudO+kBwe9NS8SnAKdArO7DD
         dTsq07CpnVJnxcL31WWDKCffqz/dWIsPROxnJwX6BSU0uDmUNn84XHT+H4jSerbUj2zr
         J2zBI3AWv1HlLpckpqF0m+AWiRZ6SeLCvWBr6+Q9NmcS4KUpuV2lm/ELW/o3mMwhLScC
         uWdA==
X-Gm-Message-State: APjAAAXB1FBgDrdT2Nl35tKEsCJlxwT6RRnKtDYVvQcxYXD97VslfJ7G
        BvwsBFuDR/ONPGu7rYLJCOsqJKZ8vO4GHRKKDc6VGg==
X-Google-Smtp-Source: APXvYqwfJ/KjDHUqMyRYTcya4wxUGjDyhjQGBQJimj1/3xX/vD0XeMTB9CXlS07iJHjcgr5dOlc5NuiOgM8QWSquNew=
X-Received: by 2002:ac2:4214:: with SMTP id y20mr11460778lfh.212.1582063131075;
 Tue, 18 Feb 2020 13:58:51 -0800 (PST)
MIME-Version: 1.0
References: <1581705404-5124-1-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1581705404-5124-1-git-send-email-jcrouse@codeaurora.org>
From:   Eric Anholt <eric@anholt.net>
Date:   Tue, 18 Feb 2020 13:58:39 -0800
Message-ID: <CADaigPXdn84cR0Pu-uLnCwOVHNUiOi_t6u7OYYDU6tkSvdWp6A@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a5xx: Always set an OPP supported hardware value
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>, Wen Yang <wen.yang99@zte.com.cn>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-kernel@vger.kernel.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        freedreno@lists.freedesktop.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:36 AM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> If the opp table specifies opp-supported-hw as a property but the driver
> has not set a supported hardware value the OPP subsystem will reject
> all the table entries.
>
> Set a "default" value that will match the default table entries but not
> conflict with any possible real bin values. Also fix a small memory leak
> and free the buffer allocated by nvmem_cell_read().
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

This does fix my warn at boot on db820c.

Reviewed-by: Eric Anholt <eric@anholt.net>
