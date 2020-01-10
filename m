Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8236813761F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 19:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAJSgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 13:36:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39051 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgAJSgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:36:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so2998195wmj.4;
        Fri, 10 Jan 2020 10:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2Yc37HGhbVglWg9H9TpyhPlGXyZBP+fZVz5l0vOH44g=;
        b=SVsPQ5UjMsyR76PLPc/tBgMUJDvso/g/fjRT+1oSH4L4pgZ1yt03xJ/sqNyB/ksxKG
         HlgKgswZHJWRqcwYP1hJGdI+waecOkAAayPF2BBkUlaR4yytijqlr/YPeV1q2zdgfR9n
         0f/BzG0Mu9BpXl2f0fXBPy9Z88U+oTC6b8c2UkAijkVWZEsEKE/0i8sjg1lCgPD9O/Pp
         PFt5vhTxPFUfGnuQEvOF8vLIyGZUkLsIyn+aCctFSxCqa9CjLbHYWaa36EBS9UYLqDiP
         8GOtTmnw6ta1oCc6B83qYRKB8Nj/b+JH8YhXcbFuERYx+N++ww6sHOLsg2PP21HuqEBQ
         G90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2Yc37HGhbVglWg9H9TpyhPlGXyZBP+fZVz5l0vOH44g=;
        b=j/eoUZlEy88gaCuHkEBYzcb4RD062ILqiAkQQHT/t/cy9ZtoI5LPPOqgVzuUo0O/Az
         IS+UcgFRTj8L0MqI8mxUk3dmcqiZLXhJPCBKqEnpJ8mmjaANR4omhMp3rC0egXlXY7Ut
         Bcuod84ZaJbd2KGfEy6YTGBojpTSTwi00+QJ+7fy5LSfvqENNP+QGJtQt0en48HQHvOv
         bNdDSsCDAsmfvQhU5SYxHWuOjXAbV2oCvSKXKFlzrEd4FH2DnFhnO4eJAYWNmZDaYJsq
         D0qwp+9WQdV0QcrBMnXYylikzosVkPM9/3kME3UJ3UsS6kTfpylkyxe5kJVYQU/bZxex
         7dsQ==
X-Gm-Message-State: APjAAAX3JuAnCQ0wPfm0S783jBk8p7jEKDz5q03CKb7Fp7jb4AW8QsVi
        d929mjEdnX/aWGzKXXXWjAk=
X-Google-Smtp-Source: APXvYqwq2dX4d91vOXSbVX8gmUC4UrZCcNWdt58mjN3ivM5n725gVZp5CFelg37U0cexfntafwYyHQ==
X-Received: by 2002:a1c:407:: with SMTP id 7mr5618354wme.29.1578681398505;
        Fri, 10 Jan 2020 10:36:38 -0800 (PST)
Received: from localhost.localdomain (ip5f5bee3c.dynamic.kabel-deutschland.de. [95.91.238.60])
        by smtp.gmail.com with ESMTPSA id x11sm3182825wre.68.2020.01.10.10.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 10:36:37 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        pedrom.sousa@synopsys.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <huobean@gmail.com>
Subject: [PATCH v1 0/3] use UFS device indicated maximum LU number
Date:   Fri, 10 Jan 2020 19:36:03 +0100
Message-Id: <20200110183606.10102-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Jedec standard UFS 3.0 and UFS 2.1 Spec, Maximum
number of logical units supported by the UFS device is specified
by parameter bMaxNumberLU in Geometry Descriptor. This series
of patches is to delete macro definition UFS_UPIU_MAX_GENERAL_LUN,
and switch to use indicated value in descriptor instead.


Bean Huo (3):
  scsi: ufs: add max_lu_supported in struct ufs_dev_info
  scsi: ufs: initialize max_lu_supported while booting
  scsi: ufs: use UFS device indicated maximum LU number

 drivers/scsi/ufs/ufs-sysfs.c |  2 +-
 drivers/scsi/ufs/ufs.h       | 14 +++++++---
 drivers/scsi/ufs/ufshcd.c    | 51 +++++++++++++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 7 deletions(-)

-- 
2.17.1

