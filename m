Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66C916970A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2020 10:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgBWJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 04:35:28 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58089 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582450528; x=1613986528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=38BzKMsHq0/zpvM4fhJvj1d+Q1vNXQSaA0NYdlJy8ec=;
  b=Iy8Qb6UygG7f5kDohRO9WxXOVU5sc8vCE5Ob6Lc7mNr6RWNkxYHR+Mlb
   qRySDI4/upbbb14iBQcCGRXHI3MBnw8VZ+E8YpFjpcuTzKO6lLrAKwq91
   5/PrSl04kRJNADwlON/H8prmtULh1sg7rXryMu9qTB9EnabAzwe6KOXim
   cooopyVMcuJanYh7DnMCSbnqfxI1Q8ImHIj2T3CdfAoMkUAtexU2HdJgt
   kaXSyUgaN1MP3RNl9yvFhd5hPp6pcUlw9HIDAmvFkTgUR1JS+DEJrMhyQ
   Tm5xHONJ3YbANPUwiTZqb/yirXJr/3IYRfJSH/C8d5xEgKOgCwfVeYrrC
   g==;
IronPort-SDR: ghohmez1aubNT72cecKCcu7dpsPSZmatkN3y17w0LEtu+jCpoxM+kIeJCY7t1GgFElxX6zqNdm
 KMQt70/47V6aWoZdt4zgQnLomKfQ9BVPzfEwb/CJJIvTVsM+m+McQaJonxJQ/HdVTRRq0X85mv
 FQEi4tmhi0YNYfQjhAXAV+t2ROYxE7OwZBaCsEkXPOiNFPrlDoy3GXqZK/GAwg1fMR8uQjOEcI
 Bc5y7DPL0x2d5U9g9bLa7WVBTXwQS0YyUAZ2tm/NPHLCTIdpvfcJzsLtChjbquHUSJ3AJyfM04
 zqE=
X-IronPort-AV: E=Sophos;i="5.70,475,1574092800"; 
   d="scan'208";a="131020035"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2020 17:35:28 +0800
IronPort-SDR: K9p7ovU6mYcZgBMbHu6byK6ha/jM1TIZ0oeTLuN45uW+iHq/XE2LIIs7U0ZMbDPhDboYPBIFo3
 y0Id8hXlSy2gNjlAwmwWjAV1SJo2OQF/GwuxWUTLYD7yc0tSzFFRm5vC13NpaOdGVqzFHZwsOn
 ZLPFEpF3nH8B85jfIuL4BMnmO2UW62WMSqfR6wqv/B/+SF/DzIK81YPIiW8k6XfZCUBg8Ucbt9
 Gh2QwIMIOkB7BV5Q2IUx67v6vgHzdXDTNnQ/4ErDlTnw9ME+1Bvsj9IPmWL5Y+mz70LaPFMZHn
 n0JIkgIbINP7bJq8nZE5Fn9R
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 01:27:57 -0800
IronPort-SDR: XrMxJOQzcCuJYAg3IUokGJCgff8MliMFLZ80pMPCKBLN/YyC/FdLA4acEWjs4I8oPxEv78aAOU
 TOMHnLKO80Lbjjb468X1Nquyl62ReEPlv28TmWfe6k6tG/eerSD5AUOj8t1d7hAKwsJHLnMiDO
 LKrKHQAKOpB9xSOzI36UT5EsuScTH4b2t9GuipKSyO3+rBPw3bkT57Ed1Yphaly/v/f22P2LoP
 a5iYXRS4K9z1cCHcSqPEwVk+Knxr5ixB28+dSWUFiXmWCrnqeS5OrefszjU/mQa/F1BJtF1TAB
 7Bs=
WDCIronportException: Internal
Received: from kfae419068.sdcorp.global.sandisk.com ([10.0.231.195])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Feb 2020 01:35:23 -0800
From:   Avi Shchislowski <avi.shchislowski@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Avi.shchislowski@wdc.com,
        Avi Shchislowski <avi.shchislowski@wdc.com>
Subject: [RESEND PATCH 0/5]  scsi: ufs: ufs device as a temperature sensor
Date:   Sun, 23 Feb 2020 11:35:17 +0200
Message-Id: <1582450522-13256-1-git-send-email-avi.shchislowski@wdc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS3.0 allows using the ufs device as a temperature sensor. The
purpose of this feature is to provide notification to the host of the
UFS device case temperature. It allows reading of a rough estimate
(+-10 degrees centigrade) of the current case temperature, And
setting a lower and upper temperature bounds, in which the device
will trigger an applicable exception event.

We added the capability of responding to such notifications, while
notifying the kernel's thermal core, which further exposes the thermal
zone attributes to user space. UFS temperature attributes are all
read-only, so only thermal read ops (.get_xxx) can be implemented.

We are re-spinning this patchset per the request of Daniel Lezcano
to cc the thermal maintainers.

Avi Shchislowski (5):
  scsi: ufs: Add ufs thermal support
  scsi: ufs: export ufshcd_enable_ee
  scsi: ufs: enable thermal exception event
  scsi: ufs-thermal: implement thermal file ops
  scsi: ufs: temperature atrributes add to ufs_sysfs

 drivers/scsi/ufs/Kconfig       |  11 ++
 drivers/scsi/ufs/Makefile      |   1 +
 drivers/scsi/ufs/ufs-sysfs.c   |   6 +
 drivers/scsi/ufs/ufs-thermal.c | 249 +++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-thermal.h |  25 +++++
 drivers/scsi/ufs/ufs.h         |  20 +++-
 drivers/scsi/ufs/ufshcd.c      |   9 +-
 drivers/scsi/ufs/ufshcd.h      |  12 ++
 8 files changed, 331 insertions(+), 2 deletions(-)
 create mode 100644 drivers/scsi/ufs/ufs-thermal.c
 create mode 100644 drivers/scsi/ufs/ufs-thermal.h

-- 
1.9.1

