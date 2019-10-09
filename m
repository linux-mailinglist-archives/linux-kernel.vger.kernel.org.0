Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A6AD1125
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 16:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfJIOZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 10:25:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56215 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbfJIOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:25:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so2854156wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iRU49OEAt4LyCj336K2hOD9DnveAI21uNOjEn9qQOW4=;
        b=E9KCxy7r7W8VuG+gzVrXD0ZY3tqFeU411T36Nq5kTRByAlfDI/wbHpZh/g5kswfCoM
         vwLhWo9403t2VxWW4ttuhL8ENG78lJ8LR6XWeY18QVo6Qr4zH+d1uHFUyneYhxhEkfb7
         oMSONezKLBCpzFUmlkWHaWWec4Xj13yVUdpiV6FskZnBwdrKUX9kQ6LjaOcmqOJlWuZM
         xTGdMwq4xxVsIXN7Ozu0ww8Z3z+iLn4MhQuSH898YBtmx6CNggIToafYp08ywpTdf7PC
         9bohWInAa5ueiUydRrA7pzUepRWP7esXN28+KUc2MKi0VSEEnuKu5Jajoz2XAehkmJu/
         Sp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=iRU49OEAt4LyCj336K2hOD9DnveAI21uNOjEn9qQOW4=;
        b=Bj6J7tN81Kuxcn3TjyhQQOquzTyuQWTp2IaiihfWVANKTGY3cNrxI+UEDBbV2RuQbJ
         4a6a9PMu4xlgnl1EzNMnfUI50cXQ3c9IPPiSEn+ZpQlq+C8wGJ6fiV/mV5WXYrcvIW6L
         HOl8gIxJF5mmtQTqr/+rzy+3bA+i56r6nLNLiY8ejYbOQdfu7MXP472Y1anGvuo2lry/
         L9eS2GaC3HzH8KCGRwlD41gkAKUW5nBJMQYCDR6sEHGPJGrnRuSe83aJY4U8jE17oEGP
         vGBxg06T7Rr0PATaiPFW4LVe+8ojpXJDdcLBHJBh6XlWSxuxnIK43Xep2+TGmp9Dl01b
         6AMQ==
X-Gm-Message-State: APjAAAXxVAub+B+vDjztt5QLzBKj2WFiUxVCttX8kvgGBpeUFntdCTlp
        V025wN8cGSsBiNcCHpS+uFluhQ==
X-Google-Smtp-Source: APXvYqyS6nKg/vIjXNFET5U6tGkbJJYtwsehBMs1oRNWirbe2tDsdOO8TNnAQ1US3oljVkz9zRdfJw==
X-Received: by 2002:a1c:dfc4:: with SMTP id w187mr2754436wmg.107.1570631105871;
        Wed, 09 Oct 2019 07:25:05 -0700 (PDT)
Received: from [192.168.0.105] (84-33-64-100.dyn.eolo.it. [84.33.64.100])
        by smtp.gmail.com with ESMTPSA id c132sm3808601wme.27.2019.10.09.07.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 07:25:05 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/2] block, bfq: make bfq disable iocost and present a
 double interface
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20191001193316.3330-1-paolo.valente@linaro.org>
Date:   Wed, 9 Oct 2019 16:25:03 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19BC0425-559E-433A-ACAD-B12FA02E20E4@linaro.org>
References: <20191001193316.3330-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens, Tejun,
can we proceed with this double-interface solution?

Thanks,
Paolo

> Il giorno 1 ott 2019, alle ore 21:33, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi Jens,
>=20
> the first patch in this series is Tejun's patch for making BFQ disable
> io.cost. The second patch makes BFQ present both the bfq-prefixes
> parameters and non-prefixed parameters, as suggested by Tejun [1].
>=20
> In the first patch I've tried to use macros not to repeat code
> twice. checkpatch complains that these macros should be enclosed in
> parentheses. I don't see how to do it. I'm willing to switch to any
> better solution.
>=20
> Thanks,
> Paolo
>=20
> [1] https://lkml.org/lkml/2019/9/18/736
>=20
> Paolo Valente (1):
>  block, bfq: present a double cgroups interface
>=20
> Tejun Heo (1):
>  blkcg: Make bfq disable iocost when enabled
>=20
> Documentation/admin-guide/cgroup-v2.rst |   8 +-
> Documentation/block/bfq-iosched.rst     |  40 ++--
> block/bfq-cgroup.c                      | 260 ++++++++++++------------
> block/bfq-iosched.c                     |  32 +++
> block/blk-iocost.c                      |   5 +-
> include/linux/blk-cgroup.h              |   5 +
> kernel/cgroup/cgroup.c                  |   2 +
> 7 files changed, 201 insertions(+), 151 deletions(-)
>=20
> --
> 2.20.1

