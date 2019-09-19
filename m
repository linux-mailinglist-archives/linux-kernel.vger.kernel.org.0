Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD6B703E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 02:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbfISAz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 20:55:28 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40426 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730468AbfISAz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:55:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id t15so699974ybg.7;
        Wed, 18 Sep 2019 17:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wHG36BAP0um3rlZ2FiO+UUtL5lnaki7vS7H2s93gT9M=;
        b=FQNLuUHU+rIximf7glugM2M34hlIeLsaXgpINSVt+ReuvyaCZ4IQPJ0sk4jVKv01zp
         COo6Q7aPVSnc8FlSmVDT6Mg9fyUyjCan3w3T/Cg0O9gjoPWQEeFSRR2QVUSVkxCna1a6
         1OilYTxgXcTUsAe3b9uWsmrt5Qokoi74VjMVAxZOaMDkt3eyV07iLesZJ5vhA+kvthVf
         8Ic8vOYYa6XSlDmmDs8vj1aEn0v8AB4Iieq6Axkhrvu+BjCFKi8Or7GbZ68cz96Y2dK5
         4VdfOOW6c6AMYBXMmbn9fPYVGGDYzkzgQAC09hskt1o+J0tYV6SHxj1lMo9lc6pGFb6R
         Q3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wHG36BAP0um3rlZ2FiO+UUtL5lnaki7vS7H2s93gT9M=;
        b=PkoIVmtPKFCAqWTC3x7iu9va0sGHlE3o7dNSCfdQyR0KYk62xSGY8pcVLz9sB+NWwd
         Ji6lySPxhQcm4svRtWgk4kBZI8AlK9izIiMIYgGtLXSsuRob0DY+TQ1EqwpAnjsblbCJ
         niENVqfS52tm0hr0C2DswUg5U8eX+yFf+NGgJluzkWssiTir/QUf2JhMrDLVAaEI297i
         c2z2eMee8qY44pXaVvj1/mu548F1nsv7/ZPr+67wYz7aJ4KxjYG81p3wBkR14cJW+cwF
         Q5u3q7IDSp5I+OsKfjh3A5OQisrD/MnrabrvlkIeaSO57uTQWjxFl6AnZbbsufXGoD86
         E6nA==
X-Gm-Message-State: APjAAAX8RtnTQZJ9NrvGAQ81kOPMJL293gbllIqju8aMlKJtpqVNHKdd
        AWRDYsNDm27NBiaDmYbL5w==
X-Google-Smtp-Source: APXvYqyROnimNIGEZnITQLk6uP7atW1wlBuyT4f97KIpqZ1zDe/7PmIQ+cd5bbb/nY1YsjEUEkH5mw==
X-Received: by 2002:a25:2647:: with SMTP id m68mr2350316ybm.190.1568854526643;
        Wed, 18 Sep 2019 17:55:26 -0700 (PDT)
Received: from 960.localdomain ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id u69sm1692475ywu.93.2019.09.18.17.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:55:25 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Mattias Jacobsson <2pi@mok.nu>, Takashi Iwai <tiwai@suse.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] platform/x86: Huawei WMI laptop extras driver
Date:   Wed, 18 Sep 2019 20:54:52 -0400
Message-Id: <20190919005505.23822-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
* Use battery charge control API.

This patch series introduce changes to huawei-wmi driver that includes:
* Move to platform driver
* Implement driver quirks and parameters
* Implement WMI management interface
* Add micmute LED support through WMI
* Add battery charging protection support through WMI
* Add fn-lock support through WMI
* Add a debugfs interface to WMI

# Move to platform driver

The current driver offers hotkeys and micmute led support only. With
these changes, a platform driver makes more sense since it handles these
changes pretty nicely.

# Implement WMI management interface

Huawei Matebook laptops come with two WMI interfaces. The first being
WMI0 which is considered "legacy" and AFAIK only found on the Matebook X
released in 2017. The second has a UID of "HWMI" and is found in pretty
much all models with a slight difference in implementation except for
the Matebook X (2017). Since this model has two interfaces, some aspects
are controlled through the legacy interface and some through the other
interface. Currently, the legacy interface is not fully implemented and
is only used for hotkeys and further debugging has to be done.

The WMI interface takes a 64 bit integer, although uses 32 bits most of
the time, and returns a 256-260 bytes buffer consists of either one ACPI
buffer of 260 bytes, in the case of Matebook X (2017), or one ACPI
package of two buffers, one with 4 bytes, and the other with 256 bytes.
We only care about the latter 256 buffer in both cases since the 4 bytes
always return zeros. The first byte of this 256 buffer always has the
return status where 1 indicated error. Some models require calling the
WMI interface twice to execute a command.

# Add micmute LED support through WMI

After implementing the WMI interface, micmute LED can be controlled
easily. Models with the legacy interface fall back to ACPI EC method
control since the legacy interface is not implemented.

# Add battery charging protection support through WMI

Most models, that has the WMI interface, are capable of battery
protection where it can control battery charging thresholds and limits
charging the battery to certain values.

# Add fn-lock support through WMI

The behavior of hotkeys is not the same among all models. Some models
require fn-lock to do things like `Ctrl-Ins` or `Alt-PrtSc`. By default,
hotkeys behave as special keys (media keys, Ins, etc), but if a modifier
is used (ctrl, alt, shift) these keys behave as F1-F12 keys. If the Fn
key is toggled on, the hotkeys with or without a modifier, behave as
F1-F12 keys. This makes it impossible to use a modifier and `PrtSc` or
`Ins`.

Now, some models fix this by excluding `PrtSc` and `Ins` keys from being
treated as F11 and F12 keys with the use of a modifier. However, some
models do not, and fixes this by the so called fn-lock.

Fn-lock inverts the behavior of the top row from special keys to F1-F12
keys. So a modifier and a special key would be possible which make
things like `Alt-Ins` possible. Now, with fn-lock we would have 4 modes:

* Fn-key off & fn-lock off - hotkeys treated as special keys using a
  modifier gives F1-F12 keys.
* Fn-key on & fn-lock off - hotkeys treated as F1-F12 keys and using a
  modifier gives F1-F12.
* Fn-key off & fn-lock on - hotkeys are treated as F1-F12 keys and using
  a modifier gives special keys.
* Fn-key on & fn-lock on - hotkeys are treated as special keys and using
  a modifier gives special keys.

# Implement driver quirks and parameters

The driver introduces 3 quirks and 2 parameters that can change the
driver's behavior. These quirks being as:
1. Fixes reporting brightness keys twice since it's already handled by
   acpi-video.
2. Some models need a short delay when setting battery thresholds to
   prevent a race condition when two processes read/write.
3. Matebook X (2017) handles micmute led through the "legacy" interface
   which is not currently implemented. Use ACPI EC method to control
   this led.

and the 2 parameters can enforce the behavior of quirk 1 & 2.

# Add a debugfs interface to WMI

An interface to the WMI management interface that allows easier
debugging.

Ayman Bagabas (6):
  platform/x86: huawei-wmi: Move to platform driver
  platform/x86: huawei-wmi: Add quirks and module parameters
  platform/x86: huawei-wmi: Implement huawei wmi management
  platform/x86: huawei-wmi: Add battery charging thresholds
  platform/x86: huawei-wmi: Add fn-lock support
  platform/x86: huawei-wmi: Add debugfs support

 drivers/platform/x86/huawei-wmi.c | 872 ++++++++++++++++++++++++++----
 1 file changed, 780 insertions(+), 92 deletions(-)

-- 
2.21.0

