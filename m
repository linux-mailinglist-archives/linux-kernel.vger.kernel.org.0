Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7FBAF5A3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 22:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388681AbfKHVjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 16:39:09 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38504 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387718AbfKHVjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:39:08 -0500
Received: by mail-yw1-f67.google.com with SMTP id s6so2717110ywe.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 13:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3x+yi7ZQlL22HiciYNh83NGIP9RfXhtr5BWNun9bwMk=;
        b=GAugVRnAoKW9nQWPQessO7hY+6lAQ4mW9C38ztcXhLnJhT7ezp/GdfmusiPoc1MOoe
         0KJ0qs6IoynTrSXFnTNcYcxmt4P3PIVTFxvhdczk1MXCsdhxJwFa/DVz8q9QCIy7A4NU
         3zCzO4WkLN6rXPtSjIYamRiFiyu+l7Aa0saE5Al4TK02lUanZgL3zsH1Yp2QOqB9nDkL
         Y1BAzrQEARhP7YGiMN4foIz/f4Ifscw2LCqna5avt0FgpzAIAzAwz3GzSTfB7/tnJ9x+
         ZFIEOvfELaIeboi36GtXtHLCrjtllRN+5c99dNdj2/MJEOSsttHsldpURU0qMLgmvree
         LjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3x+yi7ZQlL22HiciYNh83NGIP9RfXhtr5BWNun9bwMk=;
        b=qQiTktwkZRc1TGOBfdoM0YU198tet7ZxQfwnqkvz5AdrdWkHy7AS36SeL1l1Bvp8AJ
         Z35h/HH2oCnUEAPZrkXsesub3mX4NLZR0glMa3BII+wu6igUIQ9vxm0C0+h5yPZR8igE
         Sq0/1wCjCxBrq3ppVC4kpin6v04AIoB5kSn1yFWhUVZflfPY7p5M2SuNtQxFeuHBR6jQ
         qUNOQIAs1PS3SGI1BVJ9bc4Hps/mZHma/sjoYCNTea2u9WprcGkEkPziJa7jCqeyOWge
         lrZ6G6fv7jA41KENlqkOuA/jIR55zqWEtOA28hSd+rYzV3yjgPzYnyJr1Qw5dupvRpqN
         7HvQ==
X-Gm-Message-State: APjAAAWTraRh4W6cSOU75x6o4urOmXunhU8JZTH8sk4Zey9wvKUlZuLl
        nrt8BvC9pWgdM47V8fS18T3B1Tgr/+mMBNjowHkyVBm3
X-Google-Smtp-Source: APXvYqyCbwbEj4MTBZWj2uj8sfBpgfIGRsvy1KlVHpNDr5Zi4Ba42HWyocaIlBfOqFL1WqZ/ge+saTsZalzGFiYsTjM=
X-Received: by 2002:a81:51c4:: with SMTP id f187mr9006270ywb.409.1573249147230;
 Fri, 08 Nov 2019 13:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20191108213257.3097633-1-arnd@arndb.de> <20191108213257.3097633-6-arnd@arndb.de>
In-Reply-To: <20191108213257.3097633-6-arnd@arndb.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 8 Nov 2019 13:38:55 -0800
Message-ID: <CAMo8Bf+3vhwAktDJag9XMFbOJtvOXOK6WOpcUxiE6OD1M1qOGw@mail.gmail.com>
Subject: Re: [PATCH 05/16] xtensa: ISS: avoid struct timeval
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 1:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> 'struct timeval' will get removed from the kernel, change the one
> user in arch/xtensa to avoid referencing it, by using a fixed-length
> array instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/xtensa/platforms/iss/include/platform/simcall.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
