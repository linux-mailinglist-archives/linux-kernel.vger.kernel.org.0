Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C585DD11
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 05:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGCDja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 23:39:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40160 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCDja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:39:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so1010868qtn.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 20:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=v2q6SvsOB1cDEohjsvQYnod7xEYnA/l8FFyUl1WC8wU=;
        b=Dkv5gMfLTfAK3uJ4a4E1A557Oba1LAjOKLvDgUDzswzROcIXOdYfctNO/ow6sKZ36Q
         UMqarylXWwkvblKe0qYCQOzcLRMe8u8RiFPxC+Yvcmo5WeDImcb0XnQcIcBBYuhvIfYl
         jHEe08hNwl5lyLG5M+XdFCP/lbnuSCg7pygUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=v2q6SvsOB1cDEohjsvQYnod7xEYnA/l8FFyUl1WC8wU=;
        b=STW8yOsLVZ+WeZBkBu3PoVshaHbhz7IQ/fmOhvOq5lmhQ+jZ3PpkksAVcap6a8tsIV
         5CMY3s1jNC6FYjcSyW4/JlHzrOUmqjC7DJT1JszkXSmqufHpOQZ1xCGhNdySHjonvE5o
         x4xkuVVjPIfFYLQHbppjhOpwOX1oY8kgu38vJQAblTDsVtDjxiiQ+tw4ZzD2mO6sXkpn
         9ccyAfbCUJsOs1ZzX6AnXbtPJbS6tFE+Rl6S2ACDlUHt0e4tMf8ISyyi4lALyokwBy6P
         iZkFYMJt45gs77SusJIsTdIXwFdEQZFWuNFtZ6IiCnR5e5mq6I2I1lS1ofkUequfZa4V
         gi3A==
X-Gm-Message-State: APjAAAVFL0ZhmbPL7JyVyeBZ22yu2JIXGcaBxq75GFCSo+y7dYH1GzOH
        8D+ERnBQewNuBnjaz4kuepPKCp8dJ6uFmg0biABLXhWv8LoRFA==
X-Google-Smtp-Source: APXvYqzh6kQznbLgrQovx0U83ZaOgJFQxRcWY+l3dQrp2FHdd3nHMedexoVYLrCF96tMzVUhALmyEvltkW+aGmtD+pw=
X-Received: by 2002:ac8:264a:: with SMTP id v10mr28012697qtv.255.1562125169267;
 Tue, 02 Jul 2019 20:39:29 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 3 Jul 2019 03:39:17 +0000
Message-ID: <CACPK8XfCpgjAwMeoyhcZqgqtXO=-wtpuB2kwsogvBnd1VzynDg@mail.gmail.com>
Subject: [GIT PULL] FSI changes for 5.3
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

We've not had a MAINAINERS entry for drivers/fsi, so this fixes that. It names
Jeremy and I as maintainers, so if it works for you we will send pull requests
to you each cycle.

I realise this one is a bit late, but please consider including so we have a
clear path for future submissions from 5.3 on.

This pull request contains two code changes. One touches hwmon and has an ack
from Guenter as the hwmon maintainer.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-5.3

for you to fetch changes up to 371975b0b07520c85098652d561639837a60a905:

  fsi/core: Fix error paths on CFAM init (2019-07-03 10:42:53 +0930)

----------------------------------------------------------------
FSI changes for 5.3

 - Add MAINTAINERS entry. There is now a git tree and a mailing
 list/patchwork for collecting FSI patches

 - Bug fix for error driver registration error paths

 - Correction for the OCC hwmon driver to meet the spec

----------------------------------------------------------------
Eddie James (1):
      OCC: FSI and hwmon: Add sequence numbering

Jeremy Kerr (1):
      fsi/core: Fix error paths on CFAM init

Joel Stanley (1):
      MAINTAINERS: Add FSI subsystem

 MAINTAINERS                | 13 +++++++++++++
 drivers/fsi/fsi-core.c     | 32 ++++++++++++++++++++------------
 drivers/fsi/fsi-occ.c      | 15 ++++++++++++---
 drivers/hwmon/occ/common.c |  4 ++--
 drivers/hwmon/occ/common.h |  1 +
 5 files changed, 48 insertions(+), 17 deletions(-)
