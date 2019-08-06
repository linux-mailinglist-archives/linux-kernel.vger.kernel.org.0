Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693C9838BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 20:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfHFSku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 14:40:50 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:56890 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfHFSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:40:25 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so56488028pfa.23
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wP2k6PxKQdbd17RqxG3El2muiWWiSGy2kc2Gh5XByrI=;
        b=WDd/BGxofkfzmjb4D/zPUq3gRY5vVS5MLRGKZVCYfXHv34Te7S8e4Bwb30pkMShHie
         1+4797JKG5wBhEsNIjw79qTNSW2+Eznh3vG1/oYul2LAqbqiPFy9nIyRofpSeZTqz7/L
         RtZLGtGCOrSblUrgQ7Lgwa3Gl52NUeBClGtks3ov0ttCGeOqOu0muBrhHxFiaanYlI7X
         qbZUZAii/D6/GBW8a79S/zA0J+/z8j3TkU8WOQMUaGOSBYP28+IB8fZvabkUKLCPzuxH
         /EQrxqgUJoYu3vguLR46VNRLNWErX+wiTN8fS2qaSZPvSoWWDhPtpYyDs5a7ASHy/+ha
         Ku9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wP2k6PxKQdbd17RqxG3El2muiWWiSGy2kc2Gh5XByrI=;
        b=AsInaj7hCV9QVhGEJiVv7lKG7LDdlhCx1BMEtRzpBZjYG5eh+nKyK5LreelAiGlQXt
         A9zrK+3eBfEl7lRvhwZvv3QDyxvKLebI25YdfAGI704lAYevIik3PBCcHSEqJJWJhrc2
         Dh1acevAac4XuycB2F+iAWMMv6LzpCPz7F221EHFxAxsvJ4wDmRZPUvU/BmFVGl8v0Fn
         dRHbeQUUMfjt0yB+yI7jq3LPDlzeZLDpkcicQj+NoG7Ngerux1G+DWrdZ4I4TeKPuum6
         lDaKuc6tEAQrahw7U8QmwaZxq8tH0lpq1jZ7Yo3jixcSaXQpq9pAAsDiRK8mwVEqx7nc
         4GXw==
X-Gm-Message-State: APjAAAV7Kw/iuQXT/ToeXF9yr2bT5Dggo4ApEFmQuEZJUDga2nYzz5h3
        zalUDMO734MOLHlOn21VTUwbHzTGA3w=
X-Google-Smtp-Source: APXvYqwwYmJkHthiaIvaPs+VLc2DIFtXsjOTFOVcyvEdIPgfAq5a3Y0oU2QxDuFPqvHfDsC36M25NaYhWtk=
X-Received: by 2002:a65:57ca:: with SMTP id q10mr4401454pgr.52.1565116824642;
 Tue, 06 Aug 2019 11:40:24 -0700 (PDT)
Date:   Tue,  6 Aug 2019 11:40:04 -0700
Message-Id: <20190806184007.60739-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v2 0/2] Add default binderfs devices
From:   Hridya Valsaraju <hridya@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binderfs was created to help provide private binder devices to
containers in their own IPC namespace. Currently, every time a new binderfs
instance is mounted, its private binder devices need to be created via
IOCTL calls. This patch series eliminates the effort for creating
the default binder devices for each binderfs instance by creating them
automatically.

Hridya Valsaraju (2):
  binder: Add default binder devices through binderfs when configured
  binder: Validate the default binderfs device names.

 drivers/android/binder.c          |  5 +++--
 drivers/android/binder_internal.h |  2 ++
 drivers/android/binderfs.c        | 37 ++++++++++++++++++++++++++++---
 3 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.22.0.770.g0f2c4a37fd-goog

