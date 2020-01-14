Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC7913AC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 15:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgANOn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 09:43:27 -0500
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:38835 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgANOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1579013005;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=c4zjNVExD/q/xnTMWUxOWrOWIVpfGDo2l7+5R89dU/w=;
  b=at4PuBRzYm4J/fdJV23EcFWNEA1nbhizI14nox3cOCFXK5kY6CIeaAJG
   eVO0Jaaer9iGV0sfYhV/kp5g0s8ZJrqCNnLEg7PSBJ/UCSsJ9751vlaaD
   qwU8DgQcRgxymrYTS4P6GDWKlr8F0ehIybj3uA5RuhZBUOvDYnpz9gT+A
   M=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=igor.druzhinin@citrix.com; spf=Pass smtp.mailfrom=igor.druzhinin@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  igor.druzhinin@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  igor.druzhinin@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="igor.druzhinin@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="igor.druzhinin@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: BpbSJ8LorloQBSylyGbcUvu98MaLwOf3cj5LCIf/4ffN7UoVrA4Ta9z+3JVeQmXBWp5yKVOT2R
 +O5/d2h6ueGfOWcS5gAESj4X9ehJmNWgH8i/2l59CQ6KfLsbeuNqXqiCxB+S7n0VBJ0gP3faAB
 uWMkKbHVpuIjphIJ4IdYVe3JNegMmm69xMEDVxk9nUvXUJe8+F7h6p88f89w1haSs5HrE9L/7U
 W+MzyutcmiBeWe3L0vrEndBUDm2ud6QVL2EZEWWM7H9AUVaw2ztSogACIv3BOHH8m50LvnUI+t
 Ocs=
X-SBRS: 2.7
X-MesageID: 11479796
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,433,1571716800"; 
   d="scan'208";a="11479796"
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
To:     <fcoe-devel@open-fcoe.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hare@suse.de>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        Igor Druzhinin <igor.druzhinin@citrix.com>
Subject: [PATCH RESEND 0/2] Fixing libfc memory leaks
Date:   Tue, 14 Jan 2020 14:43:18 +0000
Message-ID: <1579013000-14570-1-git-send-email-igor.druzhinin@citrix.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hannes,

Could you take a look at those?
At least the first one causes noticeable memory decline over time
for some of our deployments.

Igor Druzhinin (2):
  scsi: libfc: free response frame from GPN_ID
  scsi: libfc: drop extra rport reference in fc_rport_create()

 drivers/scsi/libfc/fc_disc.c  | 2 ++
 drivers/scsi/libfc/fc_rport.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.7.4

