Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7D396CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 01:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfHTXMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 19:12:33 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21539 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHTXMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:12:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566342745; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=JBLbx18X5OTrA9oojlt/c13sORyikSozbxBL8IdstkC+Bjm+zwjEZV73CM2goiqyZEYfywZcALq+JEs6Rvg2Di0YYmpU08g9viA5q9TBT22WIO7e1/9bLxc3cxWTn7UHWW8mlWSkuLTBMx/NjbLLeIFtNkTtQ1svcoxbNQEdrf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566342745; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=EOQbmm683ZQeRo5IEAuNfp/GUzc+3sakNt4tVfxkZFk=; 
        b=iTCkeJmWtGC1zM1asYQ1HSMpZz6lT5aGAPhWZzT4eAbF+MTGkkd50DlP1X9ZcJOnYQR0S3UkdyB+voHhSD3pOPneDpbedUhG22znXiWsrEkylePdA0M7s2PwzSvEqMfl1EvpETcZ6+NUl9QCSMzcOxw9e4p7voV5xVoV8+pmX4E=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566342745;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=1145; bh=EOQbmm683ZQeRo5IEAuNfp/GUzc+3sakNt4tVfxkZFk=;
        b=ZSlW5UE71QrT7DPTq6myCafxxWn+pT5tyTfaRPQPCuRuqlELATC3S+dnczbQEcov
        C8a4d0XNlJ6w+oBKW40++1vnsrtgGwikQ3SbY9Twn9zAK740OBl2kpvI971caSiPSJ3
        BWht5PrKJ6e76R+TTGlIVpS9jO+Vm+q9baGuT2dY=
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2]) by mx.zohomail.com
        with SMTPS id 1566342744871684.1076553847704; Tue, 20 Aug 2019 16:12:24 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Brennan <stephen@brennan.io>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>
Message-ID: <20190820231156.30031-1-stephen@brennan.io>
Subject: [PATCH 0/3] staging: rtl8192u: coding style fixes in ieee80211
Date:   Tue, 20 Aug 2019 16:11:53 -0700
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed some spacing, brace placement, and macro alignment in this driver=
. I
do not have the relevent hardware, but I verified that the
drivers/staging/rtl8192u module built between each patch.

Stephen Brennan (3):
  staging: rtl8192u: fix OPEN_BRACE errors in ieee80211
  staging: rtl8192u: fix macro alignment in ieee80211
  staging: rtl8192u: fix spacing in ieee80211

 drivers/staging/rtl8192u/ieee80211/dot11d.c   |  10 +-
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  38 +++---
 .../rtl8192u/ieee80211/ieee80211_crypt.c      |   2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  22 ++--
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  |   4 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 118 ++++++-----------
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c |  14 +-
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c | 121 ++++++++----------
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |  35 +++--
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  12 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  17 ++-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       |  14 +-
 12 files changed, 174 insertions(+), 233 deletions(-)

--=20
2.22.0



