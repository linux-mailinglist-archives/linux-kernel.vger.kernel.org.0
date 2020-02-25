Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E00216EC05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 18:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgBYRDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 12:03:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50413 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgBYRDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:03:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so3804107wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WOIAsrMCz3yWV6MBUgzBXfjjCWfPYKrvISaoax4svGg=;
        b=c6to44zjOaQzbhDA/lFx5Mls2Au9Ezwa/69UC8iBSsIBqoMJAqlzyrQnRyqMpBBl8v
         GT9mukF5ICwZDg8ZA2eTZ1EGz9vL/yxTo8qjooJjQyGnH/wQpynUEZlHg5hBCvNdNDSD
         xHEZ1ihJNWTddgYvwVpBObxeXSIR4gv25OpmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WOIAsrMCz3yWV6MBUgzBXfjjCWfPYKrvISaoax4svGg=;
        b=ucrq5uvlR1H9sDNFzx4PRuQ97O5EIdijoxi8t2zHIpzMB/JWrE9pouu2CWYgknExXO
         2dA2fV1UobT7UL0hNFYtOpb/d2ZZzZlXzUVfPNQOa+k0TPrlegY24v39siNBvD4ZR9lK
         4b8FoiEWMsAWYZh3wB9jcMtHv8YIzzTYU8OPPyuj+d9dXwEyaCxj0fkAZsrIF5o7cYRn
         BFm6maSAHdO7HhQhRj97T/LomgXzWvFowW+iZv8RiqAiiSGF9npN9SjjB0fecNKS0yHx
         GJ8rAy7+Hv56dPzqN9yT3esx0Asq8K56TjCJn6PIfdmjwx9jVrhZdCIYwu5RNKRU2tbX
         8fqA==
X-Gm-Message-State: APjAAAXqAqnsmciNAm8rLbCaAIEu1EtzcEw060pByUB4IiRy8g5TDXR6
        /OaWQxFULn01aGUA4zCTH+TmuQ==
X-Google-Smtp-Source: APXvYqxzMtJXGOMsbQswdMRDN2uVpGfy+dccFzRbeHW7WQ/y4aSNT5fG7LwhOvE6poFHaK+wdbi2IQ==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr215809wmg.91.1582650196202;
        Tue, 25 Feb 2020 09:03:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n3sm4944105wmc.27.2020.02.25.09.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:03:15 -0800 (PST)
Date:   Tue, 25 Feb 2020 18:03:13 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emmanuel Vadot <manu@bidouilliste.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Emmanuel Vadot <manu@FreeBSD.org>,
        Jani Nikula <jani.nikula@intel.com>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        efremov@linux.com, kraxel@redhat.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        noralf@tronnes.org, sam@ravnborg.org, tzimmermann@suse.de
Subject: Re: [PATCH v2 1/2] drm/client: Dual licence the file in GPL-2 and MIT
Message-ID: <20200225170313.GM2363188@phenom.ffwll.local>
Mail-Followup-To: Emmanuel Vadot <manu@bidouilliste.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Emmanuel Vadot <manu@FreeBSD.org>,
        Jani Nikula <jani.nikula@intel.com>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, efremov@linux.com,
        kraxel@redhat.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        noralf@tronnes.org, sam@ravnborg.org, tzimmermann@suse.de
References: <20200215180911.18299-1-manu@FreeBSD.org>
 <20200215180911.18299-2-manu@FreeBSD.org>
 <877e0n66qi.fsf@intel.com>
 <158254443806.15220.5582277260130009235@skylake-alporthouse-com>
 <20200225091810.1de39ea4e0d578d363420412@bidouilliste.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200225091810.1de39ea4e0d578d363420412@bidouilliste.com>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 09:18:10AM +0100, Emmanuel Vadot wrote:
> On Mon, 24 Feb 2020 11:40:38 +0000
> Chris Wilson <chris@chris-wilson.co.uk> wrote:
> 
> > Quoting Jani Nikula (2020-02-15 18:33:09)
> > > On Sat, 15 Feb 2020, Emmanuel Vadot <manu@FreeBSD.org> wrote:
> > > > From: Emmanuel Vadot <manu@FreeBSD.Org>
> > > >
> > > > Contributors for this file are :
> > > > Chris Wilson <chris@chris-wilson.co.uk>
> > > > Denis Efremov <efremov@linux.com>
> > > > Jani Nikula <jani.nikula@intel.com>
> > > > Maxime Ripard <mripard@kernel.org>
> > > > Noralf Trønnes <noralf@tronnes.org>
> > > > Sam Ravnborg <sam@ravnborg.org>
> > > > Thomas Zimmermann <tzimmermann@suse.de>
> > > >
> > > > Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> > > 
> > > I've only converted some logging.
> > > 
> > > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > 
> > Bonus ack from another Intel employee to cover all Intel copyright in
> > this file,
> > Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
> > -Chris
> 
>  Thanks Chris,
> 
>  Daniel, if I'm counting right this was the last ack needed.

I'm counting the same, patch applied and thanks for taking care of the
paperwork pushing here.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
