Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0EFD182
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 00:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKNXXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 18:23:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:35778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726912AbfKNXXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:23:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 243A1AE07;
        Thu, 14 Nov 2019 23:23:06 +0000 (UTC)
Subject: Re: [PATCH 3/7] arm64: dts: realtek: rtd129x: Introduce r-bus
To:     James Tai <james.tai@realtek.com>
Cc:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-4-afaerber@suse.de>
 <f70d00d8b1f8446fb138b36c61d952f4@realtek.com>
 <a4d9c42767ac4f3a9eacab72be224f3c@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <8003e143-19f7-1de6-6e23-dadbb134a2e0@suse.de>
Date:   Fri, 15 Nov 2019 00:23:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <a4d9c42767ac4f3a9eacab72be224f3c@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 13.11.19 um 04:02 schrieb James Tai:
>>> +		rbus: r-bus@98000000 {
>>> +			compatible = "simple-bus";
>>> +			reg = <0x98000000 0x100000>;
>>> +			#address-cells = <1>;
>>> +			#size-cells = <1>;
>>> +			ranges = <0x0 0x98000000 0x100000>;
>>> +
>>
>> The r-bus size of RTD1395 is 0x200000.
>>
> 
> Sorry for the typo. The r-bus size of RTD1295 is 0x200000.

Fixed.

Thanks,
Andreas


-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
