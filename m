Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02DC10B5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 19:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfK0SnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 13:43:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34053 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfK0SnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:43:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id l28so18038347lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbp4DRGdKYx7atlFA7GlUWnZYZVPUU8tNJviwLPMwP8=;
        b=HM5iTj817tbd8cgI9ROFiU+5J5YRbcS7MYRE/ldgJRbpHkbNqHSUly1N+3IW3ABvaP
         0AnDO9ZClvsfdopZ7slk2K/U954EKFibZ0xJNi38LaKsXU7ctKWaPktwa9Oe4vB6CzGj
         MlL/2ANydkNTMbGaraqikAd4dKM9Y6DcDCxkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbp4DRGdKYx7atlFA7GlUWnZYZVPUU8tNJviwLPMwP8=;
        b=l2ioMJfoW9lrNPfsSalxA/n0UKOAWfLulHUF1enDgh36Df/UyA8TEaK0OGvvHZoFIL
         amdH9KRXY9OXjK9+lvzj4rVQL+jGk3FMLP9OlyWjHD5qF9yzEhI7HdYYWqFANtIbmr+h
         2anTko/CDFwdvoqaGwWn4olaLtzIn1Zq5JA8bIAKpvXeUeBH1Nx42/R1jtEBncXQ+NdX
         BUH0o4fQPJpM9bO1ILC8zsZ/ehwXyJBDQQamugEMoaODDfA7C+aOiLN8aNHkMlWP+nz+
         UG9hzSG5rvapMo9nTYWqXTGyF2WloKTySSG8HPBDMrNr1OUDzOCKDj44l1ps5B46EBUU
         uXXg==
X-Gm-Message-State: APjAAAXzz0bk21f96TNwMqtrAjhDRdOhKW3Y+E1rp8OgoRYXeaBLaVo2
        iRB1dZXVCt39F/KUr1RlrtF/UNpSqLM=
X-Google-Smtp-Source: APXvYqwVBx0l8EkUuGikeu0Bl/MO5idAnxy6f2xclLRj8fZMSVt4wndLhIntzdmJ6z1eVLR0vy+5Bw==
X-Received: by 2002:a19:8c4e:: with SMTP id i14mr16268118lfj.90.1574880198611;
        Wed, 27 Nov 2019 10:43:18 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v28sm2806434lfd.93.2019.11.27.10.43.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 10:43:17 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id m4so25578301ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:43:17 -0800 (PST)
X-Received: by 2002:a2e:2c19:: with SMTP id s25mr31789522ljs.26.1574880197221;
 Wed, 27 Nov 2019 10:43:17 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdZYR=5-vf29vYN-gZWRNta3axWNxMTve+hoK_ugkUhcnA@mail.gmail.com>
In-Reply-To: <CACRpkdZYR=5-vf29vYN-gZWRNta3axWNxMTve+hoK_ugkUhcnA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Nov 2019 10:43:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTCNr1e9g7U6irHxhdHqB3PZJ9hL1SZmPK32NNtuEcZQ@mail.gmail.com>
Message-ID: <CAHk-=wgTCNr1e9g7U6irHxhdHqB3PZJ9hL1SZmPK32NNtuEcZQ@mail.gmail.com>
Subject: Re: [GIT PULL] Bulk pin control changes for v5.5
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 7:01 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Rahul Tanwar :
>       pinctrl: Add pinmux & GPIO controller driver for a new SoC

Hmm. This results in

  WARNING: modpost: missing MODULE_LICENSE() in
drivers/pinctrl/pinctrl-equilibrium.o

I've pulled it, but can you please fix it up?

               Linus
