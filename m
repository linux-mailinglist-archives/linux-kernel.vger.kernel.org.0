Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 238D3132647
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 13:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgAGMgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 07:36:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44270 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGMgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:36:03 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so38707059lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 04:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEoORwEbsUG1Ph5wXGdlUAhRRrmp+B4iCncPMoayctA=;
        b=xDkHw1xoDyT1+NKE4FAkLZOcOipCNbmSuHLUXq6ZMzyhAKZj4lPa7kOVeCGAgloCkb
         RWuWt39XtVe0z8vGnakEPRQnc1bLL5UhOYqRQe2zB0txSM5iVA9aD6nD/GRae74CYPbN
         QZEFC1ydPS/zGiJUssgC4Oy3Jg+KI2dxrW33XAcz++CngbHnag3fWk1HRVfiXFuDK2WC
         uVCE1gv3rUmS3H+bHy+QBtu6j0z/eAG+uLCH8m6dlj+94rIrSJPFv2tUkanHspR987YU
         XmpcQPo1IP/GVKPBBrxxIQHSxfX8OmX4eBAGQ6xr3w0gr06skG4T0KS9ajnSLB73bO0x
         dLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEoORwEbsUG1Ph5wXGdlUAhRRrmp+B4iCncPMoayctA=;
        b=Iurf+HKgyoJhNL8pBMWfUSf2Ire+zmN6d7Gt1lbwFbuB1CuQwwFJ2JbDARnwdcDGhI
         A8dmHSaVCcassxddWY06p2Ww5dj0VkeeSzsNCJYlnsyosqQnr6DycuLa1qblPptlg5eB
         Gb7rrzCN7aoiN3AwREoUjSKoOa4Ibfs3C28vPk4I0vqGolmjIhDG2JuehuE/xWlDy85f
         sBSZ/tqLXdnBS9kLfOu7Ecw/3YOwjaqg7oif9GnXpR+whXvxiJjvlI+U32ZhpmGfoNqB
         oOrsoAd0KF0iJQwkuBrslBrur30TinRw0UFkzuWVTwq+u3hVFgXAzXZ8UA6ZS4EnvbGL
         0rQQ==
X-Gm-Message-State: APjAAAVnXkprQUStAbIpmTpFzSUuTifOl7Tl6tPT34zSV2Ya/l1gqqzA
        KDFYZqu3lxcGyIjauzKEXajzbTf8JTrOeRUcHVBLmg==
X-Google-Smtp-Source: APXvYqzQqj/JBGr6OJKJAmXaRApKrKP4NLNTitBufrrGzAHgS1IC+s4VGVolDF8FaQakj9vICEx/+KMnmbO4wDB8q/E=
X-Received: by 2002:a19:2389:: with SMTP id j131mr56980841lfj.86.1578400561366;
 Tue, 07 Jan 2020 04:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20200106232711.559727-1-paul@crapouillou.net>
In-Reply-To: <20200106232711.559727-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 13:35:50 +0100
Message-ID: <CACRpkdYo0dniDAq12WG=KWmJPjnuYEtDn=pvHRoRGRhzQUX58w@mail.gmail.com>
Subject: Re: [PATCH 0/5] pinctrl: ingenic: cleanups
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     =?UTF-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>, od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 12:27 AM Paul Cercueil <paul@crapouillou.net> wrote:

> I saw you merged Zhou's patchset, here are some cleanup patches for
> pinctrl-ingenic that should be applied on top of his commits.

All five patches applied!

Zhou can you test the result? I am pushing the devel branch
out and as soon as it builds cleanly I will push it for-next.

Yours,
Linus Walleij
