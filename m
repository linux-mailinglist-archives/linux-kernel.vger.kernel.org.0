Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD8F1B71
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 17:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfKFQj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 11:39:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40194 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfKFQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:39:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id i10so5968188wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 08:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1L6++depL7kVV/7K4URDof8ttp5u2kTTsZyvtGCqQo=;
        b=JQAwcuxoQt/mfbKl+Do1evKb1CHpu7UwUZK65d/q7Euy7+fDyLJIKo84HUkaTofrcj
         ol9VYQXfR1tT8/wRZiUkTwNRPxBLTF3lL2CNJqgPWUqydxfb2vfGrLTABZ4FZbn/S4A3
         On4YF96g3uB6uzNCL0PGJXCxIxSlhrsWFhQeAnaLREWadUbpVhhbIECjK6B/NDuYlFG/
         7SL3TK6H4Uzl4RNsQyFKcLge5+8eVKBa7J5S4MJbdhPc09x6EyEfS59pPpiVZwSQKu4M
         YEA7ho1mIF+fSmq9OJbEARINHkFB1KSQ/8aeFbHY6JP+3pPTUeC80hehMNuG9373i7wQ
         ihhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1L6++depL7kVV/7K4URDof8ttp5u2kTTsZyvtGCqQo=;
        b=kuvxzFSVttmN67Fp2BfdrBP8d5of5Cu47vZayFfmY6dhuSK7wyGzE0TIlSMWh8VZPp
         kzfp6x2rappYuowoVO5pHc9RvclXN0Bd/0obMlrGuMpWlJTZtp3IKxvLO1Bfab6S64eq
         IMMbj6hlzG0NMnsGAtjGuXsj86JJ9248WuPjtYmWV5akscZcZ0B5RnRkY7QMTOwH9hzq
         jwNlx3U0IS0yR6Nq0KubsRsXUAB258kwS3U6oXLf/tRZ9YK7Q9HxHPFuDdfPGSXFTlJJ
         zVeQoTLGMYO+apiTXQ1PCDQYE/D9ynR7JXdRDm0FMK0KxlWx8JxICvU47ENKshSI72Ow
         DZ6w==
X-Gm-Message-State: APjAAAVqGGDl64FafbtL4VGaFEksDiypI7t/69H5cdYw5Bkp/9PTqAgR
        34RFFk2dXIFo5z6/f3jSudA7jMXIHZLFUQ8iWOdKwQ==
X-Google-Smtp-Source: APXvYqwKL/x8xbyX2/N1bzAnFDoR0dbmVdxD8aVawTUdSz/SYhoCqX3gpAX0EbOBhZDBNpFeUWwh+8SJ6n8YR0RfP3I=
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr3537854wrs.63.1573058394813;
 Wed, 06 Nov 2019 08:39:54 -0800 (PST)
MIME-Version: 1.0
References: <20191024222805.183642-1-ncrews@chromium.org> <62e9a2cd-d450-ef03-ca3a-f549322232d8@collabora.com>
 <CAHcu+VYdMxoFbcxYxB1FnDSdsM=w9UsVKjF0S48LZGG0ZxKUDA@mail.gmail.com>
In-Reply-To: <CAHcu+VYdMxoFbcxYxB1FnDSdsM=w9UsVKjF0S48LZGG0ZxKUDA@mail.gmail.com>
From:   Daniel Campello <campello@google.com>
Date:   Wed, 6 Nov 2019 09:39:18 -0700
Message-ID: <CAHcu+VYJGUARhN8_LcdH=rMzgZN1aGnBcjMx=onftmkR-1PMXw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] platform/chrome: wilco_ec: Add keyboard backlight
 LED support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, linux-kernel@vger.kernel.org, arnd@arndb.de,
        weiyongjun1@huawei.com, dlaurie@chromium.org, djkurtz@chromium.org,
        dtor@google.com, sjg@chromium.org, groeck@chromium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI again,

On Wed, Nov 6, 2019 at 9:34 AM Daniel Campello <campello@google.com> wrote:
>
> Hi Enric,
>
> On Wed, Nov 6, 2019 at 8:15 AM Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
>>
>> Hi Daniel,
>>
>> On 25/10/19 0:28, Nick Crews wrote:
>> > The EC is in charge of controlling the keyboard backlight on
>> > the Wilco platform. We expose a standard LED class device
>> > named platform::kbd_backlight.
>> >
>> > Since the EC will never change the backlight level of its own accord,
>> > we don't need to implement a brightness_get() method.
>> >
>> > Signed-off-by: Nick Crews <ncrews@chromium.org>
>> > Signed-off-by: Daniel Campello <campello@chromium.org>
>>
>> As you know 0day reported an issue that needs to be solved, waiting for a new
>> version.
>>
>> Thanks,
>>  Enric
>
>
> I just sent a v9 of the patch with the issue addressed.
>
> Thanks,
> Daniel

Resending in plain text format... Sorry about that...
Daniel
