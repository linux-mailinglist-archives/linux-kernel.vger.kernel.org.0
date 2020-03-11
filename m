Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB510181C85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgCKPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 11:41:24 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32935 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbgCKPlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:41:23 -0400
Received: by mail-vs1-f66.google.com with SMTP id n27so1641806vsa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bRlEXufW+otZULePWW/gKpEh2IixSSza/KchTcrPm2Q=;
        b=j7kpCO3voHcWqHVyatv0lWnoAAecB8yuezwj9exrXWfCvklFKwRQ6i0yNsnulp2Ilf
         aYceY31muzNpCzivV9FxEu8Vqy9DpXdlRX/hd8kNQ6eG3AdabEG55fVjKvzhUR24P3NT
         f64/tJP5KM+lAmMmVfIMAu2FulqGjNZgyGQDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bRlEXufW+otZULePWW/gKpEh2IixSSza/KchTcrPm2Q=;
        b=HU4zpZCpPmR7cn/c53jQWzaA29GLccVk1OS8cHfks0DyjBIkYzScgCUqTLX1jql0gw
         cDo+b5xRCX6JuUzZlqqQWYgEEu9k6oTcAuQjWMi3Nq/Kgz/gVrknTYj/wyhHT5q63dGu
         aG1F1Bh6ZTOLoUMT/e/LO78D+976VypYefCChizONLAR6i4Vm/2mNkChnBEEeEWMskDv
         wuUfXRxyx2ttdji5EMrPpYfWS0TbKSJDuEwwf4CQCXoX430lsA+Z/CILJOPawpoCMHik
         ECbUVPJz06lj2XPjcEF73NtRew0etY8FlcJpUEvn27f/iRqvlxTmJBV7CxKs3WH6953J
         RLLQ==
X-Gm-Message-State: ANhLgQ0KLrbbp0ezn7mZQUfY108W0OzufhhnPSQ0S5Gidh49A10qhuUr
        1ZyqwdznuuenGvpaRlxzYSJus4pSxpoTLRjpxlReyg==
X-Google-Smtp-Source: ADFU+vvSyAbSz8PejFXbhO8Lv/TfLKzTjntPjsDPEH44gWzlhFI7DeDejvMB2sioeNFkEu7pKQf9Yw6dVWhEPsCxVc8=
X-Received: by 2002:a67:f641:: with SMTP id u1mr2388964vso.86.1583941282719;
 Wed, 11 Mar 2020 08:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200308212334.213841-1-abhishekpandit@chromium.org> <C9E912BC-01E0-4E5D-ABC9-DBA932231E50@holtmann.org>
In-Reply-To: <C9E912BC-01E0-4E5D-ABC9-DBA932231E50@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 11 Mar 2020 08:41:08 -0700
Message-ID: <CANFp7mVQyzwb1MnDjid9TSBb_15OmyJ85doZQNpyd-2J-SAN3w@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/5] Bluetooth: Handle system suspend gracefully
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure -- patch incoming in a few minutes.

On Wed, Mar 11, 2020 at 8:03 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Abhishek,
>
> > This patch series prepares the Bluetooth controller for system suspend
> > by disconnecting all devices and preparing the event filter and LE
> > whitelist with devices that can wake the system from suspend.
> >
> > The main motivation for doing this is so we can enable Bluetooth as
> > a wake up source during suspend without it being noisy. Bluetooth shoul=
d
> > wake the system when a HID device receives user input but otherwise not
> > send any events to the host.
> >
> > This patch series was tested on several Chromebooks with both btusb and
> > hci_serdev on kernel 4.19. The set of tests was basically the following=
:
> > * Reconnects after suspend succeed
> > * HID devices can wake the system from suspend (needs some related blue=
z
> >  changes to call the Set Wake Capable management command)
> > * System properly pauses and unpauses discovery + advertising around
> >  suspend
> > * System does not wake from any events from non wakeable devices
> >
> > Series 2 has refactored the change into multiple smaller commits as
> > requested. I tried to simplify some of the whitelist filtering edge
> > cases but unfortunately it remains quite complex.
> >
> > Series 3 has refactored it further and should have resolved the
> > whitelisting complexity in series 2.
> >
> > Series 4 adds a fix to check for powered down and powering down adapter=
s.
> >
> > Series 5 moves set_wake_capable to the last patch in the series and
> > changes BT_DBG to bt_dev_dbg.
> >
> > Please review and provide any feedback.
>
> so I was planning to apply patches 1-4. The only thing that I noticed was=
 that patch 2 introduces the following warning.
>
>   CC      net/bluetooth/hci_request.o
> net/bluetooth/hci_request.c: In function =E2=80=98hci_req_prepare_suspend=
=E2=80=99:
> net/bluetooth/hci_request.c:973:6: warning: unused variable =E2=80=98old_=
state=E2=80=99 [-Wunused-variable]
>   973 |  int old_state;
>       |      ^~~~~~~~~
>
> I think this variable should only be introduced in patch 4. Are you able =
to respin this series so that the variable moves to patch 4. If not, I can =
try to fix this myself.
>
> Regards
>
> Marcel
>
