Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88F99580
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbfHVNwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:52:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36594 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHVNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:52:23 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i0nVc-000291-Uj; Thu, 22 Aug 2019 13:52:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] typec: tcpm: fix a typo in the comparison of pdo_max_voltage
Date:   Thu, 22 Aug 2019 14:52:12 +0100
Message-Id: <20190822135212.10195-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There appears to be a typo in the comparison of pdo_max_voltage[i]
with the previous value, currently it is checking against the
array pdo_min_voltage rather than pdo_max_voltage. I believe this
is a typo. Fix this.

Addresses-Coverity: ("Copy-paste error")
Fixes: 5007e1b5db73 ("typec: tcpm: Validate source and sink caps")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 166b28562395..96562744101c 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1439,7 +1439,7 @@ static enum pdo_err tcpm_caps_err(struct tcpm_port *port, const u32 *pdo,
 				else if ((pdo_min_voltage(pdo[i]) ==
 					  pdo_min_voltage(pdo[i - 1])) &&
 					 (pdo_max_voltage(pdo[i]) ==
-					  pdo_min_voltage(pdo[i - 1])))
+					  pdo_max_voltage(pdo[i - 1])))
 					return PDO_ERR_DUPE_PDO;
 				break;
 			/*
-- 
2.20.1

