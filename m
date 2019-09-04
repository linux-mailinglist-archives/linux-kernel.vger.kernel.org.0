Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE4A7E02
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 10:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfIDIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 04:37:52 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:38254 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:37:52 -0400
Received: by mail-ed1-f51.google.com with SMTP id r12so21636536edo.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aVdFPGsO99fAHb0fDhq0jDs2yUdP0q6E5B82ILny3Mw=;
        b=U9+zEmr/e91kEhC0hkj435zZ0gbXQfHEM0gCZI0xxo4dfi1ycr946w8RBp5Vp6dYmo
         1jYryGWSSRgZGuKaXNbE87tsfEGHFZfP6KOuyMa/Vdl33wxKSdAn9aKG1BA0LvniT9DL
         gKWayI2hSfYejDicvfILxoqr37c/e1/IqH6js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=aVdFPGsO99fAHb0fDhq0jDs2yUdP0q6E5B82ILny3Mw=;
        b=Zu5cKzcdGaJeOk46QL7y9+k1dfvr9yBK2YRKwusac+io1TyiyiKa8knZZ7D/XrHCOT
         Z2g7cBQcBKRX4wcB5WUliNt4/6ZyeQHsWFnNo6+z69J+2tWVGykGO0P81U7v06gmnWzO
         tUzrSd7XRmubh6Id6YulHM+KP9VSX4dxv5xCiu5yOCPRmbx+cYFiXn67YNfIOLlVrmn5
         KWJpc8OTbC3lM07VFzxUsrZ3rrxlcu4UigTzWytVX8uep75jhYU2woNOkAO+6AS4Stqy
         3JQtTlWQ1Co9+6N5p2U9Hw7z19FVW6IVLeR61vVhlupTXC6quw8nZhX18O0Xn+SSsdnj
         NO3A==
X-Gm-Message-State: APjAAAUlFi0Qtm7oVvkw3HK0MXUSCWQfMs+Q2EP9G60wIW13f8d49Hbx
        4BbaCcEw1w8NiP0WSzjqYKWbvg==
X-Google-Smtp-Source: APXvYqz0ChI/C22nVFm32NQ+8BGIvxKJ90yP02BZdljqxcx7QVaEp8goV21yUaH/pz+vZNJPQFlB9A==
X-Received: by 2002:a17:906:7c55:: with SMTP id g21mr1482880ejp.177.1567586270115;
        Wed, 04 Sep 2019 01:37:50 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id t16sm2638378ejj.48.2019.09.04.01.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 01:37:49 -0700 (PDT)
Date:   Wed, 4 Sep 2019 10:37:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux kernel <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <hwentlan@amd.com>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
Message-ID: <20190904083747.GE2112@phenom.ffwll.local>
Mail-Followup-To: Hillf Danton <hdanton@sina.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux kernel <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <hwentlan@amd.com>
References: <20190830032948.13516-1-hdanton@sina.com>
 <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
 <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com>
 <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
 <CAKMK7uH9q09XadTV5Ezm=9aODErD=w_+8feujviVnF5LO_fggA@mail.gmail.com>
 <5d6f10a6.1c69fb81.6b104.af73SMTPIN_ADDED_MISSING@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d6f10a6.1c69fb81.6b104.af73SMTPIN_ADDED_MISSING@mx.google.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:17:16AM +0800, Hillf Danton wrote:
> Daniel Vetter <daniel@ffwll.ch>
> >>
> >> Now 11:01pm and "gnome shell stuck warning" not appear since 19:17. So
> >> looks like issue happens only when computer blocked and monitor in
> >> power save mode.
> >
> > I'd bet on runtime pm or some other power saving feature in amdgpu
> > shutting the interrupt handling down before we've handled all the
> > interrupts. That would then result in a stuck fence.
> >
> > Do we already know which fence is stuck?
> 
> It is welcomed to shed a thread of light on how to collect/print that info.
> Say line:xxx-yyy in path/to/amdgpu/zzz.c

Extend your backtrac warning slightly like

	WARN(r, "we're stuck on fence %pS\n", fence->ops);

Also adding Harry and Alex, I'm not really working on amdgpu ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
