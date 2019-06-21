Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2924EAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfFUOqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 10:46:48 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34057 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfFUOqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:46:47 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id be52ef50
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jun 2019 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=JPjauernHso6uAK9ikz8SKW4XZM=; b=dZXpZN
        2FbnOThfcWqSZTt/3LEJC6PDLD/M7HHi7q8I+IKmCSiD4MX+eEx4gkZjP9dMCHVw
        INhDVZQK50wn8q319bIdzQVvHRJmxnpjRXpHVkf7Kcoy+q/GtNruh74acfOv0lFP
        6vkMBZ9WytUwlSHXhkAhk4g1yJdNDpYpQJZUreMlJMzXCloWeq2yuD2ABAzuYa3l
        tynH/5wCpvHTvZgnXKI9TDLyqEsq9WzQK0Tx2WWfJHq67QIdBh1YUxXbaBZgDWqi
        +Aj9BsFTmaVDioxlS1lPeeRpky+fajMkUiUdwR3ngeF/gEHzM3O2aIl70mSL5mHK
        ezQDkL4TqLvile2Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9730adec (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jun 2019 14:13:21 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id r21so6554081otq.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:46:45 -0700 (PDT)
X-Gm-Message-State: APjAAAW1fpuRktOuxe/BTAjCbReWAHdZRVMz/62ICcRpgL2q9fAn2Oek
        mAwYs3sTrD9sI4fhEcyTaQrHj7Uh9MaZXoS1IAg=
X-Google-Smtp-Source: APXvYqzZGdtSyfVmV68atPrv4JHfMT0AEdbpO6M87y0EIbTH4vUTWTAy3LfyaawIX7ryVabajxYkAYQgjBa9G826oMw=
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr19770032otl.52.1561128404638;
 Fri, 21 Jun 2019 07:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com> <20190620141159.15965-3-Jason@zx2c4.com>
 <CAK8P3a1Dfx0MayHFP46KL0RDta9cZYBy3pVRTaVTbEsbMOy5xg@mail.gmail.com>
In-Reply-To: <CAK8P3a1Dfx0MayHFP46KL0RDta9cZYBy3pVRTaVTbEsbMOy5xg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Jun 2019 16:46:32 +0200
X-Gmail-Original-Message-ID: <CAHmME9qDAEzZKBDowLmdaxtc8fJqp-w_cvOWsvubh5Yr=Kgm-g@mail.gmail.com>
Message-ID: <CAHmME9qDAEzZKBDowLmdaxtc8fJqp-w_cvOWsvubh5Yr=Kgm-g@mail.gmail.com>
Subject: Re: [PATCH 3/3] timekeeping: add missing _ns functions for coarse accessors
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 4:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> I would prefer the 'coarse' on the other side, i.e.
> ktime_get_coarse_real_ns instead of ktime_get_real_coarse_ns,
> as this is what we already have with ktime_get_coarse_real_ts64.
>
> I originally went with that order to avoid the function sounding
> "real coarse", although I have to admit that it was before Thomas
> fixed it in e3ff9c3678b4 ("timekeeping: Repair ktime_get_coarse*()
> granularity"). ;-)

I can do this, but that means also I'll change get_real_fast to
get_fast_real, too, in order to be consistent. Is that okay?
