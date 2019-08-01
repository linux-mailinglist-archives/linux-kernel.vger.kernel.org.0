Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16B7D7B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfHAIdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 04:33:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45166 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfHAIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:33:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x718X7fG098223;
        Thu, 1 Aug 2019 03:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564648387;
        bh=UIyFD3CEBcyi2gh/ZMDnZhMVTHUDJPbYvzwmc7DbVZE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ylRXfApxu8i/CJx1bMr1A5CnSGsOFdrrgNDoT6bhWZLT5HNRFtptZ/LUeDF7/ttlY
         Rzv8WoTzpf0ZTMVJUptMRKkxqUe5WwOn1MdZQ5ayVjhTDmbuQkfdrJcc+/qlR03Mrb
         t+afRJur154ATv17b8Ma3oe48bcFp9+FhH7edERY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x718X7k6108535
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Aug 2019 03:33:07 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 1 Aug
 2019 03:33:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 1 Aug 2019 03:33:07 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x718X6hX038546;
        Thu, 1 Aug 2019 03:33:06 -0500
Subject: Re: [PATCH] drm/omap: Add 'alpha' and 'pixel blend mode' plane
 properties
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20190711135219.23402-1-jjhiblot@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3c606028-4ed2-d97c-cbf3-ce7d1e698d21@ti.com>
Date:   Thu, 1 Aug 2019 11:33:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190711135219.23402-1-jjhiblot@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2019 16:52, Jean-Jacques Hiblot wrote:
> Add the following properties for planes:
> * alpha
> * pixel blend mode. Only "Pre-multiplied" and "Coverage" are supported
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> ---
>   drivers/gpu/drm/omapdrm/omap_plane.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Works for me and looks good. I'll queue this. Thanks!

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
