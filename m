Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C59DA1A87
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfH2Myj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 08:54:39 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53996 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfH2Myj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gJjym+6U2Rgn78kQllWIiUt41jB46M+x30/ZRv8UY9U=; b=ehlWA5dbTWGmu8U6nqSgAAD5R
        7zgbvrSnGBVqP6zTTxkCIukNWLadoaJvQLCmCm1AZc+YQKNEpRO7PGhlUnqUNstdzXc0uBiM65Qwg
        n1EHPyvCMiKCwz8hyRKnNPvzQ+r+hSJThRyZQ+3QmCFLJg9d0ALxv3/Id5DvOP5XDxCZ0=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i3Jwj-00023r-9W; Thu, 29 Aug 2019 12:54:37 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2DC3227428D1; Thu, 29 Aug 2019 13:54:36 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] MAINTAINERS: Add keyword pattern on regulator_get_optional()
Date:   Thu, 29 Aug 2019 13:54:35 +0100
Message-Id: <20190829125435.48770-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to try to contain abuses of regulator_get_optional() add a
keyword entry to the MAINTAINERS stanza for the regulator API so that the
regulator maintainers get CCed on new usages.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6876813b94a3..cabf636cc694 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17342,6 +17342,7 @@ F:	Documentation/power/regulator/
 F:	drivers/regulator/
 F:	include/dt-bindings/regulator/
 F:	include/linux/regulator/
+K:	regulator_get_optional
 
 VRF
 M:	David Ahern <dsa@cumulusnetworks.com>
-- 
2.20.1

