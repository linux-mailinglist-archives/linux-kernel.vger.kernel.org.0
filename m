Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8674BE16
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 18:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfFSQ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 12:28:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33029 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfFSQ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:28:39 -0400
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A9842B8F6A40CB58C3F5;
        Wed, 19 Jun 2019 17:28:37 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by lhreml701-cah.china.huawei.com
 (10.201.108.42) with Microsoft SMTP Server id 14.3.408.0; Wed, 19 Jun 2019
 17:28:34 +0100
Subject: Re: [PATCH 6/6] ARM: hisilicon: DT: Switch to SPDX header
To:     Lubomir Rintel <lkundrak@v3.sk>, Olof Johansson <olof@lixom.net>
CC:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "Patrice Chotard" <patrice.chotard@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190611072921.2979446-1-lkundrak@v3.sk>
 <20190611072921.2979446-7-lkundrak@v3.sk>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <fd8f8b6e-a9aa-7e94-8e9e-c44b466db73c@hisilicon.com>
Date:   Wed, 19 Jun 2019 17:28:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190611072921.2979446-7-lkundrak@v3.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir,

On 6/11/2019 8:29 AM, Lubomir Rintel wrote:
> The original license text had a typo ("publishhed") which would be
> likely to confuse automated licensing auditing tools. Let's just switch
> to SPDX instead of fixing the wording.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Thanks!
I found linux-next has already fix this.

Best Regards,
Wei


