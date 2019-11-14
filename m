Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9743FC99E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 16:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKNPOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 10:14:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54021 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfKNPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:14:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so6067485wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 07:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ywFB54Y06QEG9/TciBUHYAiIfFcKMBy99q77Pwpv8L8=;
        b=oUR1Deq5BgL8IwhRQ4kBq4QgUj1NFn6p8Pg7wcZtfZOzskbWntQPZE2omC29NeqtOL
         Y9PKpLEjWqVn/u7zKbtSM/9qecC/Oh7HC24rziBnDeXtM7qWJNYz6EVJarZKwjEJFWvl
         hOsLHfAUk+7oxXtFLDNUo13tVblS4cY5YKzjJGs3F6iqbjGww+6kTbAVzC6WceWSRiOP
         4zsxHGU7h583/5hp9oJXYLC3ipsz9ucGZM3iidUGSlW/ZWkffURHKssg7qqHIyt+5b1G
         nDGy3xLWYEpx2ZW8EImHNhJHddm1yUZiuXzKs+33vJPc4m9xWNmDr5zFGPF2i9f98/W1
         ZR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ywFB54Y06QEG9/TciBUHYAiIfFcKMBy99q77Pwpv8L8=;
        b=l/WIbgL2CrMg95nDwpnos/E7b0dQ9Ae2wWR9H3UZD/Ih9EodXVsqQF9sNU1C2Zp5V2
         tplsJzDlzpHLegQ7SO+3vasTFkeNYlKvdbmn7r0iUG6RMo/miI011PC8TeLsVmji+QDL
         7A9OVqcjUnyM9c/SoZkihNoqsvoW6eznYDbZL5M5kgSNu0phx9KyQnNliS4bUqXW7NDU
         goyzEU8UXfCXZVBgPB1kJCUqKqHnwZxtXRESxSH2SAHkK20qQR7lu6WBM4OeFwcHOR9j
         SOGDElcUEqBKU8gTJqdrXwLbJSovWWiCSYrUpzfogCjmWSc7GrrDEThiMAYLk13IdTgI
         VU/w==
X-Gm-Message-State: APjAAAW/9qL9qZGCutPUKUlwBJrX7AJXPLZtVxtniaOr30vBBBWx6qvx
        2dUtXPhGnPGAz6n7NtbKTIs1JA==
X-Google-Smtp-Source: APXvYqzV1u6WRPDLNO36t63WZB9MrA9YVwXCbZ40Oc6gERGEcqkhzCvEwZH0cHSnEo1/vmrrf8BYCg==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr8195745wmd.79.1573744457135;
        Thu, 14 Nov 2019 07:14:17 -0800 (PST)
Received: from [192.168.43.233] ([37.160.236.95])
        by smtp.gmail.com with ESMTPSA id 72sm8487931wrl.73.2019.11.14.07.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:14:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX V2 0/1] block, bfq: deschedule empty bfq_queues not
 referred by any process
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <0cb0a853-e036-9884-5681-f4617de5c662@kernel.dk>
Date:   Thu, 14 Nov 2019 16:14:13 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        tschubert@bafh.org, patdung100@gmail.com, cevich@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2E68F00-EFEA-428E-A6C1-267E57450FF6@linaro.org>
References: <20191114093311.47877-1-paolo.valente@linaro.org>
 <0cb0a853-e036-9884-5681-f4617de5c662@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 14 nov 2019, alle ore 15:02, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 11/14/19 2:33 AM, Paolo Valente wrote:
>> Hi Jens,
>> change from V1: added check to correctly work only on bfq-queues
>> scheduled for service, and not on in-service bfq-queues (it makes no
>> sense, and it creates inconsistencies, to deschedule an in-service
>> bfq-queue).
>>=20
>> Differently from V1, which was still under test when I submitted it,
>> this version has already been tested, by those who reported V1's
>> failures.
>=20
> I'm a bit miffed that you'd send out a patch for an issue, this late
> in the cycle, and then it not being tested at all. That's not very
> confidence inspiring. I have applied this one, just letting you know
> that that is not acceptable at all.
>=20

I'm sorry for irritating you.  Yet I don't fully get your point.  I
have sent this fix now, simply because this bug was found ten days
ago, and I've tried to fix it as soon as possible.  I did test my
patch before sending it.  As for public testing, how could Oleksandr
or any other user/dev have had a chance to test this patch if I had
not submitted it here?

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

