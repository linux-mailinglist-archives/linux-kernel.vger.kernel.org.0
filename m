Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3A182E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgCLKqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 06:46:06 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37987 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:46:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id k26so3363697vso.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N5Ico3C325Jzu9GMlkuRSJ6WG8mBeI+uKqt4Ftv2/+E=;
        b=CVlRH3u5pxFhJo7LphUB6sCSb5/JtxxkvrApzEyOf8KUqKqlnoom9WTV491prc1koN
         CK7FhZCokP5SAn70UhOFimOihssB2VkgsjbMlZW9aNRYQN9hQn10LW92gITMTTkwn6or
         9erlg489gPljGfK4AOIcJDvUFWSKyTwWBljFMlzLlBvL0IQuHwnpTRESRgWMxnw2GXv8
         CrhpaiIRf1d4hJ+Fq4C5EPNVpuSuvN7dP6oIWI1Gyic+5FfO4TbOJez8MZ3szLJPUFFa
         h4mupStGIWHsDWXMVmK8zV2VRV/7afnqQJPDFmUc8J65+xeJmOkPKvumXx34CTPcR4DM
         3NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N5Ico3C325Jzu9GMlkuRSJ6WG8mBeI+uKqt4Ftv2/+E=;
        b=aFUiMtiecjARY/IyM+BAo7QHg/DdR+QXhJg6KkjdpRt1lX79G6YxFyJus4fFvWsGOw
         cP8347qYXc/oY0698MkDVLxU5mXPOiVp4nTNhXgG/MJ/uzvJ43FBbV5onueoFvVTsmwx
         NwAYyu5l63SILKCAlBHsHz+ZKJVa8AK5Gbm7FXcGzWrSM7P/u+/1S6+r2SeodoR/9pht
         nzfI5q6Dn32uNsHkhC/+0329LCgJ64PNdCD8LoH/kpTJfnNm+wfk5oZceMUGdww2EKop
         2B1gSvlpCo06zh+IsPo8X5chLIXd7TWsz+UL66yP8xfGatYZF/60zTZOBLKTSRPBH9eX
         OTEA==
X-Gm-Message-State: ANhLgQ2EytphHL/N//E3KBGRMvoaVW196ZCcvEZJxbB69rSQshTob7zO
        uaUMTgxt/qcVdsRLRRpLIbEp7CFddw290RzYuae1KQ==
X-Google-Smtp-Source: ADFU+vsgyuIiYgrQcK5GqD6i8p5v5NrSmSlYOaVuy0jz1OpUXHvnWHmyBVSNun22jeADPYYRX9B+IOGkpHggETCQUeE=
X-Received: by 2002:a67:7f04:: with SMTP id a4mr4891507vsd.57.1584009963273;
 Thu, 12 Mar 2020 03:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200308214230.15193-1-j.neuschaefer@gmx.net>
In-Reply-To: <20200308214230.15193-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Mar 2020 11:45:52 +0100
Message-ID: <CACRpkdZuSvojs6i9QTsL4xUd4Xd_YYiuZBBptMYQCwLSUgJ7Ww@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: at91: Fix a typo ("descibe")
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 8, 2020 at 10:42 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Patch applied with Ludovic's ACK.

Yours,
Linus Walleij
