Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 656BBC8D29
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfJBPoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 11:44:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40388 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfJBPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:44:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id f7so26936404qtq.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAIJJR+PL4OsNdtu93o9d73AsK7qCRhCtZmm3iIWByY=;
        b=Pq8zTMyY9e1Avy+pakQEJkBbN0zDRB2PeRgCkhRQPD+YgCLgRfhpCGIYOpuIjAbBhO
         V4/Wb841Xi4MpECyI3WNOhbMS5LKCWTh5Q89Fs5TArexkMqqbXELRSQrMK51WwEc2hjz
         Dx2YmSMA6vh3qMvQFAjzCsqC8VKcZqB3bLEVQdWTOND2VROBkRCoze1y1aLWgk7Bar34
         p0RFVjDhQTobKjDWVJLrl1DOaEYc2OLNfe8VIyYiPMGH8fqcQmu24EdCGC/JByDm/lYc
         Bx6MVK0FffNqttnAkz+paC167LUSRt2HQ6Hk1Va20+cSX3htTnrFsdCknG9yd7Ha/wST
         iWJw==
X-Gm-Message-State: APjAAAWCFnt3gX3C5r+TwqJ+C3f7FqGCwKjwiNntEE8lEzUVm8ZtvdnC
        kQco1b6gNnRbmSeiVxt+uKBsOa9CH/xfpcYcUQmlJw/vP0g=
X-Google-Smtp-Source: APXvYqzii929WbfPX4FXMBdzp6fHaCuSvuYADEJeFoQAbPJxlc9m57ZW9U3VSq5G4WPzsRBt662/ck/bbKCvC8XlN6I=
X-Received: by 2002:ac8:4a01:: with SMTP id x1mr4717582qtq.304.1570031041123;
 Wed, 02 Oct 2019 08:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <1569945867-82243-1-git-send-email-john.garry@huawei.com> <1569945867-82243-4-git-send-email-john.garry@huawei.com>
In-Reply-To: <1569945867-82243-4-git-send-email-john.garry@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Oct 2019 17:43:45 +0200
Message-ID: <CAK8P3a1rAKF2k0iuPirF+_La_VEmEbQ+D0XAfdcy=6K-Q1fu9g@mail.gmail.com>
Subject: Re: [PATCH 3/3] bus: hisi_lpc: Expand build test coverage
To:     John Garry <john.garry@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 6:07 PM John Garry <john.garry@huawei.com> wrote:
>
> Currently the driver will only ever be built for ARM64 because it selects
> CONFIG_INDIRECT_PIO, which itself depends on ARM64.
>
> Expand build test coverage for the driver to other architectures by only
> selecting CONFIG_INDIRECT_PIO for ARM64, when we really want it.
>
> Signed-off-by: John Garry <john.garry@huawei.com>

Good idea, but doesn't this cause a link failure against
logic_pio_register_range() when INDIRECT_PIO is disabled?

      Arnd
