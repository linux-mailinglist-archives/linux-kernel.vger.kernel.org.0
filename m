Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBE1900D3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 23:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgCWWBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 18:01:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44160 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgCWWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:01:15 -0400
Received: by mail-io1-f66.google.com with SMTP id v3so16013733iot.11;
        Mon, 23 Mar 2020 15:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=moatfj5jRXvxhlq8xo+ssOSqLVqKCjMat/spioxEHRQ=;
        b=guJKDC9Fnb9SiWQhXyXlkQ9PC1WigIrfAgwlU5mi8frn0JyAy+uAbrJTQ4NhwmiODs
         sdoi+zWrooPc1B3ubteJJ7ZIPQw5Y90wLWW3UWKAPOobdXn1It2759xV/zfcFzxvTA+K
         RqrpGtpNZFxkjuxRCgovVl9ewMY4MpvlF5Tm3ZbJOnB0RUHaXGQ3h/rApEmFCQRIHkYg
         wJwGa7ihkcisATqgarxp0kGKwaLDitmdrrstR+VMNj2avGE5wLAc0XX1kKhnsmSSblRF
         8A8PpbaC2V9r6j38dPy6oY1tVTOsKTvndsK+OfrGIQop/kviH6VoRJXAVgjxVwTJ/tkD
         vwwQ==
X-Gm-Message-State: ANhLgQ1DDcTS+wVicWE0ligYyEYcBE9u8bKGm4KkEuxo+XZeX0ppg8/y
        mzNc0ENilp2JGPAWUWzcbQ==
X-Google-Smtp-Source: ADFU+vs3cAIQeBmF64VbdwUuHkyB7YPqQzyPHXQtO+XeMGCPFEMA01amQdtzhjE6hL2OYktO6iZcHA==
X-Received: by 2002:a5d:9f4f:: with SMTP id u15mr20642459iot.87.1585000874691;
        Mon, 23 Mar 2020 15:01:14 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p70sm5645056ilk.53.2020.03.23.15.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:01:14 -0700 (PDT)
Received: (nullmailer pid 11664 invoked by uid 1000);
        Mon, 23 Mar 2020 22:01:12 -0000
Date:   Mon, 23 Mar 2020 16:01:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com, huijuan.xie@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: display: mediatek: get mipitx
 calibration data from nvmem
Message-ID: <20200323220112.GA11622@bogus>
References: <20200311074032.119481-1-jitao.shi@mediatek.com>
 <20200311074032.119481-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311074032.119481-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 15:40:30 +0800, Jitao Shi wrote:
> Add properties to get get mipitx calibration data.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dsi.txt    | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
