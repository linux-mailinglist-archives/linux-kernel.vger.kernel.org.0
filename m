Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D914C923C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfJBTYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 15:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbfJBTYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:24:06 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E141320700;
        Wed,  2 Oct 2019 19:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570044246;
        bh=4KN8mw5OkOZG4azye45pfCg+zyQF1plk3QKhG9zv1zM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2v8/b6OqVB7q6cRONsZ3V7FAMMA2oKqG8FdYPUyjOEE29unNBYwBw2kMd/Gp2U3FO
         cuCNC0PZQU3NprFtkBROKQhGacLPfTph3VXuKukb+5HK60qW8M4F2hFvSszmACMPT0
         lzF7Ep8MHjXkVVghjmbbdzv1cbCVFG++CIwysq8Y=
Received: by mail-qt1-f175.google.com with SMTP id l3so187291qtr.4;
        Wed, 02 Oct 2019 12:24:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWpIfsPIBtH5rTIenoFWDn6E4nKh9fKd2GSlU7tVe3r4p9JHvAZ
        05TtBGMowm7A1jG2U3WKpFBqLroVJMXVZa5xGQ==
X-Google-Smtp-Source: APXvYqxxSU7e89h5RP2NWmFdzhzsPpVxVV4qxhSgYTVTBBrzAur51fKRh4tdEiuPT/2GupMJmupLJCpjJNLu6fYK0CI=
X-Received: by 2002:ac8:75c7:: with SMTP id z7mr5951998qtq.136.1570044245108;
 Wed, 02 Oct 2019 12:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <1568875145-2864-1-git-send-email-pragnesh.patel@sifive.com> <20191001114059.6B0572742A30@ypsilon.sirena.org.uk>
In-Reply-To: <20191001114059.6B0572742A30@ypsilon.sirena.org.uk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 2 Oct 2019 14:23:54 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+FDrBQc8nZxDt50ONuDF_UZ4Hr=OOsTgKC2MsHBtHyqg@mail.gmail.com>
Message-ID: <CAL_Jsq+FDrBQc8nZxDt50ONuDF_UZ4Hr=OOsTgKC2MsHBtHyqg@mail.gmail.com>
Subject: Re: Applied "fixed-regulator: dt-bindings: Fixed building error for
 compatible property" to the regulator tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 6:41 AM Mark Brown <broonie@kernel.org> wrote:
>
> The patch
>
>    fixed-regulator: dt-bindings: Fixed building error for compatible property
>
> has been applied to the regulator tree at
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

This needs to go into 5.4 fixes.

Rob
