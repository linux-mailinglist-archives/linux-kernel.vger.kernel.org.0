Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C512C2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 11:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfE1JIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 05:08:18 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45668 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfE1JIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:08:14 -0400
Received: by mail-oi1-f179.google.com with SMTP id w144so13663224oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDByEXQ6Hf0CbYi5tGfeP4Y/wNBK9tNQLpjcw1bOeZo=;
        b=OP/IgysQdXyBC7aWcc8ztRELyrZYczvf6ydXAFrauGcAeQPQ0aQnrLJXIIYpVOmxav
         P0uChtMDV5cZ69pAuopjFCS5FE2RovXlnTPZzChBtLIav+10P9CnxY/BWxIGjVBzCQeP
         6TjLD3xAnXvZm6vT318aWMnXZamSlqFjbL0Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDByEXQ6Hf0CbYi5tGfeP4Y/wNBK9tNQLpjcw1bOeZo=;
        b=k03N1h0KIi5FXXDdV1gCvb3XFWPAd1OTvkWw4TA7ZE4NWIR0aMpp1O/tXvZO+GSkv8
         F2xJbAUYGpniftGg3iCDinTtC5RFhwTO4opbqcjXJbOfCIDucjGLFzb5eeRpDvMOclqf
         t2Tb0zTHW/NVsM1uOLu9yKUygmNmZupGxyOmnF3Gi2uT1AcARCQJ0FDwFTN9aIktes9U
         HycXp5HngtYxZWneNdwYQuKdMCWpyqpGpiIz1LGYrWrcvmk2YGIslW/MPr9EjF5E+EnP
         ydfKOKuEG6d4XaJI0gNWNuMo1e6h9QLsufy1jDbwkG2kSun2fmiWWJ+mzw95+SjNU0sG
         V62A==
X-Gm-Message-State: APjAAAWTGeM14LUW74bhGW333PbaIX3QVWw+xous5ry8bC1Pc7Vz+wyp
        EUSWlBszEUkKGgZSJ8GvcknotDhaOpU=
X-Google-Smtp-Source: APXvYqw1+KEfXSdPe2JjK6lBZWtDD5lKwgKVwFT7jPa9WFdUG9hi+yH8yfPofONPP2cstSGePt0qLw==
X-Received: by 2002:aca:ac0f:: with SMTP id v15mr1970460oie.147.1559034493589;
        Tue, 28 May 2019 02:08:13 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id g23sm4585252otr.71.2019.05.28.02.08.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:08:12 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 203so13657892oid.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:08:12 -0700 (PDT)
X-Received: by 2002:aca:3c1:: with SMTP id 184mr2080922oid.170.1559034491936;
 Tue, 28 May 2019 02:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190528055635.12109-1-acourbot@chromium.org> <20190528055635.12109-5-acourbot@chromium.org>
 <fa11a504-071e-f786-8564-cb7e95248f64@xs4all.nl>
In-Reply-To: <fa11a504-071e-f786-8564-cb7e95248f64@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 28 May 2019 18:08:00 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWKm2DxRdtWur80EkxvLYj_t7Dr62E2h0Xdm5A6wURV5A@mail.gmail.com>
Message-ID: <CAPBb6MWKm2DxRdtWur80EkxvLYj_t7Dr62E2h0Xdm5A6wURV5A@mail.gmail.com>
Subject: Re: [RFCv1 04/12] media: mtk-vcodec: fix copyright indent
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 6:07 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 5/28/19 7:56 AM, Alexandre Courbot wrote:
> > From: Yunfei Dong <yunfei.dong@mediatek.com>
> >
> > Minor identation fix for copyright notice in a few source files.
>
> How about converting to using SPDX as well?

Yeah, that would be much better. Should have thought about it.
