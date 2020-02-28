Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A065174339
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Feb 2020 00:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgB1XgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 18:36:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33740 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1XgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:36:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so5113312wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KIMqojdySftVbEchMKmvDu1hxx5jOX8pHCLHKZzK8dU=;
        b=WW2H1CwTYnCSSKdB5ERVN3QZUhoZ9JiiYzedNV1EWDCV0kqjvb0Q5tjCl6kUBpjTpa
         JnpkQt+M7rN5tJY1dDyyxR1g0jQo0iAGjA4PLgfG2C6pNXR0E2doz3nmatm8g2dKTfle
         2b572mjacSe892li+jxrKQwzRChv+DUfjwxSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=KIMqojdySftVbEchMKmvDu1hxx5jOX8pHCLHKZzK8dU=;
        b=Oyo9XXuT1iZuT4UiGj5bz2oTz6w9umCumj7rPYjFuYRC90PsCH/hfkLTBwvf9n2a5Y
         5qRdaY8um7pPmRLGnDORk7rwSkWu0pqvyiH9FC2LWDLf579XtW4npB3UV5LQeC7j1U9Q
         y+ZQZrEtHBOC2FCJn+3QUKada8WjP7+r7HT6R/Lmj5vHSm35g4PVOfDmAM5QXsZgnv2b
         dWtYoq+1MATpOXC5EV3AwwcBcMXeuOKlP0LlqP8wSgPPZKYe2jZStdjsKKtFiXlI8y7e
         SnJqPudipyR4g2ldL6GmlIuynLM9CdSzQsr9uEje6bk6T5ruL6i/aKQT90BL0KIR8tC6
         rWyg==
X-Gm-Message-State: APjAAAU5F3JEfCl9BG3vyRmOp3lpJhkYGSNDjF0IRr0BGtP4ijoRwIEc
        R1MXgkT2spPXqeXc1GfI2tIZ9Q==
X-Google-Smtp-Source: APXvYqxyy9j4SCqy/MmdVuOuV66PGkzhqqv7BQiUHzSNu1O8KoFBtk987ErE61Xt4RH6BLYh4yDpxg==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr6824766wru.293.1582932965285;
        Fri, 28 Feb 2020 15:36:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g10sm15069342wrr.13.2020.02.28.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:36:04 -0800 (PST)
Date:   Sat, 29 Feb 2020 00:36:02 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Emmanuel Vadot <manu@bidouilliste.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Emmanuel Vadot <manu@FreeBSD.org>,
        Jani Nikula <jani.nikula@intel.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, efremov@linux.com,
        kraxel@redhat.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sam@ravnborg.org, tzimmermann@suse.de
Subject: Re: [PATCH v2 1/2] drm/client: Dual licence the file in GPL-2 and MIT
Message-ID: <20200228233602.GA2363188@phenom.ffwll.local>
Mail-Followup-To: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Emmanuel Vadot <manu@bidouilliste.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Emmanuel Vadot <manu@FreeBSD.org>,
        Jani Nikula <jani.nikula@intel.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, efremov@linux.com,
        kraxel@redhat.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sam@ravnborg.org, tzimmermann@suse.de
References: <20200215180911.18299-1-manu@FreeBSD.org>
 <20200215180911.18299-2-manu@FreeBSD.org>
 <877e0n66qi.fsf@intel.com>
 <158254443806.15220.5582277260130009235@skylake-alporthouse-com>
 <20200225091810.1de39ea4e0d578d363420412@bidouilliste.com>
 <20200225170313.GM2363188@phenom.ffwll.local>
 <2a735cb0-5a78-8dcf-dcaa-30f5a5f77e2d@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a735cb0-5a78-8dcf-dcaa-30f5a5f77e2d@tronnes.org>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 01:28:57PM +0100, Noralf Trønnes wrote:
> 
> 
> Den 25.02.2020 18.03, skrev Daniel Vetter:
> > On Tue, Feb 25, 2020 at 09:18:10AM +0100, Emmanuel Vadot wrote:
> >> On Mon, 24 Feb 2020 11:40:38 +0000
> >> Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >>
> >>> Quoting Jani Nikula (2020-02-15 18:33:09)
> >>>> On Sat, 15 Feb 2020, Emmanuel Vadot <manu@FreeBSD.org> wrote:
> >>>>> From: Emmanuel Vadot <manu@FreeBSD.Org>
> >>>>>
> >>>>> Contributors for this file are :
> >>>>> Chris Wilson <chris@chris-wilson.co.uk>
> >>>>> Denis Efremov <efremov@linux.com>
> >>>>> Jani Nikula <jani.nikula@intel.com>
> >>>>> Maxime Ripard <mripard@kernel.org>
> >>>>> Noralf Trønnes <noralf@tronnes.org>
> >>>>> Sam Ravnborg <sam@ravnborg.org>
> >>>>> Thomas Zimmermann <tzimmermann@suse.de>
> >>>>>
> >>>>> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> >>>>
> >>>> I've only converted some logging.
> >>>>
> >>>> Acked-by: Jani Nikula <jani.nikula@intel.com>
> >>>
> >>> Bonus ack from another Intel employee to cover all Intel copyright in
> >>> this file,
> >>> Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
> >>> -Chris
> >>
> >>  Thanks Chris,
> >>
> >>  Daniel, if I'm counting right this was the last ack needed.
> > 
> > I'm counting the same, patch applied and thanks for taking care of the
> > paperwork pushing here.
> > 
> 
> Looks like it got lost somehow, I can't find it in drm-tip at least.

Sry got stuck in my script, I kicked now.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
