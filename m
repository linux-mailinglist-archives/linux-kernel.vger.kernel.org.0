Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD9DC078C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 16:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfI0O2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 10:28:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49234 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0O2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:28:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8REOIZF190898;
        Fri, 27 Sep 2019 14:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Rz1WKelrhXx/CX8CfO1Ki+c8gnklPMpb9zMgJPDFb08=;
 b=fkktZQXAnJ5jRf9NfvPe73M8qlAx3rnCqZhbmta/wD/sexw4ILyBAHwrID5c9OMu3POJ
 G2/nsxeGCnBAu2ExYHdtETIwNVnqGFagyeochWDiGTBQcq0xr6ILDHMrCgoIbZ943lI+
 0fw1YGQXNwI/J5UnKbwMZCofKL7OsowuGxep9hSW1YFXKc6lo2S8+PDPej5l9refK4rb
 nJ7hywdJGSl6ErksGW5YpA9C926H5GsrVR7X3fxAd4wQIVf5lIe87iXU2hiK7aTj1ehe
 lpkUFzVNa499m7gO2UvezmYdedHRxDuLYiwQYlcyb9nIl/JErP1xMiksycZlPDeFjMcL Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v5btqjm9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 14:27:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8RENX6P019009;
        Fri, 27 Sep 2019 14:27:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2v9m3f0adv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 14:27:48 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8RERi3U019336;
        Fri, 27 Sep 2019 14:27:45 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Sep 2019 07:27:44 -0700
Date:   Fri, 27 Sep 2019 17:27:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: acp3x: clean up an indentation issue
Message-ID: <20190927142552.GH27389@kadam>
References: <20190927103858.631-1-colin.king@canonical.com>
 <729ae953-b78a-9452-e8b3-3583a21a1295@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <729ae953-b78a-9452-e8b3-3583a21a1295@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9393 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909270134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9393 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909270134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 11:43:31AM +0100, Colin Ian King wrote:
> On 27/09/2019 11:38, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a return statement that is indented too deeply, remove
> > the extraneous tab.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  sound/soc/amd/raven/acp3x-pcm-dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
> > index bc4dfafdfcd1..ea57088d50ce 100644
> > --- a/sound/soc/amd/raven/acp3x-pcm-dma.c
> > +++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
> > @@ -631,7 +631,7 @@ static int acp3x_audio_probe(struct platform_device *pdev)
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!res) {
> >  		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
> > -			return -ENODEV;
> > +		return -ENODEV;
> >  	}
> >  
> >  	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
> > 
> Oops, I've sent this fix before. ignore. apologies.

Haha.  I used to do this all the time.  Now my QC script searches my
outbox.  I still send duplicates sometimes if I'm travelling and forget
to copy my outbox over.

regards,
dan carpenter

