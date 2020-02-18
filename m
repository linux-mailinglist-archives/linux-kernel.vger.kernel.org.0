Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4C16276B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 14:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgBRNvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 08:51:54 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44242 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgBRNvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:51:53 -0500
Received: by mail-wr1-f54.google.com with SMTP id m16so23990991wrx.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 05:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9p6OXHKsM023NhocmqOZnADdz+HERBrvBoyGsV+UlKE=;
        b=i+APoOGnnmlCIGHizJMEvzNQdV+k0wmdevVDYJirpQWMZ6wd1KbrIasKsmtHgrk8qy
         xKAxXUkz8FeK6SRZsVUAbXIouvTfpc49e/A82u4y6Qd5N2ZPkB3QCGJ/0/BZKkOvU5m1
         kd5GgA+mKNooGJf61agRotmNXxAFavcq+41qEYaPsAR1FYCqT2Hil8f5AfRwGR/a4xWh
         /XzkbvRNmkds4jezM25NtZGsCANvVSAakLvmx0PH1EmFnL23BDk81Kbd0//8rZ6bAoBQ
         JhnAnaB+l26mhKBL54I26Vq9om6erS/E+UosyCAs7BQqTeEikve34Fo7ns7nvVVYVuVJ
         BKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9p6OXHKsM023NhocmqOZnADdz+HERBrvBoyGsV+UlKE=;
        b=ZXNmZrxq3X/ri/aATt4omLQyEklYQaFIV5Lw23oIOUqy7aFrR/+zAa8PqDF+IL60gU
         TEAB26jI0bzs02nG+4fSMklA1tLpe+9x6pNDA7zMSSBI8Yk4mtEPGdP2ZUZBnUf9vTB7
         FpIDA7VwB2Je3xdJsW3gmx/RvLF4mjbscjCMkyK1mTpSuW3aCXc6eNO2/5nn5MFbFHGW
         dYZq9idctxZ5QqJl23fVLmi2Io7ZTCkWnYL/IrLw8E81oAUGn7OP7iLcEFkpk5pgsK4X
         8x58M24IgSB5fSw7nB3/sAQxwds07oEyh8P3fLyzJc8WRpMP+qhPRgmYYULUJjIi8SZs
         j0tw==
X-Gm-Message-State: APjAAAUxkQCgVsk+DiqSnijJtOdjuMBoPBOCjiJoanrqY1VrPCwuNRFx
        k3afYSa6dcBAVmfK60HuJH0Dow==
X-Google-Smtp-Source: APXvYqwXJi+BRLCWb7f7jxO0dAGaoQy1ZP8L6u0Vtd85ei679by+qE09DpmnnIWAAebNG5Pv+P5d0A==
X-Received: by 2002:a5d:4c84:: with SMTP id z4mr30076715wrs.423.1582033911637;
        Tue, 18 Feb 2020 05:51:51 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id w8sm3675899wmm.0.2020.02.18.05.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 05:51:51 -0800 (PST)
Date:   Tue, 18 Feb 2020 13:52:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        agx@sigxcpu.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com,
        jjhiblot@ti.com
Subject: Re: LED backlight on Droid 4 and others
Message-ID: <20200218135219.GC3494@dell>
References: <20200105183202.GA17784@duo.ucw.cz>
 <20200106084549.GA14821@dell>
 <20200211172900.GH64767@atomide.com>
 <20200212201638.GB20085@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212201638.GB20085@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020, Pavel Machek wrote:

> Hi!
> 
> > > > It would be good to get LED backlight to work in clean way for 5.6
> > > > kernel.
> > ...
> > > > [If you have an idea what else is needed, it would be welcome; it
> > > > works for me in development tree but not in tree I'd like to
> > > > upstream.]
> > > > 
> > > > Lee, would you be willing to take "backlight: add led-backlight
> > > > driver"? Would it help if I got "leds: Add managed API to get a LED
> > > > from a device driver" and "leds: Add of_led_get() and led_put()" into
> > > > for_next tree of the LED subsystem?
> > > 
> > > It looks like you have an open question from Tony on v10.
> > > 
> > > Is that patch orthogonal, or are there depend{ants,encies}?
> > 
> > Uhh looks like we messed up a bit with integration. Now droid4
> > LCD backlight can no longer be enabled at all manually in v5.6-rc1
> > without the "add led-backlight driver" patch.. Should we just
> > merge it to fix it rather than start scrambling with other
> > temporary hacks?
> 
> We should just merge the "add led-backlight driver". Everything should
> be ready for it. I'm sorry if I broke something working, I was not
> aware it worked at all.
> 
> Unfortunately, this is backlight code, not LED, so I can't just merge it.

Please go ahead.  Apply my Acked-by and merge away ASAP.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
