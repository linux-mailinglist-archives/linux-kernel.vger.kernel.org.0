Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B184E6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfD2PnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 11:43:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60930 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfD2PnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:43:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD0580D;
        Mon, 29 Apr 2019 08:43:02 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BFB23F5C1;
        Mon, 29 Apr 2019 08:42:59 -0700 (PDT)
Subject: Re: [PATCH v6 00/13] Add support for usb on Hikey960
To:     Yu Chen <chenyu56@huawei.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com
References: <20190420064019.57522-1-chenyu56@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <766eb894-f939-02d2-5a3b-03fb51f7c4ee@arm.com>
Date:   Mon, 29 Apr 2019 16:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420064019.57522-1-chenyu56@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/04/2019 07:40, Yu Chen wrote:
> The patchset adds support for usb functionality of Hikey960, includes:
> - usb phy driver for Hisilicon Kirin Soc hi3660
> - usb driver for HiKey960 board
> - some adjustment in dwc3 and usb role driver
> - dts for support usb of HiKey960
> 

Still works fine on my Debian setup:

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks,
Valentin
