Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328B9371D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfFFKhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 06:37:19 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:47023 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfFFKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:37:19 -0400
Received: by mail-io1-f52.google.com with SMTP id i10so1372516iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 03:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cFdLuSJ2n52Ggcex3WHZRygEp0K3ntsdnLR5+aexiOw=;
        b=ljz39RvU2mNY3PB0vhRVa/8I/9MCvoeAe3ugUGZ51Soi96oSX5yx3VEP69pa+vwowX
         uAqmjG7ED3MNI6XU4RlcyHILVHqxT6f+87mr/eqcDN76/FrJGz1d/K/E1cFLi4IonLD7
         UwXiDvZTQ8MCiFb29O0toqDsr6iB4VVY7dOpi3gzRGzSQLHVA1Sn46NukxaNdLZZM/b7
         zWxECsvov/m01CMOQJ9Iyzu38OL+ZsdUcVNyVb0HU7XYtgakGmb3Holrtd1xzKuwThAB
         TfEJhKkXnD7hoa6GR4hfu8gjzxH6JBMTCqnWF+05AqxSa1Etn2Gd8xhYfbPy/VwgXEeA
         QNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cFdLuSJ2n52Ggcex3WHZRygEp0K3ntsdnLR5+aexiOw=;
        b=cEUb9K4bQ36jYdUqVxt6Kw0EgrpaPIB8+tbnXHoozaY520BriIFqZQvZiPbdM3kAQD
         Zcj8g/g8ilFrr54krk+HvvWQfSRMQGTJy7YjkhtiNQz86xBwKGtt8qOZUEGeTbTcCLai
         Fgvrl8CEkSTGzN8z7wtxADNlsSnXCXNFMPyUQTUyoDXFDD3GDoSnudab/+yLoKMvt2Gs
         aE+pTvY+QspuM/lk5ImZOx11+RKYkIyX9/LeT199k2FRoWIIEL7U8Dn23C0zn3jR3YcT
         yBjP4Sr8KSzYARsdQP6xr26SZtsg+BERIPUSyFaTqlOXPnVcNNj5nWHROg2O+ffYmQuu
         Ypgg==
X-Gm-Message-State: APjAAAWMnsLkGws42yNMXz1gk6CsBaNWXrOES7Bf0Zx2rQpmZMr+FOYa
        dftxcHp0lGqOPxo0FQOt9UUPnjfW3xQYdsfn1mvM
X-Google-Smtp-Source: APXvYqzlj17gNwvtqhokEJMSNmzygAtmiJkl7ivecrfpgnIApggortIzi4quvgkD2PJn+4Du6FkwVh5ammV6GwKu4Eo=
X-Received: by 2002:a6b:1494:: with SMTP id 142mr27821213iou.72.1559817438212;
 Thu, 06 Jun 2019 03:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnDWhX25QPFNXA-uPcM_tD3Bep2ui=D5A2A8A5cZvrbJtA@mail.gmail.com>
 <F99C3F13-D705-4214-ADE8-30676E29360D@holtmann.org>
In-Reply-To: <F99C3F13-D705-4214-ADE8-30676E29360D@holtmann.org>
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Thu, 6 Jun 2019 12:37:07 +0200
Message-ID: <CADDKRnDimtWTrW8BXHZjLCHYRnpZ1qs5pravPtdNpwE13cWvvg@mail.gmail.com>
Subject: Re: [5.2.0-rcx] Bluetooth: hci0: unexpected event for opcode
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 6. Juni 2019 um 08:18 Uhr schrieb Marcel Holtmann <marcel@holtmann.=
org>:
>
> Hi Joerg,
>
> > In 5.2.0-rcx I see a new error message on startup probably after
> > loading the Bluetooth firmware:
> > [    1.609460] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> >
> >> dmesg | grep Bluetooth
> > [    0.130969] Bluetooth: Core ver 2.22
> > [    0.130973] Bluetooth: HCI device and connection manager initialized
> > [    0.130974] Bluetooth: HCI socket layer initialized
> > [    0.130975] Bluetooth: L2CAP socket layer initialized
> > [    0.130976] Bluetooth: SCO socket layer initialized
> > [    0.374716] Bluetooth: RFCOMM TTY layer initialized
> > [    0.374718] Bluetooth: RFCOMM socket layer initialized
> > [    0.374718] Bluetooth: RFCOMM ver 1.11
> > [    0.374719] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> > [    0.374720] Bluetooth: BNEP socket layer initialized
> > [    0.374721] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> > [    0.374722] Bluetooth: HIDP socket layer initialized
> > [    1.422530] Bluetooth: hci0: read Intel version: 370710018002030d00
> > [    1.422533] Bluetooth: hci0: Intel Bluetooth firmware file:
> > intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
> > [    1.609460] Bluetooth: hci0: unexpected event for opcode 0xfc2f
> > [    1.625557] Bluetooth: hci0: Intel firmware patch completed and acti=
vated
> > [   21.986125] input: BluetoothMouse3600 Mouse as
> > /devices/virtual/misc/uhid/0005:045E:0916.0004/input/input15
> > [   21.986329] input: BluetoothMouse3600 Consumer Control as
> > /devices/virtual/misc/uhid/0005:045E:0916.0004/input/input16
> > [   21.986408] hid-generic 0005:045E:0916.0004: input,hidraw3:
> > BLUETOOTH HID v1.10 Mouse [BluetoothMouse3600] on 80:19:34:4D:31:44
> >
> >
> > The error message goes away if I revert following patch:
> > f80c5dad7b64 Bluetooth: Ignore CC events not matching the last HCI comm=
and
>
> if you can send btmon trace (or better btmon -w trace.log) for this event=
 triggering it, then we can look if this is a hardware issue.

The problem is that it happens only once during startup, especially at
the very first startup after power-on only. So I can't issue any
command.

>We have only seen this with Atheros hardware so far, but it might happen f=
or others as well. It indicates that this is an unexpected event. Normally =
you can ignore this warning since it just indicates an existing issue that =
we just papered over before. So if everything works as before, just ignore =
it,

Yes for me BT works as usual so ignoring it would be no problem (but
it looks ugly because the error message is painted right on the
boot-screen).

Thanks, J=C3=B6rg
