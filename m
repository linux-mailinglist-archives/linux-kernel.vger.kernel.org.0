Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9517BDD942
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfJSPJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 11:09:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35457 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfJSPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 11:09:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id l10so8771558wrb.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ay4timk1xWotJvsgSoLnsWO4oyPYDoeHPtFGTfhtgfI=;
        b=t92CWFWjyR94g1Dx9rLLDBajpCwSVgP9bI+BzzLmMWZgV5Vh/vgSRVH9WwcAtPk2Do
         Xj4UA6iD8Am3EqTrRbGqnY9iFTeScopQVDrgzgE3PHlLQWcFQVXhgY2YkjR6m4GXKYyo
         BCoYiHBP244f7Rpf7FTvRaBA0fp9Um9xEa+Pf70IjThEsRkF5q0kyTmWK2s9pJ8+LqVY
         jseC6rLkbvcasZ5ZCWPYTEcAIX39kcjutHWqaV6QeyB6kuurSRfhTNs34cTYuayoJ/uY
         0iro7dl30v60hbWNDYSZnfg6MJn+j1fz4QqKCztV0Lf/wjQENXhpmuFZtVlJ6NNuKMkD
         GmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ay4timk1xWotJvsgSoLnsWO4oyPYDoeHPtFGTfhtgfI=;
        b=nN/giHm+LajitVlYJ4EX7gbsu+CDVL9O6DJkbEimEP3mv7KL4HPQgM7OQfPNe5eGmS
         YjHzNwMC9m1kOwB9LPbgGHKOpPjT/RmW4dNpPs+Py5/sKR/XtdDLCCxOlL+iIXJpvS2X
         z24Vdq1EQuJZYcUmRkvf1iP914UAmHgfnuYwvJ0SMULNfU29sn7DgTaZDi81oKCDtc/H
         vVAxsoCexYmb4suXaYOqhNOmKvfnKTXqGm728gM8NzNd8/mPh7pw1LwbDs/6Dc1gOniU
         +89IXqc7xAJqXiOm9ZuPW+mOTrewrvdaE5avvlboAFeLwjB2oyxvuolUYJg8qVWfauSb
         NvRg==
X-Gm-Message-State: APjAAAVDrHeDFbFmZFtSuLY6VUNhGSEL9+0+UYLR2aoOG5/j9rb1sjwS
        Q4Iyj2PMsGSSXmODB29n3g==
X-Google-Smtp-Source: APXvYqz7qO0W/vfzKmX4qN6UybbkVEuAp7v+lMxgcQwDTZpgHCDRYgUylsJfDwmszlw+CZ4cd3T+jg==
X-Received: by 2002:adf:fc4c:: with SMTP id e12mr1750054wrs.179.1571497751485;
        Sat, 19 Oct 2019 08:09:11 -0700 (PDT)
Received: from ninjabhubz.org (host-92-23-80-57.as13285.net. [92.23.80.57])
        by smtp.gmail.com with ESMTPSA id t13sm10742318wra.70.2019.10.19.08.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 08:09:10 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Sat, 19 Oct 2019 16:09:03 +0100 (BST)
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] staging: wfx: fix warnings of no space is
 necessary
In-Reply-To: <20191019142443.GH24678@kadam>
Message-ID: <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
References: <20191019140719.2542-1-jbi.octave@gmail.com> <20191019140719.2542-2-jbi.octave@gmail.com> <20191019142443.GH24678@kadam>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Oct 2019, Dan Carpenter wrote:

> On Sat, Oct 19, 2019 at 03:07:15PM +0100, Jules Irenge wrote:
> > diff --git a/drivers/staging/wfx/bh.c b/drivers/staging/wfx/bh.c
> > index 3355183fc86c..573216b08042 100644
> > --- a/drivers/staging/wfx/bh.c
> > +++ b/drivers/staging/wfx/bh.c
> > @@ -69,13 +69,13 @@ static int rx_helper(struct wfx_dev *wdev, size_t read_len, int *is_cnf)
> >  	if (wfx_data_read(wdev, skb->data, alloc_len))
> >  		goto err;
> >  
> > -	piggyback = le16_to_cpup((u16 *) (skb->data + alloc_len - 2));
> > +	piggyback = le16_to_cpup((u16 *)(skb->data + alloc_len - 2));
> >  	_trace_piggyback(piggyback, false);
> >  
> > -	hif = (struct hif_msg *) skb->data;
> > +	hif = (struct hif_msg *)skb->data;
> >  	WARN(hif->encrypted & 0x1, "unsupported encryption type");
> >  	if (hif->encrypted == 0x2) {
> > -		if (wfx_sl_decode(wdev, (void *) hif)) {
> > +		if (wfx_sl_decode(wdev, (void *)hif)) {
> 
> In the future you may want to go through and remove the (void *) casts.
> It's not required here.
> 
> > diff --git a/drivers/staging/wfx/bus_spi.c b/drivers/staging/wfx/bus_spi.c
> > index f65f7d75e731..effd07957753 100644
> > --- a/drivers/staging/wfx/bus_spi.c
> > +++ b/drivers/staging/wfx/bus_spi.c
> > @@ -90,7 +90,7 @@ static int wfx_spi_copy_to_io(void *priv, unsigned int addr,
> >  	struct wfx_spi_priv *bus = priv;
> >  	u16 regaddr = (addr << 12) | (count / 2);
> >  	// FIXME: use a bounce buffer
> > -	u16 *src16 = (void *) src;
> > +	u16 *src16 = (void *)src;
> 
> Here we are just getting rid of the constness.  Apparently we are doing
> that so we can modify it without GCC pointing out the bug!!  I don't
> know the code but this seems very wrong.
> 
Checkpatch was complaining about  space between type cast and the 
variable. I just get rid of the space. Well I don't know whether this was 
false positive one.

Thanks for the feedback. I will update the patch.

Regards,
Jules
