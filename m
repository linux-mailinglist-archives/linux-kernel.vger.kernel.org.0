Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA33C101044
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 01:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKSAck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 19:32:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39989 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKSAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 19:32:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so3075954pgd.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 16:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=o0OXgLmHTG6WHUoLd4+XFd/oiOrWoJBJ98oXwGWf49U=;
        b=M5FXXW0mR0xn+5fsbeH0ePNNujEUWE4+jL4vomKqcmMB5GfonCjRlaIdutis/H5QB3
         zAuMK1WjG32gGhpBOHHnDhMAREoTUU7xKb+mmBwWqIxeQbdzL4MQc+HxYvdIqqZ9dKnQ
         opTS860TAZBLz8BVfzAH++6rhEyMViLuHo5rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=o0OXgLmHTG6WHUoLd4+XFd/oiOrWoJBJ98oXwGWf49U=;
        b=gq6HM9Ysuu1a7/jLEe8pBT5l6NnNVLE4Efk9dAZm06PM5QMp4pZ44jJcnXI99KCTN9
         6RBpmGTBK/eLkwReZHvl0KNGlkbrVIcqB2LI4KK58ABA5QdHAso7DyrNf8pnNBkrs2c0
         FEgwnZVEGk7gHEGVQ19Z8iU7kXURJYsCt+SOEvfC9zWbMs2etvm9G1D+fbcLgwB3l8vW
         6Aj/Gqf1SF2RjpeFMyB51GhagPNDY7gBqNwFrVfJ5lAD6xFDOTroblx9z0GCfSRpqoRm
         MkbiKsQm6mvEQsa2Tzt/M8bqurObxVv2bBzJdF3qSjcTr5G9sbSJkIrssHveD/m5st7A
         WAKw==
X-Gm-Message-State: APjAAAWgnaBPW05x3ancUd8GP7ZeqKPr4TGmkRkBNt/OkCtd5dlbwALt
        XInR2J0zvT1lTHOt8HZZMbTHwA==
X-Google-Smtp-Source: APXvYqyAKyUgyhNNCirKuH+kZ1grecYk6P0rtU1NXPsuBpylGactVDgBMuarRDsz9xu7bEt2bBE6ww==
X-Received: by 2002:a65:47c1:: with SMTP id f1mr2187675pgs.393.1574123557349;
        Mon, 18 Nov 2019 16:32:37 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d23sm23136047pfo.140.2019.11.18.16.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:32:36 -0800 (PST)
Message-ID: <5dd33824.1c69fb81.2d94a.4f12@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191118234043.331542-1-robdclark@gmail.com>
References: <20191118234043.331542-1-robdclark@gmail.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/a6xx: restore previous freq on resume
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Mon, 18 Nov 2019 16:32:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2019-11-18 15:40:38)
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.h
> index 39a26dd63674..2af91ed7ed0c 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -63,6 +63,9 @@ struct a6xx_gmu {
>         struct clk_bulk_data *clocks;
>         struct clk *core_clk;
> =20
> +       /* current performance index set externally */
> +       int current_perf_index;
> +

Is there a reason this isn't unsigned? It looks like
__a6xx_gmu_set_freq() takes an int, but maybe it should take a u16 or
something?

