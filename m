Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7339E7E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 02:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfJ2Bn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 21:43:26 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:35737 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJ2BnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:43:25 -0400
Received: by mail-qk1-f171.google.com with SMTP id h6so2469013qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 18:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHHKDkrvC4BZQPC9acPCLWkbuvwPNUCU1LdyX5p7xGc=;
        b=V+NRsZnSrhbWtb1cKoFmRuRrzMGQfakcuaG4zAflDwBbHRd4mSt9Q68RMf88gioHTa
         mGQDxZwh6Fj8rCU8574qQaJq7lyHkhF6I9SEuHPCWzruYkKLQTok9lLCZBlIGw+Wva02
         /ayVhQoRzaga00rwqgXxDIR+2JFqsv2maLTpgMqgzKEAg0AgTgiifbsk25Khjr0rMkuK
         hP9cpxIvMo4LvEyV+JvhDF0H+jAOkjrVqZSyE6B/I8LxzaUQnQ5tZ4Od1S+NPIulwHXA
         5qAYWoEsa+bhcTIKQU0LTHZ/iZk3O7LrRBtv1jJTXXnr8PV9oN3QGDxkgl3SroHKlnOr
         qvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BHHKDkrvC4BZQPC9acPCLWkbuvwPNUCU1LdyX5p7xGc=;
        b=LzBWrCgVhyTnA6RobfXla9TzOi4UYPTrIRQNER/GM1wApc36CRWc4r/EgR/hNQ7Xd7
         7hcM9OWxAfA42fgelNaW8f1G5VcRA/0E9nB++b3amhAdMFQjKeXMjL5VviZ0aTStg3cr
         Zio6BcIRDOYtIePd/FHaYhHLh6QSWn3VNKopgrOC5L/zbGmmKtV5paCLRTzrOHiZG+vE
         czSbWr7xM5jNxgyX+usfVXphrYt4HOBDbD63uDYA2OtYOc/oo3aMMRrbya2EzQIXCfX6
         IRdK60Ma43w76mzxddBCzdhHIyw3XOAyqcl/GWgU0AAZ4LFVXxqnLO3yS93Jp4NAgmez
         5hwA==
X-Gm-Message-State: APjAAAV9e239Kvdk0JOTG0/zqHOTzI7YnRp6266zGSBNYK6pGut/Uixa
        bJhtWMSqf3/7A54WJ0sTIOk=
X-Google-Smtp-Source: APXvYqxVkHRnq2Rb+ETokwG7RclCm/vUhmaoM/4Eg+pdkp99rZMLHjqIhwwIL2vIk3+jXcKKyanipQ==
X-Received: by 2002:a37:dc45:: with SMTP id v66mr17521790qki.345.1572313404932;
        Mon, 28 Oct 2019 18:43:24 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:483:ade:87ad:69fb:5b32:cf88])
        by smtp.gmail.com with ESMTPSA id 197sm6698394qkh.80.2019.10.28.18.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:43:24 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 0/5] staging: rts5208: Eliminate the use of CamelCase
Date:   Mon, 28 Oct 2019 22:43:11 -0300
Message-Id: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in tree rts5208


Gabriela Bittencourt (5):
  staging: rts5208: Eliminate the use of Camel Case in file ms.c
  staging: rts5208: Eliminate the use of Camel Case in file ms.h
  staging: rts5208: Eliminate the use of Camel Case in file xd.c
  staging: rts5208: Eliminate the use of Camel Case in file xd.h
  staging: rts5208: Eliminate the use of Camel Case in file sd.h

 drivers/staging/rts5208/ms.c | 86 ++++++++++++++++++------------------
 drivers/staging/rts5208/ms.h | 70 ++++++++++++++---------------
 drivers/staging/rts5208/sd.h |  2 +-
 drivers/staging/rts5208/xd.c |  8 ++--
 drivers/staging/rts5208/xd.h |  6 +--
 5 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.20.1

