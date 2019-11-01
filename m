Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1AEBC2E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 04:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfKADDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 23:03:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41313 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfKADDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:03:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id a21so6502090edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3Ouz8MYdv6MVhyGpKyVx7KVTwv3PMM5rhYzr4+rqe0=;
        b=lVYSLALXxzZXVeHvGVRhlf4fRSvlTqULzgy52OD4Sb4TCGso9+f/bC1K8H/NKhWsKC
         97y273mZ1ksRof8bKQM+GfHFN7N+FqNN+PKBfJ+1vnQOSkAfL6jUcL3CmLpjk91Rew3y
         wfHJdrjPSdk6oqMbSUTcZxHkEhso5rluYF0ZFQ6CVTJB2MtknprJP06eq0ZtmumlxT2f
         chLB6YP6oKjW9K5VaA0RrravmWYuN4CfAbnClAfGWi0Qr8nHGE3/wyuxNEBypG81yliz
         zzruPqTU3M3sAkVJkdTklDCQ3qr5c9OkTXkSm9qQYGY4CZDPx+oVZ5IOcZV9ngqz9D1u
         dmPA==
X-Gm-Message-State: APjAAAXqpBP+0aHzMc0pVZPGqsK1qPiOX4ZhoIhg1J6pqpm0FYHgDleB
        wiwN66NhUpIsG7X6BXsPjEsIYexNUJ8=
X-Google-Smtp-Source: APXvYqyUS9xhjODfh4lpyqDPZ1+eeaZdndTUK/WS3vwpeHFDvNHvxibuPQkFJ80MDref6g2zGMUGxw==
X-Received: by 2002:a50:8dc5:: with SMTP id s5mr10066861edh.115.1572577408277;
        Thu, 31 Oct 2019 20:03:28 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id q25sm152013eds.35.2019.10.31.20.03.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 20:03:27 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id l10so8379266wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 20:03:27 -0700 (PDT)
X-Received: by 2002:adf:c641:: with SMTP id u1mr3392231wrg.361.1572577407549;
 Thu, 31 Oct 2019 20:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191031231216.30903-2-karlp@tweak.net.au> <20191031231216.30903-3-karlp@tweak.net.au>
In-Reply-To: <20191031231216.30903-3-karlp@tweak.net.au>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 1 Nov 2019 11:03:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v661sfnYmU9k7R1c7Nrc7_9-LkH5LQa9dvyPVZLGnLfaHg@mail.gmail.com>
Message-ID: <CAGb2v661sfnYmU9k7R1c7Nrc7_9-LkH5LQa9dvyPVZLGnLfaHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2-IoT Box
To:     Karl Palsson <karlp@tweak.net.au>
Cc:     Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 7:12 AM Karl Palsson <karlp@tweak.net.au> wrote:
>
> The IoT-Box is a dock for the NanoPi Duo2, adding two USB host ports, a
> 10/100 ethernet port, a variety of pin headers for i2c and uarts, and a
> quad band 2G GSM module, a SIM800C.
>
> Full documentation and schematics available from vendor:
> http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2_IoT-Box
>
> Signed-off-by: Karl Palsson <karlp@tweak.net.au>

Acked-by: Chen-Yu Tsai <wens@csie.org>
