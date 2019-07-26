Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC577225
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfGZT3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 15:29:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGZT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jX5EOIh7X//JiCBku09XqFeAZkIi1umzwzBH6CgJpO0=; b=SHKu2B4kT7+ehHc/KnvGc1sgYv
        NkGxY9sbOdHoh66sfBQgtmu2LUmwsGSweHNaBKes7MybYkvTDr+AYKi1WXHiANlQ7h0FWnbWeQK0C
        XQNDlMR1FCPfM/YsBiHbCtmeW32ZhID678vu1BcAxv1vpWgrPsEuSRF/6GoXuhITBBfOaDDXTq9Ek
        aTZYtKtFSsyz/nJe35Iw4lzZOTaapKc5g+qQVdoAz4637cGF/ayDs3QDB6J4r7z6sfHjoELe5krCQ
        pUk7WI+NBGUPnlm1DAZqTax5+vInCgS0/dl3s7CNdDUeMfjan/P+gwdFmHMGtCodJ7ROG6sO1l3t/
        qw3GL+RA==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr5u1-00046t-TS; Fri, 26 Jul 2019 19:29:17 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hr5tz-0004ye-K2; Fri, 26 Jul 2019 16:29:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 2/5] MAINTAINERS: fix reference to net phy ABI file
Date:   Fri, 26 Jul 2019 16:29:11 -0300
Message-Id: <16d0b1a858591e874f577f9bb2a7feee239be7cf.1564169297.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
References: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file sysfs-bus-mdio got removed in favor of sysfs-class-net-phydev,
with contained a duplicated set of information.

Fixes: a6cd0d2d493a ("Documentation: net-sysfs: Remove duplicate PHY device documentation")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 506ac266cf57..b57dd8494c93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6061,7 +6061,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-mdio
+F:	Documentation/ABI/testing/sysfs-class-net-phydev
 F:	Documentation/devicetree/bindings/net/ethernet-phy.yaml
 F:	Documentation/devicetree/bindings/net/mdio*
 F:	Documentation/networking/phy.rst
-- 
2.21.0

