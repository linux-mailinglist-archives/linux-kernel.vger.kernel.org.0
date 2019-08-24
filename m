Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86279BF41
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfHXSW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 14:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfHXSW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:22:58 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0392146E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566670977;
        bh=wwn25KAtlhTVxUgyGHWFSw8XC0EUfcLAQ3jg1KljjlI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LKTcsNkvPNCSKUIZC0u3jRO2pc4WgqFHrfUPdBW0QAFFJp0l225WURQDltf19B32Q
         xkNmanmdoK64D6CIqSMpghEpuJ+dkfBoE8voNMLtaZ7B2wamJN0dy/GcAW8Lyf1A+n
         b3DSsG9QO/n12nUT5H1TgcQ2kPw9+/xCeo4GYsbs=
Received: by mail-yb1-f175.google.com with SMTP id y21so5460072ybi.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2019 11:22:57 -0700 (PDT)
X-Gm-Message-State: APjAAAUXLkmXgVadzhA5K96cOKjHxbPONmQaHYiRliiI+80i/Py8qPHn
        6eOktoxmdCGUseg1vwn7a1PcCVYDitV+Q+g/ZMo=
X-Google-Smtp-Source: APXvYqxjxYuDkT7G2sfsbtYdGdTut3HUbxdvhgcLlUhp9PLXvtGkuWRbFcM9/bJA4qrQOyr2eHTzdHwpbuoGt5FhJzE=
X-Received: by 2002:a25:587:: with SMTP id 129mr8070270ybf.121.1566670976521;
 Sat, 24 Aug 2019 11:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190822213503.14726-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190822213503.14726-1-alexandre.belloni@bootlin.com>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Sat, 24 Aug 2019 20:22:39 +0200
X-Gmail-Original-Message-ID: <CAJBJ56JQ1P9zpT6EadPgAxrauSS3fp8TqYmv=VkVvUvD1fLirg@mail.gmail.com>
Message-ID: <CAJBJ56JQ1P9zpT6EadPgAxrauSS3fp8TqYmv=VkVvUvD1fLirg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: pbab01: correct rtc vendor
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:35 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> The rtc8564 is made by Epson but is similar to the NXP pcf8563. Use the
> correct vendor name.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Please use my kernel.org mailbox <shawnguo@kernel.org> for future patches.

Applied, thanks.
