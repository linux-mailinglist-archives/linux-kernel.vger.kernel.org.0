Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19255CE3D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJGNh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 09:37:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37589 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJGNh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:37:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so9309549lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/tsF7GqCM65n3gcBquhTSl70JrQbVs1nlWYo3BS3GI=;
        b=iWkb0BzPuV7IBp4vSYBVFuZJO0FbJsRfAvgu2cO+P13uspqykRW3EEBZWo11MeamXz
         ctAHRKUZ4vWMN+r1/+L+eudNCtIt0p8c3q/jkvp1e8QTCOzy/2vxFTI/F/10++5sMo5H
         vcrMs9OOTaVZKSX7eihwviBkNmwCDV3V0WG4SunWolb/1XLRVu9xMv8DpGsye+/ZhPq2
         1ZDQTPrvDqX0SnWvwXiYLhKAyRG41aIw0Xmiq3UWfw3AVnchJBDXu98e0zoVqw2vvYpJ
         irHzwIK+KFOgBogovwiGJTh7rMGHWlalJbUq1OkoGp5IHZBkwFXfXGAr5qGeaWnwXUDE
         Ntvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/tsF7GqCM65n3gcBquhTSl70JrQbVs1nlWYo3BS3GI=;
        b=L3Gzw6f4JByHrpvMBn555dYD3DMDDThKFSDR38pApwFrTyF1TkpzrJG/0BhgJrYNm7
         sFVVV4853T69f1qCZxOZ8MjUMuKKt2NFiQ/O11rhhgHeDEw79zE4m/UqpsFalmj8z1CD
         HcJsryKra+QdpLSR8ebe0KB1jvlHGlYoiEMxYXuWFv1tAd1sWHrJinP+3USiMmh8CWnk
         yOecrw8mqMWfZyT0D38o4efw4rxEeowvHFMIT6kAaclG6B7H5iCzPUswFX+dK3+KQcbb
         fX4Y4el++qDRl42uDQpUMhJjqmTAf+o6X/geOUhJRzvFGtq8OmgC6iFDe5biOJ61cUCd
         G85A==
X-Gm-Message-State: APjAAAWSgz4n8nUvTDj49ZZ84Fqx+2c+t7JqvV2BeaOOa9l8/eRmiZCE
        2G25M2mRq9NUHFo7HUqSeGcC2wUBA5oN+aKgss1zSg==
X-Google-Smtp-Source: APXvYqzdlwluYUS9ghER2EH7kQEWGcyE9V00SPsQht/6sMe7rS52Rf3HzisNVBbF55cEvGYsIShCVyJG0pnChTGN6zk=
X-Received: by 2002:ac2:4289:: with SMTP id m9mr13110124lfh.139.1570455473793;
 Mon, 07 Oct 2019 06:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190911130314.29973-1-qperret@qperret.net> <1fab36a5-25cf-abd2-ee25-23d8c8d673ac@linaro.org>
In-Reply-To: <1fab36a5-25cf-abd2-ee25-23d8c8d673ac@linaro.org>
From:   Quentin Perret <qperret@google.com>
Date:   Mon, 7 Oct 2019 14:37:42 +0100
Message-ID: <CAPwzONkaUmZuw7W1w=D11G55DVmj8fxmLwZ4hEYGdGEJbpsqHg@mail.gmail.com>
Subject: Re: [PATCH RESEND v8 0/4] Make IPA use PM_EM
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Quentin Perret <qperret@qperret.net>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Oct 7, 2019 at 6:35 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> the series does no longer apply, do you think it is possible to give it
> a respin?

Right, I'll try to fix the conflicts and post a v9 shortly.

Thanks,
Quentin
