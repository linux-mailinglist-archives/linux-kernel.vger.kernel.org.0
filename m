Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377D5A6AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfICOOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 10:14:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45865 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfICOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:14:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id r15so14425848qtn.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZuxXXMlAYNSgtrDo0fBJSBMOeWiN9xN97X6WAr23F4=;
        b=BENam+KXO70R70KQ3+MZHBhyp0284kQXpZKvwHXmtovBSgv+h5YYYG4ir1Yi/I3Ay/
         v69Vn8GjuCS05VDclOvBmpouOwM81YF05Ghnzp0C6CyAlsNdgsz4VXdloC4adgyZGm5h
         16nt2+Nl2JHxZfNRD1vJZzcmLxMpI7qb69dJB7rq/6orD1ojmXuY+K6U23r6EBq2SHsX
         5JXo/+lub1YowG0uXUxgG4ji9rzVuG3WUu6stGdifgtA0nhuCu6OPA388hVGUAJ7cdBS
         l5rRAFgb3D6a3H+0EG/5qV8vAmJXdcITlpVttsi/BSFMtjbUfUpUQiVJ5Td7RsJk0PbU
         Ja0g==
X-Gm-Message-State: APjAAAUvonmZkxqhYB4HEV5g137DRFc9u/cVgd2XT8jxPC8HfJORAVKX
        mCWQPufv9jTfU2AhP7A83SxUjm31EbISXyXOzKY=
X-Google-Smtp-Source: APXvYqxelYH9THh93iIcl3wa1OLv6f7pgPHKDWhhtXYhUd64qKHC4ZPdbqr0L0BjKsY8IVk5YfziXZyPIgVPl1f7ccw=
X-Received: by 2002:ac8:32ec:: with SMTP id a41mr3105234qtb.18.1567520079928;
 Tue, 03 Sep 2019 07:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190825202642.GA18853@piout.net>
In-Reply-To: <20190825202642.GA18853@piout.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Sep 2019 16:14:23 +0200
Message-ID: <CAK8P3a02iEsnCc2chJzAs-z=1DQ=P7=WaA1q4EkOCUNxAwwALw@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: at91: DT for 5.4
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 10:26 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
>
> ----------------------------------------------------------------
> AT91 DT for 5.4
>
>  - style cleanup for at91sam9x5 based boards
>  - avoid colliding node and property names
>
Pulled into arm/dt, thanks!

       Arnd
