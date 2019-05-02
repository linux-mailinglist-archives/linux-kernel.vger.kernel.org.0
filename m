Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5A11A85
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2019 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfEBNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 09:52:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37397 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBNws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:52:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id b12so2263458lji.4;
        Thu, 02 May 2019 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5anwCJxZnrogG1HpaX5y6QTVoKVHb6NYl3V1OWC8Maw=;
        b=fZSaTxtUp9KZxUwqiulAv3Yf8e0/0Tk8FoqOybYS6zR3CxOOmSDfy0TNx+CGk4Eoch
         v1bVlaK+AAFJvqFsHux0G0CChokbiD1DMQXApebfeG3bEna9BB7jTs+NTPVBaTaXXqVH
         Kg7dyYsa/qzl21EcdbRGK5viwRJwQLI7e4+Vmb0zeO+PaGqJ5uUVpEKG+rqzHYIQ+ujL
         PV2Lzv2rg/TGcg/Aq37DYQgbmD1hOCK9lU8mcvBxG90juU/77zDTveC+nz7OIMNFbbSq
         QIQrKrZtqle2y6b3rLC5UqXFHhhZrZmQjvAid7C59nmKpVTddv6ESm8AZsk+kS75rKGR
         3fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5anwCJxZnrogG1HpaX5y6QTVoKVHb6NYl3V1OWC8Maw=;
        b=bC7PCgWg09wNgB2un8IiutHay7w2FUcmkk/vZKmzVXwO15XL8WIApH/igeVscqH8vl
         wGuCxf6viMspIr2X0j5rY78KDgR53etsdVjh7Gp8OXm0BczFAbyvrmhJUsKrsD4t6mEX
         gbiXafvNgK5Aq50o8pk3HN9HpKqtexGk2jD1Cpnpv7Kgv3B50NtBs8G/pXuw5GOmkgTs
         kDAGG8QJtyPS81HidWfOwGVnTUkyKDlX2uHF68bz0Kssujz1JOUu4jMVDEa3ehjDkLqm
         kGS1u8GE6mA3i/rtMgEu17USmSiDWBMw0mHAvAtjGb7Ccg7MncXSSeiSFotoN8yxRqlY
         7FpQ==
X-Gm-Message-State: APjAAAVJs8Cb8wVD+w5TT7syaasRLAUzYAF9TrCBG3rofpYd5kVM73Ff
        dcWZaF9JtVU+Gg0MM+XO+1+n19VsLQ5vZIVksf0=
X-Google-Smtp-Source: APXvYqwpy0wkkhhf9ipmjbRgmrEAJI6N5SaQzNQ2z75ilDtSMuEnGod5PWv+zB0VGlgyLHDHCTU+WJ1wY+nHifNPqTA=
X-Received: by 2002:a2e:a0c4:: with SMTP id f4mr2067329ljm.100.1556805166266;
 Thu, 02 May 2019 06:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <55a0abac1c2efc4921588ee87986da43af1eb35a.1556802190.git.agx@sigxcpu.org>
In-Reply-To: <55a0abac1c2efc4921588ee87986da43af1eb35a.1556802190.git.agx@sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 2 May 2019 10:52:40 -0300
Message-ID: <CAOMZO5B3GqJoGtN42OeukxVXEUxsDRPsgMGf1huKQ7xZFYedZQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: imx8mq: Add dsi_ipg_div
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 10:07 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
>
> It's defined in imx8mq-clock.h but wasn't assigned yet. It's used as
> clk_tx_esc in the nwl dsi host controller (i.MX8MQ RM, Rev. 0, 01/2018
> Sect. 13.5.3.7.4).
>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
