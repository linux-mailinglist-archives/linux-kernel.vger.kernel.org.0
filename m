Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE1A8240
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 14:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfIDMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 08:18:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51513 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbfIDMSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:18:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id k1so3076807wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZUNvCNl71LL7bsOV2q3vh455zcpyuXw4iwVhdFBYbko=;
        b=qWT8T8t8cXk3gJqp5zZ0LNwl++o68vkXUweIMe4C+BVD3OYH5teo1CMvNy5D2/RyyY
         1fek0ayL+6+lhLrZh5sPHjSmhWZRGC8xrEgsyrz3zMX/Jwmrf+nM01GoUmZiKg1wih+x
         1RLARPW/5pG83iO/faxDUIegwvDNqu+nhMjJlH2XdnKoOjWJH8hd5WiPX7SacnpYZjbG
         lYMwjf/o9sXMgGDqoYGqvOkzMqVQJQz9eEe3CLsaeYPHol3m+ZlGCF14PG1MsYs6GyP2
         qxMkDEB+evV/eJquxuYh8kjTXd+OcpKBmB9/LOlrNG9hXTtYUH8NGu9q5kW8B3Lki7sQ
         OL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZUNvCNl71LL7bsOV2q3vh455zcpyuXw4iwVhdFBYbko=;
        b=PZqKgR4aoF4QJDCLyuBOJGSQC04Bl6mmfKK9VA/s/ZOF9S/zPARkax4aWg8t7osEpN
         /PGCNtLN5MxcGjPVcMZ1Ze6Hb71yY3GReEStg7H5Bj+TRKxDgfCyVZDVI3y3I8JcvPiE
         1LqOsZUps5GbIzy0VvN9bpWQg9d0DHZ7FGHS4xI76JY/2pYgdlFDl8V5fx32jhZ8zDoc
         3pl0uVWVD0nEixpReNOqDD/0DLGd4JxZzC7uQ/eznEinE6zB8i/uIQl3H+UUO3euqmL6
         JOdZwo3NtDa0wFAHJfE4tRJqJwKYiXvQO6wERrACoBSCcu3XNwYsfxDgRiB/zNnonT+d
         EdNg==
X-Gm-Message-State: APjAAAVBKBWJotOV1xNeWSwlmJnHYdIy1QBrWSL+4VpazoMh1kDh1QQo
        vjYxuNX8RBBlF2uzEFEQmIU5rQ==
X-Google-Smtp-Source: APXvYqy5ydGI/DCwg82bhVMUvfPqZPtc/DZDbnOwai2+G18YLAiMRjy7v6kAEkXBPu3TkQ152a/7sg==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr3869419wmh.173.1567599489980;
        Wed, 04 Sep 2019 05:18:09 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id d18sm29560180wra.91.2019.09.04.05.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 05:18:09 -0700 (PDT)
Date:   Wed, 4 Sep 2019 13:18:07 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, bjorn.andersson@linaro.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: qcom-geni: Provide an option to select FIFO
 processing
Message-ID: <20190904121807.GK26880@dell>
References: <20190904113613.14997-1-lee.jones@linaro.org>
 <20190904115609.GW2672@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190904115609.GW2672@vkoul-mobl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Vinod Koul wrote:

> On 04-09-19, 12:36, Lee Jones wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/i2c/busses/i2c-qcom-geni.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> > index a89bfce5388e..dfdbce067827 100644
> > --- a/drivers/i2c/busses/i2c-qcom-geni.c
> > +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> > @@ -353,13 +353,16 @@ static void geni_i2c_tx_fsm_rst(struct geni_i2c_dev *gi2c)
> >  static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
> >  				u32 m_param)
> >  {
> > +	struct device_node *np = gi2c->se.dev->of_node;
> >  	dma_addr_t rx_dma;
> >  	unsigned long time_left;
> > -	void *dma_buf;
> > +	void *dma_buf = NULL;
> >  	struct geni_se *se = &gi2c->se;
> >  	size_t len = msg->len;
> >  
> > -	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> > +	if (!of_property_read_bool(np, "qcom,geni-se-fifo"))
> 
> Where is this property documented, I dont see anything in linux-next for
> today

In this set. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
