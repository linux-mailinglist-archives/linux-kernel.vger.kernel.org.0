Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB710124C44
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 16:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLRPxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 10:53:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35828 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727215AbfLRPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 10:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576684422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unt15VBAcaHjgr4U8q0O2ZKzQ4PmSaIhSP/h0Yo0Lsg=;
        b=TQMCOlkNMZNgWF4tuPlLRzYc5/1QRPvXzNb0FxdF7fWKUyYMr8apRDZ7xICttgBfWjyVfK
        ylhEO0EdXxlh+yMAw0G5vmocAPGE+L0BULNIH5jAXzHZ/pv8uI/oV8SGcFFNrMA5fF5w+H
        jNY3gHIwlY3IQE2uECOIdneXne03GZ8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-AyToU93VPCeqAyfjtCxVGw-1; Wed, 18 Dec 2019 10:53:41 -0500
X-MC-Unique: AyToU93VPCeqAyfjtCxVGw-1
Received: by mail-qk1-f198.google.com with SMTP id w64so1616189qka.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 07:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unt15VBAcaHjgr4U8q0O2ZKzQ4PmSaIhSP/h0Yo0Lsg=;
        b=hjjSBBr9eSMh0owsSFXAEBNqWFducdzqvkXzYtCsFLKJFoTeD1oJIRgOP1qvfELEyL
         TcHqigw7Vc3CKN/7ZHYfgwmvv1VMowFVAea6IYJnZnRRGlmbldOsv9/Funu+2212kU6u
         hw5U4BmFaXAxyzQWY3LtO3/pI11vysJJdWc7WO3A65rRUxGp35Do/Zm7wwFDM/QTawgf
         a9DQNGfYP/ixqqsO4aFsRxIVKCkgP4TtvlbT4aunlcM2EFgkaewNybWcSHkbZkedR4O7
         6o5OMWyAqtSGzzOhKF/AHa2AkbiVwGou3P/NGaGB//xn5FgvBmMh8ykfvaht80CkQEdA
         5S4g==
X-Gm-Message-State: APjAAAVj6t05xdp6UgFRa12VrvVwK5BetlPHLuCnJ4IwMLT8WwHAw9mA
        TpX7c8ZcS54BAVADElRFip5H3V07UinHmwDceYT98GxoeWScWxaMYkLBrWNBN60hGtm68JV4YO+
        vThxb63aACgeTqKh/6ywaKQD6P9ZTPCNYRs5GeW4B
X-Received: by 2002:aed:20e5:: with SMTP id 92mr2769389qtb.294.1576684420709;
        Wed, 18 Dec 2019 07:53:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhdfn+DJmWSW1rtNfJv+v3JLGnbmcOBsRFVV57rECIvs8fgi+lo+5a3GjmoMIWei9Wj75Fqi5V2OS/6ZuECd8=
X-Received: by 2002:aed:20e5:: with SMTP id 92mr2769372qtb.294.1576684420468;
 Wed, 18 Dec 2019 07:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20191217225021.GA34258@dtor-ws>
In-Reply-To: <20191217225021.GA34258@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 18 Dec 2019 16:53:29 +0100
Message-ID: <CAO-hwJJ5JDi9z_nBjo1vLtCMG1XWLn_E_SV+57t3=qAowkmxNQ@mail.gmail.com>
Subject: Re: [PATCH] HID: hiddev: fix mess in hiddev_open()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:50 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The open method of hiddev handler fails to bring the device out of
> autosuspend state as was promised in 0361a28d3f9a, as it actually has 2
> blocks that try to start the transport (call hid_hw_open()) with both
> being guarded by the "open" counter, so the 2nd block is never executed as
> the first block increments the counter so it is never at 0 when we check
> it for the second block.
>
> Additionally hiddev_open() was leaving counter incremented on errors,
> causing the device to never be reopened properly if there was ever an
> error.
>
> Let's fix all of this by factoring out code that creates client structure
> and powers up the device into a separate function that is being called
> from usbhid_open() with the "existancelock" being held.
>
> Fixes: 0361a28d3f9a ("HID: autosuspend support for USB HID")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Thanks!

Applied to for-5.5/upstream-fixes

Cheers,
Benjamin

>  drivers/hid/usbhid/hiddev.c | 97 ++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> index 1f9bc4483465..c879b214a479 100644
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -241,12 +241,51 @@ static int hiddev_release(struct inode * inode, struct file * file)
>         return 0;
>  }
>
> +static int __hiddev_open(struct hiddev *hiddev, struct file *file)
> +{
> +       struct hiddev_list *list;
> +       int error;
> +
> +       lockdep_assert_held(&hiddev->existancelock);
> +
> +       list = vzalloc(sizeof(*list));
> +       if (!list)
> +               return -ENOMEM;
> +
> +       mutex_init(&list->thread_lock);
> +       list->hiddev = hiddev;
> +
> +       if (!hiddev->open++) {
> +               error = hid_hw_power(hiddev->hid, PM_HINT_FULLON);
> +               if (error < 0)
> +                       goto err_drop_count;
> +
> +               error = hid_hw_open(hiddev->hid);
> +               if (error < 0)
> +                       goto err_normal_power;
> +       }
> +
> +       spin_lock_irq(&hiddev->list_lock);
> +       list_add_tail(&list->node, &hiddev->list);
> +       spin_unlock_irq(&hiddev->list_lock);
> +
> +       file->private_data = list;
> +
> +       return 0;
> +
> +err_normal_power:
> +       hid_hw_power(hiddev->hid, PM_HINT_NORMAL);
> +err_drop_count:
> +       hiddev->open--;
> +       vfree(list);
> +       return error;
> +}
> +
>  /*
>   * open file op
>   */
>  static int hiddev_open(struct inode *inode, struct file *file)
>  {
> -       struct hiddev_list *list;
>         struct usb_interface *intf;
>         struct hid_device *hid;
>         struct hiddev *hiddev;
> @@ -255,66 +294,14 @@ static int hiddev_open(struct inode *inode, struct file *file)
>         intf = usbhid_find_interface(iminor(inode));
>         if (!intf)
>                 return -ENODEV;
> +
>         hid = usb_get_intfdata(intf);
>         hiddev = hid->hiddev;
>
> -       if (!(list = vzalloc(sizeof(struct hiddev_list))))
> -               return -ENOMEM;
> -       mutex_init(&list->thread_lock);
> -       list->hiddev = hiddev;
> -       file->private_data = list;
> -
> -       /*
> -        * no need for locking because the USB major number
> -        * is shared which usbcore guards against disconnect
> -        */
> -       if (list->hiddev->exist) {
> -               if (!list->hiddev->open++) {
> -                       res = hid_hw_open(hiddev->hid);
> -                       if (res < 0)
> -                               goto bail;
> -               }
> -       } else {
> -               res = -ENODEV;
> -               goto bail;
> -       }
> -
> -       spin_lock_irq(&list->hiddev->list_lock);
> -       list_add_tail(&list->node, &hiddev->list);
> -       spin_unlock_irq(&list->hiddev->list_lock);
> -
>         mutex_lock(&hiddev->existancelock);
> -       /*
> -        * recheck exist with existance lock held to
> -        * avoid opening a disconnected device
> -        */
> -       if (!list->hiddev->exist) {
> -               res = -ENODEV;
> -               goto bail_unlock;
> -       }
> -       if (!list->hiddev->open++)
> -               if (list->hiddev->exist) {
> -                       struct hid_device *hid = hiddev->hid;
> -                       res = hid_hw_power(hid, PM_HINT_FULLON);
> -                       if (res < 0)
> -                               goto bail_unlock;
> -                       res = hid_hw_open(hid);
> -                       if (res < 0)
> -                               goto bail_normal_power;
> -               }
> -       mutex_unlock(&hiddev->existancelock);
> -       return 0;
> -bail_normal_power:
> -       hid_hw_power(hid, PM_HINT_NORMAL);
> -bail_unlock:
> +       res = hiddev->exist ? __hiddev_open(hiddev, file) : -ENODEV;
>         mutex_unlock(&hiddev->existancelock);
>
> -       spin_lock_irq(&list->hiddev->list_lock);
> -       list_del(&list->node);
> -       spin_unlock_irq(&list->hiddev->list_lock);
> -bail:
> -       file->private_data = NULL;
> -       vfree(list);
>         return res;
>  }
>
> --
> 2.24.1.735.g03f4e72817-goog
>
>
> --
> Dmitry
>

