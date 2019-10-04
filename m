Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F9CB463
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 08:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388293AbfJDGRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 02:17:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33063 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbfJDGRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 02:17:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so3182870pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=4cnCC9H4fJLav9+hSDYX1cOtIjCBJIUM/F01nX4r0sE=;
        b=d6k5iUUyoTZwDdDHyzh3q/Szqethp1TagqWXHky6Zf18X5nX0CXh2pFqlAlFZlyL2b
         OyprEF0PQClat2JdeCQHleY78pYfu5VZL9b3KLWh7r8HpUMJxT8cMICodgcT7SAeZz1M
         HoKmCu1c/7hzS1phdIJLGj7N1zx2PijzHxa7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=4cnCC9H4fJLav9+hSDYX1cOtIjCBJIUM/F01nX4r0sE=;
        b=lNxdMvEByW2bd5yJ4lVdJi0hjk6wX+9//koknE8Xc8DJ88XdDvkb3ajgBH1DElaHSL
         IaGAUWtBbx4atc1g0OuMMOaOY5Gwoh5TJ32lib/HU0J61/S0rcTd1z+LPXU+gN2YVNQ1
         Yn2x5cbbwGDbpLNp5vxS9Z9BUjWMpvnVS8cYd4lhJ1IVY/wKOw9367J7pb5sneXwhCUF
         3rfxePtoNIWD0bpUQBdIdNHJY2e+pkiQ35nawprLx1jWJ/XTnq8sRIEgFVmx5gsw/5Yc
         NT/zIXt2UoXVZ2ssHaGgGgA2qYIr8paAipORa0jrbveuwaDFwxqTzMNKVd7BiPXn9V25
         oriA==
X-Gm-Message-State: APjAAAUQTlNnksvBnWQ9z322xeVkyLPDfHWyNUlFeS6771vcnI+2tTpJ
        cenyo3sFdK4QmyjbuO3gyyQ2vg==
X-Google-Smtp-Source: APXvYqyzLy03yLDhJOmpLNtDcL9DndWAkQMUpUVjgIvPtyVWjZ8BjTdnBnsSrxFiBU6W61jBDclvig==
X-Received: by 2002:a62:8286:: with SMTP id w128mr15190685pfd.240.1570169867058;
        Thu, 03 Oct 2019 23:17:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c7sm4439410pfr.75.2019.10.03.23.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 23:17:46 -0700 (PDT)
Message-ID: <5d96e40a.1c69fb81.5a60f.fd3a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191004055057.GH63675@minitux>
References: <1570146710-13503-1-git-send-email-mnalajal@codeaurora.org> <5d96daca.1c69fb81.fe5e4.e623@mx.google.com> <20191004055057.GH63675@minitux>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Murali Nalajala <mnalajal@codeaurora.org>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] base: soc: Handle custom soc information sysfs entries
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 23:17:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-10-03 22:50:57)
> On Thu 03 Oct 22:38 PDT 2019, Stephen Boyd wrote:
>=20
> > Quoting Murali Nalajala (2019-10-03 16:51:50)
> > > @@ -151,14 +156,16 @@ struct soc_device *soc_device_register(struct s=
oc_device_attribute *soc_dev_attr
> > > =20
> > >         ret =3D device_register(&soc_dev->dev);
> > >         if (ret)
> > > -               goto out3;
> > > +               goto out4;
> > > =20
> > >         return soc_dev;
> > > =20
> > > -out3:
> > > +out4:
> > >         ida_simple_remove(&soc_ida, soc_dev->soc_dev_num);
> > >         put_device(&soc_dev->dev);
> > >         soc_dev =3D NULL;
> > > +out3:
> > > +       kfree(soc_attr_groups);
> >=20
> > This code is tricky. put_device(&soc_dev->dev) will call soc_release()
> > so we set soc_dev to NULL before calling kfree() on the error path. This
> > way we don't doubly free a pointer that the release function will take
> > care of. I wonder if the release function could free the ida as well,
> > and then we could just make the device_register() failure path call
> > put_device() and return ERR_PTR(ret) directly. Then the error path is
> > simpler because we can avoid changing two pointers to NULL to avoid the
> > double free twice. Or just inline the ida remove and put_device() call
> > in the if and then goto out1 to consolidate the error pointer
> > conversion.
> >=20
>=20
> But if we instead allocates the ida before the soc_dev, wouldn't the
> error path be something like?:
>=20
> foo:
>         put_device(&soc_dev->dev);
> bar:
>         ida_simple_remove(&soc_ida, soc_num);
>         return err;
>=20
>=20
> I think we still need two exit paths from soc_device_register()
> regardless of moving the ida_simple_remove() into the release, but we
> could drop it from the unregister(). So not sure if this is cleaner...
>=20

It doesn't seem "safe" to let the number be reused before the device is
destroyed by put_device(). It would be clearer to do all the cleanup
from the release function so that the soc_device_unregister() path isn't
racy with another device being registered and reusing the same ID.

Of course this probably doesn't matter because the race I'm talking
about is extremely unlikely given there's only ever one soc device.
Reordering the put and remove would be fine too.

