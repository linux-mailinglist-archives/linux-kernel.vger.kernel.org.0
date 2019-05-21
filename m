Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BDE25A39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 00:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfEUWGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 18:06:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35772 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfEUWGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 18:06:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so162412pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 15:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E1DrzXtGDj3hfWXv7sO+LUDSb752frj/M4xDQFuIKdI=;
        b=ZLPsZLBQfDkyWlMuSQTbZZPvBJjcaZBc5GER2rRMijZOokHJ8ij+fr/bcT9/7dIdwb
         1CFYM1rB+bmDU7tm+jgEoq12FdcKNURyTwvdtiHep+LL3Xo6UxzSyCjVo/6qm5NuNPHh
         LxP/IBMmJY9UGDj19FA28SdZ9JsowKVLe5C+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E1DrzXtGDj3hfWXv7sO+LUDSb752frj/M4xDQFuIKdI=;
        b=FTmstIaUiAOOE/EEZiDU61jGB/Dt/BH5fFJcquE3kXuAmRqB51zX8fhgasgIRvsU/M
         3tgclJSJgMp1hOAFOHop047w/otqtBG600l1uSwB9LLSpjVaAkawha38zTmJ6iUFmGMt
         uOsg3bGKBtDbGzRgwd99nQnijHqTe41JKKVwFeSN6m3GtIx/wlwRK00EVDGhlpQkv255
         ELrG6EXZyCKdCg7Ht4yVbcZVhQfXi0FRuAJTsC6NbOjhIPVF69JmAuivs1m5j2MzVZQ2
         85MQht1oMa1wSjNtUP9Liq+5UJV2N/2YyAbqneHvQtAG/hXH807Q6KbqF11Vx3LVIJi0
         NoBA==
X-Gm-Message-State: APjAAAU0A0Bxt6ryM8StHmvvDlKCQUpaEPXj1Hk49JBUkXrS2HbKwjnw
        0iw1iFjxUIW9Yr2APWJRmK1wbw==
X-Google-Smtp-Source: APXvYqzQz7ZxAp6T6WnMzgzo44oFO/MH3Fqa55WCIqK5Qkpj/XDsVrW00b0XB9chQs/5VLWCkFpbsQ==
X-Received: by 2002:a63:2c4a:: with SMTP id s71mr68633329pgs.343.1558476369987;
        Tue, 21 May 2019 15:06:09 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f17sm22771652pgv.16.2019.05.21.15.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 15:06:09 -0700 (PDT)
Date:   Tue, 21 May 2019 15:06:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        ryandcase@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: rockchip: Add pin names for
 rk3288-veyron-jerry
Message-ID: <20190521220608.GK40515@google.com>
References: <20190521203215.234898-1-dianders@chromium.org>
 <20190521203215.234898-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190521203215.234898-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:32:15PM -0700, Douglas Anderson wrote:
> This is like the same change for rk3288-veyron-minnie.  See that patch
> for more details.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
