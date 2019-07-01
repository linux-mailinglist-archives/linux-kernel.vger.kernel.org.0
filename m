Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016603BDB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 22:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389802AbfFJUoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 16:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389331AbfFJUoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:44:37 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB090206E0;
        Mon, 10 Jun 2019 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560199477;
        bh=TQljNawgeS3syFsZVeamRbKXVSffVZ+/siT/mXyUdiE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X+YK4dOZClVaFYO/qO+rDblZz00FaqAg+WXMpgVdI/ZgkXTo8x8h+ezTGxjLnJH+j
         +HMsu2Zv+zCyBiGLKiigBtvmHBjkWaRlV0arykNeMLTw7iVNsnTeHuzMAklAJ+HXQv
         tTYpA/sJVkYMlAuNnj1WAmgWNui6UNOu1oLsj07U=
Received: by mail-qt1-f176.google.com with SMTP id p15so4563103qtl.3;
        Mon, 10 Jun 2019 13:44:36 -0700 (PDT)
X-Gm-Message-State: APjAAAXCkKhzX1M8PmI0q/ghzfSrcDDi216981TNclRbXzbyGo6zlhnI
        euvXgeHUbA2jY+I11uqSTJnyeZ6yEnd4rI5ggA==
X-Google-Smtp-Source: APXvYqx6sejecUTrk/D88IaH1Q9KP1//qmtoNPj2f9zntvm9PmXyt0G2QFrlQbq1rtSAVSuTS4POxPsL4m7R2LKjzI0=
X-Received: by 2002:ac8:2ec3:: with SMTP id i3mr16077099qta.110.1560199476202;
 Mon, 10 Jun 2019 13:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com> <1559577023-558-13-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559577023-558-13-git-send-email-suzuki.poulose@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Jun 2019 14:44:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLRwC6ZnSgrp_N8X-vefUEUCaAakG7Dvu034WMWzaYYZg@mail.gmail.com>
Message-ID: <CAL_JsqLRwC6ZnSgrp_N8X-vefUEUCaAakG7Dvu034WMWzaYYZg@mail.gmail.com>
Subject: Re: [RFC PATCH 12/57] of: platform: Use bus_find_device_by_of_node helper
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 9:51 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Switch to using the bus_find_device_by_of_node helper
>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/of/platform.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
