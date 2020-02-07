Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511941551B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 06:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgBGFNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 00:13:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36328 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgBGFNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 00:13:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0175DIIl001896;
        Thu, 6 Feb 2020 23:13:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581052398;
        bh=nFqSw1uJXXeCdB7orYGvSAdf7N0xCIPP5G/vQ8n0EOA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UXwU7DzGs8N1iwQ0Wlxr5VBqcKxTnuonLE9550joWb2DuQcl+6bBCajGayLXi/mOH
         5JVHqgY5JH92C0egdyo9E1NcpjlM7OPO2+pGs0JLh/H5SDXYr5Fb91U8GNJuOzvMdv
         vpXcC8OAhcaEu+rtb27HeE1YLj7tVZPDUxfevmK8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0175DIgu039530
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Feb 2020 23:13:18 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 6 Feb
 2020 23:13:17 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 6 Feb 2020 23:13:16 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0175DE2H023823;
        Thu, 6 Feb 2020 23:13:15 -0600
Subject: Re: [PATCH] phy: core: Add consumer device link support
To:     youling257 <youling257@gmail.com>, <alexandre.torgue@st.com>
CC:     <yoshihiro.shimoda.uh@renesas.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20191104143713.11137-1-alexandre.torgue@st.com>
 <20200206133918.15012-1-youling257@gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0c4a37a9-0a2e-e698-f423-53060854ea05@ti.com>
Date:   Fri, 7 Feb 2020 10:46:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200206133918.15012-1-youling257@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/02/20 7:09 PM, youling257 wrote:
> This patch cause "dwc3 dwc3.3.auto: failed to create device link to dwc3.3.auto.ulpi" problem.
> https://bugzilla.kernel.org/show_bug.cgi?id=206435

I'm suspecting there is some sort of reverse dependency with dwc3 ULPI.
Can you try the following diff?

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 2eb28cc2d2dc..397311dcb116 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -687,7 +687,7 @@ struct phy *phy_get(struct device *dev, const char
*string)

        get_device(&phy->dev);

-       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
        if (!link) {
                dev_err(dev, "failed to create device link to %s\n",
                        dev_name(phy->dev.parent));
@@ -802,7 +802,7 @@ struct phy *devm_of_phy_get(struct device *dev,
struct device_node *np,
                return phy;
        }

-       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
        if (!link) {
                dev_err(dev, "failed to create device link to %s\n",
                        dev_name(phy->dev.parent));
@@ -851,7 +851,7 @@ struct phy *devm_of_phy_get_by_index(struct device
*dev, struct device_node *np,
        *ptr = phy;
        devres_add(dev, ptr);

-       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
        if (!link) {
                dev_err(dev, "failed to create device link to %s\n",
                        dev_name(phy->dev.parent));

Thanks
Kishon
