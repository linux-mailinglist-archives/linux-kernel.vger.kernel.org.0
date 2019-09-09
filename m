Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA32BAD21E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 05:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbfIIDLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 23:11:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38920 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfIIDLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:11:36 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so11674667qki.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 20:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysUHgmNu9WMA8zL7iVWv/ObdOdJAcInEBYKpkc9uysc=;
        b=EA0bJFIwM2SjnvAUk8RI0nFyjwZcV+73V6hkW0nl/potXqj6JTUzUTyaQd7OEzizOv
         vyHEimncQN7YnHnfEUPp8I/UtaRujv1i5W762CvcziFum4ncZsXhYe+XQRxyw1WeLOLN
         rSLD8ldV0GUgjGPCvuI8Y4KehrU3PVeG49DxLr19tTb/FohzTLCBu83AEL/ZXJ2smw/L
         8s3EOcTJ4h7EQuTEMeFuq4y+mUCxkUEBTC4ggjorkPNRtmxMcf76UDUkfV424/Qy9i2h
         Bwn92bWrujqZCt04DQmiu+pBJm03Q9wELvxVN+EtcPDS3ikIFtBmOAuQNpEsnIAorRMC
         8dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysUHgmNu9WMA8zL7iVWv/ObdOdJAcInEBYKpkc9uysc=;
        b=GQo6Eni7U3CSdk2eYBDRgWZlYqb5WepqXEuMtADC9fOLAuoWHzqOwM9onsmRxf1537
         QN/OrZ9cbeIYJ5qc/WDAhaA8lsgTDfJsSPJxaS7P9MQ9WUWuYaq6uiYKJRcLh0BeTEFq
         5hwv1UMXKbsPIhXwtFFSBm+EB5AyRGY66369lsoDJWrNfpVWNrD+mFzI6JCQy0R4mjlU
         DSu1s56OJjk0vcIeSUC2aEJJISMLXpFqPu8DOX3uMvrtjvvvGaqv6R8thOPAu/yNuiqJ
         27ePJPCpZbHLS7YMZEvAQcB6cshDOb/48LL8Ly9WVg3+aLarT24rCVKpn9kmXmapvgdp
         ubXA==
X-Gm-Message-State: APjAAAVH6P22gVdeCmDEvmM9dPNefE0XsGTMbNZ6LrshevzFygwBX40B
        OFmxRLJQOZeSgo8OKB76ACDekklVyYRbLqEx4UobTw==
X-Google-Smtp-Source: APXvYqxX0B/GZlqSYxDgtH13jNbbY+d3/QJQCEQPxrTROPkHoAlfS/Qfoz+sw1btsfsESznBrLnmdvq6rUNtzvgitZI=
X-Received: by 2002:a37:9c57:: with SMTP id f84mr21728192qke.250.1567998695029;
 Sun, 08 Sep 2019 20:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190906185231.1081695-1-arnd@arndb.de>
In-Reply-To: <20190906185231.1081695-1-arnd@arndb.de>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 9 Sep 2019 11:11:24 +0800
Message-ID: <CAB4CAwfvPpdhp0oCnAkZEY9GqE+PA8OcD84wtR_P44CZ12p8-g@mail.gmail.com>
Subject: Re: [PATCH] [v2] pinctrl: intel: mark intel_pin_to_gpio __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 2:52 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The intel_pin_to_gpio() function is only called by the
> PM support functions and causes a warning when those are disabled:
>
> drivers/pinctrl/intel/pinctrl-intel.c:841:12: error: unused function 'intel_pin_to_gpio' [-Werror,-Wunused-function]
>
> Mark it __maybe_unused to suppress the warning.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Chris Chiu <chiu@endlessm.com>
