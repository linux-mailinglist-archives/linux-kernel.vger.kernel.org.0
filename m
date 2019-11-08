Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512BCF4251
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 09:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfKHIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 03:40:45 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:36538 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfKHIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:40:45 -0500
Received: by mail-qt1-f176.google.com with SMTP id y10so5626262qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=ZtJZh0QmZbFKpjxhl0jpAdvRkBYANUXSzHplZUKi5CI=;
        b=NMYulYQYbRRxJTCotZh4HfDQ6+hc95yBzFaeKpCdyL7DVCyQMDaAi22xE+dAVa0SAY
         fjfWh9BkKB/Kqy/MYa3/lyimitIVDH75fuKP/P3E+B9MW+aqVjslrvxYyNpQjt+k1cEG
         pnBhmTt/XpHYr/40Ee7zOAGUReo/zO0VuXaZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=ZtJZh0QmZbFKpjxhl0jpAdvRkBYANUXSzHplZUKi5CI=;
        b=ks1NKl6E92iZtb5XZx90NI7bY1RLd/T0RQw71f5uC8E6lB7rQyal65VTlCYl0YLPyB
         CkmPaCoStiy0RX+Tq47Bahn7aYn/r/n6/3tERUcEaPay8CHFtf2Pl87uPL4vkVVzJY2S
         6dgq4COmLkaJGz73LAXhf2n3AesemUrDB7n0szz0iKarKdhWVqh00Yyfbhto6rqZb6e6
         zLt222FhOlfA17X2V2rQpXMrd1X3GBtVuFUlbv9fkC2hUoqnIVvQThDfI7TQYo0gWxrg
         ulEavHPuMfk29o7OVkReJSZ4JqdNKK5ozCHwRnPHLiBqGJzUKBbDVA7uqeAcEKv1S9UL
         d6eg==
X-Gm-Message-State: APjAAAU35JpkItXZy7kzjGmuU/rMFuZ05+x34omMVTyxNhu1c7mAMNKM
        6VkwhkLNIi6KF/L3nB00+VKQmphUcgzaug==
X-Google-Smtp-Source: APXvYqzNC97cuMEPRkgtWydENeg8/fFFyMCmrq5z5VO18cvz16UL1/GyoDvjeZMlyftBhXhfq4BYhg==
X-Received: by 2002:ac8:7186:: with SMTP id w6mr9357505qto.220.1573202441430;
        Fri, 08 Nov 2019 00:40:41 -0800 (PST)
Received: from WARPC (pool-173-72-201-135.clppva.fios.verizon.net. [173.72.201.135])
        by smtp.gmail.com with ESMTPSA id o28sm3076154qtk.4.2019.11.08.00.40.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 00:40:40 -0800 (PST)
From:   "Justin Piszcz" <jpiszcz@lucidpixels.com>
To:     "'LKML'" <linux-kernel@vger.kernel.org>
References: <CAO9zADy6s1tM4_i+aM_hRQ7uPit3nz-G5MJrSw9DhRZdBd9Gkg@mail.gmail.com>
In-Reply-To: <CAO9zADy6s1tM4_i+aM_hRQ7uPit3nz-G5MJrSw9DhRZdBd9Gkg@mail.gmail.com>
Subject: RE: 5.4-rc6 on Supermicro X9SRL-F - Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
Date:   Fri, 8 Nov 2019 03:40:40 -0500
Message-ID: <001101d59610$338ed720$9aac8560$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJjs1h8ZpQsM9Vjxx4CGujf5DwYVqZktuOg
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Justin Piszcz [mailto:jpiszcz@lucidpixels.com]=20
Sent: Monday, November 4, 2019 8:57 AM
To: LKML
Subject: 5.4-rc6 on Supermicro X9SRL-F - Kernel panic - not syncing: =
Timeout: Not all CPUs entered broadcast exception handler

Hello,

Kernel: 5.4-rc6
Arch: x86_64
Distro: Debian Testing

Problem: On occasion, every 4-5 reboots or so I get the following error
and the Linux kernel fails to boot (see attached screenshot of the
Linux console) when using a USB-3 PCI-e card.

[ .. ]

In case anyone is reading this in the future-- the root cause was using =
a High Point USB 3.0 card (PCI-e 2.0 -x4 width) in the machine:
RocketU 1144A/1144AM/1144AR on the PCB

Issue - every 1-5 reboots, the kernel would fail to boot with: Kernel =
panic - not syncing: Timeout: Not all CPUs entered broadcast exception =
handler

After removing the card, this has not recurred (tested w/88 reboots via =
script) and not a single recurrence of the issue.

Regards,

Justin.

