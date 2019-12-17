Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7000D123880
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfLQVPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 16:15:17 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40783 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfLQVPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:15:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so1698671ljk.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miIxpQ/Ljqg/1nvvnERImSZJGAAMIhMIrlQ3MRCjAF0=;
        b=DQpT/HDqDEnXfuTHalEnH7z0eHJ9zRmDVgQR+3sMlGUq2uVljvCZCRD71oPnT7JE1j
         sxYQOl2ad2Dy8B6VfwMkYmYcQSSdkvT9u0z41CapTmKJMf+VFVLo2LX/00xAnRCtYeRM
         Wi8Sn7atlRHf0teoKy6kSdg018cHdY4DHM7o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miIxpQ/Ljqg/1nvvnERImSZJGAAMIhMIrlQ3MRCjAF0=;
        b=XyFx/D/ZTNXPsOZ9TKXqa1dI/HcHTReXRWiecSqqUJ1nBYQjDDqedOQoviBQzSU/h3
         XVSdojrHF9z1zZmNn3YDdaDatO7/zh4ZWnAX9ZyAClST09zYClLAcht/HJJC4eih0Fb6
         52cKIfcY9mKhijCbpQf2BIz3SPRVlyyX4pJUCcNgbrIniD3/uWz+IvqAPccq1rssJyya
         rI61bbcMaeAQZxtqwg1+rT0mHXhHE9qmTirlFIx5Ty+1YL/l4OsmnpP71bTPCvP+PuIw
         C53ZwLkLXO9WYQkpSbAFoyNCkxcKmP33MO/EecRrsd9d4hjO24oCqfbvnV2JqRkeAZHF
         LoMA==
X-Gm-Message-State: APjAAAXg9vO7U92CUDG3NU5/xy0X7D2VSmpIDX/cJCc/gBZUL2vYUBPw
        mkpD7TevzfgwHbPbrLFY4HNcEUc5Exc=
X-Google-Smtp-Source: APXvYqwGtLjzp2ML7AfhPBwkRVm4wOZ4HZ00LAQIWYqnkq7A/Pqiksv/IP7JGeRoGyP6g/Q/hr7Blw==
X-Received: by 2002:a2e:7d01:: with SMTP id y1mr4899708ljc.100.1576617313042;
        Tue, 17 Dec 2019 13:15:13 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y25sm11240553lfy.59.2019.12.17.13.15.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 13:15:12 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 15so62023lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 13:15:11 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr4054922lfi.170.1576617311430;
 Tue, 17 Dec 2019 13:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191217051751.7998-1-youling257@gmail.com> <20191217064254.GB3247@light.dominikbrodowski.net>
 <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com>
In-Reply-To: <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 13:14:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
Message-ID: <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as stdin/stdout/stderr
To:     youling 257 <youling257@gmail.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be fixed by 2d3145f8d280 ("early init: fix error handling
when opening /dev/console")

I'm not sure what you did to trigger that bug, but it was a bug.

              Linus


On Tue, Dec 17, 2019 at 1:34 AM youling 257 <youling257@gmail.com> wrote:
>
> I had been Revert "fs: remove ksys_dup()" Revert "init: unify opening
> /dev/console as stdin/stdout/stderr", test boot, n the system/bin/sh
> warning.
