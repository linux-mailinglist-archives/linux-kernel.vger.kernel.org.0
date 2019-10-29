Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3AE8907
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 14:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbfJ2NFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 09:05:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38428 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:05:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id v186so8846125oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1m3xu+m9D6gNt192ldAysUnXZ1pnKI/Ej70V8nnp/Q=;
        b=Z+YX88goKKBun8hGKQzGum6fxwq27ys1g6YH8mzsIOFHjZeyo187uDWpv9vwW/WtQY
         IhmQsiwUHlb15K2hPLJuKkupAkfHS7Onbgi/YlW90rAKiooUkKIeAzm1mdgBj3LrQibk
         dL1h9sf9joqZ5kU6XHo3civXlReFlcQgLzizNYxvdbylsl+TMjCzZZgRGxLv0xyNqmqX
         1roCCPyB7/4zGEUdoTCCLX+L+wHqj5ARSlp+bNRvA1ULMzPFAheyhB3fDZqo1IQVM2Rv
         KZJ1V99zSEykVE1LQGtq+xYUEztrxqnjxSD+vJKenwf/UDB5b9cl1MYzcek5AI/MIHo9
         LzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1m3xu+m9D6gNt192ldAysUnXZ1pnKI/Ej70V8nnp/Q=;
        b=BV/UIiYL5YkuaVD4tJCfkOCiWkSdgvheX2zQqqXU2SDAwato4XBTZks0qs/VSw3X5D
         eMwad2hR1PwyO5WcdKKskRtkslwK3NaK8BcU/hfGgGZP9o/O97z99xH3mATrEFsmwRE0
         9HA+NlKTgpODjhcUtHRLVvEnrtE2vlSwMaRSShfm0exI2mrjz+/EXgKNMK/rvM6qPOcs
         8XDeB9dpNTRiUdWvRXpPk4dP1AeUMVj33qUfs70vnsXrL3qJxDySysKaRTdWD4GPTn9E
         82MH4qLSCKE7UhxjS82f7PnM+GGOm9774Foij0nBx3wIUztGo5jhi8uFzFK22c2Zn7u2
         kZDA==
X-Gm-Message-State: APjAAAW61pfgC7dGaZ9cbKrxltrxKKVFvIZlIriQGKbEnPx3R5s22Vwu
        rBiQCREgUSkaGT0tiQ+t5QKaKXWRvupSVLALM1w=
X-Google-Smtp-Source: APXvYqzcuXK39zeqZTtDeXlSdcOoUxbBCJz+mD+QEuH872R+9IM1iojFTcgFg1Pi9wN5zc2183cyT1KJYO/hUnpAdu0=
X-Received: by 2002:aca:90f:: with SMTP id 15mr3812140oij.92.1572354340215;
 Tue, 29 Oct 2019 06:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <1570515056-23589-1-git-send-email-hariprasad.kelam@gmail.com>
 <CAGngYiX0zoAQB=SEoXfoMm9u_JzHu3eLErj4zmTYtSAoDwkp6Q@mail.gmail.com>
 <CAGngYiXxagQMiHA-pZupTPHfyFz4kU=QOrvM28L_jSV1VGw=jQ@mail.gmail.com> <20191029080336.GA493801@kroah.com>
In-Reply-To: <20191029080336.GA493801@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 29 Oct 2019 09:05:28 -0400
Message-ID: <CAGngYiWDUbnLCDMM4JM-Jn3GNBvQsbrD5NfNmL59q-3DVeD3uQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: make use of devm_platform_ioremap_resource
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 4:03 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This has been in my tree already for a while, can you verify it is all
> ok?
>

All good. I see you took Cristiane's version, not hariprasad's or YueHaibing's.
As long as one version lands, all is well :)
