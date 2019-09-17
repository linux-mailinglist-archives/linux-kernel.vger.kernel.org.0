Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9FB47D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 09:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404431AbfIQHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 03:02:03 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35395 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404346AbfIQHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:02:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so2831560qkf.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niI5rGV7hd+/rStnFxoqE7zna/O+5A1gNRAdX+dkuEI=;
        b=GmbHHW6vBg/GyjKQf1QmDlO7VBggMVTZNM1L8IwXt3dz8eyYaEqjFj5RG336bY4W5G
         40UinYweycEFh1GTaXpgzSlG+iuFdN7iemgj8YygI52HOHXO0HDQd4gQe/Adhewg/LA3
         XM94xx0bWks2l8+l8ZrdPCVOmW7kNWmZwcbvke00tMZzEKd49pqku8FfUSzfNGQ/Sog3
         i7iph81gt/OrdCV+2aAtj9BgRTeH7XfTyQEcGn+H9eMD6SFQJNT8oWaaT4/A+UsWP9Ns
         RTfyL41YUDc77hyDNbXnnIqR5x5nytMPVYFYy3U8YtM/2vBfha/vcAA6S9JQPqqey5Jk
         QR/g==
X-Gm-Message-State: APjAAAVj7p9GGMm3YTisUkfKugRWfDRSHwFzVG7TA1XKvk7QkjWgITtA
        H6YanCnpwIH/4fNswbbqHQ03sSFBVKyGMwCaSzc=
X-Google-Smtp-Source: APXvYqwCpAgxstZacTY/C5r2SVq4FmEMh41CnGtMqiYcBLMuHpx2Hx4DwiKBP/dMIra8V6/8QLulZJQtupnAIk7+CkI=
X-Received: by 2002:ae9:f503:: with SMTP id o3mr2143255qkg.3.1568703721534;
 Tue, 17 Sep 2019 00:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20170130110512.6943-1-thierry.reding@gmail.com>
 <20190914152544.GA17499@roeck-us.net> <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
 <056ccf5c-6c6c-090b-6ca1-ab666021db48@roeck-us.net> <20190916134920.GA18267@ulmo>
 <20190916154336.GA6628@roeck-us.net> <20190916155031.GE7488@ulmo>
 <CAK8P3a1EZi5apOm90B6YW2GzFXsirz5wk-D66daR20oj_TLXNg@mail.gmail.com> <20190916202809.GA42800@mithrandir>
In-Reply-To: <20190916202809.GA42800@mithrandir>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Sep 2019 09:01:45 +0200
Message-ID: <CAK8P3a2y9OYL-pm38rcGvgzvjgErCUC1ckjVXhd3mb=YEXiD_g@mail.gmail.com>
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:28 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
>
> All of the patches beyond the 6 in this set rely on the system reset and
> power "framework". I don't think there was broad concensus on that idea
> yet.

Ok, I see.

> If you think it's worth another try I'm happy to send the patches
> out again.

Maybe do that after we pull the first set into arm-soc then. If
we can reach consensus, I can merge them as a follow-up,
either through the soc tree as a new subsystem or through
the asm-generic tree as cross-architecture work.

      Arnd
