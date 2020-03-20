Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C00F18DB55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 23:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCTWsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 18:48:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46050 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:48:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so8781045qke.12;
        Fri, 20 Mar 2020 15:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nA0qGDHkYHJL6ggJ5t6ci+dqhrMY8bZAxvf3gcxj7rA=;
        b=Qn7SRGh3ZeclNE2+k3u5g8aAXXD+IX6uG8//2Q4oN2fMvDSG4Eo6Lffy5QqBcuDOZA
         PL7Pv4ElqdqjOryWVk0qmVvYcqVHzqtQ9ncbZYQcEW3wQLuaAYS0y4f8N8QHNteahC9x
         a+9zqZIkhkWr3VcXMye1eDSQjXfqhMPtVonZKuQvz2SEGu5WhgLkiG5iGrbOX1ooL/cR
         Y0t2R3bhMKsTlSubN5kvbLrqOVYBk+LNWdzW49/zw2CnAyuqEh+CDBNSnKFVLb8YiTOU
         BZ1sjFL5JNHdFtQIyC70CTKYAABRMPEsaZ9J4M1Jxr6qwDtKFNViF4JwYh3L4SzZ3i0M
         yfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nA0qGDHkYHJL6ggJ5t6ci+dqhrMY8bZAxvf3gcxj7rA=;
        b=CkFDnyOuBBi2QRKNe3EEJHALY/C3u++CjhoFj90ACM6fy3Hzcp7Z2dGG3avEz4HBUX
         q+eQwm36/R7rvBZ1cl9ZRAep6tiKl+OkntXhHUwUHNQNNCda5XoLxG/kFIZUi9z790Nu
         OZHaYT5goPIoCRJLAyRQ3hW2VM23FbKdpUUaQ+kfNOFB4A2H4C62WHbWuNh61cPeo+EU
         W4oMPyDlK5eJrScKKuF4fMTP7dSoL8TAPohIiLP0RUhbYO4C3ARx0Wv9ZDVdIf0sA9nY
         gTrO0sxvY9QXXj9pt33CPic11X8PVCIl8+b7gUX3nMycWbS0LqLPKu6mGosGpwHJYa45
         pWUg==
X-Gm-Message-State: ANhLgQ1DYNklEjpENvtIot4jxfNJZAzuswKe2UE1Al9t0qay7/amvnqQ
        6x14fbRg1BVquOHqvu00O+zomUaQ39EZvYre4VA=
X-Google-Smtp-Source: ADFU+vs27RjZFGCDT1+qlCcZOEkDvs33EnnExK72VpM7K+YodsysftecaKQBfisuA1rmrDLo18r2tcWEtrfRRDjrohc=
X-Received: by 2002:a37:9e8a:: with SMTP id h132mr10192391qke.314.1584744531281;
 Fri, 20 Mar 2020 15:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200316090021.52148-1-pmalani@chromium.org> <20200316090021.52148-2-pmalani@chromium.org>
 <CAFqH_50eGjYu7dHFW82CY4-EyDtq+AF+6tHCAjKbaAjW5_7WYA@mail.gmail.com> <20200320223458.GA15213@bogus>
In-Reply-To: <20200320223458.GA15213@bogus>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 20 Mar 2020 23:48:39 +0100
Message-ID: <CAFqH_51Yj4pHoXJPCxTP_Yid9oq0rSTuDFis3nS6qmTYEGufuw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: Add cros-ec Type C port driver
To:     Rob Herring <robh@kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Missatge de Rob Herring <robh@kernel.org> del dia dv., 20 de mar=C3=A7 2020
a les 23:35:
>
> On Mon, Mar 16, 2020 at 04:14:13PM +0100, Enric Balletbo Serra wrote:
> > Hi Prashant,
> >
> > Missatge de Prashant Malani <pmalani@chromium.org> del dia dl., 16 de
> > mar=C3=A7 2020 a les 10:02:
> > >
> > > Some Chrome OS devices with Embedded Controllers (EC) can read and
> > > modify Type C port state.
> > >
> > > Add an entry in the DT Bindings documentation that lists out the logi=
cal
> > > device and describes the relevant port information, to be used by the
> > > corresponding driver.
> > >
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> >
> > After Rob review, it can go together with the other patches through
> > the chrome-platform tree. From my side:
>
> LGTM, but it is dependent on usb-connector.yaml which I picked up.
> Either I can take this patch or you pull my dt/next branch in.
>

I'm fine with you picking this patch in your branch.

Thanks,
 Enric

> Rob
