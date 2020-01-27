Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D799C14A07E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgA0JMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 04:12:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45238 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgA0JMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580116339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9hxx9ozEZkaPTM1+VPDc3TWQ0gfjD9WZsQqXUI/VqM=;
        b=J/KiaGAFukkx88bafFCbVW0yTDAmtSLkd218om/1Pq/cSzHdbLKszgaq5wCQQBFIAZiQKX
        pxlmEPnWvEfva86E+ililIp05J/GkIvKRqSdkBkFipmthb0Tlj/ye2oc6PQXruIeigUrwk
        nwaAMJ2es2nZJ6s2ny8fcBCAILSsGtw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-PgKeydw9MLisRfpfk3eEGw-1; Mon, 27 Jan 2020 04:12:18 -0500
X-MC-Unique: PgKeydw9MLisRfpfk3eEGw-1
Received: by mail-qv1-f69.google.com with SMTP id g6so6077737qvp.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 01:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M9hxx9ozEZkaPTM1+VPDc3TWQ0gfjD9WZsQqXUI/VqM=;
        b=Cjx7RcPya4W3LEZf2Tuf1bjG+J9mVoEGWoG+93VlPgBkJ08LG6XsM9XUc+456sTdIU
         +O0eW11ewwnujBo8mK3enLPqTiRXPyTRCj0XogAVtUwJrSa5E63Kakf04Y+o3KLzkyws
         PoP5k/FgIWcSzAzSNbsfDqpTM45BpqO+V6jxXTUHHvSZgpSHYEtLJRtC7cTE9SzAYusZ
         4S1pqv/5BdJAyhFuJ4Hzzwh2HvKmRqVfG/BUu3EoCMCWYsQ/weeCcbR1qYQPMTqEpLes
         z7bLNAUEBeJsrUimMWAbaNUKa3yVc0pRzvF/jfoVcAwwQSErEVFPdn1l6p0G+SkDYx0W
         yEVw==
X-Gm-Message-State: APjAAAU8pB3ftP+sde7QQk1VF8fRz1n7uf3oLKSiiosZgx2q/0ldjvkN
        l6BqaA/8aKgWs8Gm90IJzShRhS8KjF5ZbKX1IrQHa98Y+niYZi+Lz1az0Cx+xcpGXOs5BAsWX2n
        IFhcJMDR8bgeDeJ6oFCNi0rr8WtEis+5Vc+2wfzWD
X-Received: by 2002:ac8:365c:: with SMTP id n28mr7847296qtb.260.1580116337679;
        Mon, 27 Jan 2020 01:12:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzr6xug3BnUa3I0Ylf4L+XjMwNQRytDMt23oIEXtx/gEFXcaRoK7dGGiqQEcSKnoWu1R6ivcG4RuChkPRN+7W4=
X-Received: by 2002:ac8:365c:: with SMTP id n28mr7847278qtb.260.1580116337395;
 Mon, 27 Jan 2020 01:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20200111192419.2503922-1-lains@archlinux.org> <aaca852e-cb31-2690-7f90-819ed673bacb@pedrovanzella.com>
In-Reply-To: <aaca852e-cb31-2690-7f90-819ed673bacb@pedrovanzella.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 27 Jan 2020 10:12:06 +0100
Message-ID: <CAO-hwJJwqXbJSTY2iEBTv3=N1_NaoHii6JvpA7_1oJUWQHZHag@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: BatteryVoltage: only read
 chargeStatus if extPower is active
To:     Pedro Vanzella <pedro@pedrovanzella.com>
Cc:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>,
        Jiri Kosina <jikos@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 20, 2020 at 2:43 PM Pedro Vanzella <pedro@pedrovanzella.com> wr=
ote:
>
> On 1/11/20 4:24 PM, Filipe La=C3=ADns wrote:
> > In the HID++ 2.0 function getBatteryInfo() from the BatteryVoltage
> > (0x1001) feature, chargeStatus is only valid if extPower is active.
> >
> > Previously we were ignoring extPower, which resulted in wrong values.
>
> Nice catch. Sorry for missing that the first time around.
>
> >
> > Example:
> >      With an unplugged mouse
> >
> >      $ cat /sys/class/power_supply/hidpp_battery_0/status
> >      Charging
>
> Tested and it works as expected now.

Thanks for the patch and the tests.

Unfortunately, the merge window is already opened, and I'd rather not
sneak this one right now. This patch doesn't seem very critical so I
rather not annoy the other maintainers.
I'll make sure it gets in the 5.6 final by pushing it into a rc when
things are calmer for everybody.

So the plan would be:
- wait for the 'normal' 5.6 HID pull request to be sent
- apply this one in for-5.6/upstream-fixes
- sent this branch for either 5.6-rc1 or 5.6-rc2

Cheers,
Benjamin

>
> >
> > This patch makes fixes that, it also renames charge_sts to flags as
> > charge_sts can be confused with chargeStatus from the spec.
> >
> > Spec:
> > +--------+-------------------------------------------------------------=
------------+
> > |  byte  |                                    2                        =
            |
> > +--------+--------------+------------+------------+----------+---------=
-+----------+
> > |   bit  |     0..2     |      3     |      4     |     5    |     6   =
 |     7    |
> > +--------+--------------+------------+------------+----------+---------=
-+----------+
> > | buffer | chargeStatus | fastCharge | slowCharge | critical | (unused)=
 | extPower |
> > +--------+--------------+------------+------------+----------+---------=
-+----------+
> > Table 1 - battery voltage (0x1001), getBatteryInfo() (ASE 0), 3rd byte
> >
> > +-------+--------------------------------------+
> > | value |                meaning               |
> > +-------+--------------------------------------+
> > |   0   | Charging                             |
> > +-------+--------------------------------------+
> > |   1   | End of charge (100% charged)         |
> > +-------+--------------------------------------+
> > |   2   | Charge stopped (any "normal" reason) |
> > +-------+--------------------------------------+
> > |   7   | Hardware error                       |
> > +-------+--------------------------------------+
> > Table 2 - chargeStatus value
> >
> > Signed-off-by: Filipe La=C3=ADns <lains@archlinux.org>
> > ---
> >   drivers/hid/hid-logitech-hidpp.c | 43 ++++++++++++++++---------------=
-
> >   1 file changed, 21 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitec=
h-hidpp.c
> > index bb063e7d48df..39a5ee0aaab0 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -1256,36 +1256,35 @@ static int hidpp20_battery_map_status_voltage(u=
8 data[3], int *voltage,
> >   {
> >       int status;
> >
> > -     long charge_sts =3D (long)data[2];
> > +     long flags =3D (long) data[2];
> >
> > -     *level =3D POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
> > -     switch (data[2] & 0xe0) {
> > -     case 0x00:
> > -             status =3D POWER_SUPPLY_STATUS_CHARGING;
> > -             break;
> > -     case 0x20:
> > -             status =3D POWER_SUPPLY_STATUS_FULL;
> > -             *level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> > -             break;
> > -     case 0x40:
> > +     if (flags & 0x80)
> > +             switch (flags & 0x07) {
> > +             case 0:
> > +                     status =3D POWER_SUPPLY_STATUS_CHARGING;
> > +                     break;
> > +             case 1:
> > +                     status =3D POWER_SUPPLY_STATUS_FULL;
> > +                     *level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> > +                     break;
> > +             case 2:
> > +                     status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +                     break;
> > +             default:
> > +                     status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > +                     break;
> > +             }
> > +     else
> >               status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > -             break;
> > -     case 0xe0:
> > -             status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> > -             break;
> > -     default:
> > -             status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > -     }
> >
> >       *charge_type =3D POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> > -     if (test_bit(3, &charge_sts)) {
> > +     if (test_bit(3, &flags)) {
> >               *charge_type =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> >       }
> > -     if (test_bit(4, &charge_sts)) {
> > +     if (test_bit(4, &flags)) {
> >               *charge_type =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> >       }
> > -
> > -     if (test_bit(5, &charge_sts)) {
> > +     if (test_bit(5, &flags)) {
> >               *level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> >       }
> >
> >
>
> Tested-by: Pedro Vanzella <pedro@pedrovanzella.com>
> Reviewed-by: Pedro Vanzella <pedro@pedrovanzella.com>
>

