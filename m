Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6BC20EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 20:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfEPSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 14:33:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45042 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPSdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:33:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id n134so3380845lfn.11;
        Thu, 16 May 2019 11:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+UOIQsK9fdttsJTvXZlnEG7LtoiIYogaWMmnhqc+ok=;
        b=X+NsxmTuP+wmtl7CIf+6brQUbRvm+YTEx6xdwkGhDK4KdncaLrOWHFtjDdCFzfBMD2
         Hcj6tKow81vKPvXKlMSaz2SK+bXMwjPhn6cFD/Y4ex4we1aJNxSYPqxqa2W2lFWPH9Jv
         RTIpvkjjTj0DIebp6ewtE8VrW+N0VdnBrJ9l2l+AyHkjRoHdGZ+JmNmCTW/OvWIsiivV
         syCgauDHV33Tj/i02gJKO4lhE2g7nfiJKwKfVlUzUtxrWJqLDxeoaRcFmSi+ts6elJCA
         ZVA1Z259n5dDcSUfGsMa4ON28CMNjFXk3tr1yw47tAH5TSRZ9yhSmcxGQzaB4V6mtJpA
         Ntmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+UOIQsK9fdttsJTvXZlnEG7LtoiIYogaWMmnhqc+ok=;
        b=NSuaqG+CxtjnwMb9mQFiDpL1dJ4GSLGW7kw/3Czx/Z4AHXBVHVzgHoyyOLzXKLa7hS
         w4a8iJ3ysHFEn2xtNlfT/uHbd7t5tOwoE4CxerK6ZXNKk78WxcmVDe418xeYc+mL/DEu
         FMvJD4+CP0zts9SSnI04tbSJNN3r/IvmpIRCN7U4aeKwbMoFzK3rECpHbs3bGfo2Qo2w
         aDvsFhaSb4bGx/Y48PA85f6U8TYwlO99vtJ5GlfiLk3RavMpn3bXzYzXKxtNNNXespok
         FQDrya+lIVSQalv8L7KehdpToYJzmf1d2+9ddI6lTAFfeWyMO+yecHzFVq6rMBpK/qhY
         Hg0w==
X-Gm-Message-State: APjAAAWGpsYUc51wDY8I7+OY2yeu+QO3iATsgWT/5Ht+qFW0TdIc0bcC
        1sKl3YTlanLeIuUYcfE6cfKBsgZ9t1OISqdaGGA=
X-Google-Smtp-Source: APXvYqwi2VC0mkED0PDqmCKfRnKlbR1V2ivKuFx74kxGlmBApi18n5RaG1NyaW1xGZ3QiEE3xA12ExoZOAA2iJlblQE=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr26223764lff.27.1558031609083;
 Thu, 16 May 2019 11:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190515144210.25596-1-daniel.baluta@nxp.com> <20190515144210.25596-2-daniel.baluta@nxp.com>
In-Reply-To: <20190515144210.25596-2-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 May 2019 15:33:19 -0300
Message-ID: <CAOMZO5Avmjf9GpGWBbMJrOxWdvdBTyXMoOPQw_uOQHhCayuHtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: imx8mm: Add SAI nodes
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, May 15, 2019 at 11:42 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> i.MX8MM has 5 SAI instances with the following base
> addresses according to RM.
>
> SAI1 base address: 3001_0000h
> SAI2 base address: 3002_0000h
> SAI3 base address: 3003_0000h
> SAI5 base address: 3005_0000h
> SAI6 base address: 3006_0000h

No SAI4?

I know the RM does not show the SAI4 in the memory map, but the clock
driver does show a SAI4 clock gate.

So it seems we have a contradiction in the reference manual. Could you
please double check with the internal folks?
