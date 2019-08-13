Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD88B1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 09:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfHMH7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 03:59:30 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:28424 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726986AbfHMH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:59:30 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7D7wkVX015820;
        Tue, 13 Aug 2019 02:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=drWtMvMOAVnhK8sSftAQV6/8V0+8UJy3F8iMkB2QTgk=;
 b=BuR1tuqDlRal7QIiMhpyfz40pfaoc+tN9CYekkRSsIbfdERQZXrEgMF8AVMipZ0dreSh
 rZNJ8eC5IrQaA9WpGgPbY8Idwo33n39NdCYG7hEtNImzsH1oE8Hm0SLGbsXjTI28RfAe
 J/Me83MaLYbghlvtmQiIhcM5WT/T+hP9B2U5xox18bBNXPCo3I6Qwwf5RUKbxiAqQvVL
 y+UQXLthLDjzBHI599FLCUyUixcEQJWJa6/tVghreZpBgEQ4TjWT4wL1FRRoNUkLagTH
 vIfC3QGIK9kDgL2Hjxs/BlS7PR6FoQrP1z+JJ1z4BuWIVZdaaqF1JTTPmtu26RzmJCMC oQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ubf9brmee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Aug 2019 02:59:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 13 Aug
 2019 08:59:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 13 Aug 2019 08:59:23 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1D51345;
        Tue, 13 Aug 2019 08:59:23 +0100 (BST)
Date:   Tue, 13 Aug 2019 08:59:23 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] mfd: madera: Add support for requesting the supply
 clocks
Message-ID: <20190813075923.GN54126@ediswmail.ad.cirrus.com>
References: <20190806151321.31137-1-ckeepax@opensource.cirrus.com>
 <20190806151321.31137-2-ckeepax@opensource.cirrus.com>
 <20190812103853.GM26727@dell>
 <20190812160937.GM54126@ediswmail.ad.cirrus.com>
 <20190813071814.GY26727@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190813071814.GY26727@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908130088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:18:14AM +0100, Lee Jones wrote:
> On Mon, 12 Aug 2019, Charles Keepax wrote:
> > On Mon, Aug 12, 2019 at 11:38:53AM +0100, Lee Jones wrote:
> > > On Tue, 06 Aug 2019, Charles Keepax wrote:
> > > 
> > > > Add the ability to get the clock for each clock input pin of the chip
> > > > and enable MCLK2 since that is expected to be a permanently enabled
> > > > 32kHz clock.
> > > > 
> > > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > > ---
> > > >  int madera_dev_init(struct madera *madera)
> > > >  {
> > > > +	static const char * const mclk_name[] = { "mclk1", "mclk2", "mclk3" };
> > > >  	struct device *dev = madera->dev;
> > > >  	unsigned int hwid;
> > > >  	int (*patch_fn)(struct madera *) = NULL;
> > > > @@ -450,6 +451,17 @@ int madera_dev_init(struct madera *madera)
> > > >  		       sizeof(madera->pdata));
> > > >  	}
> > > >  
> > > > +	BUILD_BUG_ON(ARRAY_SIZE(madera->mclk) != ARRAY_SIZE(mclk_name));
> > > 
> > > Not sure how this could happen.  Surely we don't need it.
> > > 
> > 
> > mclk_name is defined locally in this function and the mclk array in
> > include/linux/mfd/madera/core.h. This is to guard against one of
> > them being updated but not the other. It is by no means essential
> > but it feels like a good trade off given there is really limited
> > downside.
> 
> It's fine in general I guess.  How likely would it be for anyone to
> update either of the definitions?  Can there be more/less clocks on a
> supported platform?
> 

It's not super likely but if the hardware guys make a new spin
out chip with an extra clock pin which is possible. But my
problem here is there really is no down side to this check, we
have two things that need to be in sync and if the compiler can
warn me if they are not in sync that is clearly a win.

> > > > +	for (i = 0; i < ARRAY_SIZE(madera->mclk); i++) {
> > > > +		madera->mclk[i] = devm_clk_get_optional(madera->dev,
> > > > +							mclk_name[i]);
> > > > +		if (IS_ERR(madera->mclk[i])) {
> > > > +			dev_warn(madera->dev, "Failed to get %s: %ld\n",
> > > > +				 mclk_name[i], PTR_ERR(madera->mclk[i]));
> > > 
> > > Do we even want to warn on the non-acquisition of an optional clock?
> > > 
> > > Especially with a message that looks like something actually failed.
> > > 
> > 
> > devm_clk_get_optional will return NULL if the clock was not
> > specified, so this is silent in that case. A warning in the case
> > something actually went wrong seems reasonable even if the clock
> > is optional as the user tried to do something and it didn't
> > behave as they intended.
> 
> If something actually went wrong, then doesn't then become and error
> and should be reported (returned)?
> 

Yeah I guess its a judgement call but there is not really any
reason we need to proceed in the case of an error. I will update
to fail probe here.

> > > > +			madera->mclk[i] = NULL;
> > > > +		}
> > > > +	}
> > > > +
> > > >  	ret = madera_get_reset_gpio(madera);
> > > >  	if (ret)
> > > >  		return ret;
> > > > @@ -660,13 +672,19 @@ int madera_dev_init(struct madera *madera)
> > > >  	}
> > > >  
> > > >  	/* Init 32k clock sourced from MCLK2 */
> > > > +	ret = clk_prepare_enable(madera->mclk[MADERA_MCLK2]);
> > > > +	if (ret != 0) {
> > > > +		dev_err(madera->dev, "Failed to enable 32k clock: %d\n", ret);
> > > > +		goto err_reset;
> > > > +	}
> > > 
> > > What happened to this being optional?
> > > 
> > 
> > The device needs the clock but specifying it through DT is
> > optional (the clock framework functions are no-ops and return
> > success if the clock pointer is NULL). Normally the 32kHz
> > clock is always on, and more importantly no existing users of
> > the driver will be specifying one.
> > 
> > We could remove the optional status for MCLK2, but it could break
> > existing users who don't yet specify the clock until they update
> > their DT and it will complicate the code as the other clocks are
> > definitely optional, so MCLK2 will need special handling.
> 
> I'd prefer the code to reflect the actual situation.  If the clock is
> not optional it doesn't sound correct to specify it as such.  Maybe as
> an intermediary step we attempt to obtain it, but ignore missing
> clocks (with a message and comment) if it is not yet specified.  We
> can look to change the behaviour once users have had the chance to
> update their DTs.
> 

Ok I will add a print for a missing MCLK2.

Thanks,
Charles
