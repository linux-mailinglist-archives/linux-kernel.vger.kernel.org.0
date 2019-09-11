Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC43BB01C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfIKQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 12:39:55 -0400
Received: from smtp113.ord1c.emailsrvr.com ([108.166.43.113]:59718 "EHLO
        smtp113.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728828AbfIKQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1568219994;
        bh=ShXCPuRTmrlcXQzNVyVjvWiPOGKA9ghbqXSw5ScsjpY=;
        h=From:To:Subject:Date:From;
        b=ighaW8uwiJSs2+yv0J1Fj6FHIvEo+xB+FivBVZujCIPewmG5OsbTMmrWIvohtlegp
         gJEyD0z+VVKM/b6UJXE6BtIAg0kVA1FqgwBhe6fvwL59GytokCuLVczuxzAtRMKMHP
         //bDXfwK6xaZoQqVmsGnPxKCDa7ZDWM6MEg2/wPU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp15.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 9F8E620138;
        Wed, 11 Sep 2019 12:39:53 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 11 Sep 2019 12:39:54 -0400
From:   Ian Abbott <abbotti@mev.co.uk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] devices.txt: improve entry for comedi (char major 98)
Date:   Wed, 11 Sep 2019 17:39:41 +0100
Message-Id: <20190911163941.16664-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe how the comedi minor device numbers are split across comedi
devices and comedi subdevices.

Replace the current, long dead URL with an official URL for the Comedi
project.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 Documentation/admin-guide/devices.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index e56e00655153..1c5d2281efc9 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -1647,8 +1647,17 @@
 		  0 = /dev/comedi0	First comedi device
 		  1 = /dev/comedi1	Second comedi device
 		    ...
+		 47 = /dev/comedi47	48th comedi device
 
-		See http://stm.lbl.gov/comedi.
+		Minors 48 to 255 are reserved for comedi subdevices with
+		pathnames of the form "/dev/comediX_subdY", where "X" is the
+		minor number of the associated comedi device and "Y" is the
+		subdevice number.  These subdevice minors are assigned
+		dynamically, so there is no fixed mapping from subdevice
+		pathnames to minor numbers.
+
+		See http://www.comedi.org/ for information about the Comedi
+		project.
 
   98 block	User-mode virtual block device
 		  0 = /dev/ubda		First user-mode block device
-- 
2.23.0

