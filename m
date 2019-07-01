Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177D625964
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 22:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfEUUq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 16:46:57 -0400
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:56030 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfEUUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:46:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id CF965A0186;
        Tue, 21 May 2019 22:46:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1558471611; i=@fjfi.cvut.cz;
        bh=PX+ooY/jKEW+YUjaFub5T7cSqX+w0C8o4lgdq9z1QgM=;
        h=From:To:Cc:Subject:Date;
        b=pxeeB5plHLDPoTzIFr5oPaoVfwZPxEe4BFdbptW5UUPD7wHf0yHh+Hvu4Rf7TgdA3
         05v5UUbzbWQgVLwnnAUuJvQ4CtiOFtUuPmwz4DDk/kskPtPLyXXhqcEsPQeHMToeZC
         8PFTmyyyOxq2HoNa2PunvRNM2osC2Dt1XvDyDzMs=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id alyg8UxzqtnM; Tue, 21 May 2019 22:46:47 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 2DF76A004A;
        Tue, 21 May 2019 22:46:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 2DF76A004A
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id DD0A96004D; Tue, 21 May 2019 22:46:46 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH v2 0/3] block: sed-opal: add support for shadow MBR done flag and write
Date:   Tue, 21 May 2019 22:46:43 +0200
Message-Id: <1558471606-25139-1-git-send-email-zub@linux.fjfi.cvut.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extends SED Opal support: it adds IOCTL for setting the shadow
MBR done flag which can be useful for unlocking an Opal disk on boot and it adds
IOCTL for writing to the shadow MBR.

This applies on current master.

I successfully tested toggling the MBR done flag and writing the shadow MBR
using some tools I hacked together[1] with a Samsung SSD 850 EVO drive.

Changes from v1:
* PATCH 2/3: remove check with access_ok, just rely on copy_from_user as
suggested in [2] (I tested passing data == 0 and I got the expected EFAULT)

[1] https://gitlab.com/zub2/opalctl
[2] https://lore.kernel.org/lkml/20190501134833.GB24132@infradead.org/

Jonas Rabenstein (3):
  block: sed-opal: add ioctl for done-mark of shadow mbr
  block: sed-opal: ioctl for writing to shadow mbr
  block: sed-opal: check size of shadow mbr

 block/opal_proto.h            |  16 ++++
 block/sed-opal.c              | 157 +++++++++++++++++++++++++++++++++-
 include/linux/sed-opal.h      |   2 +
 include/uapi/linux/sed-opal.h |  20 +++++
 4 files changed, 193 insertions(+), 2 deletions(-)

-- 
2.20.1

