Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AF330B79
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 11:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfEaJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 05:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfEaJ14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:27:56 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 487E6266D4;
        Fri, 31 May 2019 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559294875;
        bh=8ioYcrS5zNqXZCoF0MDDoNs+KB/u0y2k7wiOQtbqdwU=;
        h=From:Date:Subject:To:Cc:From;
        b=rRXvqsqSkMv+5uNcjorixP9OQ/A9sXvcIolEmFXXDeJ0CIPy1MWNSPlgFkijG/xDd
         JLwudD1WDqmIng8QTmERVwdvFX1+RZboJZoyqYg26krjFNoXZCPXrLfUr9vJmOeYBH
         jSzTqQJwf6ZuGH1Uu7nuHnO6o35ipNSPEYWqjxow=
Received: by mail-lf1-f51.google.com with SMTP id y13so7330007lfh.9;
        Fri, 31 May 2019 02:27:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUPKOt7Prp5M9llPrgw6JEfVNjMsnrX4cqY+ocuXmECW1F/toHx
        3gz+u+RniTMCBVlxB74hWWGgi11W6xgaG42E77Q=
X-Google-Smtp-Source: APXvYqzVa4BrT5sCgmPbiMdySvHjx9aAPSDvSfLEhbdMMAjEp6CKvWokGkyQ8IL4e6xxsMN20X6ZVSeWNFb5fs7EwqM=
X-Received: by 2002:a19:4f50:: with SMTP id a16mr4880904lfk.24.1559294873357;
 Fri, 31 May 2019 02:27:53 -0700 (PDT)
MIME-Version: 1.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 31 May 2019 11:27:42 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfREyt3P2H8bL9=6+EQ1S3Ja7Urkhy1x7sCHaaubMqV1Q@mail.gmail.com>
Message-ID: <CAJKOXPfREyt3P2H8bL9=6+EQ1S3Ja7Urkhy1x7sCHaaubMqV1Q@mail.gmail.com>
Subject: [BISECT] No audio after "ASoC: core: use component driver name as
 component name"
To:     Mark Brown <broonie@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bisect points to commit b19671d6caf1ac393681864d5d85dda9fa99a448
Author: Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed May 29 14:22:14 2019 +0800
    ASoC: core: use component driver name as component name

as a reason of failure of missing Audio card on Odroid XU3 board
(ARMv7, Exynos5422,
max98090 codec). Full kernel log:
https://krzk.eu/#/builders/1/builds/3349/steps/14/logs/serial0

The problem might be in component name. The driver->name and
fmt_single_name(dev, &component->id) are:
snd_dmaengine_pcm != 3830000.i2s
snd_dmaengine_pcm != 3830000.i2s-sec
samsung-i2s != 3830000.i2s

This commit should not go in without fixing the users of old
behavior... I could adjust the platform names for primary and
secondary links... but now it looks like two components will have the
same name.

Best regards,
Krzysztof
