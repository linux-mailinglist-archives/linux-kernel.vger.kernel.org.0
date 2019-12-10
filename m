Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A071119220
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 21:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLJUeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 15:34:17 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46041 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:34:17 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so17315786iln.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EINwPsE2o9b6h5y0t6kgOUNqky5nib0p/v1Xe6hDKmc=;
        b=I+y5aLUWv90/bs4wDnkJybJ03d3qqe40pF4WwlPECm7/Bk82PnjnB33hEe8jy8woEB
         zztHEiD2drxlz9mUkyz2bWQVt7/ee+xCb7eo1JNU69OsiTp5yFARbWF5QkNFGy3994Tc
         lSHROKTc+7JyW2dUH1uMe0hPPeZrtA8U5MfvmLZMC6oVHo675XWSNWqHkUJMQ3H84SWP
         4a1xrl/a7exXXUnOxl2BGMZvvCL12mKyF4MXsAfIzTGhN6E+HQ2YITU2+wR0OSfhKKfk
         B2kkfvGSnMhpLsEU5T8BaZTgG24un45JrYhgHVbotUyNW13Y/8w4Yn+tkGoSjmSu6yV6
         +DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EINwPsE2o9b6h5y0t6kgOUNqky5nib0p/v1Xe6hDKmc=;
        b=fQUVEKceFS32ZfVTzwE/X7ZfxHS35SwMHi6kAtiVF3sxkLWAV2U6PzNME9rk9INqK2
         RhrWAUYAEc0pmhCevaD75QE5ZsLDE+t9liyjEzM3w4jmzKUgrFK1Oe/bBskan+yxzshW
         MwK3JBmHI5a7dZgNIOax4b+KLpjskyJmuz1QI5k/hM4AsbDHqv9XTNRe5ZxiTk2RM2vd
         hpKNL6pCCI3fav6DemE7n/GBFqUUlPLBxl4kAs5tHhmAvY+MXCkZjYZaGiOvGzOK+aj2
         LvsIe1OhdxZ/44Oypv7gc0mgagn6xEAvtpCMoDsc9REq/JjKlToFMwfFq3/ztVVvob+J
         AM3A==
X-Gm-Message-State: APjAAAWddBr529ZJBWGZunWEmPoXfgsQAvaZnpCGINNyhB2Mta92qnj+
        ECn5YPFeAtgj4qRcCMK/56LkHHCoeyD52AA5HRw=
X-Google-Smtp-Source: APXvYqxzyYnXt1ev4ZSaP784KRn0QhAXKh+Y5dGO6ZcL+PEYLLJIMe9IZjwLGVd87ACUvB41iMQ8EMRIktW4tQDJ9D8=
X-Received: by 2002:a92:4698:: with SMTP id d24mr37036359ilk.104.1576010056697;
 Tue, 10 Dec 2019 12:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20191210203149.7115-1-tiny.windzz@gmail.com> <20191210203149.7115-2-tiny.windzz@gmail.com>
In-Reply-To: <20191210203149.7115-2-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 11 Dec 2019 04:34:05 +0800
Message-ID: <CAEExFWtjUSWvgn=zrci=mVTTnqjOcc1WRGSkSSZgR_PbWMv7+A@mail.gmail.com>
Subject: Re: [PATCH 1/5] nvmem: sunxi_sid: convert to devm_platform_ioremap_resource
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        vz@mleia.com, khilman@baylibre.com,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        andriy.shevchenko@linux.intel.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        mans@mansr.com, treding@nvidia.com, suzuki.poulose@arm.com,
        bgolaszewski@baylibre.com, tglx@linutronix.de
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no 5/5 in this patchset, a small mistake.

Thx,
Yangtao
