Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4C8184C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCMQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 12:32:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34740 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMQcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:32:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id i19so8397849lfl.1;
        Fri, 13 Mar 2020 09:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyWHs35Zg2C+2jMgWyB6ZqLQON5LgYusa6mcsNSwpOs=;
        b=Xcv1Kr+8IFwzuD6hNma9cvqU70N6nUjy6f8SZmAp2FfPzMUaJ6fqlTTDsKOLXRcR0S
         xXp/8jazrBQbQMyITDTbtKZgOsD8ZLUTP/LL+ZBJsglA2J3R3PLLnG/KmwnpxE1yYjg4
         Ob3NjrD5/kyRZHIJqtrXOpoph5Pxl63S3KAj1XCqD+PNF5L3mKcabF1ifOAwZdbLa87j
         wo6GpZNYUWDy02LSYJrteCvZWpUnKxSQByRK/Ct1BAK2rpC2AEDmcl7AMIu9k8yGm7yF
         oHzZ4Vyf4teoiPh1t4sC3kO2Xj4CTTgfzK10UAIiKbbWj6vC1QvT1w/ZX+ZJmQeCuutP
         MpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyWHs35Zg2C+2jMgWyB6ZqLQON5LgYusa6mcsNSwpOs=;
        b=gflOL8Nrr46/DRjooe5T7M2t5k+6nQdl453oG7p94K/MNNB0bNnKZiemG5AjsXVVmY
         UsJ2lhKdRDP0s/tD8bmaky8nKgdtNo9/f/AXa4HN5v4ZvQUtjHpvTJjeq6H0bvCkpVRl
         f8jWAu04POgJxPkXyeisYQaBnVM4EqZIcZJhTLlhmcdwlCKxfWGaAHYcshh2+uucmIKJ
         fPGU0avvr5MOO39oQvqHElganD/YlnVcY0F2SuZ9j5bCfr++7QwKp9h98AJQjBxT0beJ
         j0ludxKgU/l/s9pnWI6TdMVFUDvNe59Js6GTodnADJQkGvXpbdZeZ3sVbe1l4y/SJede
         DVKA==
X-Gm-Message-State: ANhLgQ21AoVp8EPSrKj9ize4ZDY9prebc4EaFMIczI3V3b0s9ds2o5Qu
        goeaz+lB7rbZ8l5/FOC/cRS30WilGshEvi93t5w=
X-Google-Smtp-Source: ADFU+vuiG+I/daEBy3iVb2g5dsQ6DmHXLJUJbOmeFdpRT4K641xxd/jzOZblQxR+z5Zm9BaEgWmC+ODAoVQQzYMaYyY=
X-Received: by 2002:a05:6512:30f:: with SMTP id t15mr1937812lfp.7.1584117168302;
 Fri, 13 Mar 2020 09:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200306104219.6434-1-alifer.wsdm@gmail.com>
In-Reply-To: <20200306104219.6434-1-alifer.wsdm@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Mar 2020 13:32:37 -0300
Message-ID: <CAOMZO5BjAN8rJ25n2n3i=gVQ_noo-X8CTsFDZWBQB88SyZ-SNg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mq-phanbell: Fix Ethernet PHY post-reset duration
To:     Alifer Moraes <alifer.wsdm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marco Franchi <marco.franchi@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alifer,

On Fri, Mar 6, 2020 at 7:41 AM Alifer Moraes <alifer.wsdm@gmail.com> wrote:
>
> i.MX8MQ Phanbell board uses Realtek RTL8211FD as Ethernet PHY.
> Its datasheet states that the proper post reset duration should be at least 50 ms.

The datasheet I found in the web states:

"The RTL8211F(I)/RTL8211FD(I) has a PHYRSTB pin to reset the chip. For
a complete PHY reset, this pin must be asserted low for at least 10ms
(Tgap in Figure 9) for the internal regulator. Wait for a further 30ms
(for internal circuits settling time) before accessing the PHY
register"

Where does the 50ms requirement come from? Do you have an updated
datasheet that says 50ms instead?

Please clarify.

Thanks
