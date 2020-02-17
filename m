Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD06160C38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 09:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBQIGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 03:06:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36561 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgBQIGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:06:32 -0500
Received: by mail-io1-f65.google.com with SMTP id d15so17472631iog.3;
        Mon, 17 Feb 2020 00:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4iErZEeHdLP/k4A9lJOInup/YFd9m5dp1K6FqMWj0s=;
        b=r4lTZKFkelyQbz679rc7YQ8WGMITje3bKOmCHvs+Q5j/Rr1HBfh2kI1MHWyR+CSksT
         IzanKGI/HDGMH/3l958t+tHn+BQykhIVokans18248p9ouurocRZvMjmq/5G3NPDWjOc
         /K8JsCM4NbwFk8b7noddTFElZkQzGmDwdkdZFrY0/EDZTKKKXYdU67HPoh9P6Hux+qEJ
         a+36sUjN7ghK+0IiDs3yLD6ytmWt5JvLIm4OdaBEOGjpLihhDYEq6XqKjEBba+aRNRcv
         2J6D8scwACDFLfbvZrWxyDnYNrR23/PpbqLou5NNRQ6gZEKsHyfiXjnrT3Bljd3LAL22
         jbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4iErZEeHdLP/k4A9lJOInup/YFd9m5dp1K6FqMWj0s=;
        b=ApXwxZctJ2Z8glSiReqllK0GdQ5aB6fBk0EcDD+J8i4uycKkmK7aHCxHY7FpHTYMaL
         fp2BU6x1WZU1uqXYkY/SxNE7NjDmTY5J0nzMix/Yk/YJFUfrNDeimra+7FShJWZfYKVy
         rN1o0Ril+9+Z4QPVdIHh0qS4Qd1uSvH0LEMI1B2wQKS25+TrRA+PkkcmCl48cQNtdLl8
         lqyGKtmILK+0fluKaPvP04tDucFFDn7p2h1kmABrjWQATVvRsrgmHUkXORE69zvPOOwJ
         lBfvmEw95FmnBvTzZQJUoCs+ht3Cf3gnJDOnMrMFvtHJiPbH41T6oBWwVbGblkNOIYzj
         d6qA==
X-Gm-Message-State: APjAAAXjZFacqicJ+NubGpP11z0X7d83y56nfoCoD2w/zDKbADCtPBwa
        +WnWSMJoEzwsDhsWHsAs6a8Mxgv3TQELVaMIGeE=
X-Google-Smtp-Source: APXvYqwT6KOGaK3oTFNEspTWDTqsYMPcRLQVAN6wvSFTTlhryrCpMH7JZXDt+Ot+X/F8lBhIHH9/d+si6uF0Ts+z/C4=
X-Received: by 2002:a05:6638:1a3:: with SMTP id b3mr11936540jaq.84.1581926791843;
 Mon, 17 Feb 2020 00:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20200216202101.2810-1-linux.amoon@gmail.com> <1jpnedzmr2.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jpnedzmr2.fsf@starbuckisacylon.baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 17 Feb 2020 13:36:21 +0530
Message-ID: <CANAwSgR918Q3wGtJN_u9tjM+t1ZMod+PpZzJcBLT5jyqYEnP6g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: amlogic: odroid-n2: set usb-pwr-en regulator
 always on
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, 17 Feb 2020 at 13:08, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Sun 16 Feb 2020 at 21:21, Anand Moon <linux.amoon@gmail.com> wrote:
>
> > usb-pwr-en regulator is getting disable after booting, setting
> > regulator-alway-on help enable the regulator after booting.
>
> This explains what your patch does, not why it needs to be done.
> Why does this regulator need be on at all time ? What device needs it
> and cannot claim it properly ?
>

I missed this node is for micro usb, plz discard this patch.
I am relay sorry for this, sorry for the noise.

-Anand
