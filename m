Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303B312C37B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Dec 2019 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfL2QdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Dec 2019 11:33:03 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43395 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfL2QdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 11:33:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so30277380edb.10;
        Sun, 29 Dec 2019 08:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w8219L+FFqUH9cjSnRUbblLwTHC5hsqSbYNReVBrhuc=;
        b=sRpgMPCE61t2egxQc4nMr01Sf4kXmRcMUi17WkhMzbGaO9kRz58xvXbQirrtsQgFti
         XvXARiLmW2LAFlDpGKxjjYtdWqSqitFKr1lEWc53nhOwcxQoXR8h/xAEhaLNYqt674s8
         y85eRCsHFXloGmAeF+lwPlHycn7eFm9wGwZIKdlHu3xDfZZ8e5wQUZTULX3slJBKcktf
         2+UGxGm+E2COQ+0iPmAYltgC+3+HLE68J3SYlJs1B7c/cG8QC1ngn0M0MdUcFWE73n8C
         fnWNoDfviLmTB1Emz6GR1KE9w31Ap6BdEa+ItmEKX2sNAhj+8n3SNZQFk5y6P58Z7DjM
         sqqg==
X-Gm-Message-State: APjAAAUClLPGDKfskA1hQxsW4vUNz4oswvlFCdLfIKPbtQ4MgDVlmVu5
        TQhuVlBLulHq1Wp0yIFWeceo4srF
X-Google-Smtp-Source: APXvYqzRb6vwdUw8G86aJ7mHh+/AEBuqsi9vNpw708AECo/09tP3fogV3xvK3TJdPC/SJtQeQ+HDGA==
X-Received: by 2002:a05:6402:3c5:: with SMTP id t5mr65295462edw.217.1577637181592;
        Sun, 29 Dec 2019 08:33:01 -0800 (PST)
Received: from kozik-lap ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id pv11sm5178514ejb.75.2019.12.29.08.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 08:33:00 -0800 (PST)
Date:   Sun, 29 Dec 2019 17:32:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hyunki Koo <hyunki00.koo@gmail.com>
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: define EXYNOS_IRQ_COMBINER
Message-ID: <20191229163258.GA32260@kozik-lap>
References: <20191224211108.7128-1-hyunki00.koo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191224211108.7128-1-hyunki00.koo@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 25, 2019 at 06:11:07AM +0900, Hyunki Koo wrote:
> From: Hyunki Koo <hyunki00.koo@samsung.com>
> 
> This patch is written to clean up dependency of ARCH_EXYNOS
> Not all exynos device have IRQ_COMBINER, especially aarch64 EXYNOS
> but it is built for all exynos devices.
> Thus add the config for EXYNOS_IRQ_COMBINER
> remove direct dependency between ARCH_EXYNOS and exynos-combiner.c
> and only selected on the aarch32 devices
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig | 1 +
>  drivers/irqchip/Kconfig      | 7 +++++++
>  drivers/irqchip/Makefile     | 2 +-
>  3 files changed, 9 insertions(+), 1 deletion(-)

I assume it will go through irqchip tree:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

If not, let me know, so I could take it via samsung-soc.

Best regards,
Krzysztof

