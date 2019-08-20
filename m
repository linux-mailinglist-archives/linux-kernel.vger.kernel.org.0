Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C857595C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 12:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfHTKvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 06:51:43 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:53974 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729485AbfHTKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:51:42 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7KAoZZL018379;
        Tue, 20 Aug 2019 05:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=Sd676kgDI3J5BISCCZv/3KEjP4ZC3vS5nBNkBDvdlT0=;
 b=haBM+TFv81wjfbTy2gzkyHRKdd5Dp++9G/JisUqDimpXzWeySaY8iqwQ9YSCSd2FfsF8
 +VyRZb7rakMGFsVo8mC/QFzdnQoi+24CQry/xYWv1DUFhbZIR+7FGqhS/ykJTXUSJRGe
 5b9KkrONyrfp8paKLD2b5JqiEP8bM4GzfMSh5pofaLA280c0hARHDxPV3LvT3givxRVm
 UH9kSWKfJhTxnc6VJ8/jT6rA8HVJgSsi7bYHh8A2824jHJc3W+Vbx4vMsYDtYsESg2Qu
 xylcXPJ3cbPZbV4PzYtb37kBNBWoXSaxBEup47TfKofAUMtmWdpqtnk4PBbtok1rTlT1 eg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2uef01df6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Aug 2019 05:50:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 20 Aug
 2019 11:50:33 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 20 Aug 2019 11:50:33 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3BBCF2A3;
        Tue, 20 Aug 2019 10:50:33 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:50:33 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH 2/2] ASoC: wm8904: implement input mode select as a mux
Message-ID: <20190820105033.GG10308@ediswmail.ad.cirrus.com>
References: <f95ae1085f9f3c137a122c4d95728711613c15f7.1566297120.git.mirq-linux@rere.qmqm.pl>
 <17f8556414a0e5352dc570fa16d50bd1bc2b4b0a.1566297120.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17f8556414a0e5352dc570fa16d50bd1bc2b4b0a.1566297120.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 mlxlogscore=709 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908200113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 12:33:33PM +0200, Michał Mirosław wrote:
> Make '* Capture Mode' a mux. This makes DAPM know that in single-ended
> mode only inverting mux paths need to be enabled.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> +static const struct snd_kcontrol_new rin_mode =
> +	SOC_DAPM_ENUM("right Capture Mode", rin_mode_enum);

Minor nit missing a captial on the right here.

Otherwise looks good:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
