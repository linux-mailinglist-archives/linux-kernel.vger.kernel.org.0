Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190CA5A19F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 19:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF1RBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 13:01:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43949 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1RBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:01:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so3273643pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=wch5MM+H0l/uILtdINMEnnNWEA6lOEztjug6TCu857U=;
        b=FQY+R2DnA3Qf3YvRtJPhTAvekIg9gvZOFGlpJExkD5LxnLSrXBzEuxr01irHMHsEfH
         gi07+jeixj+LHqVKz+xjfHl47lq41f5YWph/T3yUwal4Xml8yNhUt0d0rVeVtedrHS6k
         qNB5XDjFFZxw/veugJ/wdJW3i65YVvhwn0auowed2KkDPGqQrnhE16P5NJ2qFKgSsWR7
         GNBwAiqheof/QJf+Ezyj5b5nqsHMsw2KHCktTosyELCZJT41T/xXDav6ZOTj8Jb7OMAU
         8oMACAFrLCMAIrMMFJCAMVON6f+NVFmowhCdi59kZ9qNCnGlGkINQWXymc1a3kAjJaPg
         ikFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=wch5MM+H0l/uILtdINMEnnNWEA6lOEztjug6TCu857U=;
        b=B+J8grzstLPSQrJyUT5bGT6STSMgQf5hbTzMTIFWE0L5KOliidEVWkW47StKNXlWB4
         DC6vOF+Z6Ca4KjMYOrj1GYG/aCvONlJdMXSwUYD1E+i5fjxw/m3gh3Az4URg0eIVVQBx
         ECfTtTf42n+X9Ol1aFgpIWKB1b2ezkOBngDicJmdIKRoK7LZv14a8OOuf0x9Gny5+zA9
         rpsXwe97w5Pmy0wbcZp4Gn7tSCYGLOcpCyBldbsZCWnz4YKSi1JuPvM4oxdDHr41VRMm
         DKKpa0VLJRXBblWgtNFsI2AuueZAXt3EdlSBTvGn5hxCmSsMRkHwbHPCCHm9XU9AbRgN
         mztQ==
X-Gm-Message-State: APjAAAVzJOQpE6Zu4xt4enhEDrZuhsM9Jsa/OSZz2ZrT8EiMyJ38qCGq
        R64+xQThfLSfZ/b3wsciHCI=
X-Google-Smtp-Source: APXvYqxFlvZtf4xwVnsKaTpIGlUpTSe66C+iBAc4DMzGG/Evt4ErEBLnBIt7TO2IRbDP5ugqx5opMg==
X-Received: by 2002:a63:c607:: with SMTP id w7mr10125845pgg.379.1561741277725;
        Fri, 28 Jun 2019 10:01:17 -0700 (PDT)
Received: from localhost.localdomain ([183.83.73.90])
        by smtp.gmail.com with ESMTPSA id 30sm2971033pjk.17.2019.06.28.10.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 10:01:17 -0700 (PDT)
From:   Harsh Jain <harshjain32@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, harshjain32@gmail.com,
        harshjain.prof@gmail.com
Subject: [PATCH 0/2] staging:kpc2000:Fix integer as null pointer warning
Date:   Fri, 28 Jun 2019 22:30:44 +0530
Message-Id: <20190628170046.3219-1-harshjain32@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: root <harshjain32@gmail.com>

It fixes sparse warning in kpc2000 driver.

Harsh Jain (2):
  staging:kpc2000:Fix symbol not declared warning
  staging:kpc2000:Fix integer as null pointer warning

 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

