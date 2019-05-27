Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F982B0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfE0JHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 05:07:51 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35316 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0JHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:07:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4R96u0w109353;
        Mon, 27 May 2019 04:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558948016;
        bh=6S54ESIYMmpxy+kompIXto4pV+JNxqetVk/JuZrY26k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cUTjl+r4BCYvMRqp88aG3GR29rQn0tlI6WBN0noSL9+vc7MKiZn4unA4HF1n+zvsa
         +rocwno3NetwGkFDLvyxeYEEFUPxgCxSlhZkEBPoCi1ahsaO7a9VCwYwhjUxEPpnAK
         po3guNyCI1SBx+wy7rXVhHLvU8eCtjc/YWZv8k5E=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4R96uEc018108
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 May 2019 04:06:56 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 27
 May 2019 04:06:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 27 May 2019 04:06:55 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4R96rV0066362;
        Mon, 27 May 2019 04:06:54 -0500
Subject: Re: [PATCH] drm/omapdrm: fix warning PTR_ERR_OR_ZERO can be used
To:     Matteo Croce <mcroce@redhat.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190525073026.GA7114@hari-Inspiron-1545>
 <CAGnkfhzauQGgGdvPtkNcdGkjvo1BsORxZ6f3SzGzQYuYCDetUg@mail.gmail.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <9f72e575-82b6-0dc0-ec36-1e21d355c9f0@ti.com>
Date:   Mon, 27 May 2019 12:06:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGnkfhzauQGgGdvPtkNcdGkjvo1BsORxZ6f3SzGzQYuYCDetUg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/05/2019 17:56, Matteo Croce wrote:
> On Sat, May 25, 2019 at 9:30 AM Hariprasad Kelam
> <hariprasad.kelam@gmail.com> wrote:
>>
>> fix below warnings reported by coccicheck
>>
> 
> Hi,
> 
> a similar patch was nacked because it makes backports more difficult:
> 
> https://lore.kernel.org/lkml/3dec4093-824e-b13d-d712-2dedd445a7b7@ti.com/
> 
> Tomi, what's your thought?
> 

I don't particularly like the PTR_ERR_OR_ZERO, and changing old code to 
use it seem pointless.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
