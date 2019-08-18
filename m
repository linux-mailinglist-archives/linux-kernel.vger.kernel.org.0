Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9E919EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 00:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfHRWVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Aug 2019 18:21:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41263 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfHRWVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 18:21:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id m24so9718361ljg.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4N7EQSOmGj3kmcTNPKFw2gJI2T24TmEUzwOY9YGFTVM=;
        b=TD2+3+1CBIjNRgLZwww8Qq1LkU6sL6SugbzUz9h75QIzYAWD2xhMDuC0So6puRH8K/
         iApu6xW3d/+oN6p/QIPV23VeNNe/mecvBVOJMEuOHE7gZyJFq2/RZrDODrJWG7UmxggJ
         GDNNpMvgBHiYo3kNf4l9NRdnpmfuDrMqkq76t+AGMW5fbt3aO/vCPtfGQvAZ/MnjAsUX
         0yZHcS/5ZsDYU+RGiZNOWT1lXWItU6r8HxgJVqpswqhfQY3PtUSlPgl+007u22HBBLYJ
         843UiEnSTVPsCiZJ2wIlxQMVx12hy+5yUryslha16M6jZgkJ3VchfVa9xPJWa5mETfq7
         l+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4N7EQSOmGj3kmcTNPKFw2gJI2T24TmEUzwOY9YGFTVM=;
        b=CdNdu5KJKvGYclCqv5a+0/QeJDvNoZYVCj7FnW5e5Dtv9lX83bFGzGQIa7JFqdbg94
         u+halYS1XS2awekxo1WOWKfNkbIykDD0AY+8lZrQCNAyNcs9rjYWmM8AR9qsVXG5GqMA
         axxQINNuIQasfBL7XgEp6vbngx8a/S/kWe1ZEBdwO8Ug80Hs4qzo+q9gxrWsvL9yebE8
         xM+GpIh48wGSTRXPU/QzIxl5IKcq+EgV5atsCSNhJrirdgwQWYg5wGazHBz1jWDnRBbD
         ChG9LiCg9cZ5kzzJhAFwuP0NG/TTM02IGLcW6U7bvVK0ooJhrE77yQQOXPpXDaL1ZiZP
         sbWA==
X-Gm-Message-State: APjAAAWVT+8VWYAiPOoURN812DdePpKXph8/AxUENVB87xdyR4PWZwWT
        oz3StD3OtyOpm/H/K8UVN5OI9rVy1BByV38QQqckAg==
X-Google-Smtp-Source: APXvYqygo5u9eGNktFx7NI+0t+FrzDYrgrxjIyb5vohICZ2YZlXEyO7G1boHyXHcMYWVxQvpQ9j4dnY7P4p+0WVk2wo=
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr11157494lja.180.1566166865940;
 Sun, 18 Aug 2019 15:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com> <1565984527-5272-3-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1565984527-5272-3-git-send-email-skomatineni@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Aug 2019 00:20:54 +0200
Message-ID: <CACRpkda7CTUevWogRo9FQQOBZfO4hQqt-1fGYpAiGJTm-sE_Xw@mail.gmail.com>
Subject: Re: [PATCH v9 02/22] pinctrl: tegra: Flush pinctrl writes during resume
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jckuo@nvidia.com, Joseph Lo <josephl@nvidia.com>, talho@nvidia.com,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>, spatra@nvidia.com,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 9:42 PM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:

> This patch adds pinctrl register read to flush all the prior pinctrl
> writes and then adds barrier for pinctrl register read to complete
> during resume to make sure all pinctrl changes are effective.
>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Patch applied.

Yours,
Linus Walleij
