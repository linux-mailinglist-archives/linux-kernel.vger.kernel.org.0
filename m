Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78055B66AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 17:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbfIRPFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 11:05:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52305 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfIRPFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:05:25 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAbWB-0000Jr-CT; Wed, 18 Sep 2019 17:05:19 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAbWA-0004H0-Pv; Wed, 18 Sep 2019 17:05:18 +0200
Date:   Wed, 18 Sep 2019 17:05:18 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] regulator: da9062: fix suspend_enable/disable
 preparation
Message-ID: <20190918150518.vqphd2rsopesbi7q@pengutronix.de>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-2-m.felsch@pengutronix.de>
 <AM5PR1001MB0994E4B24181AEFCA0C26CF2808E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB0994E4B24181AEFCA0C26CF2808E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:03:13 up 123 days, 21:21, 69 users,  load average: 0.37, 0.20,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 19-09-18 12:41, Adam Thomson wrote:
> On 17 September 2019 13:43, Marco Felsch wrote:
> 
> > Currently the suspend reg_field maps to the pmic voltage selection bits
> > and is used during suspend_enabe/disable() and during get_mode(). This
> > seems to be wrong for both use cases.
> 
> Hi Marco,
> 
> I'd be very surprised if what was in place was wrong as I know Stephen tested
> this driver thoroughly over its lifetime. Regardless, I'll need some time to review
> your proposed updates to make sure this aligns with our expectation of operation.

Thanks for the upcoming review.

Regards,
  Marco


> > 
> > Use case one (suspend_enabe/disable):
> > Those callbacks are used to mark a regulator device as enabled/disabled
> > during suspend. Marking the regulator enabled during suspend is done by
> > the LDOx_CONF/BUCKx_CONF bit within the LDOx_CONT/BUCKx_CONT
> > registers.
> > Setting this bit tells the DA9062 PMIC state machine to keep the
> > regulator on in POWERDOWN mode and switch to suspend voltage.
> > 
> > Use case two (get_mode):
> > The get_mode callback is used to retrieve the active mode state. Since
> > the regulator-setting-A is used for the active state and
> > regulator-setting-B for the suspend state there is no need to check
> > which regulator setting is active.
> > 
> > Fixes: 4068e5182ada ("regulator: da9062: DA9062 regulator driver")
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  drivers/regulator/da9062-regulator.c | 118 +++++++++++----------------
> >  1 file changed, 47 insertions(+), 71 deletions(-)
> > 
> > diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-
> > regulator.c
> > index 2ffc64622451..9b2ca472f70c 100644
> > --- a/drivers/regulator/da9062-regulator.c
> > +++ b/drivers/regulator/da9062-regulator.c
> > @@ -136,7 +136,6 @@ static int da9062_buck_set_mode(struct regulator_dev
> > *rdev, unsigned mode)
> >  static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
> >  {
> >  	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
> > -	struct regmap_field *field;
> >  	unsigned int val, mode = 0;
> >  	int ret;
> > 
> > @@ -158,18 +157,7 @@ static unsigned da9062_buck_get_mode(struct
> > regulator_dev *rdev)
> >  		return REGULATOR_MODE_NORMAL;
> >  	}
> > 
> > -	/* Detect current regulator state */
> > -	ret = regmap_field_read(regl->suspend, &val);
> > -	if (ret < 0)
> > -		return 0;
> > -
> > -	/* Read regulator mode from proper register, depending on state */
> > -	if (val)
> > -		field = regl->suspend_sleep;
> > -	else
> > -		field = regl->sleep;
> > -
> > -	ret = regmap_field_read(field, &val);
> > +	ret = regmap_field_read(regl->sleep, &val);
> >  	if (ret < 0)
> >  		return 0;
> > 
> > @@ -208,21 +196,9 @@ static int da9062_ldo_set_mode(struct regulator_dev
> > *rdev, unsigned mode)
> >  static unsigned da9062_ldo_get_mode(struct regulator_dev *rdev)
> >  {
> >  	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
> > -	struct regmap_field *field;
> >  	int ret, val;
> > 
> > -	/* Detect current regulator state */
> > -	ret = regmap_field_read(regl->suspend, &val);
> > -	if (ret < 0)
> > -		return 0;
> > -
> > -	/* Read regulator mode from proper register, depending on state */
> > -	if (val)
> > -		field = regl->suspend_sleep;
> > -	else
> > -		field = regl->sleep;
> > -
> > -	ret = regmap_field_read(field, &val);
> > +	ret = regmap_field_read(regl->sleep, &val);
> >  	if (ret < 0)
> >  		return 0;
> > 
> > @@ -408,10 +384,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_BUCK1_CONT,
> > +			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9061_ID_BUCK2,
> > @@ -444,10 +420,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_BUCK3_CONT,
> > +			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9061_ID_BUCK3,
> > @@ -480,10 +456,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_BUCK4_CONT,
> > +			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9061_ID_LDO1,
> > @@ -509,10 +485,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
> >  		.suspend_vsel_reg = DA9062AA_VLDO1_B,
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_LDO1_CONT,
> > +			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -542,10 +518,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
> >  		.suspend_vsel_reg = DA9062AA_VLDO2_B,
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_LDO2_CONT,
> > +			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -575,10 +551,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
> >  		.suspend_vsel_reg = DA9062AA_VLDO3_B,
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_LDO3_CONT,
> > +			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -608,10 +584,10 @@ static const struct da9062_regulator_info
> > local_da9061_regulator_info[] = {
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
> >  		.suspend_vsel_reg = DA9062AA_VLDO4_B,
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_LDO4_CONT,
> > +			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -652,10 +628,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK1_MODE_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_BUCK1_MODE_MASK)) - 1),
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VBUCK1_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_BUCK1_CONT,
> > +			__builtin_ffs((int)DA9062AA_BUCK1_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VBUCK1_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_BUCK1_CONF_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9062_ID_BUCK2,
> > @@ -688,10 +664,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK2_MODE_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_BUCK2_MODE_MASK)) - 1),
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VBUCK2_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_BUCK2_CONT,
> > +			__builtin_ffs((int)DA9062AA_BUCK2_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VBUCK2_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_BUCK2_CONF_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9062_ID_BUCK3,
> > @@ -724,10 +700,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK3_MODE_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_BUCK3_MODE_MASK)) - 1),
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VBUCK3_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_BUCK3_CONT,
> > +			__builtin_ffs((int)DA9062AA_BUCK3_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VBUCK3_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_BUCK3_CONF_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9062_ID_BUCK4,
> > @@ -760,10 +736,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			__builtin_ffs((int)DA9062AA_BUCK4_MODE_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_BUCK4_MODE_MASK)) - 1),
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VBUCK4_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_BUCK4_CONT,
> > +			__builtin_ffs((int)DA9062AA_BUCK4_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VBUCK4_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_BUCK4_CONF_MASK) - 1),
> >  	},
> >  	{
> >  		.desc.id = DA9062_ID_LDO1,
> > @@ -789,10 +765,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_LDO1_SL_B_MASK)) - 1),
> >  		.suspend_vsel_reg = DA9062AA_VLDO1_B,
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VLDO1_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_LDO1_CONT,
> > +			__builtin_ffs((int)DA9062AA_LDO1_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VLDO1_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_LDO1_CONF_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO1_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -822,10 +798,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_LDO2_SL_B_MASK)) - 1),
> >  		.suspend_vsel_reg = DA9062AA_VLDO2_B,
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VLDO2_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_LDO2_CONT,
> > +			__builtin_ffs((int)DA9062AA_LDO2_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VLDO2_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_LDO2_CONF_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO2_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -855,10 +831,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_LDO3_SL_B_MASK)) - 1),
> >  		.suspend_vsel_reg = DA9062AA_VLDO3_B,
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VLDO3_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_LDO3_CONT,
> > +			__builtin_ffs((int)DA9062AA_LDO3_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VLDO3_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_LDO3_CONF_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO3_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > @@ -888,10 +864,10 @@ static const struct da9062_regulator_info
> > local_da9062_regulator_info[] = {
> >  			sizeof(unsigned int) * 8 -
> >  			__builtin_clz((DA9062AA_LDO4_SL_B_MASK)) - 1),
> >  		.suspend_vsel_reg = DA9062AA_VLDO4_B,
> > -		.suspend = REG_FIELD(DA9062AA_DVC_1,
> > -			__builtin_ffs((int)DA9062AA_VLDO4_SEL_MASK) - 1,
> > +		.suspend = REG_FIELD(DA9062AA_LDO4_CONT,
> > +			__builtin_ffs((int)DA9062AA_LDO4_CONF_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > -			__builtin_clz((DA9062AA_VLDO4_SEL_MASK)) - 1),
> > +			__builtin_clz(DA9062AA_LDO4_CONF_MASK) - 1),
> >  		.oc_event = REG_FIELD(DA9062AA_STATUS_D,
> >  			__builtin_ffs((int)DA9062AA_LDO4_ILIM_MASK) - 1,
> >  			sizeof(unsigned int) * 8 -
> > --
> > 2.20.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
