Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E6BEB15C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 14:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfJaNkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 09:40:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40512 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726803AbfJaNkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:40:47 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 670877ED1617A348749B;
        Thu, 31 Oct 2019 21:40:43 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 21:40:38 +0800
Message-ID: <5DBAE455.30406@huawei.com>
Date:   Thu, 31 Oct 2019 21:40:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Mark Brown <broonie@kernel.org>
CC:     <bardliao@realtek.com>, <oder_chiou@realtek.com>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Make rt5677_spi_pcm_page static
References: <1571919319-4205-1-git-send-email-zhongjiang@huawei.com> <20191031132010.GR4568@sirena.org.uk>
In-Reply-To: <20191031132010.GR4568@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 21:20, Mark Brown wrote:
> On Thu, Oct 24, 2019 at 08:15:19PM +0800, zhong jiang wrote:
>> The GCC complains the following warning.
>>
>> sound/soc/codecs/rt5677-spi.c:365:13: warning: symbol 'rt5677_spi_pcm_page' was not declared. Should it be static?
> It looks like this has been fixed already in the latest code.
Yes,  I has noticed that. 

Thanks,
zhong jiang

