Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041AE18006
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfEHSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 14:46:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38368 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHSqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:46:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so10945496pfo.5;
        Wed, 08 May 2019 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EEIALcFEhNF+WL2qzyLPm5x2lHhfDb/Qp5qzDZrKchA=;
        b=ED6Jc0y/rtA42Jk4s0/banDWfr2InZNBnE5IZQvmzqg0VUJkJntsNao4IhCL8FLN52
         FADam1XGvUx+ZLYVxJAj1wHDGzwGiH1Uwmt41QuFL15kLXvwiQJUUaIVux0DWKnMd2Jf
         9yaR/UHVIcNoO91XxgYAlxb0HluY3EGM+UTgCA1RY0q6gW1wbp0sjdmeEKpBCnHMaNZe
         kkSL40A1B8HFK+v3B59224xhwe/2bhPbiTWscuexqMTdjKsjYg2cBo0wkqUELtQv2O/w
         ql4ngjOjOJrp6/+QpDlinxa/RsN6fOKwOmSa+N+BpTNoMxM8ImyQ7bPhv4yKNjrnCwml
         4dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EEIALcFEhNF+WL2qzyLPm5x2lHhfDb/Qp5qzDZrKchA=;
        b=fHIxWaJb2O4wzlTHbdF+sMz03603up4k0wzaiakXbRKnV3jZCqsZEdyBXFEhaqvSe9
         9PMCaBGEtaR9ulwC0FbM9Gu/0CLb6fLoljaJrez4ENDYDwju9gXRm68GvUXVW0ZWQkKF
         lWV4v3GuoyYpJQfMsvpNtPr40oyOp91R19UXvQCbFka64I1o0Euq2ZN1K/LmGlXLINFe
         DSZN+hCHGq5qcqz2jdC6vT/uaIijg3BqGPoZ2E4ScWmlyVRB/kp0tPza3kdYH3T6XQ1D
         k+WOrfLI8N+wFAnbFSV/eUXxPg1R4tie8mTVM+6R5EqIdNCDh7q4M0CbzKvNGja1JI+j
         ythg==
X-Gm-Message-State: APjAAAUGnq3bCLzASVkr0CGS2nE1b3rIVoulwZByBdljUORMJYtTE2SA
        K0GmQQ9i6F8J74wFB66VjdOwS7RU
X-Google-Smtp-Source: APXvYqwdjxSZUPLBY7Xi7DbEBJHWjC57QwVVpV6zk5Y45uNkDlR4U6Vsbxb+TmsZfc3t/3Suf+vngw==
X-Received: by 2002:a65:5248:: with SMTP id q8mr32321120pgp.92.1557341200675;
        Wed, 08 May 2019 11:46:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o66sm23257953pfb.184.2019.05.08.11.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:46:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v5 0/2] hwmon: scmi: Scale values to target desired HWMON units
Date:   Wed,  8 May 2019 11:46:33 -0700
Message-Id: <20190508184635.5054-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep, Guenter,

This patch series adds support for scaling SCMI sensor values read from
firmware. Sudeep, let me know if you think we should be treating scale
== 0 as a special value to preserve some firmware compatibility (not
that this would be desired).

Changes in v5:
- overflow check would not work, so check specifically for an absolute
  scale being greater than 19 to avoid returning an incorrect power of
  10 factor
- fixed incorrect value argument passed to scmi_hwmon_scale().
- Added Guenter's Reviewed-by tag on the first patch

Changes in v4:
- deal with overflow in the caller of __pow10() as suggested by Guenter
  which makes us rework a bit how the value argument/return value are
  passed
- don't harcode the latest power of 10 factor to be 18, just rely on
  overflowing the u64 value instead

Changes in v3:

- add a local __pow10 function to scmi-hwmon.c while a plan to provide
  a generic function is figured out.
- add check on power > 18 which would overflow a 64-bit unsigned integer
- use div64_u64() to properly divide a 64-bit quantity with an unsigned
  64-bit quantity

Changes in v2:

- added a helper function in kernel.h: __pow10()
- made the scale in scmi_sensor_info an s8 type, added defines for
  checking the sign bit and sign extending with a mask
- simplify computations in hwmon driver

Florian Fainelli (2):
  firmware: arm_scmi: Fetch and store sensor scale
  hwmon: scmi: Scale values to target desired HWMON units

 drivers/firmware/arm_scmi/sensors.c |  6 ++++
 drivers/hwmon/scmi-hwmon.c          | 45 +++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h       |  1 +
 3 files changed, 52 insertions(+)

-- 
2.17.1

