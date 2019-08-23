Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B3C9AB85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 11:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbfHWJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 05:42:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42519 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfHWJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:42:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so8254573ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 02:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9mRsUodr8INx8kLiQuFLT6wntAGfHnLDVBZoZICFTI=;
        b=D7pMMnHdfqhTHEbILraVb+LJvXqHH0oAURqSthG109P6NhNjxj8dD1tTBKCsoZE6Wg
         +ZVyTADxuYmkbpWAU9YFNL+rpYNJAnnwAf1p4HUn77wkRPYNFoWUreoo8oq8nyQy+da8
         Y4EaWT/NZVIPTHhT/82Y8zlr/QsGAQEGJRBB/8CGdQOZKAilJteJ6NRHVCfWJ0EfLQkw
         ADRGbxPFwc43sXCSwFxqXc2rliWafXYyjNHb6g3A31lCi37BDlIFfaYbwMXOlolMDvVK
         5IW1yX/qn1VkdCUaFjnINEp+cGHSctJDS1HErbvHADRBx7bEijJbDa9sf0CIZlN889Vp
         +S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9mRsUodr8INx8kLiQuFLT6wntAGfHnLDVBZoZICFTI=;
        b=Scst+x4QCy0kVgWaQvJIRpeUxmNA8E9y5MqTfq0au6Fl3kYHpIaP3kdA4MMMEore1S
         UowWFdkAeJTaQd0xM4lBeARfe4qmu50GXVttBTArsrYnOY0oaA7pR8p3F1+9nYVt4uL6
         hIs2bkTg2+rzBkkosz2NkU/0HvRZu+dN0Z8SEEXXnvvwpyFRcFJ0oK+0+oW0CtL8Kzko
         0cpm6rbHITwfWMqSmMPM31fALkwF81gIpqKQ+6LYKtXf0CaFPtCPOhSFClLVtk43rpco
         Yo9Oj5D5AWVO6PuFQFGmP1APPLkhRxqp2NlYtWhXXKv569mW6ZxC0K31s24FVtmd3HTb
         EY1A==
X-Gm-Message-State: APjAAAUa967YxcSsvzuXVROwAWhuRhmIM7+GTyKc8h0Ai4H04CP2+q/z
        aDosD1O97mPAYCPniGGDqaYIs4bfrENAy57v8SBlbw==
X-Google-Smtp-Source: APXvYqxbUW9mwdFAw8PYUVklPhImRXOOG2mrpV80i8O7nFOQr4/Kq5cY8eZfZBLO11XOblNgr1rWKltULlseXo8MMs4=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr2368029ljc.28.1566553330329;
 Fri, 23 Aug 2019 02:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <1566335128-31498-1-git-send-email-hongweiz@ami.com> <1566335128-31498-2-git-send-email-hongweiz@ami.com>
In-Reply-To: <1566335128-31498-2-git-send-email-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 11:41:58 +0200
Message-ID: <CACRpkdaa3tWw_LC6Ce9Ru4gFji_SquitmsDqThRj114=Fro2zg@mail.gmail.com>
Subject: Re: [v8 1/1] gpio: aspeed: Add SGPIO driver
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 11:05 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> Add SGPIO driver support for Aspeed AST2500 SoC.
>
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> Reviewed-by:   Andrew Jeffery <andrew@aj.id.au>

This v8 patch applied for v5.4, thanks!

Yours,
Linus Walleij
