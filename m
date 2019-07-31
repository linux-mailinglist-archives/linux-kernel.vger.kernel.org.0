Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF417C040
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 13:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfGaLl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 07:41:58 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:34093 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfGaLl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:41:57 -0400
Received: by mail-lf1-f52.google.com with SMTP id b29so39987456lfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Scxi4ZxaYb4wXMQQZvVXE7gyxyoPGepBHxLOfFuZjhM=;
        b=ni7/O8Hm0PS/XU8nxGHCU01AO4CbhX0HVmjwO7afdnUAVxRmW1Jt5Aa45hkjQgt9mX
         etg5g4IoOcRbofurC9E9dCnQHu5IZptqCI5io751aFQa2Rb27oMfVt/jzG0P2Htzb0n/
         /Oar4FjPpKJdLjHVvm9nFSu+PamvzrF8fK0yZnX8AMS0iidEh3wJZmSGW5xUEtiht0L7
         y5yJmJ0W+GrczdXDYRs1p0jHV9uF1UeJ2x77+BFNGATg7ENZVbtwDGNY6glp3CSM8iAI
         5HRH/ZE97/xVhENQI6zu8nflmcOajvaIEZpW2y04xpnOVEncjwrg8UDxhwkcUerCkGcH
         kzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Scxi4ZxaYb4wXMQQZvVXE7gyxyoPGepBHxLOfFuZjhM=;
        b=Yw7ie3TrSF+k0VzLfjimHGgkYUMbzue+TnUDYvP68iNAaEtCUSuu3LrgMWxcOF01ek
         7nEbTXnoHA8uybEIxakqg3rb0EL87rna6Xm96d6VPJGvueD1kzPHHLycIbNTdRBSnV6E
         Valhj80ky9E2N/Md14htkL8A1KWAmU+CDcDK6wwDVYzEHY+XM6RTBQ2aGrSNS/t1XQJO
         RbRvf5weHQ+JYEqsnYHM+MuG6Fd+WTnUeQr3UXWmbx4JpI6k3fBCUtd62hrFEGRZQlZQ
         bbCB0X2eftId0TdReYmK/pUOzRHfpsZzv5HpoDnvu5fKGjZnE4vGHg2uacC9HpfzsXeV
         WVUg==
X-Gm-Message-State: APjAAAV6CCL1BguEkrYH/ZCme1/2QbBlC61UDipQHCmG0XyjKTxWIMAg
        4W087SdHMSgwPBDKAeWmELEtko/oVAK5/YedOSkKSxi6rOg=
X-Google-Smtp-Source: APXvYqyXgtk5LrXiapHUh6k/Zt09iuBKAbjfeBT6AS1UsZFTYBZXatK8z5e2Zy7P5LIkjRbMBSf1aD8+jT1Ic+4ymJY=
X-Received: by 2002:a19:7509:: with SMTP id y9mr57706547lfe.117.1564573315403;
 Wed, 31 Jul 2019 04:41:55 -0700 (PDT)
MIME-Version: 1.0
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Wed, 31 Jul 2019 17:11:44 +0530
Message-ID: <CACAVd4gjA0iwooWomJ+1CmhVRo3kDzEh0dSEKh2dXuZ-ZSHqnQ@mail.gmail.com>
Subject: query on linux kernel timer implementation
To:     linux-kernel@vger.kernel.org
Cc:     arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Team,

We have a query on the implementation linux timer implementation.

We have been running our application on linux kernel 4.9.168 (debian -
stretch) version. We use intel Rangeley 4 cpu system which has tsc
timer. Our application is an multi-threaded program which creates a
monotonic timer-fd  object, sets one second expiry time and does read
on the timer object infinitely. Once in a while, we face an anomaly in
the return value of timerfd read call.

As per the man page, read on timer fd
(http://man7.org/linux/man-pages/man2/timerfd_create.2.html) returns 8
or -1 but we observed read returns 0.

While debugging, we found timerfd_read function returns 0 when the
amount of negative tsc clock drift goes above certain boundary
condition. Through instrumentation, we found the following sequence of
code flow gets hit and causes timerfd_read to return 0.

Please find the below sequence of code that leads to this anomaly.

read(timerfd,=E2=80=A6) --> timerfd_read() --->  hrtimer_forward_now --->
hrtimer_forward() return 0 if expiry time is greater than current
time. Timer object expire time becomes greater than current time due
to negative tsc clock drift.

We like to know whether returning 0 from timerfd_read is expected?

      - If yes, can we document it in timerfd read man page?

      - If no, can we do the needful to address this problem in Linux?


Please cc me in all the discussions happening on this post.

Regards,
Arul
