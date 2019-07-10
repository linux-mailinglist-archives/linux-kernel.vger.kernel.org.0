Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19F64AED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 18:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfGJQq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 12:46:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42741 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfGJQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:46:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id v15so2821963eds.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uI+5nY7XDdUozZn2ePMYhLurWiDfFbelgLstEGLSrzU=;
        b=cAyGu57gbAQyE13Us/MLHPU4v7/XxDe2mavAEkjAhv5wVIt7cwMgbvQbCmNOq4Uhds
         jENjmnGzOLQq7AwZHeVRaB2yanqQRHyGxNQvXFYMvRFpGVslUyB61RxDdPlMC4TSlQIR
         OKq0ihnd6b82L5buDsdq9D49nYXqBveHF62Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uI+5nY7XDdUozZn2ePMYhLurWiDfFbelgLstEGLSrzU=;
        b=f1avgJh2TGTeWf+1GdXSYIVH6NvxKyB8k5Pr9+EY8wA3W1/qqDodLOUF47Nt2VVRmT
         CkAu/BCgPiNYCpSGiuWG99fVHVeljplMRMLvtCyRndnz2W2z7vp9+0vZSkeL4CFobwyN
         YtLzh3EohX2sn0O36cA4xEFuZ6RRRSbt2uwF8qVgEGebiXyhhFqGdm87QgeXL9dFhZ9h
         OA5YSO4HD4BLrQmxtiHOcZDor+7CZzAFXrYJGjqBqc2KdmfzAO7X4i+7VRy+y+020J1a
         UU5jnNZE6iTltVBbSKLVm3JDBrQTGtfcLbZ6oMM1d0gXvv4RbwEWdKts/IwL8F9QVkLq
         1dFg==
X-Gm-Message-State: APjAAAUTjpeWhJNyolw7/ZEe++9EQXlbsV1AgSIucGCtK91nI7S0Ibpz
        2Szp/fac3pa/2hmuh7rxJIS7UA==
X-Google-Smtp-Source: APXvYqx35KoS1Wn0RwEDuvd3T+zLAeKQdcZhzZWd4E0Y4NS5zUOWLNZfHnNlW68SKf8txrnyIHEBQA==
X-Received: by 2002:a50:b155:: with SMTP id l21mr31948432edd.186.1562777185813;
        Wed, 10 Jul 2019 09:46:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x11sm625141eju.26.2019.07.10.09.46.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 09:46:25 -0700 (PDT)
Date:   Wed, 10 Jul 2019 18:46:23 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/vkms: Use alpha value for blending
Message-ID: <20190710164622.GA15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1562695974.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1562695974.git.rodrigosiqueiramelo@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:52:02PM -0300, Rodrigo Siqueira wrote:
> The first patch of this series reworks part of the blend function to
> improve the readability and also for preparing it for using alpha value.
> The second patch updates the blend function for applying alpha value for
> a fully transparent blend. After applying this patchset,
> pipe-a-cursor-alpha-transparent in kms_cursor_crc start to pass.

Looking at the series I wonder whether we should go right ahead to
reworking the entire composer pipeline to future proof it for multiple
planes and other pixel modes. Or whether enabling alpha blending with what
we have now is a better idea, but that means more complicated refactoring
later on ...

> This patchset depends on:
> https://patchwork.freedesktop.org/series/61738/

Ok I guess I need to look at this one here first.
-Daniel

> 
> Rodrigo Siqueira (2):
>   drm/vkms: Rework blend function
>   drm/vkms: Use alpha channel for blending cursor with primary
> 
>  drivers/gpu/drm/vkms/vkms_composer.c | 54 ++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 15 deletions(-)
> 
> -- 
> 2.21.0



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
