Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23715A453
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 20:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfF1SlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 14:41:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38268 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF1SlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:41:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id 9so2937013ple.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=fQE3yjXSmEBBK7nvjeoLovQEjasyqjJ5dyMYD6mC7O8=;
        b=QY3rhsLuoD6pfWkXWngj/KQZLMCZ6yKpGYJkF8Udg5G/NGlFdbnzzTaxM/GRBX+11c
         AnNNBc/vjnaGlBRfRxmVRJoln28jtZgEKcNVIEXES54GLsmjjJVEjQGOwQx3duZv8EFD
         bg778Ycp1xeyCJe7RSwG5IXqT5y/7DDJtHpUMuqo1T0kome3xAVG4DxMia5CUsq+d4VD
         8f4NSX1ZdBgmdmwL/W+JZt8Sq6C3jNm2Iyyz70u/HmpqhhcQUZ+L/yrkulUFpykYYq3Y
         RijRHD7GKT4cLc9K1EZckwtGCnlSApICLOCkfIClG7XztQWsSpDyHnltBacBvaUmhgzs
         oaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fQE3yjXSmEBBK7nvjeoLovQEjasyqjJ5dyMYD6mC7O8=;
        b=MiQVldEALXddTfS71wmcbbsLBZhMjWyBn6Sb6729JeFdTDtKaGjBVLm60L7UW1XW9L
         zW9mewIM+0K4+kIEiXG6BHQYlCfgNKgr+Zl30nPpYl5BGktZk1Vf1XRWi6TCOUbQ3wPQ
         618DP2l+2JveYlh0toriROe5xEkqQxg4w+dPPIYTryyYrKY+jMjTmy6YyX/+8jBdQi2m
         YTiey+sKHxG0qxlUL2KJHPcU4VpFcV5lfVOP27Yic1Vg19VdDjVvYdX6h96nk8hgL+bs
         M8UrIG+eGnPI7UPP4AuSUkd63xm/6EhKkSha7gTe8LucP5ar1bXAuFvs8+e20BHL9Zei
         nxdw==
X-Gm-Message-State: APjAAAVkHhyrqnu213xz9di/M543K7LG0mOdfsh4Ck7iBsiRbAOh03ag
        dWeOPQ3kZowfLhd1OhovMf93BbYbXfhsLA==
X-Google-Smtp-Source: APXvYqzByc/4yIWQSC44smY+Wmaei7vfmV5iHq9ECor2e7zK+iHHiRISkR4djb2VDtszsmN6vH8dvw==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr13517930pll.310.1561747268178;
        Fri, 28 Jun 2019 11:41:08 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id q144sm4238550pfc.103.2019.06.28.11.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 11:41:07 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-g12a: add missing dwc2 phy-names
In-Reply-To: <20190625123647.26117-1-narmstrong@baylibre.com>
References: <20190625123647.26117-1-narmstrong@baylibre.com>
Date:   Fri, 28 Jun 2019 11:41:04 -0700
Message-ID: <7h8stlr1rz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The G12A USB2 OTG capable PHY uses a 8bit large UTMI bus, and the OTG
> controller gets the PHY but width by probing the associated phy.
>
> By default it will use 16bit wide settings if a phy is not specified,
> in our case we specified the phy, but not the phy-names.
>
> The dwc2 bindings specifies that if phys is present, phy-names shall be
> "usb2-phy".
>
> Adding phy-names = "usb2-phy" solves the OTG PHY bus configuration.
>
> Fixes: 9baf7d6be730 ("arm64: dts: meson: g12a: Add G12A USB nodes")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queuing for v5.3-rc,

Thanks,

Kevin
