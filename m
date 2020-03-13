Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9647E184252
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 09:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCMIRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 04:17:31 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57322 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgCMIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:17:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02D8HTkI117623;
        Fri, 13 Mar 2020 03:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584087449;
        bh=W1XLhfYH7JOYKxG/hRoePa90UP4Vd2cNoqL3zerlMY4=;
        h=From:To:CC:Subject:Date;
        b=dr0ubNZoXsD9rKiWAE+WPBUmzc7bKDV7WCbTqyNpA7UUECBjmUPnStJJxtCVDvXsn
         UOeLQHgH/yXwbOyd9HSLN0fM3PeXn82R4nKluzjIT51Q8C/949apJgfMaaf3olr2kI
         IRH68cDCTMfhq9ILRzcvQiCodLGSFx9Ug+wRaiNA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02D8HTBk047066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Mar 2020 03:17:29 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 03:17:28 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 03:17:28 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02D8HQlW097835;
        Fri, 13 Mar 2020 03:17:26 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <s-anna@ti.com>, <afd@ti.com>
Subject: [PATCHv8 00/15] remoteproc: updates for omap remoteproc support
Date:   Fri, 13 Mar 2020 10:17:03 +0200
Message-ID: <20200313081718.30612-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ok one more round. This time applied Mathieu's and Andrew's acks on the
corresponding patches. Contains some minor changes based on comments to
patches #3, #4, #7, #10, #12, #14.

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
