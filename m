Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20995139001
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 12:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgAMLWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 06:22:55 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56655 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMLWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:22:54 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200113112252euoutp016ed758ce864e919298b4f2bee715bd8a~pbnBLMVGi2105721057euoutp01x
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 11:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200113112252euoutp016ed758ce864e919298b4f2bee715bd8a~pbnBLMVGi2105721057euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578914572;
        bh=ix1rkgGPZPzm5yktB53W1Jh9DT6iYWfQ3B5imBJCsTk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nW0sK/dfnu24LUjnFte6y9Dj1OmIsjLm9+q9xF0lbCdcBX1NCfw9NCF89obsj3jjo
         ud2NeFzzo19V3qTRPvxPRC6PNi1z5tueRl9OXfElIQ3nH9kzZKrhAwJzCgw4qszIiW
         608LXzqQCZcS57PuTKohVPqlScBnxFH3Gzs8NNNk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200113112252eucas1p2fcc58a5aaaf50459127b3714d800d57f~pbnBDUxV30288202882eucas1p2i;
        Mon, 13 Jan 2020 11:22:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 8A.3A.60698.C035C1E5; Mon, 13
        Jan 2020 11:22:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200113112252eucas1p2bcaff3d6a3c671947b2764cec908c7e5~pbnAxbo100310003100eucas1p2E;
        Mon, 13 Jan 2020 11:22:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200113112252eusmtrp1bd5eba4d02a0ca424cf74fbd80cddfc3~pbnAw4r8X1393613936eusmtrp1Z;
        Mon, 13 Jan 2020 11:22:52 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-18-5e1c530cd3ff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 29.DC.08375.C035C1E5; Mon, 13
        Jan 2020 11:22:52 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200113112251eusmtip1e14c64b3e722415f5ddfeeaf4d30c16d~pbnAIb70H1545715457eusmtip1v;
        Mon, 13 Jan 2020 11:22:51 +0000 (GMT)
Subject: Re: [PATCH] ata: pxa: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     axboe@kernel.dk, vkoul@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4b9f3d2b-e1e4-48a4-c0e2-624bac77dba9@samsung.com>
Date:   Mon, 13 Jan 2020 12:22:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191217074033.21831-1-peter.ujfalusi@ti.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87o8wTJxBm3LdS1W3+1nszi24xGT
        xeVdc9gsZn38wWqx884JZgdWj8tnSz02repk8zh+YzuTx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        n64+Yi/4x1nRcnA2WwPjXI4uRk4OCQETiaP9O1m7GLk4hARWMEpMu/meCcL5wiixu+UFM4Tz
        mVHi/Ow3TDAtqx7OYgWxhQSWM0q82yICYb9llPh1tBjEFhaIlvi9ey8LiC0ioCVx69pNRhCb
        WSBB4vryNjCbTcBKYmL7KjCbV8BO4ubpx+wgNouAqsTPG8fB4qICERKfHhxmhagRlDg58wnY
        TE4Ba4n3Z+ZCzRSXuPVkPhOELS+x/e0csKMlBKazS5xv+soMcbSLxML9kxkhbGGJV8e3sEPY
        MhKnJ/ewQDSsY5T42/ECqns7o8Tyyf/YIKqsJe6c+wVkcwCt0JRYv0sfxJQQcJT4uLMcwuST
        uPFWEOIGPolJ26YzQ4R5JTrahCBmqElsWLaBDWZr186VzBMYlWYh+WwWkm9mIflmFsLaBYws
        qxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQITzOl/x7/uYNz3J+kQowAHoxIPr0StdJwQ
        a2JZcWXuIUYJDmYlEd5N56TihHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2a
        WpBaBJNl4uCUamCcI+6bVcsY9ySQd/UW8W2BVn86/01fanj2wd03Avo3JCd+PHEwvD/23oOA
        rcnmBu5Blw28O/alSyatLY03CfJMt72UnX7xqPZK802mLQIB9exdlhfPxzHpOAgr1brbP90s
        HLZ92e3ww3rTyu/MNlixap7fCkHnffcZbXa9/fVH1vGb3Ot9uqeVWIozEg21mIuKEwEHwOtW
        LAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xu7o8wTJxBj/3SlisvtvPZnFsxyMm
        i8u75rBZzPr4g9Vi550TzA6sHpfPlnpsWtXJ5nH8xnYmj8+b5AJYovRsivJLS1IVMvKLS2yV
        og0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyPl19xF7wj7Oi5eBstgbGuRxd
        jJwcEgImEqsezmLtYuTiEBJYyihx89k+li5GDqCEjMTx9WUQNcISf651sUHUvGaU+LL6ASNI
        QlggWuL37r0sILaIgJbErWs3weLMAgkS9zZeZ4Ro6GOUeLz4HztIgk3ASmJi+yqwIl4BO4mb
        px+DxVkEVCV+3jgOFhcViJA4vGMWVI2gxMmZT8AWcApYS7w/MxdqgbrEn3mXmCFscYlbT+Yz
        QdjyEtvfzmGewCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg
        VG079nPzDsZLG4MPMQpwMCrx8B6oko4TYk0sK67MPcQowcGsJMK76ZxUnBBvSmJlVWpRfnxR
        aU5q8SFGU6DnJjJLiSbnAyM+ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFM
        HxMHp1QDY4EA2/OemRt9FTyuCuXpidW9djzLfSaNT2vHquQwv2nNj++v1Wg5M9H000KbdLFF
        /IE32u1kb/xS4OucIq/quWb1YlUO5quH3Wp6Jxw6ff5aRafoxcXbnVfIP5jrYbgspmDVNG2N
        h9wKU59ovLZrdsoR+D1TlX3Olrfpwf+fzPe/xXw9S2ahuhJLcUaioRZzUXEiAJ+5GQjAAgAA
X-CMS-MailID: 20200113112252eucas1p2bcaff3d6a3c671947b2764cec908c7e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191217074028eucas1p1eeef714e4d8c2cff2c133ffd239d7468
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191217074028eucas1p1eeef714e4d8c2cff2c133ffd239d7468
References: <CGME20191217074028eucas1p1eeef714e4d8c2cff2c133ffd239d7468@eucas1p1.samsung.com>
        <20191217074033.21831-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/17/19 8:40 AM, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_pxa.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 41430f79663c..71678bed04b0 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -274,10 +274,9 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * Request the DMA channel
>  	 */
> -	data->dma_chan =
> -		dma_request_slave_channel(&pdev->dev, "data");
> -	if (!data->dma_chan)
> -		return -EBUSY;
> +	data->dma_chan = dma_request_chan(&pdev->dev, "data");
> +	if (IS_ERR(data->dma_chan))
> +		return PTR_ERR(data->dma_chan);
>  	ret = dmaengine_slave_config(data->dma_chan, &config);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "dma configuration failed: %d\n", ret);
> 
