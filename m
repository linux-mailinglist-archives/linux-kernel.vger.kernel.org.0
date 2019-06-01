Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5B32021
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 19:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfFAR3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jun 2019 13:29:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41417 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFAR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 13:29:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id 136so10427988lfa.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+lhiKAmeE59NvMLuLYA9mDmwdIPM7xWvOTprCB4K5Q=;
        b=P2Lovz6jt85k2SacSk9IXWWXKQbCYK/Jbf6S3FB7iwQ1VdaIYPiypMsD+ZS+fOxTmZ
         K/undTkLFsTc1p6uC9p3qblgqXRrB7fUYwB8UlZhsQK176ExeW6nb+n5zucpjMV1UXgu
         59bAV8+5M8kBrteqtcgtbmAzO0EA5NapZL/LJ4n39WSqdIAX5IdoR8dqbEwL4P+h489X
         QIen7LBC2YxbHmt2JZLn5Goctriz8VCJ1bXFfgyrund3AP/J8W09cj8ZtrIum9pVeqpd
         oPwqrN/tjjqneyoWuCZgTfI2l1IVBOd/j891nb7VGEaGddwNR6RuyZgsgzYffIFg+kLk
         jNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+lhiKAmeE59NvMLuLYA9mDmwdIPM7xWvOTprCB4K5Q=;
        b=IKysA+xNDihVZYSa7F7W9nQgtdWGbwjQCZnHNHYCi/PgWQH3SpUW6oAggATNRHMAn0
         XvcKqVGCKuawOLMTt/YruVW855Afd+tiUxTwFgIXbHhvx7ztKjLRTqSOpdx80MpuRAi4
         GZZHQwMoUFPBjqoNWuVQ36/NWHfRnOSdJfOjW5Se+o2j/c0Td4SBsUfxvW6wGqTpp+DH
         M0WEaYmIiQOUtU2yJX3BEA7N2bvj5eP/EF7kSjTjQoZ9bDmhVJdzx6rsRckxAY9p8cTO
         rkUevlQYFzhw8g0Es5hb4QGyKyhWgOadlERQLlOBJKzxq+6gAjyxtQWqB9g3phYyBjS8
         kEQQ==
X-Gm-Message-State: APjAAAU6Yr8hEV35k/I83noDoKHwIVk6qq6WZfpH/iTXWw0UVWbGENB+
        sLKDU14PeKmGw1tjL6vpAX6olR5jaj6oFNTEiMdIrQ==
X-Google-Smtp-Source: APXvYqyYQEUgAqogtrjonQ6oVdW+wtCspm5WWcklotqCUeF+9hIXl1Bf9pxpMm51V3Qrx1MdrbwxXg+ndHh52nZ+0jE=
X-Received: by 2002:ac2:429a:: with SMTP id m26mr8158279lfh.152.1559410173090;
 Sat, 01 Jun 2019 10:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190520144108.3787-1-narmstrong@baylibre.com> <20190520144108.3787-2-narmstrong@baylibre.com>
In-Reply-To: <20190520144108.3787-2-narmstrong@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 19:29:21 +0200
Message-ID: <CACRpkda8VpT8+aXTx2yzvRwO4xiCOntxB9hFBkq30SMDtPJUpw@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: meson: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:41 PM Neil Armstrong <narmstrong@baylibre.com> wrote:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Patch applied with Martin's review tag.

Yours,
Linus Walleij
