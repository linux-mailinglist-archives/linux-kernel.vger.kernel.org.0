Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B91D10C5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 10:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfK1JIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 04:08:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45464 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfK1JIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:08:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so27599263ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78TUNxc9SDX9bG49GuEtf0MJi3qZ9js9cOuwvB8JDFM=;
        b=nbQb12OW3QrlhRiNVts6U011R3m6RJ2IEahdggL7ug6hl7xtA+9L7UvULnrkncuKRU
         gCNhiPKLz3OH0WAbv0A6fK18YGwpkmdibsvvq6qMPjp38/nElKb5NKEE3RrRsnbsRMYz
         qEqpXH0p2ePUaP28QIYssojmsJK/Ua4i13WW4e7vIRQxY55UJ2+HRrDF5LE4lyClylpp
         +m4Ae+pPeG18JfAcMMK8RNmm//6eMh/cROJgUUoLVqx4oa+tHcnX94Ad3FyBbDrimcPi
         YLzifSmM/WtgXS/Oq7LbbS843h4fSTu9Logu1D04uiSyEp7zw/vHOOGXuFQgD6uEId/p
         K96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78TUNxc9SDX9bG49GuEtf0MJi3qZ9js9cOuwvB8JDFM=;
        b=rXHgKB0tE2OpK7ZvGcC5MUH6fX4/EXNsWHLFFeIpQIK0csIfNiUs6+zn5zYf+npuqi
         /CTHCmDFzlFCEFy+gdAXjWdcQ7i9p8FIZA+GjvI9kGWg143R+7OmarwjSQ02/uhCUP8s
         irNksMQqV586ugvmNK9EeAvxXA3RIkyGmXWnASmdPmnXRBC7O/f0OX659R5tuEalYtDn
         k9LjxfSU1SyzVH+Y4gN7RRBDSiIq0B2dVZHYUEFKe4y65e6rOOnKgawAo3vLUyTX9AZV
         OcMe4Wj077QmBmOM95nd+G7GvXZVdeToJU4WEF61oHf3MMNvukrWpwpG3iyEvceBDK4h
         aMhA==
X-Gm-Message-State: APjAAAUSJBb1spGAJqWFZbvtFM6ItwoJEVb1pIfdl7NWxyz8oYf7lzuA
        2EbH1wScZCQrOVW/CgwKxflA2JHx7jZSTEl40X3upQ==
X-Google-Smtp-Source: APXvYqxgwoUSOqDcdaqGDS7R5yA+8++vOzVHDWK3tPmj3lxVoGi4FFBLUdIzhwyII2/H891p5hwnicQruvpBBJvptCo=
X-Received: by 2002:a05:651c:102a:: with SMTP id w10mr4635658ljm.77.1574932117200;
 Thu, 28 Nov 2019 01:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20191126131541.47393-1-mihail.atanassov@arm.com> <20191126131541.47393-25-mihail.atanassov@arm.com>
In-Reply-To: <20191126131541.47393-25-mihail.atanassov@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 10:08:25 +0100
Message-ID: <CACRpkdZViRq-cxfR5MsbBtduNm6mkYJtO9c6Beiep15gyvqYNw@mail.gmail.com>
Subject: Re: [PATCH 24/30] drm/mcde: dsi: Use drm_bridge_init()
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 2:16 PM Mihail Atanassov
<Mihail.Atanassov@arm.com> wrote:

> No functional change.
>
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
