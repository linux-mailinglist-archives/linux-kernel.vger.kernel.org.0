Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F26ADAAD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 13:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394156AbfJQLH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 07:07:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40448 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393638AbfJQLH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:07:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9HB7K1a064246;
        Thu, 17 Oct 2019 06:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571310440;
        bh=gGHXuaGN6JWtNLkiVaFXPm/K1WA5sPtAM5owozosUj4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SXqiXIX52GQ1nwaIZ0TlJqA/ZiugfcL1FvnC5U0t4UfqZtoOdy/7lgp/CRrhnG7Z6
         CBuQhGrsQl6iX658NhAHg6yVchrj0o9QAQKVtHgbGbCDv9qfs2W/rTnTlefuqr3LHe
         gZ5Hd1t0K5a3thM8xNTiVweF1qh01vWgMhnht5u8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9HB7KBG042799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Oct 2019 06:07:20 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 17
 Oct 2019 06:07:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 17 Oct 2019 06:07:20 -0500
Received: from [172.24.190.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9HB7Hjo032997;
        Thu, 17 Oct 2019 06:07:19 -0500
Subject: Re: [PATCH] ARM: davinci: dm644x-evm: Add Fixed regulators needed for
 tlv320aic33
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <bgolaszewski@baylibre.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190830102308.22586-1-peter.ujfalusi@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <e6a03603-a901-56a8-c8ad-d528f2d51595@ti.com>
Date:   Thu, 17 Oct 2019 16:37:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830102308.22586-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/19 3:53 PM, Peter Ujfalusi wrote:
> The codec driver needs correct regulators in order to probe.
> Both VCC_3.3V and VCC_1.8V is always on fixed regulators on the board.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied for v5.4

Thanks,
Sekhar
