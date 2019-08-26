Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4E99D0B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfHZNdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 09:33:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40862 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfHZNde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:33:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7QDXPgb077692;
        Mon, 26 Aug 2019 08:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566826405;
        bh=x/l7WTUYQLyGQJpHktcZftFgeoQOSOMXYep1kT3lYfw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=R+SZaD59BlyW747nt5XrFCAdEOIDxeE8lQ1kTQSmRTsr7Mr//f+APNIRMwepeG2EB
         zTeM8hMKPFvEUyS2EVw7PP0bOj4ydRAQWJ/B58WxoYjvwyyelIb09mqEbCBCO8MQIW
         cAI8yJD+/gEXJdzHEFR23FMSFOM5VzE0wQC4blYE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7QDXPJZ106311
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Aug 2019 08:33:25 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 26
 Aug 2019 08:33:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 26 Aug 2019 08:33:25 -0500
Received: from [172.24.145.97] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7QDXMNr025859;
        Mon, 26 Aug 2019 08:33:23 -0500
Subject: Re: [PATCH] ARM: dts: da850-evm: Use generic jedec, spi-nor for flash
To:     Adam Ford <aford173@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <adam.ford@logicpd.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190723121042.28634-1-aford173@gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <24eb9276-87e2-575a-2c4f-967b65e61b1c@ti.com>
Date:   Mon, 26 Aug 2019 19:03:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723121042.28634-1-aford173@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/19 5:40 PM, Adam Ford wrote:
> Logic PD re-spun the L138 and AM1808 SOM's with larger flash.
> The m25p80 driver has a generic 'jedec,spi-nor' compatible option
> which is requests to use whenever possible since it will read the
> JEDEC READ ID opcode.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied to v5.4/dt

Thanks,
Sekhar
