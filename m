Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB3184F36
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 20:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgCMTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 15:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgCMTTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:19:33 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A58DA206B1;
        Fri, 13 Mar 2020 19:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584127172;
        bh=u/YdNrWdkp2l2Y+ZcshY5dnTxoc3Q36CBOYuokFz5v8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u+Kw50OjBbzrHYAElZpjew80DqhAXUFN1hhXU4vU2wOdVt9P/NVjtrQZvvT9p5Zxb
         veAw/oyz4V2n1HuuwuSFUsJ4mdNMKpwRfyRlEkUiBzo9sw5efnqpHqcGt/dxu3cF9o
         siomM+1AaZ7PYOoyNUKJrPfQx7TrpedbDUAn+hUw=
Received: by mail-qt1-f181.google.com with SMTP id l21so8508603qtr.8;
        Fri, 13 Mar 2020 12:19:32 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2/CMu7JqQG1/jF6jB3lqQ+2or0oq99OPiTsvW0YfsMyF9GaLJJ
        7i7KIt7Ut7/VUpKqS8IilQ45qqNqJyzJ1nVR9g==
X-Google-Smtp-Source: ADFU+vtzFniWDb7ap1vMQkeG/nhau8hPIsmJMnWM+RrFZ7uXGaIVa3RBdSZj2jLCJWmfgdvozj/TJtkIM+Qo4xGK3lk=
X-Received: by 2002:ac8:554a:: with SMTP id o10mr14380809qtr.224.1584127171827;
 Fri, 13 Mar 2020 12:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200313180543.20497-1-robh@kernel.org> <20200313185555.GM5528@sirena.org.uk>
In-Reply-To: <20200313185555.GM5528@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Mar 2020 14:19:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pihBa4NCYQJrVnNiRgJzx_Q7f5zDTExud0y0tPXwWNw@mail.gmail.com>
Message-ID: <CAL_Jsq+pihBa4NCYQJrVnNiRgJzx_Q7f5zDTExud0y0tPXwWNw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: google,cros-ec-codec: Fix dtc
 warnings in example
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 1:55 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Mar 13, 2020 at 01:05:43PM -0500, Rob Herring wrote:
> > Extra dtc warnings (roughly what W=1 enables) are now enabled by default
> > when building the binding examples. These were fixed treewide in
> > 5.6-rc5, but the newly added google,cros-ec-codec schema adds some new
> > warnings:
>
> v1 got applied, could you send an incremental diff please?

Indeed, missed that. While I wish Gmail could just learn to thread
emails properly, it would help Gmail users a lot if you kept the
$subject on your applied emails.

I'll just worry about the node name again when and if we start checking that...

Rob
