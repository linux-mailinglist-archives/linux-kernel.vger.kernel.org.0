Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88C51408D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 12:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgAQLXm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jan 2020 06:23:42 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:53860 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726785AbgAQLXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:23:42 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 00HBLTXn074222
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 17 Jan 2020 19:21:29 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from lenovo (10.0.74.130) by BJMBX01.spreadtrum.com (10.0.64.7) with
 Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 17 Jan 2020 19:22:06 +0800
Date:   Fri, 17 Jan 2020 19:22:02 +0800
From:   Orson Zhai <orson.zhai@spreadtrum.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Orson Zhai <orson.zhai@unisoc.com>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <baolin.wang@unisoc.com>, <kevin.tang@unisoc.com>,
        <chunyan.zhang@unisoc.com>, <liangcai.fan@unisoc.com>
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon
 reference
Message-ID: <20200117112202.GG19966@lenovo>
References: <1576037311-6052-1-git-send-email-orson.zhai@unisoc.com>
 <20200116135207.GS325@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200116135207.GS325@dell>
X-Originating-IP: [10.0.74.130]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 00HBLTXn074222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Thu, Jan 16, 2020 at 01:52:07PM +0000, Lee Jones wrote:
> On Wed, 11 Dec 2019, Orson Zhai wrote:
>
> > There are a lot of similar global registers being used across multiple SoCs
> > from Unisoc. But most of these registers are assigned with different offset
> > for different SoCs. It is hard to handle all of them in an all-in-one
> > kernel image.
> >
> > Add a helper function to get regmap with arguments where we could put some
> > extra information such as the offset value.
> >
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > Tested-by: Baolin Wang <baolin.wang@unisoc.com>
> > ---
> >  drivers/mfd/syscon.c       | 29 +++++++++++++++++++++++++++++
> >  include/linux/mfd/syscon.h | 14 ++++++++++++++
> >  2 files changed, 43 insertions(+)
>
> Something really odd is happening when I try to apply this patch.
>
> Patchwork doesn't like it either.
>
> Could you please rebase it and re-send using `git send-mail`, thanks.

I have sent v3 to you with rebasing on v5.5-rc6.
>
> Also apply my and Arnd's Ack when re-sending.

Done, but add reviewed-by for Arnd as he indicated at previous mail.

Best,
Orson

>
> > diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> > index e22197c..2918b05 100644
> > --- a/drivers/mfd/syscon.c
> > +++ b/drivers/mfd/syscon.c
> > @@ -224,6 +224,35 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
> >  }
> >  EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
> >
> > +struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
> > +                                       const char *property,
> > +                                       int arg_count,
> > +                                       unsigned int *out_args)
> > +{
> > +       struct device_node *syscon_np;
> > +       struct of_phandle_args args;
> > +       struct regmap *regmap;
> > +       unsigned int index;
> > +       int rc;
> > +
> > +       rc = of_parse_phandle_with_fixed_args(np, property, arg_count,
> > +                       0, &args);
> > +       if (rc)
> > +               return ERR_PTR(rc);
> > +
> > +       syscon_np = args.np;
> > +       if (!syscon_np)
> > +               return ERR_PTR(-ENODEV);
> > +
> > +       regmap = syscon_node_to_regmap(syscon_np);
> > +       for (index = 0; index < arg_count; index++)
> > +               out_args[index] = args.args[index];
> > +       of_node_put(syscon_np);
> > +
> > +       return regmap;
> > +}
> > +EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle_args);
> > +
> >  static int syscon_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> > diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
> > index 112dc66..714cab1 100644
> > --- a/include/linux/mfd/syscon.h
> > +++ b/include/linux/mfd/syscon.h
> > @@ -23,6 +23,11 @@ extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
> >  extern struct regmap *syscon_regmap_lookup_by_phandle(
> >                                         struct device_node *np,
> >                                         const char *property);
> > +extern struct regmap *syscon_regmap_lookup_by_phandle_args(
> > +                                       struct device_node *np,
> > +                                       const char *property,
> > +                                       int arg_count,
> > +                                       unsigned int *out_args);
> >  #else
> >  static inline struct regmap *device_node_to_regmap(struct device_node *np)
> >  {
> > @@ -45,6 +50,15 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle(
> >  {
> >         return ERR_PTR(-ENOTSUPP);
> >  }
> > +
> > +static struct regmap *syscon_regmap_lookup_by_phandle_args(
> > +                                       struct device_node *np,
> > +                                       const char *property,
> > +                                       int arg_count,
> > +                                       unsigned int *out_args)
> > +{
> > +       return ERR_PTR(-ENOTSUPP);
> > +}
> >  #endif
> >
> >  #endif /* __LINUX_MFD_SYSCON_H__ */
>
> --
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
