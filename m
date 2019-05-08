Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F162F18180
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 23:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfEHVKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 17:10:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:10:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so84202pfa.10;
        Wed, 08 May 2019 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=07BOO7U5xcapfXnneDkgQZbWTgcEELbJBQkQs75ET+I=;
        b=f9p94f0yEajnquy6qgPWpbX/r9AqRq8MGMxzjYW+ZKDzIoqzAPhoN23BTCY7E5c0z1
         Jw4WtWkrsEuq8qZuswzE65cW0QgHTaqzYLeL/gb1aBSIpp14pNuAekpKMhJ/oUjIlHwl
         V22C3AgKvmSqePmFLAKjW7KqAJeRx/90sgCY6D7sONo57GkiM1wFsQXZEDMQjLN2NV2l
         zVO7v1kEMX6YUkeixgrZOOdVpduYJHE9+U9sDOXLqbBJHSw2HkmaMBe+X9WB3ARCwDn3
         0bTZEQrwY9yZL9d6c3L2vIpYU9JlYHDho0CXzl+8qU/Rx1rHvwJTjV1RssxdbhMJl6WZ
         At0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=07BOO7U5xcapfXnneDkgQZbWTgcEELbJBQkQs75ET+I=;
        b=ofuIAQYd/8BeBYbHoxRWSW2Jbk1NW92uzpfb12jvyp9M+kLmqeiwQKd5Yhy3nauU2u
         zplEUYA1vZxqp/TXWC04zihffyLUBHUwTfheWetLyS3XG3hhvZjR6Z2HOJU/ubDO7j2i
         dUJ+7tB5+um17PeGY3f3V6BYpEOPG507QVo9+DajclD0dx0V27360dKkhgj2qR2lVLNt
         Pf5bzTazm3l1YqopJ016k3aPEDhXmhALeA1WLNz67XjY6sN7LjDBykM/DCaJ+pL/4kyL
         vWb8XvBvDi3ReBypKvVfaDeWbmtXo9eU6FgLOqFSkMGflLGcLQ0cQAGRaD3gXBxfdBtM
         09QQ==
X-Gm-Message-State: APjAAAXM64KQRWkok8IAhThksGJW71A7pq6KW8KQ7MO2wzqZlkaJcx4d
        O1/lyAGzv4XUYu1luX5GU/AmtnWl
X-Google-Smtp-Source: APXvYqyPzHqkoKsaUvrCiik7J8XYWuRdshAizY9cMBTAAtCyDlW8ZS16ofvebzy7sM2sYQCF0cRBKQ==
X-Received: by 2002:a65:6644:: with SMTP id z4mr417902pgv.300.1557349819400;
        Wed, 08 May 2019 14:10:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d67sm228765pfa.35.2019.05.08.14.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 14:10:18 -0700 (PDT)
Date:   Wed, 8 May 2019 14:10:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
Message-ID: <20190508211017.GA29998@roeck-us.net>
References: <20190508184635.5054-1-f.fainelli@gmail.com>
 <20190508184635.5054-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508184635.5054-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 11:46:35AM -0700, Florian Fainelli wrote:
> If the SCMI firmware implementation is reporting values in a scale that
> is different from the HWMON units, we need to scale up or down the value
> according to how far appart they are.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Question is which tree this series should go through. I am fine with arm.

Thanks,
Guenter

> ---
>  drivers/hwmon/scmi-hwmon.c | 45 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index a80183a488c5..2c7b87edf5aa 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -18,6 +18,47 @@ struct scmi_sensors {
>  	const struct scmi_sensor_info **info[hwmon_max];
>  };
>  
> +static inline u64 __pow10(u8 x)
> +{
> +	u64 r = 1;
> +
> +	while (x--)
> +		r *= 10;
> +
> +	return r;
> +}
> +
> +static int scmi_hwmon_scale(const struct scmi_sensor_info *sensor, u64 *value)
> +{
> +	s8 scale = sensor->scale;
> +	u64 f;
> +
> +	switch (sensor->type) {
> +	case TEMPERATURE_C:
> +	case VOLTAGE:
> +	case CURRENT:
> +		scale += 3;
> +		break;
> +	case POWER:
> +	case ENERGY:
> +		scale += 6;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (abs(scale) > 19)
> +		return -E2BIG;
> +
> +	f = __pow10(abs(scale));
> +	if (scale > 0)
> +		*value *= f;
> +	else
> +		*value = div64_u64(*value, f);
> +
> +        return 0;
> +}
> +
>  static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			   u32 attr, int channel, long *val)
>  {
> @@ -29,6 +70,10 @@ static int scmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  
>  	sensor = *(scmi_sensors->info[type] + channel);
>  	ret = h->sensor_ops->reading_get(h, sensor->id, false, &value);
> +	if (ret)
> +		return ret;
> +
> +	ret = scmi_hwmon_scale(sensor, &value);
>  	if (!ret)
>  		*val = value;
>  
> -- 
> 2.17.1
> 
