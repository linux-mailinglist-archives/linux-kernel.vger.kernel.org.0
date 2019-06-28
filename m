Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7559390
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 07:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfF1Fmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 01:42:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36186 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1Fmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:42:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so7695341wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 22:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUmauarPYj2SQlusGyMDBTJmU8hMPlbsUq3l5nJNX88=;
        b=TDTzYlFnKgzjZQ9gI/SNj822C1vpURAvVYRfwCO6x+WFL/tArkz9HkDgem1AmYnkN8
         VkOc2wFbtDh/vBJJxiNcP+GdkZpfce+UmJ6f6jRmHr/kcx/Rf+wFodmSgMl1qD6qa4SS
         KfjhEScvVvScxqLgPnnfnMgp+1muYMviMKyoY/YtdYrTiso0lZQU5FRsJHhE8UntwGQl
         aT6uTm7KoIY09VX4nVRnOC1u09cp0uwWIeJH38WL3ZBIS0zIuDXc4/spAKm2EkmoQHZx
         62c7yUbNJVk2C5XNjnyYTOnuukHTrvVwUGft7ACLwKsZe+smc//GrsoTSQ/U8kIfjX5R
         ZSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUmauarPYj2SQlusGyMDBTJmU8hMPlbsUq3l5nJNX88=;
        b=iL0irEQRrA2TzaqbuWy4sTBH+sUT6A9moVzxVytWXEm56hJFTmDp36B38CwCqaKkNV
         PD5IDTts2O5wy9sPRWhf2KtVONB81QAUXmyJaB6Jja+WX/Pu+7Ma5UujWVdIqjZHoXn0
         l5erbmyOR80xahAZ0WZBOk7TviGjdEtVW1pYVgAFGP4uEwZHmniCckK3+xFftgeePh7P
         ToZGBMCMPP1Hp2SSuKMV05uS/TQ7SdNwMKrA6d28X4pFsPWEDfv51exeQBQkkBaKNS6i
         nvnPiqJRb3/qGtNCj5MryZnE1XpwiETMxn34Q62gGyHkdhEo+OURaXGrV4JbHPHKmwX4
         cxEg==
X-Gm-Message-State: APjAAAWPtyPP9wrKvBBUXYhk2U9UCjhgcg7kDYK4kh75jaBC2ACMIwgv
        mQpY3k1RAQbYNPL3rwJTA5Uso+8P5xT5eDYsSS8=
X-Google-Smtp-Source: APXvYqwAOqZmkppeFcMiIoFt4MysbFWIxUza8rc+k5ahTj8SHHHqKDGGqzwqY8kpvHG18Av+CAe4jlnYhZGZ4p0Z0Ng=
X-Received: by 2002:a7b:c247:: with SMTP id b7mr6041397wmj.13.1561700571802;
 Thu, 27 Jun 2019 22:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190628032544.8317-1-Anson.Huang@nxp.com>
In-Reply-To: <20190628032544.8317-1-Anson.Huang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 28 Jun 2019 08:42:40 +0300
Message-ID: <CAEnQRZDgbgmKXaLNVoe0N5e_voGkC45gqp0bUjPJsSh4CXOc+w@mail.gmail.com>
Subject: Re: [PATCH V2] soc: imx-scu: Add SoC UID(unique identifier) support
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 6:36 AM <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Add i.MX SCU SoC's UID(unique identifier) support, user
> can read it from sysfs:
>
> root@imx8qxpmek:~# cat /sys/devices/soc0/soc_uid
> 7B64280B57AC1898
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
