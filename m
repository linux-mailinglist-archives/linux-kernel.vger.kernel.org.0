Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E56B718284
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 01:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfEHXGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 19:06:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42030 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfEHXGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:06:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id 13so212205pfw.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=t70/GD4+TaRx0FldKygqFoHbNhYk6zrpT7AiFIAmSv8=;
        b=Fri/TeXVgYyjnZIznu8q6N0IGTnkTrWQ18au3lSfnWfTG2ZkiTI61O2C5RTAOwTbzh
         OdpGEjCviMHWxMXYyIZlCsQjhEELlWLfMl8Sc/p56Dx+j9VsCBaaYQBnnH66PliOTrmZ
         mDi3GShJzoUAch6DLpF6CSaLmHpU47T9SDG4vywGULaiGbndDQeseshOQq2oaIK1xnIa
         7DfVK8J85+hcEOgz4faGuxCOPYX+0C6wIcwG2YjqvxUs09Xy5YmVO5dsYRTlE1euOtH5
         H4sANH12QAmjf4yiYG76OG+ixN+EPk9jSUGf+8UiGYbxBgvkGyjKJTbWx+44piU+4cmf
         Xqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=t70/GD4+TaRx0FldKygqFoHbNhYk6zrpT7AiFIAmSv8=;
        b=p7gQl5X0fcVcteQ8r2OZW64zimOOLPpii+DnFDaIeOdRAzuxMF24SLoCX/nhUGz4r4
         wA//exQMpU2f2ekuinEO67rlN6k6zFPX4bgmpoUcALBXb4SiKWZNLzC/ZfpSBy3HPZoQ
         yqGQXj0asDXm5Pc4qEyKyiJLWYQs8OUNkHIJznaB82M4ZS3WKBOAdF9ervDBkPUsErpm
         33Vk+853NVHRJ3jYFjdRigz8z0hB17RlNR5tfPBJiZRTUiZY7vJoi1Bwt4nXf4PSxQ91
         kK2w5J32Xrs5TvrcOpIgku8+gYLpUb2ka+k+tHK0MOjKVaS6CKQGxdWQwN/1MpfQd1Wf
         od5A==
X-Gm-Message-State: APjAAAXrADG98NnI1CoWb43gdF5jZHHVVnF74ARn1yOjD2P5FrOUb8sP
        SNSxhl0J3KR2YrLQ/oyBeqp2sg==
X-Google-Smtp-Source: APXvYqzyTGl8pYlwhBLIqpAgx01vbZZrXGfIdb6DXQWdcD9rkNEl4DqkLmLEqp06fO3s5T37XBQMnQ==
X-Received: by 2002:a65:6490:: with SMTP id e16mr938694pgv.13.1557356761644;
        Wed, 08 May 2019 16:06:01 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a864:57af:5348:a6ea])
        by smtp.googlemail.com with ESMTPSA id 63sm385693pfu.95.2019.05.08.16.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 16:06:00 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: meson-g12a: Add Infrared Decoder support
In-Reply-To: <20190412100518.24470-1-narmstrong@baylibre.com>
References: <20190412100518.24470-1-narmstrong@baylibre.com>
Date:   Wed, 08 May 2019 16:05:59 -0700
Message-ID: <7hy33gh7hk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add Infrared Decoder support for the Amlogic G12A and enable it on the
> X96 Max and U200 Reference Design boards.

Queued for v5.3 (branch: v5.3/dt64)

Kevin
