Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC73E138EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 11:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgAMK1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 05:27:20 -0500
Received: from foss.arm.com ([217.140.110.172]:37190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbgAMK1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:27:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6570413D5;
        Mon, 13 Jan 2020 02:27:15 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AC473F534;
        Mon, 13 Jan 2020 02:27:14 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: add reg property to brcmf sub node
To:     Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200110142128.13522-1-jbx6244@gmail.com>
 <CA+z=w3UjX71Nw7W+iiGkQh=UJkPMsEn1phSdp25d--O8QM-ETQ@mail.gmail.com>
 <2116127.mXfZQK7onI@phil>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6159eaa4-4729-0c3d-0967-e855e2652772@arm.com>
Date:   Mon, 13 Jan 2020 10:27:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2116127.mXfZQK7onI@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2020 9:26 am, Heiko Stuebner wrote:
> Hi Johan,
> 
> Am Freitag, 10. Januar 2020, 16:40:24 CET schrieb Johan Jonker:
>> Hi,
>>
>> Question for Heiko or rob+dt.
>> Where would should #address-cells and #size-cells go in the dts or to the dtsi.
>> In case they become required in a futhure rockchip-dw-mshc.yaml?
>> ie. Should we patch all XXX rockchip,rk3288-dw-mshc nodes with them?
> 
> I don't think it is a required property for the dw-mmc itself, as only
> in special-cases do you need subnodes there. Like emmc and sd-cards
> are completely probeable without needing further information and
> only the wifi/bt chips _might_ need these.
> 
> So I don't think that this is a property of the controller itself, but te
> connected card - hence should stay in the board file.

Indeed, and in general dtc already warns about those properties being 
present unnecessarily, e.g.:

arch/arm64/boot/dts/rockchip/rk3399.dtsi:1812.27-1847.4: Warning 
(avoid_unnecessary_addr_size): /mipi@ff968000: unnecessary 
#address-cells/#size-cells without "ranges" or child "reg" property

Robin.
