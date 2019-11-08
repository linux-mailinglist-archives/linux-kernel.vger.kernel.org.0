Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30EDF3F9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 06:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfKHFUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 00:20:16 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:38500 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfKHFUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:15 -0500
Received: by mail-pl1-f175.google.com with SMTP id w8so3280171plq.5;
        Thu, 07 Nov 2019 21:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YuW1ipLzZ/2+gNhmz9GQaaZr1Idsk5f88aGw6tJt1FE=;
        b=h/Htgv05sKRRazJUllEnoeg0JF9DrJfLx+QhhEnGCfV+4oK3XW71fEWR6xZFnu8rba
         6l8xLBJWxW51VlEMz/bBR/OiaKWExGgNlNwSMPVRdc3z8I28eVuvr3RFE59DHmKQYBdr
         sTp4QRQN3orrHUh6AamiEiArid/lOOJqqdhi+a5G2i/o+iL851mAR7eWQVMQ8Yr6aYTb
         9ep/S4IbA9aGJpML1MvscFH/stjhsyXwD9dCW+ad5s5+VOb9Pg5Gmamg5f9wkXNHaRK1
         3Y7YYfDylifVoNKxvhBOG1r0ggRH0ccAI7Rx0ZTyx6N4PHc/dkabFgMdcCp8cjsXMfAH
         yuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YuW1ipLzZ/2+gNhmz9GQaaZr1Idsk5f88aGw6tJt1FE=;
        b=DkqST912SbTXGLU0w440K105ENk6S7NMo1Xaj7t+9MmfOhIPxigq7DuYRNqZXbMNQH
         or60Yz+V05xQsop02AI/vjEpqnRYbStZpBZCDLoSbKBc6hSoaHQrQKfM7wiYZjmyxYZM
         WkEyPw6Ix9IaR/z74wIq6NnQIfu72/T/TPT78y8n37pDNr9f0Q/ox1xwBYrXda1/Y08z
         VH0LCG4FIFgZ5IV1rO3rgS7P0I9K7lCkXq6oRGpy94KWEdp355x3PtjcCQxkxHbyUTab
         Wii13M8pGLGu/pDckp7Wj7fpDtsDAgQfjX4qtA8pp9fbiSrijdC5W6CZSd3AbRQDaerT
         hwdg==
X-Gm-Message-State: APjAAAXKDAsXb7r4X92QWsbjynEb0W5WGs/NeWgu0Dhl+IbMIMbtft7u
        OuNpwHIiLZGSmv9Q+e+Jw7U=
X-Google-Smtp-Source: APXvYqw3gu0p58jR3NALir+s/tOHFoe/Ibt9ItE1rMD3EBHbggifQSaQFtnZBgen2qwmkQOVnP1H1Q==
X-Received: by 2002:a17:90a:24b:: with SMTP id t11mr10871279pje.77.1573190414746;
        Thu, 07 Nov 2019 21:20:14 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:14 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: [PATCH v2 03/11] ABI: Update FSI path documentation
Date:   Fri,  8 Nov 2019 15:49:37 +1030
Message-Id: <20191108051945.7109-4-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paths added back in 4.13 weren't quite correct. The in reality the
files documented lived under

  /sys/devices/../fsi0/rescan
  /sys/devices/../fsi0/break
  /sys/devices/../fsi0/slave@00:00/term
  /sys/devices/../fsi0/slave@00:00/raw

In 5.5 with the addition of the FSI class they move to

  /sys/devices/../fsi-master/fsi0/rescan
  /sys/devices/../fsi-master/fsi0/break
  /sys/devices/../fsi-master/fsi0/slave@00:00/term
  /sys/devices/../fsi-master/fsi0/slave@00:00/raw

This is closer to how the (incorrect) documentation described them.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/ABI/testing/sysfs-bus-fsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-fsi b/Documentation/ABI/testing/sysfs-bus-fsi
index 57c806350d6c..320697bdf41d 100644
--- a/Documentation/ABI/testing/sysfs-bus-fsi
+++ b/Documentation/ABI/testing/sysfs-bus-fsi
@@ -1,25 +1,25 @@
-What:           /sys/bus/platform/devices/fsi-master/rescan
+What:           /sys/bus/platform/devices/../fsi-master/fsi0/rescan
 Date:		May 2017
 KernelVersion:  4.12
-Contact:        cbostic@linux.vnet.ibm.com
+Contact:        linux-fsi@lists.ozlabs.org
 Description:
                 Initiates a FSI master scan for all connected slave devices
 		on its links.
 
-What:           /sys/bus/platform/devices/fsi-master/break
+What:           /sys/bus/platform/devices/../fsi-master/fsi0/break
 Date:		May 2017
 KernelVersion:  4.12
-Contact:        cbostic@linux.vnet.ibm.com
+Contact:        linux-fsi@lists.ozlabs.org
 Description:
 		Sends an FSI BREAK command on a master's communication
 		link to any connnected slaves.  A BREAK resets connected
 		device's logic and preps it to receive further commands
 		from the master.
 
-What:           /sys/bus/platform/devices/fsi-master/slave@00:00/term
+What:           /sys/bus/platform/devices/../fsi-master/fsi0/slave@00:00/term
 Date:		May 2017
 KernelVersion:  4.12
-Contact:        cbostic@linux.vnet.ibm.com
+Contact:        linux-fsi@lists.ozlabs.org
 Description:
 		Sends an FSI terminate command from the master to its
 		connected slave. A terminate resets the slave's state machines
@@ -29,10 +29,10 @@ Description:
 		ongoing operation in case of an expired 'Master Time Out'
 		timer.
 
-What:           /sys/bus/platform/devices/fsi-master/slave@00:00/raw
+What:           /sys/bus/platform/devices/../fsi-master/fsi0/slave@00:00/raw
 Date:		May 2017
 KernelVersion:  4.12
-Contact:        cbostic@linux.vnet.ibm.com
+Contact:        linux-fsi@lists.ozlabs.org
 Description:
 		Provides a means of reading/writing a 32 bit value from/to a
 		specified FSI bus address.
-- 
2.24.0.rc1

