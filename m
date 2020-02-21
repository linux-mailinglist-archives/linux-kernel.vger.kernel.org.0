Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF4F168792
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 20:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgBUTmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 14:42:00 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36507 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgBUTl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:41:59 -0500
Received: by mail-io1-f67.google.com with SMTP id d15so3633301iog.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPEkVNQNo6+YwuuDTJ8f8LWVOUVBTxJ7HCWvWKezvwM=;
        b=OOj04mF2+3yRsYgUDM4psSLvDVhPp3+mkxUO1ZzxFRyV2BpOHmDVNSaSg0Nf+m0Jvv
         g0iOef6Ch4C7hb4JDOA4KgPfcuXgKOre6matGbVL9twWijFXGJ0NeeRfME4dB6V33VJK
         mrf7dJ5OaUo00VZfHhlyludpRW1y7L1C8zfQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPEkVNQNo6+YwuuDTJ8f8LWVOUVBTxJ7HCWvWKezvwM=;
        b=pt77OkZPe7c+uVSN0OJ3zh+92n5t5+gHlXXhNt0OuWyN7O0/ebBS+ThYPq3xJk8L7Z
         KifysTsHVaEqX9/TYBJhFhd78Jk/dAIpocRMBnaZ68ajl/Qoy3wC18D5YKozJvXPuCAL
         ITu3GM4XZpNe/rF/b/Owv1yEOelnNzsMnReRn3z4SfRlQCNs9zDh9rxin8BWKByaeTFa
         qvwvIHP3DwAubgZiEPod76zp024cactEf522ewjh/wxAhlJCeEBwUOw3325I+Soulr81
         cdEGwjBpX+bMMorQk8zSqurMIms5zjeTuq8EeOmuSnSsqzd8wH+7RgW4TDY+7KdZmyx+
         fqMw==
X-Gm-Message-State: APjAAAVJVtB4OTk1y4J0r6Qq3yEJtJUAYLd8YVAmBSznDnAYJX7P5O7X
        L90QujNjVOFs25yiDeBnHI8ymmr+OEGIbUuA3R74Vw==
X-Google-Smtp-Source: APXvYqyhv6yoRrvJUuENNKPAWV05pjT3Uyf9H3bCQETX5SOA9ofYJ2wSIn+d5yP6cxreX1ktp9sFgfx2+GHoYNL0c/U=
X-Received: by 2002:a6b:7117:: with SMTP id q23mr31725213iog.153.1582314118577;
 Fri, 21 Feb 2020 11:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20200214062637.216209-1-evanbenn@chromium.org>
 <20200214172512.1.I02ebc5b8743b1a71e0e15f68ea77e506d4e6f840@changeid>
 <20200219223046.GA16537@bogus> <CAODwPW8JspiUtyU4CC95w9rbNRyUF-Aeb9TuPm1PzmP6u=y1EA@mail.gmail.com>
 <20200219232005.GA9737@roeck-us.net> <CAKz_xw2hvHL=a4s37dmuCTWDbxefQFR3rfcaNiWYJY4T+jqabA@mail.gmail.com>
 <e42320b8-266f-0b0e-b20b-b72228510e81@amlogic.com>
In-Reply-To: <e42320b8-266f-0b0e-b20b-b72228510e81@amlogic.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 21 Feb 2020 11:41:47 -0800
Message-ID: <CAODwPW94KX46PzSrf_uuEFPKudXor=26d=g3Qta5veRfxmMDUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: Add arm,smc-wdt watchdog
 arm,smc-wdt compatible
To:     Xingyu Chen <xingyu.chen@amlogic.com>
Cc:     Evan Benn <evanbenn@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-watchdog@vger.kernel.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yonghui Yu <yonghui.yu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Because the ATF does not define standard wdt index, each vendor defines
> its own index.
> So I don't think that the current driver[0] can fully cover my usecases.

I think the best way to solve this would be to put the SMC function ID
as another field into the device tree, so that multiple vendors could
share the same driver even if their firmware interface uses a
different SMC. But they still have to implement the same API for that
SMC, of course, not sure if the Meson driver is suitable for that (but
if it is then I think merging those drivers would be a good idea).
