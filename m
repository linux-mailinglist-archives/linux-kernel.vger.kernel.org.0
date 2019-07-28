Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924BC7820E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 00:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfG1WWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 18:22:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39522 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfG1WWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:22:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id v85so40638554lfa.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mk7OXDT+kyhl11Xs5+A7Dfh2TrPQ+FPHs/EPPvVwBk8=;
        b=cYvUW+CxDim7JdtD71ldQzsj/MU4rTmgFudsug6RVeGvizAVIqyJhFaDq0dLuIb71A
         oQZb+eQ+BZDClN9NIqbEyqeUJQhy73o/bJt89lagppTaQJPiu+MBINpKKCcMRllQZ74B
         hejFCugU0VDAOVKDH5SiI3u9sIE0IYzAKRZCPVvviMkiMLKNjLkJPapEB+GkxjnTjFVK
         kvWn72QcLhP4cogDbONo6xFRpoMjr70SNGT19uuxqzVGTM33O1mB6EVVU0mDVCfsxv/D
         7fYUFZTuQFV86fsHYsbDqUuAVJVQsgJAtEMhluKvtEOBSCGAnUDXfrkN9fdOHaBevVOr
         l7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mk7OXDT+kyhl11Xs5+A7Dfh2TrPQ+FPHs/EPPvVwBk8=;
        b=BkcAPrbDIgNHWyQYYX5tqwHleC1UkAj9+k8JyF1uTI6gvy7XwRZpUyZpwOVPmwUtP1
         pzxjTpKlms4EfV4a54NK8HH9mEVb9NAHhDrO69lq3Qix+RNd18QnTKp5XLjchgwOtXyw
         I+9Wq+9Kz8aXkUBq912cS7ocPxPCK0OMHYLkcjmD4UkpyV8bxxvEVk0v07m/ZXKtmwax
         wH9jfOm9610lxOdq7GOXSh94l+ZJkdaPOf1Iz69ve92mD7d3PNT+7+ErPi1hmbfejuy8
         3VRcWji0vngzodlmh13w9WpI9WlPRj/rz54cOQuQkhaV9+914GZV5GDRLM5leHkqwcky
         wVmQ==
X-Gm-Message-State: APjAAAUiikT35pRvNmeuXjxHjjT+/Jj3Qzv8WZUwuk3AgDzhx3Kel0eP
        zKvll6kYH47/jz7X8DYoftBdc3eBDjhd76vkLnnCUg==
X-Google-Smtp-Source: APXvYqyNTybbZVFPcp+YYlaKBlY6BVX7hbBoWTvMJUU6+xXNYT4nQVY4YRLaNcR6227l1Uhx28wW1S2+EfHEIlaPABY=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr39357845lfp.61.1564352551209;
 Sun, 28 Jul 2019 15:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190706164722.18766-1-gregkh@linuxfoundation.org> <20190706164722.18766-2-gregkh@linuxfoundation.org>
In-Reply-To: <20190706164722.18766-2-gregkh@linuxfoundation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:22:19 +0200
Message-ID: <CACRpkdbBXoTywAXb-18LJkTFayLgdRhrxEq0DoJxpCkn=Etupw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mfd: ab8500: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 6:48 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
