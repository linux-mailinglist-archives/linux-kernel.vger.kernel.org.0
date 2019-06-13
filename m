Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E791F4475A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfFMQ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:59:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46267 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfFMAkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:40:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so12403950ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 17:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BgRm8z+fuFOYDnZHzzS3mkZjHYVE5tepOZGIldQ/Uw=;
        b=Ypcnb57arGPy8htVQZvJkU6HDA/u3lSRi/yBbQIfuYWTEocd6WnL/Atu/ShME/mGGi
         m8dAhYtJLFVK0bqModWdRZ8ddgNzueCHdVNU6HOQsWdWc9APhjQU6LK3Rnf1BuBF3SU9
         2sxywfKtxFhwgtKH2Va8t7qZigdDiszn0kkuOthvzxOt1r9hTLtapNI5MX/p3KRgcVn2
         tYQXQpopKGE1vAwEQBtoAyOSNLumds6hE2KFUm6Y0o4R6cOdlLkfRPhB3F4mE0t3IFsQ
         kzkz/ykF/EppIeuyJl6tvaf0G4fQb5vQqba41XFRuTLVnRn28JGCueUwUnlNFIfkGDuF
         nFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BgRm8z+fuFOYDnZHzzS3mkZjHYVE5tepOZGIldQ/Uw=;
        b=Hk8nKLw+6NtqLtiRdRLkVOCHEkiFVvSDVc68GePgEdNM+8MrDfAFKX8EO4HEOZAEp7
         RmZat+4Wmd7/0tQv9z6zUp2TB2rTNT8U6k4h6LvPCTB9+Ks5Geyx33xSDpeYWI4CwnPD
         gfZWeNvLCU4YZoRTVgJrP4SVqraMbZ6SCUdzzUGuxUFmB7zmnoZZ1dSbOAOuM4OEklsD
         q44o0cf1xlznTTHBe02Va5PRHSk/hc8Bt7Z5Iey0RAkFgd6IAaCQPJYpd1TCIYQNmkrI
         6zqItvPVFZfIXqrL8F1ViZKutfP9ctPxZTSAzOhmp/S9/1cfQ431eHYlaA+LGFj1BueU
         r7xg==
X-Gm-Message-State: APjAAAUY7d9XwF1fcIzx33OC5QF+89piB/oqyF8f8tX6r7pT10hMYVui
        Fhnbg0iWWXqsnAQrSv10HjA0bk+s6+kC0Ditdo1hwA==
X-Google-Smtp-Source: APXvYqzLD0XU1anFNgzmQs/wupNY81zHREHeBVBg8Xkp+UQ+ikLxAqzOQqiH6vXp4DcOLwy5d/fNPl7wvagx1n+NZgk=
X-Received: by 2002:a2e:2f12:: with SMTP id v18mr44314153ljv.196.1560386401982;
 Wed, 12 Jun 2019 17:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <1560376776-21994-1-git-send-email-info@metux.net>
In-Reply-To: <1560376776-21994-1-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Jun 2019 02:39:50 +0200
Message-ID: <CACRpkdbBcbOmwu6=fB0TkSU-p_-mRRRLpeE3nFAgvSD4Z75DOA@mail.gmail.com>
Subject: Re: [PATCH] include: linux: gpio: fix build warnings on undefined
 struct pinctrl_dev
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:04 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> From: Enrico Weigelt <info@metux.net>
>
> This fixes the warnings:
>
> * include/linux/gpio.h:254:11: warning: 'struct pinctrl_dev' declared
>   inside parameter list will not be visible outside of this definition
>   or declaration
> * include/linux/gpio/driver.h:602:11: warning: 'struct pinctrl_dev'
>   declared inside parameter list will not be visible outside of this
>   definition or declaration
>
> Signed-off-by: Enrico Weigelt <info@metux.net>

Patch applied, also reported by the build robot.

Thanks,
Linus Walleij
