Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78B33BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 01:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFCXbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 19:31:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33074 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfFCXbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:31:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so1692174pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=J5q67u/bE0NaIbXJT8NLoweDbHR9pR8xtFgHY3tljTw=;
        b=U43F8sSKRnuOaThj9loHA1WhOgSlyUuLw7qVcLT4NnMwgHV/e1QptgXhkdhjRLlhIU
         8nRK1apoAF0B7pRdldwLWfjJNJm1boMbc2HhVQ/qh64b3k7A0wO4B7PKUaB5vwu15s+h
         VxU7oMtLku+8epmraApThVuerML+zpD1t2zLxWVYUg8nQ4RfJZ29scf1pIE3XJYrg3Ww
         40GikizWsN7HTxx68NGWac2lSyXVnIWXm3xL5fOcnv9tCqWUEIfRQQNUzOkMNbJia6+H
         ljOPrCNOGZhzOYC2nuis2DaT0wX32zWGfGZHwOq0mGfBp7wtXrOafAWL1lFK4YnVbn/I
         LZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=J5q67u/bE0NaIbXJT8NLoweDbHR9pR8xtFgHY3tljTw=;
        b=f72oHEtQ36JSvrFQNO55kJ5xOIHZH9MFjuj3veyyoPOzrj4zpolKuOylXUDUAn06dU
         olDjsPXvZB06OHRd8IEP/emaq3s6UeYxFNqDx59Xrte3ivOY6erkWZfx6Jo3kyhL57I/
         Fhq5AV7cxI9JGJOumoZcBU6YGP55MxyHgubyR+DOihq2c1s8PXtWBbFgZHYQ1ZI9c8fn
         D83wCNp27RXTbYSNhwzIJ+BtijwCMXI5drbiJXO2hScvq1j5xMYoFiFkEJjktVVaGoln
         WBS0M3bRc0a+ndiS647vq/T2v9qk+5H3vrhwgpiGS37nAMmxlqkoy+8AFWo1wASNG4a3
         x9AQ==
X-Gm-Message-State: APjAAAW8wzpNFTD9d5qFer+2pe4zi9yvzuxvDnnxpL1xtW5ZMdgeN7ge
        pP+n/bUhrcFzCBlkiTTdJWYJmQ==
X-Google-Smtp-Source: APXvYqzFwYg0SY33IApIVejfjkchj8RZz0W9jfJKAxvgj5vGfWTfCtTCmsVczqop2IkQrJxb5WsGRg==
X-Received: by 2002:a17:90a:2201:: with SMTP id c1mr33162789pje.10.1559604707835;
        Mon, 03 Jun 2019 16:31:47 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id a69sm20791391pfa.81.2019.06.03.16.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 16:31:47 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/4] arm64: dts: meson: g12a: add SDIO controller
In-Reply-To: <20190603100357.16799-2-narmstrong@baylibre.com>
References: <20190603100357.16799-1-narmstrong@baylibre.com> <20190603100357.16799-2-narmstrong@baylibre.com>
Date:   Mon, 03 Jun 2019 16:31:45 -0700
Message-ID: <7hzhmygs9q.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Jerome Brunet <jbrunet@baylibre.com>
>
> The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
> add the port A (SDIO) pinctrl and controller nodes and mark this specific
> controller with the amlogic,dram-access-quirk property.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

I'm assuming this one should replace the one that was already sent with
the MMC quirks series?  Or maybe they identical (other than diff context?)

Kevin
