Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BD11A969
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEKU2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 16:28:25 -0400
Received: from narfation.org ([79.140.41.39]:34154 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfEKU2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 16:28:25 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 May 2019 16:28:24 EDT
Received: from sven-desktop.home.narfation.org (unknown [IPv6:2a00:1ca0:1480:f1fc::4065])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id 44A201100D9;
        Sat, 11 May 2019 22:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1557605968; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references:openpgp:autocrypt;
        bh=7w4hc+IcRext4UXbUarhDzyKL3rDHUZzGOnD6LexJ18=;
        b=pQNNebF3QrUxQPUOvgWNO4PhvNG3fNe2eguAwUwV23jReO0FEQ45DXxNgs71I5xshCDgAv
        QRyCT2oeLXDr+ikLTNs3hHFFxnduadcUWvxorMNgASk+nFuuZdoa5Hv6EQ9NDj72LyxB9M
        Ru+u4R1UE2bnM0UD39ZLWDYYZJynRss=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] scripts/spdxcheck.py: Fix path to deprecated licenses
Date:   Sat, 11 May 2019 22:19:16 +0200
Message-Id: <20190511201917.20828-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1557605968; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references:openpgp:autocrypt;
        bh=7w4hc+IcRext4UXbUarhDzyKL3rDHUZzGOnD6LexJ18=;
        b=pkt8sH9FGWCnY1byVoTeJ/4W3OcPspWWgHAwKrYlW5F0iA7EeV5bAwQptbk9P5Sni42rgv
        UdDLkEBWwNzU2rFFwWIiDZoZZb70oCglVjMjfXUYKvFH9Mmqf8JQdr8EctC/c48z1Z89xw
        i/lZ+AdThayEw0KXaLS0TDFZKT9Puys=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1557605968; a=rsa-sha256;
        cv=none;
        b=zEv1csVNyBD1jnOIa6gCxq+smzkcaGHujyvJuXYRC86ejMPOuwSkN6vCpXS8cxuGCXPzSP
        06Wxw+AZvpa08SB1UG4QR9qgsftqwZsmxxcRbjM2G0+wbpz17l2qHjhP57KM76CqsjOxbM
        HOjy4SZh9p0LAj/6SiLt6c4aLdU4yrI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The directory name for other licenses was changed to "deprecated" in 
commit 62be257e986d ("LICENSES: Rename other to deprecated"). But it was
not changed for spdxcheck.py. As result, checkpatch failed with

  FAIL: "Blob or Tree named 'other' not found"
  Traceback (most recent call last):
    File "scripts/spdxcheck.py", line 240, in <module>
      spdx = read_spdxdata(repo)
    File "scripts/spdxcheck.py", line 41, in read_spdxdata
      for el in lictree[d].traverse():
    File "/usr/lib/python2.7/dist-packages/git/objects/tree.py", line 298, in __getitem__
      return self.join(item)
    File "/usr/lib/python2.7/dist-packages/git/objects/tree.py", line 244, in join
      raise KeyError(msg % file)
  KeyError: "Blob or Tree named 'other' not found"

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 62be257e986d ("LICENSES: Rename other to deprecated")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 scripts/spdxcheck.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 4fe392e507fb..1a39b34588b7 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -32,7 +32,7 @@ class SPDXdata(object):
 def read_spdxdata(repo):
 
     # The subdirectories of LICENSES in the kernel source
-    license_dirs = [ "preferred", "other", "exceptions" ]
+    license_dirs = [ "preferred", "deprecated", "exceptions" ]
     lictree = repo.head.commit.tree['LICENSES']
 
     spdx = SPDXdata()
-- 
2.20.1

