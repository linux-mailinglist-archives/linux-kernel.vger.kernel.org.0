Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98608E5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfHOIEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 04:04:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40346 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbfHOIEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:04:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id e27so1493598ljb.7;
        Thu, 15 Aug 2019 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DJdrgW8rQ9WDcBu7AceZ+PV2QceTUz0gTPn5TA0WI9E=;
        b=nF7md9dw4GnWjU1GDdIcSg+Ev+UWsObP17rQ7yn81e86CzV947thJivLITYypAMqw1
         IuAKwWGIsw8l2tTdEvOxgg3HrLGqXCbJnclNTP7kSshR3aVBPbAoxiWOygpclDFGZvc3
         gnN0ah2GdzKzD1DrGlLz+WKhJhrQbwU0rUlf1azkOvne9+4XxW7iI8Q3WLxB/1y2Ae3X
         Tme8BRqrZ/Htc2g6qbClJ5TuA7WVW2AjMrmrKxLvi6E4BmVD3gjk6mk8JCsYnE8+J6If
         +sBg4OcbSCtwulCmzw8/aemHnxTftyxO6FcJHHY0aJrtK0sP5pDJrLnXppr8GI1qiITs
         hTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DJdrgW8rQ9WDcBu7AceZ+PV2QceTUz0gTPn5TA0WI9E=;
        b=tDvB5nCE+YtJi2F+tf/kHJPaodJiXnSjc8lkWghkvEllXKZlO3c82Q+3D496Sc+Xz8
         6AsjlkWJCgbOOMH4zdEe4pLeacVBoYbZeOZvUYnupY4Ne8/U7byq+YTGyEs/Ur+tk4+a
         4EAa6PwynOni0O/aSdmIRq+N4p+VtGusACQj2OfzNsJ3VekjbrYBqeQEQ92eApDLeoK+
         zp8lPpQojTJbXyxTe3borIvguQYxKWyWjZAErF2uef79+qMNJRkPEa0clUMZrslVIcVz
         Ywe1uSBfjBdFTZCaNeB+PASRGyJ2za5YWAZSud+A9c/opFVXyTp4/Ot2S97sYhz7s9AB
         Nbfw==
X-Gm-Message-State: APjAAAXhg/a9vpTpmrDE2aRSSdDz+KhWfiNSFRTDxhIwGNUlLnTGQiyF
        +xn2rii3jDcdl6wCw1UAUwctyisG9tjMvsLJvZE=
X-Google-Smtp-Source: APXvYqy1ZljxbUP5caEvDk4rZnn5hEEgafcYGZI0m0VguZPcJP2an8DpQbJhrkCkTa06JADshNdI6/v/+J+y751B5as=
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr2059138ljj.34.1565856287550;
 Thu, 15 Aug 2019 01:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <1565842753-14245-1-git-send-email-u0084500@gmail.com> <20190815071402.GA25906@kroah.com>
In-Reply-To: <20190815071402.GA25906@kroah.com>
From:   =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>
Date:   Thu, 15 Aug 2019 16:04:35 +0800
Message-ID: <CADiBU3__gnBfab2DDPGudBjOiAW2xmGCYF-c2fLx9PyqQzA84w@mail.gmail.com>
Subject: Re: [PATCH] From: cy_huang <cy_huang@richtek.com> Subject: usb: add
 more vendor defined ops in tcpci
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        cy_huang <cy_huang@richtek.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gene_chen@richtek.com,
        shufan_lee@richtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2019=E5=B9=B48=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Aug 15, 2019 at 12:19:13PM +0800, cy_huang wrote:
> > diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tc=
pci.h
> > index 303ebde..a6754fb 100644
> > --- a/drivers/usb/typec/tcpm/tcpci.h
> > +++ b/drivers/usb/typec/tcpm/tcpci.h
> > @@ -130,6 +130,11 @@ struct tcpci_data {
> >                        bool enable);
> >       int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data =
*data,
> >                                 enum typec_cc_status cc);
> > +     int (*set_vbus)(struct tcpci *tcpci,
> > +                     struct tcpci_data *data, bool source, bool sink);
> > +     int (*get_current_limit)(struct tcpci *tcpci, struct tcpci_data *=
data);
> > +     int (*set_current_limit)(struct tcpci *tcpci,
> > +                              struct tcpci_data *data, u32 max_ma, u32=
 mv);
> >  };
>
> You are adding callbacks here with no users of them, which isn't
> allowed.  Please also submit the code that uses these callbacks at the
> same time so we can review it all together.
>
> thanks,
>
> greg k-h

Yes, I'm adding the callback for the sub-pmic (CHG/TCPC)

I'll push the mfd driver first. for the tcpc, it's just a sub device.
