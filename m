Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB86932AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 10:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfFCIh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 04:37:27 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:51588 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725856AbfFCIh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:37:26 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x538UCI1022227;
        Mon, 3 Jun 2019 03:37:19 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2sunsr9v90-1;
        Mon, 03 Jun 2019 03:37:19 -0500
Received: from EDIEX01.ad.cirrus.com (ediex01.ad.cirrus.com [198.61.84.80])
        by mail3.cirrus.com (Postfix) with ESMTP id 9620D612C693;
        Mon,  3 Jun 2019 03:37:55 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 3 Jun
 2019 09:37:12 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 3 Jun 2019 09:37:12 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 27E1544;
        Mon,  3 Jun 2019 09:37:12 +0100 (BST)
Date:   Mon, 3 Jun 2019 09:37:12 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] regulator: arizona-micsupp: Delete unused include
Message-ID: <20190603083712.GK28362@ediswmail.ad.cirrus.com>
References: <20190531230252.6541-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190531230252.6541-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=745 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906030063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2019 at 01:02:52AM +0200, Linus Walleij wrote:
> This driver uses no symbols from <linux/gpio.h> so just drop
> this include.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
