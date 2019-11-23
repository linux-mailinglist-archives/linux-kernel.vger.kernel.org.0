Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D13107CC4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 05:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKWEJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 23:09:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46612 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfKWEJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 23:09:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id n14so8384840oie.13;
        Fri, 22 Nov 2019 20:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/StAbOzu7TbVfpwEDDPv1iyC2lDLFD40/T8YtuapqgM=;
        b=csyKcR0G6duYbAFeSfsl0TObsmUCbg7yjnrstyyH4dQlTmJ35FInruSwHWJOBcab3T
         sZu0EMdMqS+h4N3EEoqb2lpglYcllBFIu192QF/Ec3hV2ArLj/nFWFSgItM/7eC2NU1u
         NfE2FQDgCbzo9dM4dg9CeQiHBliIPCQJnwMvLtkL1tB2vP1W4DMGxK1ims31tcOgAfIS
         5xGf/hfl99aue72wpqGIuUu0RK/AM53bWHr5gT6SthTLTAZ4KFuuLL29xNZpMzspM6hV
         5xI2741CrL0spL146gleHSvMejh7Bi41vSLwDLobP9osr0s3csri/zvKCCh6ZiW85LZH
         4otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/StAbOzu7TbVfpwEDDPv1iyC2lDLFD40/T8YtuapqgM=;
        b=d3mAghPy7TOM5tGxTSUrrEz63MJNakRdcyyeXcrtOrUR9aXtFeXvfGbLxeumBb/+O5
         YTieQU4WgtOSLrgHTkVo/ZZKmd2X3nHllKY38TS6oXdyKOhagJiMcUHifzgz7BSAaLhc
         mI+kqRxpz/ms15Mauat/JWhtBTuOEmYI9zdrB3QArQ657G3/1g3itC9XLcQDqPNs+sMH
         obzxpkGa7o0XcDkjrUw3dv1wUJYP8yjCampZ2RWcTmxPYIa66PwUx+TR1Ol0jnYDC2ZP
         9h3GsY5JtC4d+bVIgP1R9liQS0XFV7hWu+Qwh4tDEEufNUoCfdgLb2Fr43T4irjrMnO9
         jrpg==
X-Gm-Message-State: APjAAAXYSUUzAj+yKxyLKkjI3dyrxpCLud5umJ30/tfrp71/OSJ18sEY
        yXqcTfdzDsR2tDBQkie2D8w=
X-Google-Smtp-Source: APXvYqztg7h+ZdNBjZ+JwfJq+MHBkRf07w6eOrZ7gcY8qzAAQtM+4cY4xM2ObWJx3rVUhJo87tpGWg==
X-Received: by 2002:aca:ec45:: with SMTP id k66mr232432oih.179.1574482176302;
        Fri, 22 Nov 2019 20:09:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e93sm2957367otb.60.2019.11.22.20.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 20:09:35 -0800 (PST)
Date:   Fri, 22 Nov 2019 20:09:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Giovanni Mascellani <gio@debian.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dell-smm-hwmon: Add support for disabling
 automatic BIOS fan control
Message-ID: <20191123040933.GA13255@roeck-us.net>
References: <20191122101519.1246458-1-gio@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191122101519.1246458-1-gio@debian.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 11:15:18AM +0100, Giovanni Mascellani wrote:
> This patch exports standard hwmon pwmX_enable sysfs attribute for
> enabling or disabling automatic fan control by BIOS. Standard value
> "1" is for disabling automatic BIOS fan control and value "2" for
> enabling.
> 
> By default BIOS auto mode is enabled by laptop firmware.
> 
> When BIOS auto mode is enabled, custom fan speed value (set via hwmon
> pwmX sysfs attribute) is overwritten by SMM in few seconds and
> therefore any custom settings are without effect. So this is reason
> why implementing option for disabling BIOS auto mode is needed.
> 
> So finally this patch allows kernel to set and control fan speed on
> laptops, but it can be dangerous (like setting speed of other fans).
> 
> The SMM commands to enable or disable automatic fan control are not
> documented and are not the same on all Dell laptops. Therefore a
> whitelist is used to send the correct codes only on laptopts for which
> they are known.
> 
> This patch was originally developed by Pali Roh�r; later Giovanni
> Mascellani implemented the whitelist.
> 
> Signed-off-by: Giovanni Mascellani <gio@debian.org>
> Co-Developed-by: Pali Roh�r <pali.rohar@gmail.com>
> Signed-off-by: Pali Roh�r <pali.rohar@gmail.com>

Applied, after fixing checkpatch warnings.

Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 114 ++++++++++++++++++++++++++++++---
>  1 file changed, 104 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 4212d022d253..25d160b36a57 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -68,6 +68,8 @@ static uint i8k_pwm_mult;
>  static uint i8k_fan_max = I8K_FAN_HIGH;
>  static bool disallow_fan_type_call;
>  static bool disallow_fan_support;
> +static unsigned int manual_fan;
> +static unsigned int auto_fan;
>  
>  #define I8K_HWMON_HAVE_TEMP1	(1 << 0)
>  #define I8K_HWMON_HAVE_TEMP2	(1 << 1)
> @@ -300,6 +302,20 @@ static int i8k_get_fan_nominal_speed(int fan, int speed)
>  	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * i8k_fan_mult;
>  }
>  
> +/*
> + * Enable or disable automatic BIOS fan control support
> + */
> +static int i8k_enable_fan_auto_mode(bool enable)
> +{
> +	struct smm_regs regs = { };
> +
> +	if (disallow_fan_support)
> +		return -EINVAL;
> +
> +	regs.eax = enable ? auto_fan : manual_fan;
> +	return i8k_smm(&regs);
> +}
> +
>  /*
>   * Set the fan speed (off, low, high). Returns the new fan status.
>   */
> @@ -726,6 +742,35 @@ static ssize_t i8k_hwmon_pwm_store(struct device *dev,
>  	return err < 0 ? -EIO : count;
>  }
>  
> +static ssize_t i8k_hwmon_pwm_enable_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	int err;
> +	bool enable;
> +	unsigned long val;
> +
> +	if (!auto_fan)
> +		return -ENODEV;
> +
> +	err = kstrtoul(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	if (val == 1)
> +		enable = false;
> +	else if (val == 2)
> +		enable = true;
> +	else
> +		return -EINVAL;
> +
> +	mutex_lock(&i8k_mutex);
> +	err = i8k_enable_fan_auto_mode(enable);
> +	mutex_unlock(&i8k_mutex);
> +
> +	return err ? err : count;
> +}
> +
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, i8k_hwmon_temp, 0);
>  static SENSOR_DEVICE_ATTR_RO(temp1_label, i8k_hwmon_temp_label, 0);
>  static SENSOR_DEVICE_ATTR_RO(temp2_input, i8k_hwmon_temp, 1);
> @@ -749,6 +794,7 @@ static SENSOR_DEVICE_ATTR_RO(temp10_label, i8k_hwmon_temp_label, 9);
>  static SENSOR_DEVICE_ATTR_RO(fan1_input, i8k_hwmon_fan, 0);
>  static SENSOR_DEVICE_ATTR_RO(fan1_label, i8k_hwmon_fan_label, 0);
>  static SENSOR_DEVICE_ATTR_RW(pwm1, i8k_hwmon_pwm, 0);
> +static SENSOR_DEVICE_ATTR_WO(pwm1_enable, i8k_hwmon_pwm_enable, 0);
>  static SENSOR_DEVICE_ATTR_RO(fan2_input, i8k_hwmon_fan, 1);
>  static SENSOR_DEVICE_ATTR_RO(fan2_label, i8k_hwmon_fan_label, 1);
>  static SENSOR_DEVICE_ATTR_RW(pwm2, i8k_hwmon_pwm, 1);
> @@ -780,12 +826,13 @@ static struct attribute *i8k_attrs[] = {
>  	&sensor_dev_attr_fan1_input.dev_attr.attr,	/* 20 */
>  	&sensor_dev_attr_fan1_label.dev_attr.attr,	/* 21 */
>  	&sensor_dev_attr_pwm1.dev_attr.attr,		/* 22 */
> -	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 23 */
> -	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 24 */
> -	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 25 */
> -	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 26 */
> -	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 27 */
> -	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 28 */
> +	&sensor_dev_attr_pwm1_enable.dev_attr.attr,	/* 23 */
> +	&sensor_dev_attr_fan2_input.dev_attr.attr,	/* 24 */
> +	&sensor_dev_attr_fan2_label.dev_attr.attr,	/* 25 */
> +	&sensor_dev_attr_pwm2.dev_attr.attr,		/* 26 */
> +	&sensor_dev_attr_fan3_input.dev_attr.attr,	/* 27 */
> +	&sensor_dev_attr_fan3_label.dev_attr.attr,	/* 28 */
> +	&sensor_dev_attr_pwm3.dev_attr.attr,		/* 29 */
>  	NULL
>  };
>  
> @@ -828,16 +875,19 @@ static umode_t i8k_is_visible(struct kobject *kobj, struct attribute *attr,
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_TEMP10))
>  		return 0;
>  
> -	if (index >= 20 && index <= 22 &&
> +	if (index >= 20 && index <= 23 &&
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN1))
>  		return 0;
> -	if (index >= 23 && index <= 25 &&
> +	if (index >= 24 && index <= 26 &&
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN2))
>  		return 0;
> -	if (index >= 26 && index <= 28 &&
> +	if (index >= 27 && index <= 29 &&
>  	    !(i8k_hwmon_flags & I8K_HWMON_HAVE_FAN3))
>  		return 0;
>  
> +	if (index == 23 && !auto_fan)
> +		return 0;
> +
>  	return attr->mode;
>  }
>  
> @@ -1135,12 +1185,48 @@ static struct dmi_system_id i8k_blacklist_fan_support_dmi_table[] __initdata = {
>  	{ }
>  };
>  
> +struct i8k_fan_control_data {
> +	unsigned int manual_fan;
> +	unsigned int auto_fan;
> +};
> +
> +enum i8k_fan_controls {
> +	I8K_FAN_34A3_35A3,
> +};
> +
> +static const struct i8k_fan_control_data i8k_fan_control_data[] = {
> +	[I8K_FAN_34A3_35A3] = {
> +		.manual_fan = 0x34a3,
> +		.auto_fan = 0x35a3,
> +	},
> +};
> +
> +static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
> +	{
> +		.ident = "Dell Precision 5530",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Precision 5530"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> +	{
> +		.ident = "Dell Latitude E6440",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E6440"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> +	{ }
> +};
> +
>  /*
>   * Probe for the presence of a supported laptop.
>   */
>  static int __init i8k_probe(void)
>  {
> -	const struct dmi_system_id *id;
> +	const struct dmi_system_id *id, *fan_control;
>  	int fan, ret;
>  
>  	/*
> @@ -1200,6 +1286,14 @@ static int __init i8k_probe(void)
>  	i8k_fan_max = fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
>  	i8k_pwm_mult = DIV_ROUND_UP(255, i8k_fan_max);
>  
> +	fan_control = dmi_first_match(i8k_whitelist_fan_control);
> +	if (fan_control && fan_control->driver_data) {
> +		const struct i8k_fan_control_data *fan_control_data = fan_control->driver_data;
> +		manual_fan = fan_control_data->manual_fan;
> +		auto_fan = fan_control_data->auto_fan;
> +		pr_info("enabling support for setting automatic/manual fan control\n");
> +	}
> +
>  	if (!fan_mult) {
>  		/*
>  		 * Autodetect fan multiplier based on nominal rpm
