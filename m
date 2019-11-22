Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035471075C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfKVQ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 11:27:39 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32772 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:27:38 -0500
Received: by mail-io1-f66.google.com with SMTP id j13so8743484ioe.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 08:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlWqqCQ+zgEV72jaObyUbNZTFY8rKw/Sl0dnc6Dl/5A=;
        b=Q3de4ll9e8KMpxI6muGFZLyE6AtK8cNP9PPf7FhGVILpdUDr2/fmfkA6lyoQW2n2TR
         n/d4o06GOFMQKFA/uxZwpohzLAewPAEWEl1D0i3RqNxIxxH3yCaK3+CaFFHK91qnMiPa
         JnHQ+AP3izQjZA8A7uZRODuPBE2ygcvsWnFI25OD4yGrQjWYMpxYHzNoBfGTKyRlkLvS
         lG3ibCe/VgG0y5KwtrkoVOJ5YlJfrK5JwIHTw3ruMuM/D9c50iLAd7Svfuxmw08j9X+n
         DuWPON1UvQXTEWc4VQAk+szrUVfQdjN8OJ0oQAhQyoo1I43xjI01M6nie/C6DSNvvJir
         GZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlWqqCQ+zgEV72jaObyUbNZTFY8rKw/Sl0dnc6Dl/5A=;
        b=nNg5QfL5g4IJEs5Xg0UkrS/N/VYPqnl1+yPSUs3wNhpRgA0HU6X9+Hbyxjwc0D5CDG
         1Qqk2Ge3M6v4WWRvTc9OmBo1WOQIZIQ5u80ap13sVxA8cJQbT+uML/be9BusFq6uELrZ
         Ee906NOID8A0SxSPR8qApK8oc+M8SeGInMUnx11IG8Z4lAZQePOPTXgVJ+6mc5pV0Pfc
         B/zTfX60xXqvokA0Mza3RXj8rfZCdxPr8OhOo4aRfiaVLoerAIGYt93j4lDBRoHU50ze
         QjA4K+TCACmtYzWO715CmYqRPSdRjiDV90SBGFSpqPCL+Tke5vKTAn/ch2isfmuvtAVj
         tMZw==
X-Gm-Message-State: APjAAAU+wCxijYHC1zi80RgILXPMUtbquO5rMrt3rUPKohBevq9LrI0b
        SPe7vOfmn43CDZK9N3BKA7/35hf6uFL5eUL4BtdslA==
X-Google-Smtp-Source: APXvYqyif/FcVg31H4mCMrqc1tAv9+xfOMC4ku1jEbZz0D4MzKrvW2UuCa7rSztTlQQZp6E44d6wzwy8qjw4Fx0IG+w=
X-Received: by 2002:a6b:c389:: with SMTP id t131mr13745566iof.50.1574440057783;
 Fri, 22 Nov 2019 08:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20191115223356.27675-1-mathieu.poirier@linaro.org> <20191121203555.GC813260@kroah.com>
In-Reply-To: <20191121203555.GC813260@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 22 Nov 2019 09:27:26 -0700
Message-ID: <CANLsYkyumUDrP6ic0towr68S6pxL1psZHVP0XTRC+Tf82O4wQQ@mail.gmail.com>
Subject: Re: [stable 4.19+][PATCH 01/20] i2c: stm32f7: fix first byte to send
 in slave mode
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "# 4 . 7" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 at 13:35, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 15, 2019 at 03:33:37PM -0700, Mathieu Poirier wrote:
> > From: Fabrice Gasnier <fabrice.gasnier@st.com>
> >
> > commit 915da2b794ce4fc98b1acf64d64354f22a5e4931 upstream
>
> That commit is not in Linus's tree :(

:o(  Apologies for that - probably a copy/paste problem.

>
> I'll stop here.  Please check all of these and resend the whole thing.
>
> Also, does this series also apply fully to 5.3.y?

Normally it should have and that is what I assumed.  I just did a
quick test and I'm wrong - as you probably noticed since you're
pointing it out.  Forget the whole thing and I'll send another set (or
two).

>
> thanks,
>
> greg k-h
