Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97634BDC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 18:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfFSQMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 12:12:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33026 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfFSQMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:12:34 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6F02E688331B27644478;
        Wed, 19 Jun 2019 17:12:33 +0100 (IST)
Received: from [127.0.0.1] (10.202.227.157) by LHREML711-CAH.china.huawei.com
 (10.201.108.34) with Microsoft SMTP Server id 14.3.408.0; Wed, 19 Jun 2019
 17:12:31 +0100
Subject: Re: [PATCH v2 01/11] ARM: dts: hip04: Update coresight DT bindings
To:     Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Andy Gross" <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     Guodong Xu <guodong.xu@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
References: <20190508021902.10358-1-leo.yan@linaro.org>
 <20190508021902.10358-2-leo.yan@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <ee33f0b2-e016-7c2f-feca-6b9e2bfe1e43@hisilicon.com>
Date:   Wed, 19 Jun 2019 17:12:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190508021902.10358-2-leo.yan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 5/8/2019 3:18 AM, Leo Yan wrote:
> CoreSight DT bindings have been updated, thus the old compatible strings
> are obsolete and the drivers will report warning if DTS uses these
> obsolete strings.
> 
> This patch switches to the new bindings for CoreSight dynamic funnel and
> static replicator, so can dismiss warning during initialisation.
> 
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Applied to the hisilicon dt tree.
Thanks!

Best Regards,
Wei

