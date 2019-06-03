Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E361F326C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 04:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfFCCsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jun 2019 22:48:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42796 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFCCsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 22:48:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so3561119lje.9;
        Sun, 02 Jun 2019 19:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C39z48dT4cw82rVIn1K+CbAu/jegU5y+sxR7gF6uO+I=;
        b=urIYmDURC0bvf3Ucz7YsBrIWg5eMQIponz+Pxkb/eV9piukxxId/2OWfuKkGH2hkKA
         r/VBNM5WVI0OxTtlbhbO/t6rspN3eb76pxRhHICiMxRIEdmOfi8nQTfK7ZUULWFw7oaL
         75wnDH3wxFSfm4QBfscKXjAFxysb/VPBhZZNpO6L1n1vksX785ldOR+Zrb6fGut2XLXt
         wuwkWKdeydqT6p5WHeBWdNZU++DQ7hDfsu1eNo/0GCJQpRqh0dhSfeBDvLooE/AnyQng
         8vVN5PIwQt0+Cqq1VTKYAqG5miD8XWcHXi3E8BMCPqwukUqGJ+ccUaVwXDm8pN/Wt1LI
         Xwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C39z48dT4cw82rVIn1K+CbAu/jegU5y+sxR7gF6uO+I=;
        b=TdOgFk6CPsPTuL6YgvM4gI8J9auhSU+W8QDfsZTXBwI1me4c17ZScO6RPPs/1hy0Q5
         dwyuMLeTP7HN1vz6JT6mZYgcEvbUnZBslou2ovlRkU3g5IloNzdfmokgOe+208ZyOUls
         tpr+R9sCGIet26OVaU4zF2RXqbOWLArJwZA3X9W34Fi4qyMW0T1Cxxt2lZM7eZ+d/qnN
         tzdlRbF7BSZYwYdonV1Ng3A+OfQCC2JwGpdUKDeX4cjrCfLDgYc3UGDssXY689PA/Dz9
         vM9xqoGbRz11XrX7tn+HAau+soXX/Ovnunn/RrlojHPDUxV6ooX1PVqTaPWtim/gZc1H
         KNUA==
X-Gm-Message-State: APjAAAWW16j+IEKJ7qJUu/bky1NL/ARF4GzvY28OuyMp5zoYgwjwMI7m
        TgdZQ9zZeTWgHHh+4MevNH2oDbTXmlnuPzGdOJo=
X-Google-Smtp-Source: APXvYqxAyGdiaZ+w+cYB8umtQAviM0JQI2N2QJGsGxd55Saz01+W66hBjgtHwFxEDz5PS3hi/3bkmn3WhI8AIMTuC/U=
X-Received: by 2002:a2e:9185:: with SMTP id f5mr9457522ljg.51.1559530115662;
 Sun, 02 Jun 2019 19:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190603004820.36247-1-Anson.Huang@nxp.com>
In-Reply-To: <20190603004820.36247-1-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 2 Jun 2019 23:48:33 -0300
Message-ID: <CAOMZO5B_1HTg6i2Aybv1Hdm4jXg=1R7FRbOnkAXjjG0mk3RZ=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Fix build warnings
To:     Yongcai Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Ping Bai <ping.bai@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Sun, Jun 2, 2019 at 9:46 PM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> This patch fixes below build warning with "W=1":

I have already sent patches to fix these warnings.
