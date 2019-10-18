Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E84DC3F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 13:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442658AbfJRL0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 07:26:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41682 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389257AbfJRL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:26:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9IBQgpP052342;
        Fri, 18 Oct 2019 06:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571398002;
        bh=SGgYh3SnaZDe4luA7XBqvh2HpjuvgWKDMwr4BQhthWQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sHgftTDeMeG9jgm2d39Jqa/67L50GluK/v/GytMQAryOgXShPxnErsACEWdW0mIJ4
         +S4M5gL6GRr2H7wQt/3MjEXcQVAsCZpS49r802pypbRjAHcsn787tI2VMRT8LVdQLI
         p+LQp1r+BcHdoeRwdMVn2SWMqKIM/N3QLCD28pKE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9IBQgLG011551
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Oct 2019 06:26:42 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 18
 Oct 2019 06:26:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 18 Oct 2019 06:26:34 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9IBQd0M047364;
        Fri, 18 Oct 2019 06:26:40 -0500
Subject: Re: [RFC] mmc: cqhci: commit descriptors before setting the doorbell
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20191014183849.14864-1-faiz_abbas@ti.com>
 <CAPDyKFqbRNXaNVEACFQkKEymaY=Jm8L65-Ne_LbAmqFUkY1zcw@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <ceb94a3f-9785-9fc7-b9e5-35435df9b498@ti.com>
Date:   Fri, 18 Oct 2019 16:57:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqbRNXaNVEACFQkKEymaY=Jm8L65-Ne_LbAmqFUkY1zcw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On 18/10/19 4:28 PM, Ulf Hansson wrote:
> On Mon, 14 Oct 2019 at 20:37, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Add a write memory barrier to make sure that descriptors are actually
>> written to memory before ringing the doorbell.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> 
> Applied for fixes and by adding a stable tag, thanks!
> 
> BTW, do you have a valid commit that it fixes?
> 
You can add:

Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")

Thanks,
Faiz
