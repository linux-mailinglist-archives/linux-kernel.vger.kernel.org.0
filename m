Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F91A05A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 17:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfH1PFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 11:05:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37498 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfH1PFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:05:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id bj8so118520plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=C3VeIkBR2ygAogHj3dhdM+HYyIbqE6aDBH4PLuROOd0=;
        b=OsbnKMoHg1owahguO2xtv3lJ5V4/9VFMGgV7nRlrxP4kgR4TtFqEP4n2qnUVmhIIAv
         r8veXQCOlb2udN/G5FsG/GcWvH+Yw9X2E2aMBQyM9lGa05JCdS/KrWA8Ebl2ixMpWYOr
         VMIdQZArhVkUDF/5mnnCOQuGhw58MaPTZRrFT1u4AjWIdu2G9LAjX45b+cNrml+cWYv1
         C/kh2zcBb60Y0QJsAWzg6idP+femvZ/VCEAAjWqKGrAmqQvNhr60WEehcUsOXzC6p5qS
         vfBATKFGrMiCsE4WKEOc0RSEZ7DrhoeXmGs3t2tRTRFfDv1sI+s+7y7zjBNwX+HacH7O
         +fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=C3VeIkBR2ygAogHj3dhdM+HYyIbqE6aDBH4PLuROOd0=;
        b=GDywZKshPEIJrr916B3g37UT9Vs2YVSOhX0KNlIoOwUhPCDpPIJniPYBTcUX8f+lco
         wXhMsQskr4Wd5vNPpcx0cUbDZKYKUoh1OxgBfxaxNVAsfxMxgb+p8LC0/lUpWrnzQ4nZ
         6SzymlWdYvN5GCZ9jN0ukqDcU2JQtIc098jAPQf6r71r3V88jqV9vyDbUEdxUoVmEVtR
         joaCnd0YhmpTlk3AnwZZf4WskpK3Qo1YTxcFmn6rhEcp/makLvMRXpI8B3+2D0YfpxU1
         yfU/9H12sQDjW88ciOP0G9qiJJYKR55SA+19OKAOzPhoaoSkAus2xxUohzDwgM0ldjjZ
         GobQ==
X-Gm-Message-State: APjAAAWKQyQT7k6Rd1dmw/dKxx+SKQMImyz7EUOJsPZZKHsnsHxxSycL
        9l8YpPGSIJRpuyxJtYQwZMeFWA==
X-Google-Smtp-Source: APXvYqybSJSB+8bIOOrG6VdEt5w5z/wnugis+PgSbd/5o5Aviw0F4NGsXCWwydW5Qq6TnjRpwnWKdg==
X-Received: by 2002:a17:902:141:: with SMTP id 59mr4905309plb.324.1567004739473;
        Wed, 28 Aug 2019 08:05:39 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:cc35:e750:308e:47f])
        by smtp.gmail.com with ESMTPSA id q8sm9790381pje.2.2019.08.28.08.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 08:05:38 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ASoC: meson: axg-tdm-formatter: add g12a reset
In-Reply-To: <20190823154432.16268-1-jbrunet@baylibre.com>
References: <20190823154432.16268-1-jbrunet@baylibre.com>
Date:   Wed, 28 Aug 2019 08:05:38 -0700
Message-ID: <7hy2zds531.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> This patchset add the possibility to provide a reset to the tdm formatter.
> Such reset is available on the g12a SoC family and helps solve a random
> channel output shift when using more than one output lane.
>
> Changes since v1 [0]:
> - Rebased on kevin's tree

Queued for v5.4,

Thanks,

Kevin
