Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178C7165B75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 11:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBTK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 05:26:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46056 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgBTK0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:26:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id a2so3001361qko.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XW0RVUOafRWzBn6AHPCLH2bW11TB9C9eIVtZb1rn20I=;
        b=GOTeP2csS3xkcJ6a9/1t+PpPHy/Ce5CQ2FHQlbIQWzc6QcNwzZC8jt2NT60YL088wR
         1BCx6egwQ3pNCKjmdgReg7Kl2q5LvlvYnNxc1XaXce3ERZQtiahMXw1w7dP9a84Md942
         W9aAH1ejPT2Snn/8pyDsMUgdkFJoF1XTKUTaQ/k7TDslqU/EhmCFYGw+A27naDMfucF7
         Do1mqV5OT4OQTjJatcSu4w4ZEX8E/8ot6knRdCQmnpNi+uncCzvGqHm9nlU0sXSrysMd
         6Z42C8aoVna0JGz9bxdP/n0V/VbUNyIpL4lQt4IhnokFtUQpLSWtYQan0p+fSBtKnCgt
         FGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XW0RVUOafRWzBn6AHPCLH2bW11TB9C9eIVtZb1rn20I=;
        b=gt0gnxS52NbfWvnqMXD0M7/Wk5hslgPFen+SgyJOjJOeMva2zerRAjErD2QMWo4wDi
         OoQbCiPPmS7FRQ2jMcb+7dSPj6stPEm5YC7Hc0LNq3R3d/n5kEjRoSMfqQWgq4auD6WJ
         aDDsiPDGfuEn5CIo7XEe/Ci18Wt3ZApKihVmOp46tEYcVQBeSEfkioMV7dFbuRoen9PG
         3XvO+wC3CzGZolYIiPXp5RPzjGEM238QkcG2hDXAGn1H6IlICpMTbV8cFa4/7MmAQsnJ
         Ldo6Vp4IYs0NpLnXmhkMrcWlzLE5FLg7YWaJ77CzKYJJNarP4nUFHcukUgSUBehygr+y
         q/Dw==
X-Gm-Message-State: APjAAAU7CGBym6meNYzScGj5+vx7sED+IsX7+RCgWziLBQfE1Bd0ZO6E
        j7vVyjN8+eVU9oRKaodEi8CkU14+F68mHEFe36RqsQ==
X-Google-Smtp-Source: APXvYqxZ/p9N0WN3fKI6WmMbU+UuLuuiId4wUYvQin8O/qYIMdHBWbfAsTzerfcyHk8G256I9CsY4ittloiK3eWs0hA=
X-Received: by 2002:a37:a488:: with SMTP id n130mr26958458qke.120.1582194407546;
 Thu, 20 Feb 2020 02:26:47 -0800 (PST)
MIME-Version: 1.0
References: <1581942793-19468-1-git-send-email-srinivas.neeli@xilinx.com> <1581942793-19468-4-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1581942793-19468-4-git-send-email-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 20 Feb 2020 11:26:36 +0100
Message-ID: <CAMpxmJWshBbSxL1FrOrb=Rq2bRvvijoaLn5xq5HxA01k0qX7BA@mail.gmail.com>
Subject: Re: [PATCH V3 3/7] devicetree-binding: Add pmc gpio node
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        shubhrajyoti.datta@xilinx.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 17 lut 2020 o 13:33 Srinivas Neeli <srinivas.neeli@xilinx.com> napisa=
=C5=82(a):
>
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>
> Add the pmc gpio node to the device tree.
>

Same here: I don't know what pmc gpio node is nor do I need to. Please
make your commit messages more verbose.

Bartosz
