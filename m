Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F19661B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 00:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfGKW1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 18:27:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34776 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfGKW1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:27:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id b29so5137655lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8EpXie+ptmasVVNdO8s7zWM0edWI+2s7AgvaLi9GlkM=;
        b=AchHtqaoZUJyesaLgpDv5jgEPOgym/QoazHvg2D8ktNHn0YGKOl1SymrQeoIlsdS4O
         xEpD8sp181zYoV3+9XKNaeRqflFVPpanXlK9/k5ZGp/P8u3USwHYx841H8aVaW1RS8Et
         64istFrP3hmxKs7rTJCuBLgjzCmF5myPsmmSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8EpXie+ptmasVVNdO8s7zWM0edWI+2s7AgvaLi9GlkM=;
        b=btbd6TJH+WEoAjSAsRTCXmCPVuRaQJ+KGBa4TDTgtal6jdncZbGgViZxAt14Bw2MZE
         Td2rrWI1YgxzYnzm2Kj80MWwUwzB+LNivIOvZtHmk7KB/F7LhkCcjewJFGyXvbkuZl5O
         0XDZ1LMnc1uFC0Y/hjyzbJ/sqR92cdhbgHipdxzT41PWTimjLp6x7JeIvJtwzGroyOvN
         C7L1ivzk6wrm7GRd11hZ1tTneXdErUjwhrRkgH2GOf/wW9dj+E9fH86l6vEB4YVoCMA9
         puqARdFDQJrwWfT2ChGm+TDqeMeywnBe9cMcBagWoMa63zh5w0brwltw0pZiJwTsbWL4
         O9mg==
X-Gm-Message-State: APjAAAXNin1RV8+771HSqr//phZr9KzH1a1LDiaTn5fd4kVEOsJTqym6
        yTkwmYDihajAs7AolVdDTRKm4Be9hbI=
X-Google-Smtp-Source: APXvYqziF4WmTU6tFKS8+sVLJxc+ykYTpJptJaosoqa3+iGMHkLG8oQcFxTdpW5mPxCQn5Y9EYJiTw==
X-Received: by 2002:ac2:46d5:: with SMTP id p21mr2941617lfo.133.1562884028537;
        Thu, 11 Jul 2019 15:27:08 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 72sm1164767ljj.104.2019.07.11.15.27.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 15:27:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v24so7374183ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 15:27:07 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr3907527ljj.165.1562884027307;
 Thu, 11 Jul 2019 15:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <1562696588-26554-1-git-send-email-linux@roeck-us.net> <20190711221948.GA16140@roeck-us.net>
In-Reply-To: <20190711221948.GA16140@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jul 2019 15:26:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4B5D2nd66iqCTzbY9bhtDn3WxpZCNc4hM9zOL+iJGBQ@mail.gmail.com>
Message-ID: <CAHk-=wh4B5D2nd66iqCTzbY9bhtDn3WxpZCNc4hM9zOL+iJGBQ@mail.gmail.com>
Subject: Re: [GIT PULL] hwmon updates for hwmon-for-v5.3
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 3:19 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> I have been sending out those odd messages ever since v5.1 because
> my script was checking for v4.x, not for v5.x. Oh well.
> Should I resend with better subject and text ?

I nbever even noticed any oddity.

As long as I see "git" and "pull" in an email that is directed to me,
it gets caught in my filter for pull requests. The rest is gravy,
although I'll complain if it doesn't have the expected diffstat and
explanation for my merge commit message.

The "for hwmon-for-v5.3" instead of just "for 5.3" difference I didn't
even notice before you just pointed it out.

And I've actually already merged your pull request., it just hasn't
been pushed out yet. It was just delayed by (a) my normal "merge
similar subjects together as batches" and then by (b) the 24-hour
merge hiatus as I was fighting my machines not booting due to a couple
of independent bugs this merge window that just happened to hit me.

                Linus
