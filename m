Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6998B83BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 23:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfISVxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 17:53:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38374 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbfISVxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:53:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so3158376pfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ruovMVYJjXPQTVCPUHE1KGFchlWZ6UJGh5pYStjnRd4=;
        b=Z7uMzduhDzAdayqBJOHW7hks8pDNL9ak3sQhSb0Z2lM9M0Enc80PCUSdgPzH/raueq
         X63eiXg7eHdVKTXMC1xV2cK2+92TeYLSYTCYfwzrTU4nStzu0G0Oc1IFA6X6H6JhJLfh
         dbP2ZnN5qxSV5pBmgLvOM9vpx1fZ6y2l+grEysoVmoELDcwF0gFAd26aL5NfJ63orlZG
         VQe0g4oIUiZqNk5GCyjLpqJwBC27h+vvgbtWCTvJzNyc3l2O9BaNdqvQ1Sm4RRl1MPtx
         le93kDDdPxe4oTTZU2vWMG9fXPvEciUJzuG2TYt1jaWEMXZGqFFltSFMV48xskn/aXOU
         MqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ruovMVYJjXPQTVCPUHE1KGFchlWZ6UJGh5pYStjnRd4=;
        b=JkZ/aHyiR4u1JYr/hDBJ/sYKQ7ZetQj0gz0aKm+fZJs8a/dIbFsmF00PVxZ0Rtroy5
         nHb9dtsrXf1YY20pQCihz5ZkWEXb9AJ4h4rUQIUIdM1E2YhulthmecNBG0QdttTA8Z9w
         owL8s++Or75mQS2uNMBbLxt82pP/GUQVBe5CvPcStDmDizzY5oAaoEuBgMqawC1VaR2X
         8IiiRehutmt1ipTOnVK1pXWDiqHFIq3LFY/xQj4uFjU79GRUjKPNFYHNnHLkPavYbzFS
         PwzmLGl8vmTMub5AevNDaU8RCLEgajiMF6uo0n6wfRB01zzBs1izVL8OWKS/3lO+uHTF
         7Z6g==
X-Gm-Message-State: APjAAAXY+7esSsqGjBJSx3jmbTPtP/zHRVQq1pB8HoVJXuubfaeG94Zb
        H/qndjsaKG4vLKMEyYhBj3k7rw==
X-Google-Smtp-Source: APXvYqzvlLVlbxwqi/PKdrrVmvPE3Utp7lxx0LxNp2MZzisfAvK9bjrhAH0sGgUs0ykXcKtBP/Ygvw==
X-Received: by 2002:aa7:8813:: with SMTP id c19mr10319247pfo.101.1568929982814;
        Thu, 19 Sep 2019 14:53:02 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 30sm6417430pjk.25.2019.09.19.14.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 14:53:02 -0700 (PDT)
Date:   Thu, 19 Sep 2019 14:53:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Murali Nalajala <mnalajal@codeaurora.org>, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] base: soc: Export soc_device_to_device API
Message-ID: <20190919215300.GC1418@minitux>
References: <1568927624-13682-1-git-send-email-mnalajal@codeaurora.org>
 <20190919213203.GA395325@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919213203.GA395325@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 Sep 14:32 PDT 2019, Greg KH wrote:

> On Thu, Sep 19, 2019 at 02:13:44PM -0700, Murali Nalajala wrote:
> > If the soc drivers want to add custom sysfs entries it needs to
> > access "dev" field in "struct soc_device". This can be achieved
> > by "soc_device_to_device" API. Soc drivers which are built as a
> > module they need above API to be exported. Otherwise one can
> > observe compilation issues.
> > 
> > Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>
> > ---
> >  drivers/base/soc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/base/soc.c b/drivers/base/soc.c
> > index 7c0c5ca..4ad52f6 100644
> > --- a/drivers/base/soc.c
> > +++ b/drivers/base/soc.c
> > @@ -41,6 +41,7 @@ struct device *soc_device_to_device(struct soc_device *soc_dev)
> >  {
> >  	return &soc_dev->dev;
> >  }
> > +EXPORT_SYMBOL_GPL(soc_device_to_device);
> >  
> >  static umode_t soc_attribute_mode(struct kobject *kobj,
> >  				struct attribute *attr,
> 
> What in-kernel driver needs this?
> 

Half of the drivers interacting with the soc driver calls this API,
several of these I see no reason for being builtin (e.g.
ux500 andversatile). So I think this patch makes sense to allow us to
build these as modules.

> Is linux-next breaking without this?
> 

No, we postponed the addition of any sysfs attributes in the Qualcomm
socinfo driver.

> We don't export things unless we have a user of the export.
> 
> Also, adding "custom" sysfs attributes is almost always not the correct
> thing to do at all.  The driver should be doing it, by setting up the
> attribute group properly so that the driver core can do it automatically
> for it.
> 
> No driver should be doing individual add/remove of sysfs files.  If it
> does so, it is almost guaranteed to be doing it incorrectly and racing
> userspace.
> 

The problem here is that the attributes are expected to be attached to
the soc driver, which is separate from the platform-specific drivers. So
there's no way to do platform specific attributes the right way.

> And yes, there's loads of in-kernel examples of doing this wrong, I've
> been working on fixing that up, look at the patches now in Linus's tree
> for platform and USB drivers that do this as examples of how to do it
> right.
> 

Agreed, this patch should not be used as an approval for any crazy
attributes; but it's necessary in order to extend the soc device's
attributes, per the current design.

So:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
