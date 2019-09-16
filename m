Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED7B440F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 00:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbfIPWgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 18:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfIPWgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 18:36:37 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CBA1214AF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 22:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568673396;
        bh=cgBibUhFcjP8VZBif2i2zXEf+Enx1YGlyHXoEAUrbKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RtoKHQtYhKKbVbqAM3whuZWcJCtPehxBOH9376myc9sgouP9y/ioxa+3sWpPAVYYl
         wYIgIo4XyeUpHXDyAECMN8Qjt9w2xYWM0yrwXNCvubi0/9UpG1wVw4D/Y43sOzfS50
         42aYFCg8l+lQe4TlriCDwgF+IyLsdKFntFNFsWbc=
Received: by mail-qt1-f170.google.com with SMTP id x4so1902456qtq.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 15:36:36 -0700 (PDT)
X-Gm-Message-State: APjAAAWvAFWjNVEVLOm1Kxj+Esn+RUWneuprU3cv6oleS0hJXKsMs1Xc
        HiFdqxgYOCMvlngtJ5JIOZYOg4NOFAa7sEvBfQ==
X-Google-Smtp-Source: APXvYqw9nfK6ijHIbDLE2u7dIhOwDFr+8HHs9pqMsZRdNI8f/ZH1FLofjrqiO0RCgz8ge0OlTDVmu8hzE7dKP0XR2/c=
X-Received: by 2002:a0c:9e20:: with SMTP id p32mr630806qve.39.1568673395267;
 Mon, 16 Sep 2019 15:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190912112804.10104-1-steven.price@arm.com> <20190912112804.10104-3-steven.price@arm.com>
 <20190913174343.GB5387@kevin>
In-Reply-To: <20190913174343.GB5387@kevin>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Sep 2019 17:36:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHqvwJrO2jocoMx38z8rMtVrK+PcMRHO13Y7EQaQK+DQ@mail.gmail.com>
Message-ID: <CAL_JsqJHqvwJrO2jocoMx38z8rMtVrK+PcMRHO13Y7EQaQK+DQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panfrost: Simplify devfreq utilisation tracking
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Steven Price <steven.price@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 12:43 PM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> Patch 1 is:
>
>         Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
>
> Patch 2 is:
>
>         Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

In the future, please reply to each patch with your tag. The reason
being is patchwork will automatically add them instead of me doing it
manually. For a tag on a whole series, replying to patch #0 is fine.
Patchwork doesn't handle that, but I view that as a patchwork
limitation.

Rob
